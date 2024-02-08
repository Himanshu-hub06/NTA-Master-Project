#pragma implicitwith disable
/// <summary>
/// Page Requisition Header (ID 50194).
/// </summary>
page 50194 "Requisition Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 50087;
    SourceTableView = WHERE(Posted = CONST(false),
                            Status = FILTER(Open | "Pending for Approval"));

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
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Requisition from Other Section"; Rec."Requisition from Other Section")
                {
                    ApplicationArea = All;
                    Editable = Editablereq;

                    trigger OnValidate()
                    begin
                        UserSetup.GET(USERID);
                        IF (UserSetup.Section = 'S02') OR (UserSetup.Section = 'S02') THEN
                            Editablereq := TRUE
                        ELSE
                            Editablereq := FALSE;
                        IF Rec."Requisition from Other Section" = TRUE THEN
                            EditableSec := TRUE
                        ELSE
                            EditableSec := FALSE;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Created Section';
                    Editable = EditableSec;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Created Section Name';
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section';
                    Editable = true;
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Created User Id';
                    Editable = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    Caption = 'Created User Name';
                }
                field("Sending UID"; Rec."Sending UID")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer User ID';
                    Visible = true;
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
                    ApplicationArea = All;
                    Editable = false;
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
            part(RequisitionHeaderSubform; 50195)
            {
                ApplicationArea = All;
                SubPageLink = "Requisition No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
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
            action("Requisition &Slip")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;

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
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                RunObject = Page Issue;
                RunPageView = SORTING("No.")
                              ORDER(Ascending);
                Visible = false;
            }
            action("Send for Approvals")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;

                trigger OnAction()
                var
                    Ins, Response : Boolean;
                    Usertab2: Record User;
                    SendMailCU: Codeunit "Send Mail(API)";
                    BodyMassage: Text[250];
                    NotTab: Record "Notification Tab";
                    NotTab1: Record "Notification Tab";
                    entryNo: Integer;
                begin
                    // TESTFIELD("Requisition to Section");
                    // TESTFIELD("Shortcut Dimension 2 Code");
                    // VALIDATE("Shortcut Dimension 2 Code");
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                        RequisitionLine.TESTFIELD(RequisitionLine.Quantity);
                    END ELSE
                        ERROR('Please fill requisition Line Then send to Approved');
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    IF Rec."Sending UID" = '' THEN
                        ERROR('Please select Transfer User ID');
                    IF NOT CONFIRM(Text004) THEN
                        EXIT;

                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 50087);
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FINDFIRST THEN
                        ERROR(Text00001, Rec."No.");
                    ApprovalEntry.RESET;
                    IF ApprovalEntry.FINDLAST THEN BEGIN
                        "EntryNo." := ApprovalEntry."Entry No.";

                    END;
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
                    ApprovalEntry1.RESET;
                    ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 50087);
                    ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                    IF ApprovalEntry1.FINDLAST THEN BEGIN
                        "SeqNo." := ApprovalEntry1."Sequence No."
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
                    //kamlesh date 15-02-2023
                    //  Clear(BodyMassage);
                    //   Clear(Response);
                    //     if ins then begin
                    //         BodyMassage := BodyMassage + StrSubstNo('Requisition No. %1 has been send by', Rec."No.");
                    //        BodyMassage := BodyMassage + ' %1 (Designation - %2) for approval!';
                    // Error(BodyMassage);
                    //       Response := SendMailCU.Sendmail(Rec."Sending UID", StrSubstNo('Approval Request of Requsition No. %1', Rec."No."), BodyMassage);
                    //       if Response then begin
                    //           Usertab2.Reset();
                    //           Usertab2.SetRange("User Name", UserId);
                    //           if Usertab2.FindFirst() then
                    //              if Usertab2."Contact Email" = '' then
                    //                 Message('Requisition has been Forwarded by %1!', Usertab2."Full Name");
                    //      end;
                    //    end;
                    //kamlesh end date 15-02-2023
                    ReqHeadRec.RESET;
                    ReqHeadRec.SETRANGE(ReqHeadRec."No.", Rec."No.");
                    IF ReqHeadRec.FINDFIRST THEN BEGIN
                        ReqHeadRec.Status := ReqHeadRec.Status::"Pending for Approval";
                        ReqHeadRec."Pending From User Id" := Rec."Sending UID";
                        ReqHeadRec."Pending From User" := Rec."Transfer User Name";
                        ReqHeadRec."Approving UID" := Rec."Sending UID";
                        ReqHeadRec."Approving Date" := WORKDATE;
                        ReqHeadRec."Approving Time" := TIME;
                        ReqHeadRec."Sending UID" := '';
                        ReqHeadRec."Transfer User Name" := '';
                        ReqHeadRec.MODIFY;
                    END;
                    CurrPage.CLOSE;

                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FIND('-') THEN
                        IF USERID <> ApprovalEntry."Sender ID" THEN
                            ERROR(CancelRequestErr, ApprovalEntry."Sender ID");

                    //ApprovalMagmt.OnCancelRequistionApprovalRequest(Rec);//EXp
                    ReqHrd.RESET;
                    ReqHrd.SETRANGE(ReqHrd."No.", Rec."No.");
                    IF ReqHrd.FINDFIRST THEN BEGIN
                        ReqHrd."Sent for Authorization" := FALSE;
                        ReqHrd.Status := Rec.Status::Open;
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
                ApplicationArea = All;
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
            action("Attatch Requisition")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Rec.Attachment <> '' THEN
                        IF NOT CONFIRM('Requisition document is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                    FileDir.Get();
                    // loaright := FileDir."Loa Right";
                    // FilePath := 'D:\Published_App\BOC\boc_ftp\Requisition\';
                    FilePath := FileDir."Requisition Write";
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
            action("View attachment")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

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
            action("Re&open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                Visible = false;

                trigger OnAction()
                begin

                    IF Rec.Status = Rec.Status::"Pending for Approval" THEN BEGIN
                        Rec.Status := Rec.Status::Open;
                        Rec."Approving UID" := '';
                        Rec."Approving Date" := 0D;
                        Rec."Approving Time" := 0T;
                        Rec."Sending UID" := '';
                        Rec."Sending Date" := 0D;
                        Rec."Sending Time" := 0T;
                        Rec.MODIFY;
                    END;
                    //END ELSE
                    //  ERROR('Already Open');

                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                        REPEAT
                            RequisitionLine.Status := RequisitionLine.Status::Open;
                            RequisitionLine.MODIFY;
                        UNTIL RequisitionLine.NEXT = 0;
                    END;

                    MESSAGE('Document No. %1 has successfully Reopen', Rec."No.");
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

    trigger OnAfterGetCurrRecord()
    begin
        UserSetup.GET(USERID);
        IF (UserSetup.Section = 'S02') OR (UserSetup.Section = 'S02') THEN
            Editablereq := TRUE
        ELSE
            Editablereq := FALSE;
        IF Rec."Requisition from Other Section" = TRUE THEN
            EditableSec := TRUE
        ELSE
            EditableSec := FALSE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF (UserSetup.Section = 'S02') OR (UserSetup.Section = 'S02') THEN
            Editablereq := TRUE
        ELSE
            Editablereq := FALSE;
        IF Rec."Requisition from Other Section" = TRUE THEN
            EditableSec := TRUE
        ELSE
            EditableSec := FALSE;
        Rec.SetSecurityFilter;
    end;

    var
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50082;
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
        ApprovalEntry1: Record 454;
        ReqHrd: Record 50087;
        Editablereq: Boolean;
        EditableSec: Boolean;
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        Text004: Label 'Do you want to send for Approval?';
        UserTab: Record "User BOC";
        UserTab1: Record "User BOC";
        SeniorityLevel: Integer;
        Text00001: Label 'Requisition no. %1 allready pending for approval.';
        "EntryNo.": Integer;
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
        Entryno: Integer;
        NoteshetTab: Record 50084;
        len: Integer;
        Char10: Char;
}

#pragma implicitwith restore

