/// <summary>
/// Page Closed/Issued Requisition (ID 50765).
/// </summary>
#pragma implicitwith disable
page 50213 "Closed/Issued Requisition"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 50091;
    SourceTableView = WHERE(Status = FILTER(Closed | Issued));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Requisition No.';
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
                    Editable = true;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section';
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name';
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Issue To"; Rec."Issue To")
                {
                    ApplicationArea = All;
                    Caption = 'Delivered To';
                    Editable = false;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(RequisitionHeaderSubform; 50220)
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

                trigger OnAction()
                begin
                    PostedReqHdr.RESET;
                    PostedReqHdr.SETRANGE("No.", Rec."No.");
                    IF PostedReqHdr.FIND('-') THEN
                        REPORT.RUNMODAL(50037, TRUE, TRUE, PostedReqHdr);
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
                    /*
                    TESTFIELD(Status,Status::"Pending for Approval");
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.","No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status,ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FIND('-') THEN
                        IF USERID <> ApprovalEntry."Sender ID" THEN
                          ERROR(CancelRequestErr,ApprovalEntry."Sender ID");
                    
                    ApprovalMagmt.OnCancelRequistionApprovalRequest(Rec);
                    ReqHrd.RESET;
                    ReqHrd.SETRANGE(ReqHrd."No.","No.");
                    IF ReqHrd.FINDFIRST THEN BEGIN
                      ReqHrd."Sent for Authorization":= FALSE;
                      ReqHrd.Status := Status :: Open;
                      ReqHrd."Approving UID" := '';
                      ReqHrd."Approving Date" := 0D;
                      ReqHrd."Approving Time" := 0T;
                      ReqHrd."Sending UID" := '';
                      ReqHrd."Sending Date" := 0D;
                      ReqHrd."Sending Time" := 0T;
                      ReqHrd.MODIFY;
                    END;
                    */

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
        RequisitionHeader: Record 50087;
        Text50002: Label 'Requisition No. %1 already closed.';
        Text50003: Label 'Requisition %1 posted successfully.';
        Text50004: Label 'There is nothing to post?';
        Text50001: Label 'Do you want to Closed Requisition %1?';
        OldFileName: Text;
        ServerFileName: Text;
        PostedReqHdr: Record 50091;
}

#pragma implicitwith restore

