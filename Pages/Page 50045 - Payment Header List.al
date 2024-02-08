page 50045 "Payment Header List"
{
    ApplicationArea = All;
    Caption = 'Payment Header List';
    PageType = List;
    SourceTable = "Vendor Payment Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                    ApplicationArea = All;
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ToolTip = 'Specifies the value of the Base Amount field.';
                    ApplicationArea = All;
                }
                field("Beltron Voucher"; Rec."Beltron Voucher")
                {
                    ToolTip = 'Specifies the value of the Beltron Voucher field.';
                    ApplicationArea = All;
                }
                field("Amount to Vendor"; Rec."Amount to Vendor")
                {
                    ToolTip = 'Specifies the value of the Amount to Vendor field.';
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachement field.';
                    ApplicationArea = All;
                }
                // field("BShortcut Dimension 1 Code"; Rec."BShortcut Dimension 1 Code")
                // {
                //     ToolTip = 'Specifies the value of the BShortcut Dimension 1 Code field.';
                //     ApplicationArea = All;
                // }
                field("Bill Book No."; Rec."Bill Book No.")
                {
                    ToolTip = 'Specifies the value of the Bill Book No. field.';
                    ApplicationArea = All;
                }
                field("Budgetary Head"; Rec."Budgetary Head")
                {
                    ToolTip = 'Specifies the value of the Budgetary Head field.';
                    ApplicationArea = All;
                }
                field("Budgetary Head Name"; Rec."Budgetary Head Name")
                {
                    ToolTip = 'Specifies the value of the Budgetary Head Name field.';
                    ApplicationArea = All;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                    ApplicationArea = All;
                }
                field("Due Date With penalty"; Rec."Due Date With penalty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date With penalty field.';
                }
                field("Due Date Without Penalty"; Rec."Due Date Without Penalty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date Without Penalty field.';
                }

                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File No. field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Amount field.';
                }
                field("IT Tds Amount"; Rec."IT Tds Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IT Tds Amount field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("Letter Date"; Rec."Letter Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Letter Date field.';
                }
                field("Letter No."; Rec."Letter No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Letter No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Name field.';
                }
                field("Main Budgetary Account No."; Rec."Main Budgetary Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Budgetary Account No. field.';
                }
                field("Main Budgetary Name"; Rec."Main Budgetary Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Main Budgetary Name field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("On Account Of"; Rec."On Account Of")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the On Amount Of field.';
                }
                field("Order Details"; Rec."Order Details")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Details field.';
                }
                field("Pay To."; Rec."Pay To.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay To. field.';
                }
                field("Payment Done"; Rec."Payment Done")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Done field.';
                }
                field("Payment Proposal Created"; Rec."Payment Proposal Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Personal Created field.';
                }
                field("Payment Receipt"; Rec."Payment Receipt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Receipt field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Proposal Approved"; Rec."Proposal Approved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal Approved field.';
                }
                field("Proposal Remarks"; Rec."Proposal Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal Remarks field.';
                }
                field("Proposal Status"; Rec."Proposal Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal Status field.';
                }
                field("Rejected Remarks"; Rec."Rejected Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rejected Remarks field.';
                }
                field("GST CGST Amount"; Rec."GST CGST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST CGST Amount field.';
                }
                field("GST IGST Amount"; Rec."GST IGST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST IGST Amount field.';
                }
                field("GST SGST Amount"; Rec."GST SGST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST SGST Amount field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Total Salary"; Rec."Total Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Salary field.';
                }
                field("Transfer File User ID"; Rec."Transfer File User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer File User ID field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Invoice Date field.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Invoice No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Voucher Date"; Rec."Voucher Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Voucher Date field.';
                }
                field("Voucher No."; Rec."Voucher No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Voucher No. field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field("e-office No."; Rec."e-office No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the e-office No. field.';
                }
                field("vendor Type"; Rec."vendor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vendor Type field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
