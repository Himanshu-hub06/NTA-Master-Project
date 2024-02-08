/// <summary>
/// Page Indent Under Approval Header (ID 50795).
/// </summary>
page 50242 "Indent Under Approval Header"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = 50089;
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER("Pending for Approval"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Indent Read";

                        if Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec."Attachment";
                            ServerFileName := FilePath + Rec."Attachment";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
                field("Rejected Remarks"; Rec."Rejected Remarks")
                {
                    ApplicationArea = All;
                }
                field("Transfer User Id"; Rec."Transfer User Id")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'INDENT');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User ID", '<>%1', USERID);

                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Transfer User Id" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Full Name";
                        END;
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;

                }
                field("Transfer User name"; Rec."Transfer User name")
                {
                    ApplicationArea = All;
                }
            }
            part(IndentLine; 50243)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function ")
            {
                action("Send for Department")
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want Send for department?', TRUE, Rec."No.") THEN BEGIN
                            //TESTFIELD("Remarks");
                            Rec.Reopen;
                        END;
                    end;
                }
                action("Note &Sheet")
                {
                    Caption = 'Note &Sheet';
                    Image = ViewComments;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin

                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 50172);
                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", rec."No.");
                        PAGE.RUN(PAGE::"Notesheet List", ApprovalCommentLine);
                    end;
                }

                action("Fill Requisition Line")
                {
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF Rec.Status = Rec.Status::"Pending for Approval" THEN
                            ERROR('Document Must be Open');
                        Rec.TESTFIELD("Requisition No.");
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");

                        // CurrPage.IndentLine.PAGE.GetPurchReqLines;
                    end;
                }
            }
            group(Posting)
            {
                action(Post)
                {
                    Image = Post;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Manual Close Indent")
                {
                    Image = Close;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IndentLine.SETRANGE("Document No.", Rec."No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IF IndentLine."Purchase Order No." = '' THEN
                                    PurchaseOrder := IndentLine."Purchase Order No.";
                            UNTIL IndentLine.NEXT = 0;
                            IF PurchaseOrder <> '' THEN BEGIN
                                Rec.Posted := TRUE;
                                Rec."Manual Close" := TRUE;
                                Rec.MODIFY;
                            END ELSE
                                ERROR('This Indent is not selected in any Purchase Document');
                        END;
                    end;
                }
                action("Indent Print")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IndentHead.SETRANGE("No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN
                            REPORT.RUN(50076, TRUE, TRUE, IndentHead);
                    end;
                }
                action(Approve)
                {
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        //kamlesh
                        Ins, Response : Boolean;
                        SendMailCU: Codeunit "Send Mail(API)";
                        BodyMassage: Text[250];
                        Usertab2: Record User;

                    //kamlesh
                    begin
                        IF NOT CONFIRM(Text0003) THEN
                            EXIT;
                        AppuserGroupMem.RESET;
                        AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code", 'INDENT');
                        AppuserGroupMem.SETRANGE("User ID", USERID);
                        AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission", FALSE);
                        IF AppuserGroupMem.FINDFIRST THEN
                            ERROR('You do not have permision to approve Indent');
                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in Indent');
                        NoteshetTab.RESET;
                        NoteshetTab.SETRANGE("Document No.", rec."No.");
                        IF NoteshetTab.FIND('-') THEN BEGIN
                            Entryno := NoteshetTab."Last Entry No." + 1;
                            NoteshetTab.CALCFIELDS("Running Note");
                            IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
                                NoteshetTab."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(NsheetOld);
                            END;
                            NoteshetTab.CALCFIELDS("Current Note");

                            IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
                                NoteshetTab."Current Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(Nsheet);
                            END;
                            Char10 := 10;
                            NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
                            IF Nsheet <> '' THEN BEGIN
                                IF NsheetOld <> '' THEN BEGIN
                                    SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                END
                                ELSE
                                    SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);

                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);


                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END
                            ELSE BEGIN

                                SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);

                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);


                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END;
                        END;

                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE("Table ID", 50172);
                        ApprovalEntry.SETRANGE("Approver ID", USERID);
                        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN
                            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                            //  ApprovalEntry.Indent := TRUE;
                            ins := ApprovalEntry.MODIFY;
                        END;
                        // kamlesh date 16-02-2023
                        //   Clear(BodyMassage);
                        //   if ins then begin
                        //       BodyMassage := BodyMassage + StrSubstNo('Indent No. %1 has been Approved by', Rec."No.");
                        //      BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                        //     Response := SendMailCU.Sendmail(UserId, StrSubstNo('Approval Request of Indent No. %1', Rec."No."), BodyMassage);
                        //     if Response then begin
                        //          Usertab2.Reset();
                        //         Usertab2.SetRange("User Name", UserId);
                        //        if Usertab2.FindFirst() then
                        //          if Usertab2."Contact Email" = '' then
                        //              Message('Indent is successfully approved!');
                        //   end;
                        // end;
                        // kamlesh date 16-02-2023
                        IndentHead.RESET;
                        IndentHead.SETRANGE(IndentHead."No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN BEGIN
                            IndentHead.Status := IndentHead.Status::Approved;
                            IndentHead."Transfer User Id" := '';
                            IndentHead."Transfer User name" := '';
                            IndentHead."Approving UID" := IndentHead."Pending From User Id";
                            IndentHead."Approver Name" := IndentHead."Pending From User Name";
                            IndentHead.MODIFY;
                        END;
                        IndentLine.RESET;
                        IndentLine.SETRANGE(IndentLine."Document No.", Rec."No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IndentLine.Status := IndentHead.Status;
                                IndentLine.MODIFY;
                            UNTIL IndentLine.NEXT = 0;
                        END;
                        CurrPage.CLOSE;
                    end;
                }
                action(Forword)
                {
                    Caption = 'Forward';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        //kamlesh
                        Ins, Response : Boolean;
                        SendMailCU: Codeunit "Send Mail(API)";
                        BodyMassage: Text[250];
                        Usertab2: Record User;
                        NotTab: Record "Notification Tab";
                        NotTab1: Record "Notification Tab";
                    //kamlesh
                    begin
                        IF NOT CONFIRM(Text0004) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");
                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50172);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        ApprovalEntry1.SETRANGE(ApprovalEntry1.Status, ApprovalEntry1.Status::Open);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID", USERID);
                        IF ApprovalEntry1.FINDFIRST THEN BEGIN
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Forwarded;
                            ApprovalEntry1."Forwarding Date-Time" := CURRENTDATETIME;
                            ApprovalEntry1.MODIFY;

                        END;
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in Indent');
                        NoteshetTab.RESET;
                        NoteshetTab.SETRANGE("Document No.", rec."No.");
                        IF NoteshetTab.FIND('-') THEN BEGIN
                            Entryno := NoteshetTab."Last Entry No." + 1;
                            NoteshetTab.CALCFIELDS("Running Note");
                            IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
                                NoteshetTab."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(NsheetOld);
                            END;
                            NoteshetTab.CALCFIELDS("Current Note");

                            IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
                                NoteshetTab."Current Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(Nsheet);
                            END;
                            Char10 := 10;
                            NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
                            IF Nsheet <> '' THEN BEGIN
                                IF NsheetOld <> '' THEN BEGIN
                                    SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                END
                                ELSE
                                    SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);

                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);


                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END
                            ELSE BEGIN

                                SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);

                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);


                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END;
                        END;
                        NotTab.Reset();
                        If NotTab.FindLast() Then begin
                            entryNo := NotTab."Entry No.";
                        end;
                        NotTab1.Reset();
                        NotTab1."Entry No." := entryNo + 1;
                        NotTab1."Posting Date" := Today;
                        NotTab1."Sender ID" := UserId;
                        NotTab1."Receiver ID" := Rec."Transfer User Id";
                        NotTab1.read := false;
                        NotTab1."Notification Details" := 'Indent No.' + rec."No." + ' ' + 'Receive for your consideration ';
                        NotTab1.Insert();
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Table ID" := 50172;
                        ApprovalEntry."Document No." := Rec."No.";
                        ApprovalEntry."Sequence No." := 1;
                        ApprovalEntry."Sender ID" := USERID;
                        ApprovalEntry."Approver ID" := Rec."Transfer User Id";
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
                        ApprovalEntry."Last Modified By User ID" := USERID;
                        ApprovalEntry.VALIDATE("Location Code", Rec."Location Code");
                        ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        //ApprovalEntry.Indent := TRUE;
                        ApprovalEntry."Record ID to Approve" := Rec.RECORDID;
                        ins := ApprovalEntry.INSERT;
                        // kamlesh date 16-02-2023
                        // Clear(BodyMassage);
                        //  if ins then begin
                        //      BodyMassage := BodyMassage + StrSubstNo('Indent No. %1 has been forwarded by', Rec."No.");
                        //      BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                        //     SendMailCU.Sendmail(Rec."Transfer User Id", StrSubstNo('Approval Request of Indent No. %1', Rec."No."), BodyMassage);
                        //  if Response then begin
                        //    Usertab2.Reset();
                        //     Usertab2.SetRange("User Name", Rec."Transfer User Id");
                        //      if Usertab2.FindFirst() then
                        //          if Usertab2."Contact Email" = '' then
                        //              Message('Indent has been Forwarded to %1!', Usertab2."Full Name");
                        //   end;
                        //  end;
                        IndentHead.RESET;
                        IndentHead.SETRANGE(IndentHead."No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN BEGIN
                            IndentHead."Transfer User Id" := '';
                            IndentHead."Transfer User name" := '';
                            IndentHead."Pending From User Id" := Rec."Transfer User Id";
                            IndentHead."Pending From User Name" := Rec."Transfer User name";
                            IndentHead.MODIFY;
                        END;

                        CurrPage.CLOSE;
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record 454;
                    //   ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        IF NOT CONFIRM(Text0005) THEN
                            EXIT;
                        Rec.TESTFIELD("Rejected Remarks");
                        //CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE("Table ID", 50172);
                        ApprovalEntry.SETRANGE("Approver ID", USERID);
                        //ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN
                            //ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                            ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                        ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry.MODIFY;
                        IndentHead.RESET;
                        IndentHead.SETRANGE(IndentHead."No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN
                            IndentHead.Status := IndentHead.Status::Rejected;
                        IndentHead."Rejected By" := USERID;
                        IndentHead."Rejected Date" := WORKDATE;

                        IndentHead.MODIFY;
                        ReqLine.RESET;
                        ReqLine.SETRANGE(ReqLine."Indent No.", Rec."No.");
                        IF ReqLine.FINDFIRST THEN BEGIN
                            REPEAT
                                ReqLine."Indent No." := '';
                                ReqLine."Indent Line No." := 0;
                                ReqLine."Requisition Selected" := FALSE;
                                ReqLine.MODIFY;
                            UNTIL ReqLine.NEXT = 0;
                        END;
                    end;
                }
                action("Send Email")
                {
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.SendForApproval();
                        /*IndentLine.SETRANGE("Document No.","No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                          REPEAT
                          ItemNo := IndentLine."No.";
                          ItemDescription := IndentLine.Description + ' ' + IndentLine."Description 2" +' ' + IndentLine."Description 3";
                          ItemQty := IndentLine.Quantity;
                          UNTIL IndentLine.NEXT =0;
                        END;


                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FIND('-') THEN BEGIN
                          SenderAddress:=UserSetup."Sender's Email ID";
                          Recipient :=UserSetup."Receiver's Email ID" ;
                          SenderName := "User ID";
                        END;
                        Subject:='Pending Indent for Approval';
                        Body:='Indent Document No. '+"No."+' is Pending for your approval .';
                        SMTPMail.CreateMessage(SenderName,SenderAddress,Recipient,Subject,'',TRUE);
                        SMTPMail.AppendBody('Dear Sir / Madam,');
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody(Body);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Branch-');
                        SMTPMail.AppendBody("Shortcut Dimension 1 Code");
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Department-');
                        SMTPMail.AppendBody("Department");
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item No-');
                        SMTPMail.AppendBody(ItemNo);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item Description-');
                        SMTPMail.AppendBody(ItemDescription);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item Qty-');
                        SMTPMail.AppendBody(FORMAT(ItemQty));
                        SMTPMail.AppendBody('<br><Br>');
                        SMTPMail.AppendBody('Regards,');
                        SMTPMail.AppendBody('<br>');
                        SMTPMail.AppendBody(SenderName);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this email ID.');
                        IF CCName <> '' THEN
                          SMTPMail.AddCC :=CCName;
                          SMTPMail.Send;
                          "Email Sent" := TRUE;
                          MODIFY;
                          MESSAGE('E-Mail Sent Successfully');
                         */

                    end;
                }
            }
            action("View Note Sheet")
            {
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                begin

                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", rec."No.");
                    PAGE.RUN(PAGE::"NoteSheet Display", ApprovalCommentLine);
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
        }
    }

    var
        IndentLine: Record 50090;
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead: Record 50089;
        UserSetup_gRec: Record 91;
        SenderAddress: Text[100];
        Recipient: Text[200];
        SenderName: Text[100];
        Subject: Text[100];
        Body: Text[100];
        // SMTPMail: Codeunit 400;
        UserSetup: Record 91;
        CCName: Text;
        ItemDescription: Text[150];
        ItemNo: Code[20];
        ItemQty: Decimal;
        ApprovalEntry: Record 454;
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // ApprovalsMgmt: Codeunit 1535;
        Text0003: Label 'Do you want to approve ?';
        Text0004: Label 'Do you want to Forward higher authority  ?';
        Text0005: Label 'Do you want to Reject ?';
        ReqLine: Record 50088;
        AppuserGroupMem: Record 50082;
        ApprovalUserGroup: Record 50082;
        ApprovalEntry1: Record 454;
        "EntryNo.": Integer;
        FileDir: Record 50083;
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        NoteshettabFin: Record 50084;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        SaveTxt: Text;
        NoteSheetTab: Record 50084;
        Entryno: Integer;
        NoteshetTab: Record 50084;
        len: Integer;
        Char10: Char;
        ApprovalCommentLine: Record 50084;
        UserTab: Record "User BOC";
        UserTab1: Record "User BOC";

}

