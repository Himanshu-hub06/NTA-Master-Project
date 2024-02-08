page 50203 "Requisition Under App Header"
{
    // {
    // UserTab1.RESET;
    // UserTab1.SETRANGE(UserTab1."User Name",USERID);
    // IF UserTab1.FINDFIRST THEN BEGIN
    //  SeniorityLevel := UserTab1."Seniority Level";
    // END;
    // UserTab.RESET;
    // UserTab.SETCURRENTKEY(UserTab."Seniority Level");
    // UserTab.SETFILTER(UserTab."Seniority Level",'<=%1',SeniorityLevel);
    // }
    // UserTab.SETRANGE(UserTab."Employee Left Status",'N');
    // //ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code",'SALPAY');
    // IF PAGE.RUNMODAL(50381,UserTab) = ACTION::LookupOK THEN
    // BEGIN
    //    "Sending UID" := UserTab."User Name";
    //    "Transfer User Name" := UserTab."Full Name";
    // END;
    // IF "Sending UID" = '' THEN
    //    "Transfer User Name" := '';

    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = 50087;
    SourceTableView = WHERE(Status = FILTER("Pending for Approval"));
    PromotedActionCategories = 'New,Process,Reports,Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                }
                field("Requisition from Other Section"; Rec."Requisition from Other Section")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    Caption = 'Req. To Section';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    Caption = 'Req. To Section Name';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Remarks"; Rec."Rejected Remarks")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Sending UID"; Rec."Sending UID")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer User ID';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'REQUISITION');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User ID", '<>%1', USERID);
                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Sending UID" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Full Name";
                        END;
                        IF Rec."Sending UID" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;
                }
                field("Transfer User Name"; Rec."Transfer User Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Attachment; Rec.Attachment)
                {
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Requisition Read";

                        if Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec."Attachment";
                            ServerFileName := FilePath + Rec."Attachment";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
            }
            part(RequisitionHeaderSubform; 50204)
            {
                ApplicationArea = All;
                SubPageLink = "Requisition No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Requisition &Slip")
            {
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ReqHeadRec.RESET;
                    ReqHeadRec.SETRANGE("No.", Rec."No.");
                    IF ReqHeadRec.FIND('-') THEN BEGIN
                        REPORT.RUNMODAL(50050, TRUE, TRUE, ReqHeadRec);
                    END;
                end;
            }
            action("&List")
            {
                Image = List;
                Promoted = true;
                ApplicationArea = All;
                RunObject = Page Issue;
                RunPageView = SORTING("No.")
                              ORDER(Ascending);
                Visible = false;
            }
            action("Re&open")
            {
                Image = ReOpen;
                Promoted = true;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    /*
                    IF Status = Status :: "Pending for Approval" THEN BEGIN
                      Status := Status :: Open;
                      "Approving UID" := '';
                      "Approving Date" := 0D;
                      "Approving Time" := 0T;
                      "Sending UID" := '';
                      "Sending Date" := 0D;
                      "Sending Time" := 0T;
                      MODIFY;
                      END;
                    //END ELSE
                      //  ERROR('Already Open');

                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.","No.");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                      REPEAT
                        RequisitionLine.Status := RequisitionLine.Status :: Open;
                        RequisitionLine.MODIFY;
                      UNTIL RequisitionLine.NEXT = 0;
                    END;

                    MESSAGE('Document No. %1 has successfully Reopen',"No.");
                    */

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

                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 50087);
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", rec."No.");
                    PAGE.RUN(PAGE::"Notesheet List", ApprovalCommentLine);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = false;
                Image = Cancel;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false; //nitin 07-09-23

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FIND('-') THEN
                        IF USERID <> ApprovalEntry."Sender ID" THEN
                            ERROR(CancelRequestErr, ApprovalEntry."Sender ID");


                    ReqHrd.RESET;
                    ReqHrd.SETRANGE(ReqHrd."No.", Rec."No.");
                    IF ReqHrd.FINDFIRST THEN BEGIN
                        ReqHrd."Sent for Authorization" := FALSE;
                        ReqHrd.Status := ReqHrd.Status::Open;
                        ReqHrd."Approving UID" := '';
                        ReqHrd."Approving Date" := 0D;
                        ReqHrd."Approving Time" := 0T;
                        ReqHrd."Sending UID" := '';
                        ReqHrd."Sending Date" := 0D;
                        ReqHrd."Sending Time" := 0T;
                        ReqHrd.MODIFY;
                    END;
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    ApprovalsMgmt: Codeunit 1535;
                    //kamlesh
                    Ins, Response : Boolean;
                    Usertab2: Record User;
                    SendMailCU: Codeunit "Send Mail(API)";
                    BodyMassage: Text[250];
                //kamlesh
                begin
                    TotalAppQty := 0;
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FIND('-') THEN BEGIN
                        REPEAT
                            TotalAppQty := TotalAppQty + RequisitionLine."Approved Qty";
                        UNTIL RequisitionLine.NEXT = 0;
                    END;
                    IF TotalAppQty = 0 THEN
                        ERROR('Approved Qty cannot be zero');

                    // UserSetup.RESET;
                    // UserSetup.SETRANGE(UserSetup."User ID", USERID);
                    // UserSetup.SETRANGE(UserSetup."Requisition Approval", FALSE);
                    // IF UserSetup.FINDFIRST THEN BEGIN
                    //     ERROR('You do not have permision to approve Requisition');

                    // END;
                    AppuserGroupMem.RESET;
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code", 'REQUISITION');
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."User ID", USERID);
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission", FALSE);
                    IF AppuserGroupMem.FINDFIRST THEN BEGIN
                        ERROR('You do not have permision to approve Requisition!');
                    END;

                    // Usersetup2.GET(USERID);// commented for changes via user's // Nitin 07-09-23
                    // IF ((Usersetup2."Store Section") <> Rec."Requisition to Section") THEN
                    //     ERROR('This requisition is %1 but forworded to %2 section,Please forword to other section', Rec."Requisition to Section", Usersetup2."Store Section");

                    IF NOT CONFIRM(Text0003) THEN
                        EXIT;
                    NoteshettabFin.RESET;
                    NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", rec."No.");
                    IF NOT NoteshettabFin.FINDFIRST THEN
                        ERROR('Please create note sheet in Purchase Proposal');
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
                    ApprovalEntry.SETRANGE("Table ID", 50087);
                    ApprovalEntry.SETRANGE("Approver ID", USERID);
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN

                        ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                        //  ApprovalEntry.Requisition := TRUE;
                        ins := ApprovalEntry.MODIFY;
                    END;
                    // kamlesh date 16-02-2023
                    // Clear(BodyMassage);
                    //  if ins then begin
                    //      BodyMassage := BodyMassage + StrSubstNo('Requisition No. %1 has been Approved by', Rec."No.");
                    //      BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';

                    //      Response := SendMailCU.Sendmail(UserId, StrSubstNo('Approval Request of Requsition No. %1', Rec."No."), BodyMassage);
                    //      if Response then begin
                    //         Usertab2.Reset();
                    //         Usertab2.SetRange("User Name", UserId);
                    //         if Usertab2.FindFirst() then
                    //             if Usertab2."Contact Email" = '' then
                    //                Message('Requisition is successfully approved!');
                    //      end;
                    //   end;
                    // kamlesh end date 16-02-2023
                    ReqHead.RESET;
                    ReqHead.SETRANGE(ReqHead."No.", Rec."No.");
                    IF ReqHead.FINDFIRST THEN BEGIN
                        ReqHead.Status := ReqHead.Status::Approved;
                        ReqHead."Approving UID" := UserId;
                        ReqHead."Approved By" := UserId;
                        ReqHead."Approving Date" := WORKDATE;
                        ReqHead."Approving Time" := TIME;
                        ReqHead."Pending From User Id" := '';
                        ReqHead."Pending From User" := '';
                        ReqHead."Sending UID" := '';
                        ReqHead."Transfer User Name" := '';
                        ReqHead.Posted := TRUE;
                        ReqHead.MODIFY;
                    END;

                    ReqLine.RESET;
                    ReqLine.SETRANGE(ReqLine."Requisition No.", Rec."No.");
                    IF ReqLine.FINDFIRST THEN BEGIN
                        REPEAT
                            ReqLine."Remaining Qty" := ReqLine.Quantity;
                            IF ReqLine."Approved Qty" <> 0 THEN
                                ReqLine."Approved Qty" := ReqLine.Quantity;
                            IF ReqLine."Item Type" = ReqLine."Item Type"::" " THEN BEGIN
                                IF Item.GET(ReqLine."No.") THEN
                                    ReqLine."Item Type" := Item."Item Type";
                            END;
                            ReqLine.MODIFY
                        UNTIL ReqLine.NEXT = 0;
                    END;
                    CurrPage.CLOSE;

                end;
            }
            action(Forword)
            {
                Image = Approvals;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    ApprovalsMgmt: Codeunit 1535;
                    Ins, Response : Boolean;
                    Usertab2: Record User;
                    SendMailCU: Codeunit "Send Mail(API)";
                    BodyMassage: Text[250];
                    NotTab: Record "Notification Tab";
                    NotTab1: Record "Notification Tab";
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    Rec.TESTFIELD("Sending UID");
                    IF NOT CONFIRM(Text0005) THEN
                        EXIT;

                    //IF ApproverUser = '' THEN
                    // ERROR('Please select Approver User ID');

                    NoteshettabFin.RESET;
                    NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", rec."No.");
                    IF NOT NoteshettabFin.FINDFIRST THEN
                        ERROR('Please create note sheet in Requisition');
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

                    ApprovalEntry1.RESET;
                    ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50087);
                    ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                    ApprovalEntry1.SETRANGE(ApprovalEntry1.Status, ApprovalEntry1.Status::Open);
                    //ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID",USERID);
                    IF ApprovalEntry1.FINDFIRST THEN BEGIN
                        ApprovalEntry1.Status := ApprovalEntry1.Status::Forwarded;
                        ApprovalEntry1."Forwarding Date-Time" := CURRENTDATETIME;
                        ApprovalEntry1.MODIFY;

                    END;
                    ApprovalEntry2.RESET;
                    IF ApprovalEntry2.FINDLAST THEN BEGIN
                        "EntryNo." := ApprovalEntry2."Entry No.";

                    END;
                    NotTab.Reset();
                    If NotTab.FindLast() Then begin
                        entryNo := NotTab."Entry No.";
                    end;
                    NotTab1.Reset();
                    NotTab1."Entry No." := entryNo + 1;
                    NotTab1."Posting Date" := Today;
                    NotTab1."Sender ID" := UserId;
                    NotTab1."Receiver ID" := Rec."Sending UID";
                    NotTab1.read := false;
                    NotTab1."Notification Details" := 'Requisition No.' + rec."No." + ' ' + 'Receive for your consideration ';
                    NotTab1.Insert();
                    ApprovalEntry3.RESET;
                    ApprovalEntry3.SETRANGE(ApprovalEntry3."Table ID", 50170);
                    ApprovalEntry3.SETRANGE(ApprovalEntry3."Document No.", Rec."No.");
                    IF ApprovalEntry3.FINDLAST THEN BEGIN
                        "SeqNo." := ApprovalEntry3."Sequence No."
                    END
                    ELSE
                        "SeqNo." := 0;
                    ApprovalEntry.RESET;
                    ApprovalEntry."Entry No." := "EntryNo." + 1;
                    ApprovalEntry."Table ID" := 50087;
                    ApprovalEntry."Document No." := Rec."No.";
                    ApprovalEntry."Sequence No." := "SeqNo." + 1;
                    ApprovalEntry."Sender ID" := USERID;
                    ApprovalEntry."Approver ID" := Rec."Sending UID";
                    ApprovalEntry.Status := ApprovalEntry.Status::Open;
                    ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                    ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
                    ApprovalEntry."Last Modified By User ID" := USERID;
                    ApprovalEntry.VALIDATE("Location Code", Rec."Location Code");
                    ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    //ApprovalEntry.Requisition := TRUE;
                    ApprovalEntry."Record ID to Approve" := Rec.RECORDID;
                    ins := ApprovalEntry.INSERT;
                    // kamlesh date 16-02-2023
                    // Clear(BodyMassage);
                    //  Clear(Response);
                    //  if ins then begin
                    //       BodyMassage := BodyMassage + StrSubstNo('Requisition No. %1 has been forwarded by', Rec."No.");
                    //       BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                    //       Response := SendMailCU.Sendmail(Rec."Sending UID", StrSubstNo('Approval Request of Requsition No. %1', Rec."No."), BodyMassage);
                    //       if Response then begin
                    //           Usertab2.Reset();
                    //            Usertab2.SetRange("User Name", Rec."Sending UID");
                    //           if Usertab2.FindFirst() then
                    //               if Usertab2."Contact Email" = '' then
                    //                   Message('Requisition has been Forwarded to %1!', Usertab2."Full Name");
                    //       end;
                    //   end;
                    // kamlesh end date 16-02-2023
                    ReqHead.RESET;
                    ReqHead.SETRANGE(ReqHead."No.", Rec."No.");
                    IF ReqHead.FINDFIRST THEN BEGIN
                        ReqHead.Status := ReqHead.Status;
                        ReqHead."Pending From User Id" := Rec."Sending UID";
                        ReqHead."Pending From User" := Rec."Transfer User Name";
                        ReqHead."Approving UID" := Rec."Sending UID";
                        ReqHead."Approving Date" := WORKDATE;
                        ReqHead."Approving Time" := TIME;
                        ReqHead."Sending UID" := '';
                        ReqHead."Transfer User Name" := '';
                        ReqHead.MODIFY;
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
                    ApprovalsMgmt: Codeunit 1535;
                begin

                    IF NOT CONFIRM(Text0004) THEN
                        EXIT;
                    Rec.TESTFIELD("Rejected Remarks");
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE("Table ID", 50087);
                    ApprovalEntry.SETRANGE("Approver ID", USERID);
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN
                        ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                        ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry.MODIFY;
                    END;

                    ReqHead.RESET;
                    ReqHead.SETRANGE(ReqHead."No.", Rec."No.");
                    IF ReqHead.FINDFIRST THEN BEGIN
                        ReqHead.Status := ReqHead.Status::Rejected;
                        ReqHead.MODIFY;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("View attachment")
            {
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    FileDir.Get();
                    //LoaPath := FileDir.Loa;
                    //  FilePath := 'http://192.168.10.60/boc_ftp/loa/';
                    FilePath := FileDir."Requisition Read";

                    IF Rec.Attachment <> '' THEN BEGIN
                        OldFileName := Rec.Attachment;
                        ServerFileName := FilePath + Rec.Attachment;
                        HYPERLINK(ServerFileName);
                    END;
                end;
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
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TESTFIELD(Status,Status::Open);
    end;

    trigger OnOpenPage()
    begin
        //  Rec.SetSecurityFilter;//EXPDIP
    end;


    var
        ReqHeadRec: Record 50087;
        NoofRec: Integer;
        LineNo: Integer;
        ProdOrderComp: Record 5407;
        Item: Record 27;
        Window: Dialog;
        RequisitionLine2: Record 50088;
        ILERemQty: Decimal;
        AvailQty: Decimal;
        RemQty: Decimal;
        UserSetup: Record 91;
        LocCode: Code[20];
        LineNo2: Integer;
        LocCode2: Code[20];
        ProdOrder: Record 5405;
        ProdOrderComp2: Record 5407;
        ActualQtyForIndent: Decimal;
        ItemSubs: Record 5715;
        item3: Record 27;
        SubstituteItemStock: Decimal;
        Location6: Record 14;
        RequisitionLine: Record 50088;
        ShortcutDimCode: array[8] of Code[20];
        ApprovalMagmt: Codeunit 1535;
        User1: Code[50];
        User2: Code[50];
        Text0001: Label 'Status must be Open for Indent %1';
        Text002: Label 'You cannot rename a %1.';
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        ApprovalEntry: Record 454;
        CancelRequestErr: Label 'Document Sent by %. You cannot cancel approval request.';
        ReqHrd: Record 50087;
        Text0003: Label 'Do you want to approve ?';
        Text0005: Label 'Do you want to Forword higher authority for approval ?';
        Text0004: Label 'Do you want to reject ?';
        OldFileName: Text;
        ServerFileName: Text;
        AppuserGroupMem: Record 50082;
        ReqHead: Record 50087;
        FilePath: Text[150];
        TotalAppQty: Decimal;
        UserTab: Record "User BOC";
        UserTab1: Record "User BOC";
        SeniorityLevel: Integer;
        ApprovalEntry1,//: Record "454";
        ApprovalEntry2,//: Record "454";
        ApprovalEntry3 : Record 454;
        "EntryNo.": Integer;
        ReqLine: Record 50088;
        UserSetup1: Record 91;
        ReqHead1: Record 50087;
        ReqLine1: Record 50088;
        EntryNo: Integer;
        Loctab1: Record 14;
        DimValue: Record 349;
        Usersetup2: Record 91;
        "SeqNo.": Integer;
        FileDir: Record 50083;
        NoteshettabFin: Record 50084;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        SaveTxt: Text;
        NoteSheetTab: Record 50084;
        Vis001: Boolean;
        NoteshetTab: Record 50084;
        len: Integer;
        Char10: Char;
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50082;
}

