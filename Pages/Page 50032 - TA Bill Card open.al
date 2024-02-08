page 50032 "TA Bill Card open"
{
    Caption = 'TA/DA Bill Card';
    DataCaptionExpression = rec."Reference No";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ApplicationArea = all;
    SourceTable = "TA Bill Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; Rec."Reference No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(BillType; Rec.BillType)
                {
                    Caption = 'Bill Type';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exam Name"; Rec."Exam Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("NTA Unique ID"; Rec."NTA Unique ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requester Name"; Rec."Requester Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address For Communication"; Rec."Address For Communication")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Contact No"; Rec."Contact No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Bank_Branch_Name; Rec.Bank_Branch_Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Bank_Account_No; Rec.Bank_Account_No)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Claimed Amount"; Rec."Claimed Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remuneration Days"; Rec."Remuneration Days")
                {
                    ApplicationArea = All;
                }
                field("Remuneration Rate"; Rec."Remuneration Rate")
                {
                    ApplicationArea = All;
                }
                field("Remuneration Amount"; Rec."Remuneration Amount")
                {
                    ApplicationArea = All;
                }
                field("Hotel Amount"; Rec."Total Amount Hotel")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Local Amount"; Rec."Total Amount Local")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Oustation Amount"; Rec."Total Amount Outstation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Approved Amount"; rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount")
                {
                    Caption = 'Approved Amount';
                    Editable = false;
                    Visible = false;
                }
                field("TDS(%)"; Rec."TDS Percent")
                {
                    ApplicationArea = All;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    ApplicationArea = All;
                }
                field("Submitted Date"; rec."Last Modified on")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ApplicationArea = All;

                }

                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part("Outstation Journey"; 50036)
            {
                Caption = 'Outstation Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
                ApplicationArea = All;
            }
            part("Details of Hotel/Food/Daily Allowance"; 50033)
            {
                Caption = 'Details of Hotel/Food/Daily Allowance';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
                ApplicationArea = All;
            }
            part("Local Journey"; 50035)
            {
                Caption = 'Local Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = LocalBill;
                ApplicationArea = All;
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

                trigger OnAction()
                var
                //Text: ;
                begin
                    rec.TESTFIELD(rec.Status, rec.Status::Open);
                    IF NOT CONFIRM(Text001) THEN
                        EXIT;
                    //Block Raj Due to base code
                    //IF ApprovalMgmt.CheckTABillApprovalsWorkflowEnabled(Rec) THEN
                    //ApprovalMgmt.OnSendTABillForApproval(Rec);
                    CurrPage.CLOSE;
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
                    PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF rec.BillType = rec.BillType::"Local" THEN BEGIN
            LocalBill := TRUE;
            OutBill := FALSE;
        END ELSE
            IF rec.BillType = rec.BillType::OutStation THEN BEGIN
                //LocalBill:=FALSE;
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

