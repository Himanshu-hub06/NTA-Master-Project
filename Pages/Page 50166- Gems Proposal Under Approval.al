page 50166 "Gems Proposal Under Approval"
{
    Caption = 'Gems Proposal Under Approval';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    // SourceTable = Table50011;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER("Pending for Approval"),
                            "Purchase Type" = CONST(GeM));

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
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("Transfer User Id"; Rec."Transfer User Id")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        ApprovalUserGroup.Reset();
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'PURCHPRO');
                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Transfer User Id" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Description";
                        END;
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                        /*
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code",'PURCHPRO');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User Name",'<>%1',USERID);
                        IF PAGE.RUNMODAL(0,ApprovalUserGroup) = ACTION::LookupOK THEN
                        BEGIN
                           "Transfer User Id" := ApprovalUserGroup."User Name";
                           "Transfer User Name" := ApprovalUserGroup."User Description";
                        END;
                        */

                    end;

                    // trigger OnValidate()
                    // begin
                    //     IF Rec."Transfer User Id" = '' THEN
                    //         Rec."Transfer User Name" := '';
                    // end;
                }
                field("Transfer User Name"; Rec."Transfer User Name")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Purchase Proposal Read";

                        if Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec."Attachment";
                            ServerFileName := FilePath + Rec."Attachment";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }

                field("Contract for GeM"; Rec.Attachment1)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Contract for GeM';
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Purchase Proposal Read";

                        if Rec.Attachment1 <> '' THEN BEGIN
                            OldFileName := Rec."Attachment1";
                            ServerFileName := FilePath + Rec."Attachment1";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
                field("Crac for GeM"; Rec.Attachment2)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Crac for GeM';
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Purchase Proposal Read";

                        if Rec.Attachment2 <> '' THEN BEGIN
                            OldFileName := Rec."Attachment2";
                            ServerFileName := FilePath + Rec."Attachment2";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
                field("Thirdy Party Inspection"; Rec.Attachment3)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Thirdy Party Inspection';
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();

                        FilePath := FileDir."Purchase Proposal Read";

                        if Rec.Attachment3 <> '' THEN BEGIN
                            OldFileName := Rec."Attachment3";
                            ServerFileName := FilePath + Rec."Attachment3";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
                field("converted Purchase Type"; Rec."converted Purchase Type")
                {
                    ApplicationArea = All;
                }
            }
            part("GeM Proposal Line"; "Gems Propos Under App Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function ")
            {
                action("Note &Sheet")
                {
                    Caption = 'Note &Sheet';
                    Image = ViewComments;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin

                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 50179);
                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", Rec."No.");
                        PAGE.RUN(PAGE::"Notesheet List", ApprovalCommentLine);
                    end;
                }
                action("View attachment")
                {
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        FileDir.Get();
                        //LoaPath := FileDir.Loa;
                        //  FilePath := 'http://192.168.10.60/boc_ftp/loa/';
                        FilePath := FileDir."Purchase Proposal Read";

                        IF Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec.Attachment;
                            ServerFileName := FilePath + Rec.Attachment;
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
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

                        //CurrPage.IndentLine.PAGE.GetPurchReqLines;
                    end;
                }
                action("Proposal Calculation Sheet")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        PurchProHead.RESET;
                        PurchProHead.SETRANGE("No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN
                            REPORT.RUN(50141, TRUE, TRUE, PurchProHead);
                    end;
                }
            }
            group(Posting)
            {
                action(Refresh)
                {
                    Image = Refresh;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
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
                    begin

                        IF NOT CONFIRM(Text0003) THEN
                            EXIT;
                        AppuserGroupMem.RESET;
                        AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code", 'PURCHPRO');
                        AppuserGroupMem.SETRANGE(AppuserGroupMem."User ID", USERID);
                        AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission", FALSE);
                        IF AppuserGroupMem.FINDFIRST THEN
                            ERROR('You do not have permision to approve Purchase Proposal');

                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE("Table ID", 50179);
                        ApprovalEntry.SETRANGE("Approver ID", USERID);
                        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN

                            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                            ApprovalEntry.MODIFY;
                        END;
                        // Rec.TESTFIELD("Transfer User Id");//nitin
                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", Rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in Purchase Proposal');
                        NoteshetTab.RESET;
                        NoteshetTab.SETRANGE("Document No.", Rec."No.");
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
                        IF ApprovalEntry1.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry1."Entry No.";
                        END;

                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50011);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        IF ApprovalEntry1.FINDLAST THEN BEGIN
                            "SeqNo." := ApprovalEntry1."Sequence No."
                        END
                        ELSE
                            "SeqNo." := 0;
                        ApprovalEntry1.RESET;
                        ApprovalEntry1."Entry No." := "EntryNo." + 1;
                        ApprovalEntry1."Table ID" := 50179;
                        ApprovalEntry1."Document No." := Rec."No.";
                        ApprovalEntry1."Sequence No." := "SeqNo." + 1;
                        ApprovalEntry1."Sender ID" := Rec."User ID";
                        ApprovalEntry1."Approver ID" := Rec."Transfer User Id";
                        ApprovalEntry1.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry1."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry1."Last Date-Time Modified" := CURRENTDATETIME;
                        ApprovalEntry1."Last Modified By User ID" := USERID;
                        ApprovalEntry1.VALIDATE("Location Code", Rec."Location Code");
                        ApprovalEntry1.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        //ApprovalEntry."Purchase Proposal" := TRUE;
                        ApprovalEntry1."Record ID to Approve" := Rec.RECORDID;
                        ApprovalEntry1.INSERT;
                        PurchProHead.RESET;
                        PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN BEGIN
                            PurchProHead.Status := PurchProHead.Status::Approved;
                            PurchProHead."Pending From User Id" := Rec."Transfer User Id";
                            PurchProHead."Pending From User Name" := Rec."Transfer User Name";
                            // PurchProHead."Transfer User Id" := '';//nitin250823
                            // PurchProHead."Transfer User Name" := '';
                            PurchProHead.MODIFY;
                        END;
                        //Nitin
                        PurchaseProposalLine.RESET;
                        PurchaseProposalLine.SETRANGE(PurchaseProposalLine."Document No.", REC."No.");
                        IF PurchaseProposalLine.FINDFIRST THEN BEGIN
                            REPEAT
                                PurchaseProposalLine.Status := PurchaseProposalLine.Status::Approved;
                                PurchaseProposalLine."Purchase Type" := Rec."Purchase Type";
                                PurchaseProposalLine.MODIFY;
                            UNTIL PurchaseProposalLine.NEXT = 0;
                        END;
                        CurrPage.CLOSE;

                        /*
                        IF NOT CONFIRM(Text0003) THEN
                            EXIT;
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.","No.");
                        ApprovalEntry.SETRANGE("Table ID",50011);
                        ApprovalEntry.SETRANGE("Approver ID",USERID);
                        ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN

                          ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                        END;
                        CurrPage.CLOSE;
                        */

                    end;
                }
                action(Forword)
                {
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Ins, Response : Boolean;
                        Usertab2: Record User;
                        SendMailCU: Codeunit "Send Mail(API)";
                        BodyMassage: Text[250];
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                        IF NOT CONFIRM(Text0005) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");
                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", Rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in Invoice');
                        NoteshetTab.RESET;
                        NoteshetTab.SETRANGE("Document No.", Rec."No.");
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
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50011);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        ApprovalEntry1.SETRANGE(ApprovalEntry1.Status, ApprovalEntry1.Status::Open);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID", USERID);
                        IF ApprovalEntry1.FINDFIRST THEN BEGIN
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Approved;
                            ApprovalEntry1."Forwarding Date-Time" := CURRENTDATETIME;
                            ApprovalEntry1.MODIFY;

                        END;
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50011);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        IF ApprovalEntry1.FINDLAST THEN BEGIN
                            "SeqNo." := ApprovalEntry1."Sequence No."
                        END
                        ELSE
                            "SeqNo." := 0;
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Table ID" := 50179;
                        ApprovalEntry."Document No." := Rec."No.";
                        ApprovalEntry."Sequence No." := "SeqNo." + 1;
                        ApprovalEntry."Sender ID" := Rec."User ID";
                        ApprovalEntry."Approver ID" := Rec."Transfer User Id";
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
                        ApprovalEntry."Last Modified By User ID" := USERID;
                        ApprovalEntry.VALIDATE("Location Code", Rec."Location Code");
                        ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        // ApprovalEntry."Purchase Proposal" := TRUE;
                        ApprovalEntry."Record ID to Approve" := Rec.RECORDID;
                        ins := ApprovalEntry.INSERT;
                        //kamlesh date 15-02-2023
                        Clear(BodyMassage);
                        Clear(Response);
                        if ins then begin
                            BodyMassage := BodyMassage + StrSubstNo('Gem Purchase Proposal No. %1 has been send by', Rec."No.");
                            BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                            // Error(BodyMassage);
                            Usertab2.Reset();
                            Usertab2.SetRange("User Name", Rec."Transfer User Id");
                            if Usertab2.FindFirst() then
                                if Usertab2."Contact Email" <> '' then
                                    SendMailCU.Sendmail(Rec."Transfer User Id", StrSubstNo('Approval Request of Gem Purchase Proposal No. %1', Rec."No."), BodyMassage)
                                else
                                    Message('Gem Purchase Proposal has been Forwarded to %1!', Usertab2."Full Name");

                        end;
                        //kamlesh end date 15-02-2023
                        PurchProHead.RESET;
                        PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN BEGIN
                            PurchProHead."Pending From User Id" := Rec."Transfer User Id";
                            PurchProHead."Pending From User Name" := Rec."Transfer User Name";
                            PurchProHead."Transfer User Id" := '';
                            PurchProHead."Transfer User Name" := '';
                            PurchProHead.MODIFY;
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
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        IF NOT CONFIRM(Text0005) THEN
                            EXIT;
                        Rec.TESTFIELD(Remarks);

                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE("Table ID", 50179);
                        ApprovalEntry.SETRANGE("Approver ID", USERID);
                        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN BEGIN

                            ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                            ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                            ApprovalEntry.MODIFY;
                        END;

                        PurchProHead.RESET;
                        PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN BEGIN
                            PurchProHead.Status := PurchProHead.Status::Rejected;
                            PurchProHead.MODIFY;
                        END;
                        /*
                        IF NOT CONFIRM(Text0005) THEN
                           EXIT;
                        TESTFIELD(Remarks);
                        //CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Document No.","No.");
                        ApprovalEntry.SETRANGE("Table ID",50011);
                        ApprovalEntry.SETRANGE("Approver ID",USERID);
                        //ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN
                          ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                          */
                        IndentHead1.RESET;
                        IndentHead1.SETRANGE(IndentHead1."Purchase Proposal No.", Rec."No.");
                        IF IndentHead1.FINDFIRST THEN BEGIN
                            IndentHead1."Proposal Created Date" := 0D;
                            IndentHead1."Purchase Proposal Created" := FALSE;
                            IndentHead1.MODIFY;
                        END;
                        PurchaseProposalLine.RESET;
                        PurchaseProposalLine.SETRANGE(PurchaseProposalLine."Document No.", Rec."No.");
                        IF PurchaseProposalLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IndentLine1.RESET;
                                IndentLine1.SETRANGE(IndentLine1."Purchase Proposal No.", PurchaseProposalLine."Document No.");
                                IndentLine1.SETRANGE(IndentLine1."Purchase Proposal Line No.", PurchaseProposalLine."Line No.");
                                IF IndentLine1.FINDFIRST THEN BEGIN
                                    IndentLine1."Purchase Proposal Created" := FALSE;
                                    IndentLine1."Purchase Proposal No." := '';
                                    IndentLine1."Purchase Proposal Line No." := 0;
                                    IndentLine1.MODIFY;
                                END;
                            UNTIL PurchaseProposalLine.NEXT = 0;
                        END;

                        CurrPage.CLOSE;

                    end;
                }
                action("Send Email")
                {
                    Visible = false;

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
                action("View Note Sheet")
                {
                    Visible = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin

                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", Rec."No.");
                        PAGE.RUN(PAGE::"NoteSheet Display", ApprovalCommentLine);
                    end;
                }
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
            action("Convert Purchase  Proposal")
            {

                trigger OnAction()
                begin
                    IF NOT CONFIRM(Text0006) THEN
                        EXIT;
                    Rec.TESTFIELD("converted Purchase Type");
                    PurchProHead.RESET;
                    PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                    IF PurchProHead.FINDFIRST THEN BEGIN
                        PurchProHead."Purchase Type" := PurchProHead."converted Purchase Type";
                        PurchProHead."Converted User ID" := USERID;
                        PurchProHead."Converted Date" := WORKDATE;
                        PurchProHead.MODIFY;
                    END;
                    AppuserGroupMem.RESET;
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code", 'PURCHPRO');
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."User ID", USERID);
                    AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission", FALSE);
                    IF AppuserGroupMem.FINDFIRST THEN
                        ERROR('You do not have permision to approve Requisition');

                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE("Table ID", 50179);
                    ApprovalEntry.SETRANGE("Approver ID", USERID);
                    ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN BEGIN

                        ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                        ApprovalEntry.MODIFY;
                    END;
                    PurchProHead.RESET;
                    PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                    IF PurchProHead.FINDFIRST THEN BEGIN
                        PurchProHead.Status := PurchProHead.Status::Approved;

                        PurchProHead.MODIFY;
                    END;
                    /*
                    InComdoc.RESET;
                    InComdoc.SETRANGE(InComdoc."Document No.","No.");
                    IF InComdoc.FINDFIRST THEN BEGIN
                    REPEAT
                    InComdoc.Active := TRUE;
                    InComdoc.MODIFY;
                    UNTIL InComdoc.NEXT = 0;
                    END;
                    */
                    MESSAGE('Purchase Proposal converted and approved successfully');
                    CurrPage.CLOSE;

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        IndentLine: Record "Indent Line";
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead: Record "Indent Header";
        UserSetup_gRec: Record "User Setup";
        SenderAddress: Text[100];
        Recipient: Text[200];
        SenderName: Text[100];
        Subject: Text[100];
        Body: Text[100];

        UserSetup: Record "User Setup";
        CCName: Text;
        ItemDescription: Text[150];
        ItemNo: Code[20];
        ItemQty: Decimal;
        ApprovalEntry: Record "Approval Entry";

        Text0003: Label 'Do you want to approve ?';
        IndentHead1: Record "Indent Header";
        IndentLine1: Record "Indent Line";
        PurchaseProposalLine: Record "Purchase Proposal Line";
        Text0005: Label 'Do you want to Forword  Purchase Proposal ?';
        AppuserGroupMem: Record "Approval User Group Member";
        PurchProHead: Record "Purchase Proposal Header";
        Text0006: Label 'Do you want to Convert  Purchase Proposal ?';
        ServerFileName: Text;
        ClientFileName: Text;
        //FileManagement: Codeunit "419";
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record "Approval User Group Member";
        "EntryNo.": Integer;
        PurchPropHead: Record "Purchase Proposal Header";
        ApprovalEntry1: Record "Approval Entry";
        "SeqNo.": Integer;
        NoteshettabFin: Record NoteSheet;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        Newline: Text;
        NSheetTab: Record NoteSheet;
        USetup: Record "User Setup";
        SectCode: Code[10];
        SectUser: Code[20];
        USetupList: Page "User Setup";
        NStTab: Record NoteSheet;
        SaveTxt: Text;
        len: Integer;
        Edtble: Boolean;
        UserTab: Record "User BOC";
        Char10: Char;
        NoteSheetTab: Record NoteSheet;
        Entryno: Integer;
        NoteshetTab: Record NoteSheet;
        FileDir: Record 50083;
}

