page 50015 "Posted TA Bill Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Posted TA Bill Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill ID"; rec."Bill ID")
                {
                }
                field(BillType; rec.BillType)
                {
                    Caption = 'Bill Type';
                }
                field("Exam ID"; rec."Exam ID")
                {
                }
                field("Exam Date"; rec."Exam Date")
                {
                }
                field("NTA Unique ID"; rec."NTA Unique ID")
                {
                }
                field("Requester Name"; rec."Requester Name")
                {
                }
                field(Designation; rec.Designation)
                {
                }
                field("Address For Communication"; rec."Address For Communication")
                {
                }
                field("Contact No."; rec."Contact No.")
                {
                }
                field("Bank Name & Branch"; rec."Bank Name & Branch")
                {
                }
                field("Account No."; rec."Account No.")
                {
                }
                field("IFSC Code"; rec."IFSC Code")
                {
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field(Status; rec.Status)
                {
                }
            }
            part("Local Journey"; "Posted TA Bill Loacl Subform")
            {
                Caption = 'Local Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = LocalBill;
            }
            part("Outstation Journey"; "Posted TA Bill Outst Subform")
            {
                Caption = 'Outstation Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
            }
            part("Details of Hotel/Food/Daily Allowance"; "Posted TA Bill Hotel Subform")
            {
                Caption = 'Details of Hotel/Food/Daily Allowance';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                Visible = OutBill;
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage()
    begin
        IF rec.BillType = rec.BillType::"Local" THEN BEGIN
            LocalBill := TRUE;
            OutBill := FALSE;
        END ELSE
            IF rec.BillType = rec.BillType::OutStation THEN BEGIN
                LocalBill := FALSE;
                OutBill := TRUE;
            END;
    end;

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        LocalBill: Boolean;
        OutBill: Boolean;
}

