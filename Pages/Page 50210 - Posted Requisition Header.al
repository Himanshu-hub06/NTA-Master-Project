#pragma implicitwith disable
page 50210 "Posted Requisition Header"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 50087;
    SourceTableView = WHERE(Posted = CONST(true),
                            Status = FILTER(Approved),
                            Issued = CONST(false));

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
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
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
                    Editable = false;
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section';
                    Editable = false;
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
                    Editable = false;
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
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Issue To"; Rec."Issue To")
                {
                    ApplicationArea = All;
                    Caption = 'Delivered To';
                }

            }
            part(RequisitionHeaderSubform; 50211)
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
            action("Requisition &Slip")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    ReqHeadRec.RESET;
                    ReqHeadRec.SETRANGE("No.", Rec."No.");
                    IF ReqHeadRec.FIND('-') THEN BEGIN
                        REPORT.RUNMODAL(50019, TRUE, TRUE, ReqHeadRec);
                    END;
                end;
            }
            action("Re&fresh")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;

                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                end;
            }
            action("Re&open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
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
            action("Send To Store")
            {
                ApplicationArea = All;
                Caption = 'Send To Store';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Status, Rec.Status::Approved);

                    IF CONFIRM('Do you want send to Store', TRUE) THEN BEGIN
                        Rec.Posted := TRUE;

                        Rec.MODIFY;
                        MESSAGE('Requisition Send to store');
                    END;

                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FINDFIRST THEN
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
            action("Closed Requisition")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    InvSetup: Record 313;
                    PostedReqHead: Record 50091;
                    NoSeriesMgt: Codeunit 396;
                    PostedReqLine: Record 50092;
                    ReqHead: Record 50087;
                    ReqLine: Record 50088;
                begin

                    RequisitionHeader.RESET;
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    IF RequisitionHeader.FIND('-') THEN
                        IF RequisitionHeader.Status = RequisitionHeader.Status::Closed THEN BEGIN
                            MESSAGE(Text50002, Rec."No.");
                        END ELSE
                            IF CONFIRM(Text50001, TRUE, Rec."No.") THEN BEGIN
                                InvSetup.GET;
                                InvSetup.TESTFIELD(InvSetup."Posted Requisition No.");
                                PostedReqHead.TRANSFERFIELDS(Rec);
                                PostedReqHead."No." := NoSeriesMgt.GetNextNo(InvSetup."Posted Requisition No.", WORKDATE, TRUE);
                                PostedReqHead.Attachment := Rec."No.";
                                PostedReqHead.Status := PostedReqHead.Status::Closed;
                                PostedReqHead.INSERT;
                                RequisitionLine.RESET;
                                RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", Rec."No.");
                                //RequisitionLine.SETFILTER(RequisitionLine."Quantity To Issue",'<>%1',0);
                                IF RequisitionLine.FINDFIRST THEN BEGIN
                                    REPEAT
                                        PostedReqLine.TRANSFERFIELDS(RequisitionLine);
                                        PostedReqLine."Requisition No." := PostedReqHead."No.";

                                        PostedReqLine.INSERT;

                                    UNTIL RequisitionLine.NEXT = 0;
                                END;

                            END;
                    ReqHead.SETRANGE(ReqHead."No.", Rec."No.");
                    IF ReqHead.FINDFIRST THEN BEGIN
                        ReqHead.DELETE;
                    END;
                    MESSAGE('Requisition Closed');
                end;
            }
            action(Issue)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin
                    //TESTFIELD("Shortcut Dimension 1 Code");
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    Rec.TESTFIELD("Requisition to Section");
                    //VALIDATE("Shortcut Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code");
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", Rec."No.");
                    RequisitionLine.SETFILTER(RequisitionLine."Quantity To Issue", '<>%1', 0);
                    IF NOT RequisitionLine.FINDFIRST THEN BEGIN
                        ERROR('Quantity to issue is not bank');
                    END;
                    RequisitionLine1.RESET;
                    RequisitionLine1.SETRANGE(RequisitionLine1."Requisition No.", Rec."No.");
                    RequisitionLine1.SETFILTER(RequisitionLine1."Quantity To Issue", '<>%1', 0);
                    IF RequisitionLine1.FINDFIRST THEN BEGIN
                        REPEAT
                            IF Itemtab.GET(RequisitionLine1."No.") THEN
                                Itemtab.TESTFIELD(Itemtab."Item Type");
                        UNTIL RequisitionLine1.NEXT = 0;
                    END;

                    Rec.TESTFIELD("Issued Date");
                    IF CONFIRM('Do you want to Issue requisition', TRUE) THEN BEGIN
                        ItemJnlmanag.FillItemJournalFromRequisition1(Rec."No.");
                    END;
                    RequisitionLine2.RESET;
                    RequisitionLine2.SETRANGE(RequisitionLine2."Requisition No.", Rec."No.");
                    RequisitionLine2.SETFILTER(RequisitionLine2."Remaining Qty", '>%1', 0);
                    IF NOT RequisitionLine2.FINDFIRST THEN BEGIN
                        RequisitionLine2.DELETEALL;

                        ReqHeadRec.RESET;
                        ReqHeadRec.SETRANGE(ReqHeadRec."No.", Rec."No.");
                        IF ReqHeadRec.FINDFIRST THEN
                            ReqHeadRec.DELETE;
                        //ReqHeadRec.Issued := TRUE;
                        // ReqHeadRec.Status := ReqHeadRec.Status::Issued;
                        // ReqHeadRec.MODIFY;
                    END;
                    CurrPage.CLOSE;


                end;
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
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
        Rec.SetSecurityFilter;
    end;

    var
        ReqHeadRec: Record 50087;
        NoofRec: Integer;
        LineNo: Integer;
        ProdOrderComp: Record 5407;
        Item: Record 27;
        Window: Dialog;
        RequisitionLine2: Record 50088;
        RequisitionLine1: Record 50088;
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
        RequisitionHeader: Record 50087;
        Text50002: Label 'Requisition No. %1 already closed.';
        Text50003: Label 'Requisition %1 posted successfully.';
        Text50004: Label 'There is nothing to post?';
        Text50001: Label 'Do you want to Closed Requisition %1?';
        ItemJnlmanag: Codeunit "ItemJnlManagement Ext";
        // ItemJnlmanag: Codeunit 240;
        FilePath: Text[150];
        OldFileName: Text[150];
        ServerFileName: Text[150];
        Itemtab: Record 27;
        FileDir: Record 50083;
}

#pragma implicitwith restore

