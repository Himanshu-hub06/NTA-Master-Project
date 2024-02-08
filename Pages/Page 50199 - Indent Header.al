#pragma implicitwith disable
page 50199 "Indent Header"
{


    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    SourceTable = 50089;
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER(<> Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnAssistEdit()
                    begin

                        IF Rec."No." = '' THEN BEGIN
                            IF rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                        END;


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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
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
            part(IndentLine; "Indent Line")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Document No.", "Line No.");
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
                    ApplicationArea = All;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Due Date");
                        //TESTFIELD("Cost Centre Dimension");
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                        Rec.TESTFIELD("Indent Date");

                        Rec.Release;
                    end;
                }
                action("Create Indent Line")
                {
                    ApplicationArea = All;
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        IF Rec.Status = Rec.Status::"Pending for Approval" THEN
                            ERROR('Document Must be Open');

                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                        IndentLine1.RESET;
                        IndentLine1.SETRANGE(IndentLine1."Document No.", Rec."No.");
                        IF IndentLine1.FINDFIRST THEN
                            ERROR('Indent Line already Created');
                        /*
                        IndentLine1.RESET;
                        IndentLine1.SETRANGE(IndentLine1."Document No.","No.");
                        IF IndentLine1.FINDFIRST THEN BEGIN
                          IF CONFIRM (Text005_gTxt,FALSE) THEN BEGIN
                            CurrPage.IndentLine.PAGE.GetPurchReqLines;
                        
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
                        END;
                        */
                        CurrPage.IndentLine.PAGE.GetPurchReqLines;
                        // CurrPage.CLOSE;P

                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Reopen;
                    end;
                }
                action(Attachment1)
                {
                    Caption = 'Attachment';
                    ApplicationArea = All;
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    trigger OnAction()
                    begin
                        IF Rec.Attachment <> '' THEN
                            IF NOT CONFIRM('Indent document is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FileDir.Get();

                        FilePath := FileDir."Indent Write";
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
                        //MESSAGE('Upload successfully');
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
                }
                action("Note &Sheet")
                {
                    Caption = 'Note &Sheet';
                    Image = ViewComments;
                    Promoted = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 50089);
                        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", rec."No.");
                        PAGE.RUN(PAGE::"Notesheet List", ApprovalCommentLine);
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
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        IndentHead.SETRANGE("No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN
                            REPORT.RUN(50010, TRUE, TRUE, IndentHead);
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
                        SendMailCU: Codeunit "Send Mail(API)";
                        BodyMassage: Text[250];
                        Usertab2: Record User;
                        NotTab: Record "Notification Tab";
                        NotTab1: Record "Notification Tab";
                    begin
                        IndentLine1.RESET;
                        IndentLine1.SETRANGE(IndentLine1."Document No.", Rec."No.");
                        IF NOT IndentLine1.FINDFIRST THEN
                            ERROR('Please create indent line before send for approval');
                        IndentLine3.RESET;
                        IndentLine3.SETRANGE(IndentLine3."Document No.", Rec."No.");
                        IF IndentLine3.FINDFIRST THEN BEGIN
                            IF IndentLine3.Quantity = 0 THEN
                                ERROR('Please fill indent quantity before send for approval');
                        END;
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        Rec.TESTFIELD("Transfer User Id");
                        IF NOT CONFIRM(Text004) THEN
                            EXIT;
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
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 50089);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN
                            ERROR(Text0001, Rec."No.");
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Table ID" := 50089;
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
                        //kamlesh date 16-02-2023
                        //   Clear(BodyMassage);
                        //   Clear(Response);
                        //   if ins then begin
                        //       BodyMassage := BodyMassage + StrSubstNo('Indent No. %1 has been send by', Rec."No.");
                        //       BodyMassage := BodyMassage + ' %1 (Designation %2) for approval!';

                        //      Response := SendMailCU.Sendmail(Rec."Transfer User Id", StrSubstNo('Approval Request of Indent No. %1', Rec."No."), BodyMassage);
                        //     if Response then begin
                        //         Usertab2.Reset();
                        //       Usertab2.SetRange("User Name", Rec."Transfer User Id");
                        //     if Usertab2.FindFirst() then
                        //          if Usertab2."Contact Email" = '' then
                        //              Message('Indent No. has been Forwarded to %1!', Usertab2."Full Name");
                        //   end;
                        // end;
                        //kamlesh end date 16-02-2023
                        IndentHead.RESET;
                        IndentHead.SETRANGE(IndentHead."No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN BEGIN
                            IndentHead.Status := IndentHead.Status::"Pending for Approval";
                            IndentHead."Pending From User Id" := Rec."Transfer User Id";
                            IndentHead."Pending From User Name" := Rec."Transfer User name";
                            IndentHead."Transfer User Id" := '';
                            IndentHead."Transfer User name" := '';
                            IndentHead.MODIFY;
                        END;

                        CurrPage.CLOSE;
                    end;
                }
                action("Indent Slip")
                {
#pragma warning disable AL0482
                    Image = indent;
#pragma warning restore AL0482
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        indent.SETRANGE("No.", Rec."No.");
                        IF indent.FIND('-') THEN BEGIN
                            REPORT.RUNMODAL(50010, TRUE, TRUE, indent);
                        END;
                    end;
                }
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
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
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    var
        IndentLine: Record 50090;
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead: Record 50089;
        Text0001: Label 'Indent Order No.  %1 is send for approval';
        Text0002: Label 'Indent Order No.  %1 is already approved';
        indent: Record 50089;
        UserSetup: Record 91;
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        CancelRequestErr: Label 'Document Sent by %. You cannot cancel approval request.';
        ApprovalMagmt: Codeunit 1535;
        ApprovalEntry: Record 454;
        IndentLine1: Record 50090;
        Text005_gTxt: Label 'Indent line already Created,do you want delete existing line!';
        RequisitionLine: Record 50088;
        Text004: Label 'Do you want to send for Approval?';
        ApprovalUserGroup: Record 50082;
        "EntryNo.": Integer;
        IndentLine3: Record 50090;
        FileDir: Record 50083;
        OldFileName: Text;
        ServerFileName: Text;
        FilePath: Text[150];
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        ClientFileName: Text;
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

#pragma implicitwith restore

