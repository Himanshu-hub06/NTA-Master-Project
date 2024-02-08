page 50168 "Gems Proposal Approved"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER(Approved),
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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Approved By Name"; "Approved By Name")
                // {
                // }
                field("Indented By"; Rec."Indented By")
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
                    Visible = false;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /* //block commented by kamlesh date 31-01-2023
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'PURCHPRO');
                        //ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User Name",'<>%1',USERID);
                        IF ("Shortcut Dimension 2 Code" = 'S079') OR ("Shortcut Dimension 2 Code" = 'S108') THEN BEGIN
                            ApprovalUserGroup.SETRANGE(ApprovalUserGroup.Section, 'S108');
                        END
                        ELSE BEGIN
                            IF ("Shortcut Dimension 2 Code" = 'S078') OR ("Shortcut Dimension 2 Code" = 'S109') THEN
                                ApprovalUserGroup.SETRANGE(ApprovalUserGroup.Section, 'S109');
                        END;
                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            "Transfer User Id" := ApprovalUserGroup."User Name";
                            "Transfer User Name" := ApprovalUserGroup."User Description";
                        END;
                        IF "Transfer User Id" = '' THEN
                            "Transfer User Name" := '';
                     */
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

                    trigger OnValidate()
                    begin
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;
                }
                field("Transfer User Name"; Rec."Transfer User Name")
                {
                    Visible = false;
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
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
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
            }
            // part(ProposalLine; 50293)
            part(ProposalLine; "Purchase Proposal Line")
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

                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 50011);
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
                        FilePath := 'http://115.243.18.40/bseb_ftp/PurchProposal/';
                        IF Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec.Attachment;
                            ServerFileName := FilePath + Rec.Attachment;
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
                action(Attachment1)
                {
                    ApplicationArea = All;
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //UploadAttachment;
                        IF Rec.Attachment <> '' THEN
                            IF NOT CONFIRM('Purchase Proposal is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchProposal\';
                        OldFileName := (FilePath + Rec.Attachment);
                        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                        ClientFileName := FileManagement.GetFileName(ServerFileName);
                        IF ClientFileName <> '' THEN BEGIN
                            Rec.Attachment := DELCHR(Rec."No.", '=', '/') + ClientFileName;
                            Rec.MODIFY(TRUE);
                        END;
                        ClientFileName := FilePath + Rec.Attachment;
                        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                        IF OldFileName <> '' THEN
                            FileManagement.DeleteServerFile(OldFileName);
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
                action("Work Order ")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        PurchProHead.RESET;
                        PurchProHead.SETRANGE("No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN
                            REPORT.RUN(50142, TRUE, TRUE, PurchProHead);
                    end;
                }
                action(Forword)
                {
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record 454;
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Approved);
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
                                /* //block commented by kamlesh date 31-01-2023
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                               */
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
                                /* //block commented by kamlesh date 31-01-2023
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                */
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
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Forwarded;
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
                        ApprovalEntry."Table ID" := 50011;
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
                        ApprovalEntry.INSERT;

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
                action("Send for Approval Revised Rate")
                {
                    Caption = 'Send for Approval Revised Rate';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record 454;
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Approved);
                        IF Rec.Remarks = '' THEN
                            ERROR('Please enter remarks in case of rate revised');
                        IF NOT CONFIRM(Text0005) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");
                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", Rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in GeM Direct Purchase');
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
                                /* //block commented by kamlesh date 31-01-2023
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                */
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
                                /* //block commented by kamlesh date 31-01-2023
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                */
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
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Forwarded;
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
                        ApprovalEntry."Table ID" := 50011;
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
                        //  ApprovalEntry."Purchase Proposal" := TRUE;
                        ApprovalEntry."Record ID to Approve" := Rec.RECORDID;
                        ApprovalEntry.INSERT;

                        PurchProHead.RESET;
                        PurchProHead.SETRANGE(PurchProHead."No.", Rec."No.");
                        IF PurchProHead.FINDFIRST THEN BEGIN
                            PurchProHead.Status := PurchProHead.Status::"Pending for Approval";
                            PurchProHead."Pending From User Id" := Rec."Transfer User Id";
                            PurchProHead."Pending From User Name" := Rec."Transfer User Name";
                            PurchProHead."Transfer User Id" := '';
                            PurchProHead."Transfer User Name" := '';
                            PurchProHead.MODIFY;
                        END;
                        CurrPage.CLOSE;
                    end;
                }
                action("Upload Contract for GeM")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.UploadProposalAttachment(1);
                    end;
                }
                action("Crac Upload GeM")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.UploadProposalAttachment(2);
                    end;
                }
                action("Thirdy Party Inspection")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.UploadProposalAttachment(3);
                    end;
                }
                action("Final Work Order Attachment")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        /* //block commented by kamlesh date 31-01-2023
                        //UploadAttachment;
                        IF Attachment4 <> '' THEN
                            IF NOT CONFIRM('Final Work Order is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchProposal\';
                        OldFileName := (FilePath + Attachment4);
                        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                        ClientFileName := FileManagement.GetFileName(ServerFileName);
                        IF ClientFileName <> '' THEN BEGIN
                            Attachment4 := DELCHR("No.", '=', '/') + ClientFileName;
                            MODIFY(TRUE);
                        END;
                        ClientFileName := FilePath + Attachment4;
                        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                        IF OldFileName <> '' THEN
                            FileManagement.DeleteServerFile(OldFileName);
                            */
                    end;
                }
                action("View Final Work Order attachment")
                {
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        /*
                        FilePath := 'http://115.243.18.40/bseb_ftp/PurchProposal/';
                        IF Attachment4 <> '' THEN BEGIN
                            OldFileName := Attachment4;
                            ServerFileName := FilePath + Attachment4;
                            HYPERLINK(ServerFileName);
                        END;
                        */
                    end;
                }
                action("Cancel Demand Order")
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want Cancel Demand Order?', TRUE, Rec."No.") THEN BEGIN
                            PurchProLine.RESET;
                            PurchProLine.SETRANGE(PurchProLine."Document No.", Rec."No.");
                            IF PurchProLine.FINDFIRST THEN BEGIN
                                /*//block commented by kamlesh date 31-01-2023
                                   PurchProLine.TESTFIELD(PurchProLine.Remarks);
                                   PurchProLine."Cancel Demand Order No." := PurchProLine."Demand Order No.";
                                   PurchProLine."Cancel Demand Order Date" := PurchProLine."Demand Order Date";
                                   PurchProLine."Cancel Rate" := PurchProLine."Direct Unit Cost";
                                   PurchProLine."Demand Order No." := '';
                                   PurchProLine."Demand Order Date" := 0D;
                                   PurchProLine.MODIFY;
                                   */
                            END;


                            //Reopen;
                        END;
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
                    Caption = 'Create Purchase Praposal';
                    Image = Post;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        /* //block commented by kamlesh date 31-01-2023
                        IndentLine.RESET;
                        IndentLine.SETRANGE(IndentLine."Document No.", "No.");
                        IndentLine.SETRANGE(IndentLine."Select Item For Proposal", TRUE);
                        IF IndentLine.FINDFIRST THEN BEGIN
                            ItemJnlManag.FillPurchasePraposalFromIndent("No.");
                        END
                        ELSE
                            ERROR('Please select Indent line for Purchase Praposal Creation');
                    */
                    end;
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
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //IF CONFIRM('Do you want Approve the Indent?', TRUE, "No.") THEN
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

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        // IndentLine: Record "50040";
        IndentLine: Record "Indent Line";
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead: Record "Indent Header";
        // IndentHead: Record "50039";
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
        ItemJnlManag: Codeunit 240;
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        PurchProHead: Record "Purchase Proposal Header";
        // PurchProHead: Record "50011";
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50082;
        "EntryNo.": Integer;
        Text0005: Label 'Do you wand to forword Purchase Proposal?';
        ApprovalEntry1: Record 454;
        "SeqNo.": Integer;
        NoteshettabFin: Record 50084;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        Newline: Text;
        NSheetTab: Record 50084;
        USetup: Record 91;
        SectCode: Code[10];
        SectUser: Code[20];
        //  USetupList: Page user;
        NStTab: Record 50084;
        SaveTxt: Text;
        len: Integer;
        Edtble: Boolean;
        UserTab: Record 2000000120;
        Char10: Char;
        NoteSheetTab: Record 50084;
        Entryno: Integer;
        NoteshetTab: Record 50084;
        PurchProLine: Record "Purchase Proposal Line";
        FileDir: Record 50083;

}

