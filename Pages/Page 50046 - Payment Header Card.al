page 50046 "Payment Header Card"
{
    ApplicationArea = All;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    Caption = 'Payment Header Card';
    PageType = Card;
    SourceTable = "Vendor Payment Header";
    UsageCategory = Lists;




    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ToolTip = 'Specifies the value of the Base Amount field.';
                }
                field("Bill Book No."; Rec."Bill Book No.")
                {
                    ToolTip = 'Specifies the value of the Bill Book No. field.';
                }
                // field("Expence Type"; Rec."Expence Type")
                // {
                //     ToolTip = 'Specifies the value of the Expence Type field.';
                // }
                field("Expense Voucher"; Rec."Expense Voucher")
                {
                    ToolTip = 'Specifies the value of the Expense Voucher field.';
                }
                field("File No."; Rec."File No.")
                {
                    ToolTip = 'Specifies the value of the File No. field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Location Name"; Rec."Location Name")
                {
                    ToolTip = 'Specifies the value of the Location Name field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Budgetary Head"; Rec."Budgetary Head")
                {
                    ToolTip = 'Specifies the value of the Budgetary Head field.';
                }
                field("Budgetary Head Name"; Rec."Budgetary Head Name")
                {
                    ToolTip = 'Specifies the value of the Budgetary Head Name field.';
                }
                field("Main Budgetary Account No."; Rec."Main Budgetary Account No.")
                {
                    ToolTip = 'Specifies the value of the Budgetary Account No. field.';
                }
                field("Main Budgetary Name"; Rec."Main Budgetary Name")
                {
                    ToolTip = 'Specifies the value of the Budgetary Name. field.';
                }

            }
            group(Line)
            {
                part("paymentline"; "Payment Line List")
                {
                    SubPageLink = "Document No." = field("No.");
                    ApplicationArea = All;
                }

            }
        }

    }

}
