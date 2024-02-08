page 50023 "Approved TA Bill Card"
{
    DataCaptionExpression = rec."Reference No";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = all;
    SourceTable = "TA Bill Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; rec."Reference No")
                {
                    Editable = false;
                }
                field(BillType; rec.BillType)
                {
                    Caption = 'Bill Type';
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
                field("NTA Unique ID"; rec."NTA Unique ID")
                {
                    Editable = false;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    Editable = false;
                }
                field(Designation; rec.Designation)
                {
                    Editable = false;
                }
                field("Address For Communication"; rec."Address For Communication")
                {
                    Editable = false;
                }
                field("Contact No"; Rec."Contact No")
                {
                    Editable = false;
                }
                field(Bank_Branch_Name; Rec.Bank_Branch_Name)
                {
                    Editable = false;
                }
                field(Bank_Account_No; Rec.Bank_Account_No)
                {
                    Editable = false;
                }
                field("IFSC Code"; rec."IFSC Code")
                {
                    Editable = false;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    Editable = false;
                }
                field("Remuneration Days"; rec."Remuneration Days")
                {
                    Editable = false;
                }
                field("Remuneration Rate"; rec."Remuneration Rate")
                {
                    Editable = false;
                }
                field("Remuneration Amount"; rec."Remuneration Amount")
                {
                    Editable = false;
                }
                field("Hotel Amount"; rec."Total Amount Hotel")
                {
                    Visible = false;
                }
                field("Local Amount"; rec."Total Amount Local")
                {
                    Visible = false;
                }
                field("Oustation Amount"; rec."Total Amount Outstation")
                {
                    Visible = false;
                }
                //field("Approved Amount";rec."Total Amount Hotel"+rec."Total Amount Outstation"+rec."Total Amount Local" + "Remuneration Amount";"Total Amount Hotel"+"Total Amount Outstation"+"Total Amount Local" + "Remuneration Amount")
                field("Approved Amount"; rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount")
                {
                    Caption = 'Approved Amount';
                    Editable = false;
                }
                field("TDS(%)"; Rec."TDS Percent")
                {
                    Editable = false;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    Editable = false;
                }
                field("Submitted Date"; rec."Last Modified on")
                {
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
            }
            part("Outstation Journey"; 50036)
            {
                Caption = 'Outstation Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
            }
            part("Details of Hotel/Food/Daily Allowance"; 50033)
            {
                Caption = 'Details of Hotel/Food/Daily Allowance';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
            }
            part("Local Journey"; 50035)
            {
                Caption = 'Local Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = LocalBill;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                //Text: ;
                begin
                    rec.TESTFIELD(rec.Status, rec.Status::Open);
                    IF NOT CONFIRM(Text001) THEN
                        EXIT;
                    //Block Raj
                    //IF ApprovalMgmt.CheckTABillApprovalsWorkflowEnabled(Rec) THEN
                    //  ApprovalMgmt.OnSendTABillForApproval(Rec);
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
                    ApprovalCommentLine.SETRANGE("Table ID", 50005);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"Approval Comments view", ApprovalCommentLine);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF Rec.BillType = Rec.BillType::"Local" THEN BEGIN
            LocalBill := TRUE;
            OutBill := FALSE;
        END ELSE
            IF Rec.BillType = Rec.BillType::OutStation THEN BEGIN
                LocalBill := TRUE;
                OutBill := TRUE;
            END;
    end;

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        LocalBill: Boolean;
        OutBill: Boolean;
        Text001: Label 'Do you want to send for approval ?';
}

