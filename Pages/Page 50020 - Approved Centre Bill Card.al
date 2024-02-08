page 50020 "Approved Centre Bill Card"
{
    //DataCaptionExpression = "Reference No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    MultipleNewLines = true;
    PageType = Card;
    ShowFilter = false;
    ApplicationArea = all;
    SourceTable = "Centre Bill Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; rec."Reference No.")
                {
                    Editable = false;
                }
                field("Centre No."; rec."Centre No.")
                {
                    Editable = false;
                }
                field("Centre City"; rec."Centre City")
                {
                    Editable = false;
                }
                field("Centre Address"; rec."Centre Address")
                {
                    Editable = false;
                }
                field("Superintendent Name"; rec."Superintendent Name")
                {
                    Editable = false;
                }
                field("Contact No."; rec."Contact No.")
                {
                    Editable = false;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    Editable = false;
                }
                field("Exam Date"; rec."Exam Date")
                {
                    Editable = false;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    Editable = false;
                }
                field("Advance Amount"; rec."Advance Amount")
                {
                    Editable = false;
                }
                field("Refund Amount"; rec."Refund Amount")
                {
                    Editable = false;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    Editable = false;
                }
                field("TDS (%)"; rec."Tds percentage")
                {
                    Caption = 'TDS %';
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                }
                field("Net Payble Amount"; rec."Net Payble Amount")
                {
                    Caption = 'Net Payble Amount';
                    Editable = false;
                }
                field("Submitted Date"; rec."Created on")
                {
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field("Supporting Document"; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."File Path" <> '' THEN
                            HYPERLINK(InvSetup."FTP Path" + rec."File Path");

                    end;
                }
            }
            part("Approved Centre Bill"; "Approved Centre Bill Subform")
            {
                SubPageLink = "Centre Bill ID" = field("CentreBill ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Enabled = Enable;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                //  Text: ;
                begin
                    rec.TESTFIELD(rec.Status, rec.Status::Open);
                    IF NOT CONFIRM(Text002) THEN
                        EXIT;
                    //IF ApprovalMgmt.CheckCentreBillApprovalsWorkflowEnabled(Rec) THEN
                    // ApprovalMgmt.OnSendCentreBillForApproval(Rec);
                end;
            }
            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalCommentLine: Record "Approval Comment Line";
                begin
                    ApprovalCommentLine.SETRANGE("Table ID", 50002);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"Approval Comments view", ApprovalCommentLine);
                end;
            }




        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec."File Path" <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';
    end;

    trigger OnOpenPage()
    begin
        IF rec.Status = rec.Status::Open THEN
            Enable := TRUE
    end;

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        NotSent: Boolean;
        AttachDoc: Text;
        Text001: Label 'Click here to View';
        Enable: Boolean;
        Text002: Label 'Do you want to send for approval ?';
        InvSetup: Record "Inventory Setup";
}

