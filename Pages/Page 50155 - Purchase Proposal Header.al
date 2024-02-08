page 50155 "Purchase Proposal Header"
{
    // ApprovalUserGroup.RESET;
    // ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code",'PURCHPRO');
    // ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User Name",'<>%1',USERID);
    // IF PAGE.RUNMODAL(0,ApprovalUserGroup) = ACTION::LookupOK THEN
    // BEGIN
    //    "Transfer User Id" := ApprovalUserGroup."User Name";
    //    "Transfer User Name" := ApprovalUserGroup."User Description";
    // END;
    // IF "Transfer User Id" = '' THEN
    //   "Transfer User Name" :=  '';

    DeleteAllowed = false;
    InsertAllowed = true;
    LinksAllowed = false;
    PageType = Document;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER(Open),
      "Purchase Type" = CONST(Direct));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Indented By"; Rec."Indented By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    Editable = false;
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
                // commented by kamlesh date 25-01-2023
                // field(Attachment5; Attachment5)
                // {
                //     Caption = 'Estimate Attachment';
                // }
                // field("Total Amount(Exclusing GST)"; "Total Amount(Exclusing GST)")
                // {
                // }
                // field("Total Amount(Including GST)"; "Total Amount(Including GST)")
                // {
                // }
                // end kamlesh date 25-01-2023
                field("Transfer User Id"; Rec."Transfer User Id")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'PURCHPRO');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User ID", '<>%1', USERID);
                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Transfer User Id" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Full Name";
                        END;
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;
                }
                field("Transfer User Name"; Rec."Transfer User Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Purchase Proposal"; "Purchase Proposal Line")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Document No.", "Line No.");
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ApplicationArea = All;
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
                action(Release)
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Rec."Due Date");
                        //TESTFIELD("Cost Centre Dimension");
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                        Rec.TESTFIELD("Indent Date");

                        Rec.Release;
                    end;
                }
                action("Fill Indent Line")
                {
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        /*
                        IF Status = Status::"Pending for Approval" THEN
                          ERROR('Document Must be Open');

                        TESTFIELD("Location Code");
                        TESTFIELD("Shortcut Dimension 2 Code");
                        IndentLine1.RESET;
                        IndentLine1.SETRANGE(IndentLine1."Document No.","No.");
                        IF IndentLine1.FINDFIRST THEN BEGIN
                          IF CONFIRM (Text005_gTxt,FALSE) THEN BEGIN
                            REPEAT
                            RequisitionLine.SETRANGE(RequisitionLine."Requisition No.",IndentLine1."Requisition No.");
                            RequisitionLine.SETRANGE(RequisitionLine."Line No.",IndentLine1."Requisition Line No.");
                            IF RequisitionLine.FINDFIRST THEN BEGIN
                              RequisitionLine."Requisition Selected" := FALSE;
                              RequisitionLine.MODIFY;
                            END;
                            UNTIL IndentLine1.NEXT = 0;
                          IndentLine1.DELETEALL;
                          END;

                        END;
                        CurrPage.IndentLine.PAGE.GetPurchReqLines;
                        */

                    end;
                }
                action(Reopen)
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.Reopen;
                    end;
                }
                action("Estimate Attachment")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Attachment <> '' THEN
                            IF NOT CONFIRM('GeM Purchase Proposal is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FileDir.Get();

                        FilePath := FileDir."Purchase Proposal Write";
                        OldFileName := (FilePath + Rec.Attachment);
                        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                        ClientFileName := FileManagement.GetFileName(ServerFileName);
                        IF ClientFileName <> '' THEN BEGIN
                            Rec.Attachment := ClientFileName;
                            Rec.MODIFY(TRUE);
                        END;
                        ClientFileName := FilePath + Rec.Attachment;
                        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                        IF OldFileName <> '' THEN
                            FileManagement.DeleteServerFile(OldFileName);

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
                action("View Estimate attachment")
                {
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //below lines commented by kamlesh date 25-01-2023

                        // FilePath := 'http://115.243.18.40/bseb_ftp/PurchProposal/';
                        // IF Attachment5 <> '' THEN BEGIN
                        //     OldFileName := Attachment5;
                        //     ServerFileName := FilePath + Attachment5;
                        //     HYPERLINK(ServerFileName);
                        // END;
                    end;
                }
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
                        /*
                        IndentLine.SETRANGE("Document No.","No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                          REPEAT
                            IF IndentLine."Purchase Order No." = '' THEN
                              PurchaseOrder := IndentLine."Purchase Order No.";
                          UNTIL IndentLine.NEXT = 0;
                          IF PurchaseOrder <> '' THEN BEGIN
                            Posted := TRUE;
                            "Manual Close" := TRUE;
                            MODIFY;
                          END ELSE
                            ERROR('This Indent is not selected in any Purchase Document');
                        END;
                        */

                    end;
                }
                action("Indent Print")
                {
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*
                        IndentHead.SETRANGE("No.","No.");
                        IF IndentHead.FINDFIRST THEN
                          REPORT.RUN(50010,TRUE,TRUE,IndentHead);
                        */

                    end;
                }
                action("Send For Approval")
                {
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Ins, Response : Boolean;
                        Usertab2: Record User;
                        SendMailCU: Codeunit "Send Mail(API)";
                        BodyMassage: Text[250];
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code");
                        PraposalLine.RESET;
                        PraposalLine.SETRANGE(PraposalLine."Document No.", Rec."No.");
                        PraposalLine.SETRANGE(PraposalLine."Estimated Cost", 0);
                        IF PraposalLine.FINDFIRST THEN BEGIN
                            ERROR('Before send for approval please enter Estimated Cost');
                        END;

                        IF NOT CONFIRM(Text004) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        IF Rec."Transfer User Id" = '' THEN
                            ERROR('Please select transfer from user Id before sending approval');
                        //TESTFIELD("Transfer User Id");

                        // IF NOT CONFIRM(Text004) THEN
                        //     EXIT;
                        /*
                         NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.","No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                          ERROR('Please create note sheet in Purchase Proposal');
                          *///EXP
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
                                //below block commented by kamlesh date 25-01-2023
                                /*
                                 UserTab.RESET;
                                 UserTab.SETRANGE(UserTab."User Name", USERID);
                                 IF UserTab.FINDFIRST THEN
                                     IF UserTab."Designation Name" <> '' THEN
                                         SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                     ELSE
                                         SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                 */ //end kamlesh date 25-01-2023
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
                                //below block commented by kamlesh date 25-01-2023
                                /*
                               UserTab.RESET;
                               UserTab.SETRANGE(UserTab."User Name", USERID);
                               IF UserTab.FINDFIRST THEN
                                   IF UserTab."Designation Name" <> '' THEN
                                       SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                   ELSE
                                       SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);

                              */ //end kamlesh date 25-01-2023
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
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 50096);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN
                            ERROR(Text0001, Rec."No.");
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50096);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        IF ApprovalEntry1.FINDLAST THEN BEGIN
                            "SeqNo." := ApprovalEntry1."Sequence No."
                        END
                        ELSE
                            "SeqNo." := 0;
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Table ID" := 50096;
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
                        ins := ApprovalEntry.INSERT;


                        //kamlesh date 20-02-2023
                        // Clear(BodyMassage);
                        // Clear(Response);
                        // if ins then begin
                        //     BodyMassage := BodyMassage + StrSubstNo('Direct Purchase Proposal No. %1 has been send by', Rec."No.");
                        //     BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                        //     Usertab2.Reset();
                        //     Usertab2.SetRange("User Name", Rec."Transfer User Id");
                        //     if Usertab2.FindFirst() then
                        //         if Usertab2."Contact Email" <> '' then
                        //             SendMailCU.Sendmail(Rec."Transfer User Id", StrSubstNo('Approval Request of Direct Purchase Proposal No. %1', Rec."No."), BodyMassage)
                        //         else
                        //             Message('Direct Purchase Proposal has been Forwarded to %1!', Usertab2."Full Name");
                        // end;
                        //kamlesh end
                        PurchPropHead.RESET;
                        PurchPropHead.SETRANGE(PurchPropHead."No.", Rec."No.");
                        IF PurchPropHead.FINDFIRST THEN BEGIN
                            PurchPropHead.Status := PurchPropHead.Status::"Pending for Approval";
                            PurchProHead."Pending From User Id" := Rec."Transfer User Id";
                            PurchProHead."Pending From User Name" := Rec."Transfer User Name";
                            // PurchPropHead."Transfer User Id" := '';
                            // PurchPropHead."Transfer User Name" := '';
                            PurchPropHead.MODIFY;
                        END;

                        CurrPage.CLOSE;

                    end;
                }
                action("Indent Slip")
                {
                    Image = Indent;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        indent.SETRANGE("No.", Rec."No.");
                        IF indent.FIND('-') THEN BEGIN
                            REPORT.RUNMODAL(50010, TRUE, TRUE, indent);
                        END;
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
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Purchase Type" := Rec."Purchase Type"::Direct;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // "Purchase Type" := "Purchase Type"::Direct;
    end;

    var
        pendUser: code[50];
        IndentLine: Record "Indent Line";
        // IndentLine: Record "50040";
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead, indent : Record "Indent Header";
        // IndentHead: Record "50039";
        Text0001: Label 'Indent Order No.  %1 is send for approval';
        Text0002: Label 'Indent Order No.  %1 is already approved';
        // indent: Record "50039";
        UserSetup: Record 91;
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        CancelRequestErr: Label 'Document Sent by %. You cannot cancel approval request.';
        ApprovalMagmt: Codeunit 1535;
        ApprovalEntry: Record 454;
        ApprovalEntry1: Record 454;
        PraposalLine: Record "Purchase Proposal Line";
        Text005_gTxt: Label 'Indent line allready Created,do you want delete existing line!';
        RequisitionLine: Record 50038;
        PurchProHead, PurchPropHead : Record "Purchase Proposal Header"; // : Record "50011";
        Text004: Label 'Do you want to send for Approval?';
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        // PurchPropHead: Record "50011";
        ApprovalUserGroup: Record 50082;
        ApprovalCommentLine: Record 50084;
        "EntryNo.": Integer;
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
        USetupList: Page 119;
        NStTab: Record 50084;
        SaveTxt: Text;
        len: Integer;
        Edtble: Boolean;
        UserTab: Record 2000000120;
        Char10: Char;
        NoteSheetTab: Record 50084;
        Entryno: Integer;
        NoteshetTab: Record 50084;
        FileDir: Record 50083;
}

