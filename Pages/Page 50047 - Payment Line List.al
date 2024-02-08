page 50047 "Payment Line List"
{
    ApplicationArea = All;
    Caption = 'Payment Line List';
    PageType = ListPart;
    SourceTable = "Vendor Payment Line";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Ref. No."; Rec."Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Ref. No. field.';
                    ApplicationArea = All;
                }
                field("Absent Days"; Rec."Absent Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Absent Days field.';
                }
                field("Advance Paid Amount"; Rec."Advance Paid Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Paid Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                // field("Amount Hold%"; Rec."Amount Hold%")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Amount Hold% field.';
                // }
                field("Amount To Vendor"; Rec."Amount To Vendor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount To Vendor field.';
                }
                field("Applied Document No."; Rec."Applied Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applied Document No. field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Approved No. of Days"; Rec."Approved No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved No. of Days field.';
                }
                field("Assessee Code"; Rec."Assessee Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assessee Code field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Basic; Rec.Basic)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Basic field.';
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Amount field.';
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Date field.';
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill No. field.';
                }
                // field("Buy-From GST Registration No."; Rec."Buy-From GST Registration No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Buy-From GST Registration No. field.';
                // }
                field("CGST Amount"; Rec."CGST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CGST Amount field.';
                }
                field("CGST TDS"; Rec."CGST TDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CGST TDS field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Customer Account No."; Rec."Customer Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Account No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Direct unit Cost"; Rec."Direct unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Direct unit Cost field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("EPF Employer Amount"; Rec."EPF Employer Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EPF Employer Amount field.';
                }
                field("EPF Employer %"; Rec."EPF Employer %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EPF Employer% field.';
                }
                field("ESI Employer"; Rec."ESI Employer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ESI Employer field.';
                }
                field("ESIC Employer Amount"; Rec."ESIC Employer Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ESIC Employer Amount field.';
                }
                field("ESIC Employer %"; Rec."ESIC Employer %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ESIC Employer% field.';
                }
                field("For The Month of"; Rec."For The Month of")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the For The Month of field.';
                }
                field("GST Assessable Value"; Rec."GST Assessable Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Assessable Value field.';
                }
                field("GST Base Amount"; Rec."GST Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Base Amount field.';
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Credit field.';
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Group Code field.';
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Group Type field.';
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Jurisdiction Type field.';
                }
                field("GST Reverse Charge"; Rec."GST Reverse Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST Reverse Charge field.';
                }
                field("GST TCS State Code"; Rec."GST TCS State Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST TCS State Code field.';
                }
                field("GST TDS/TCS"; Rec."GST TDS/TCS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST TDS/TCS field.';
                }
                field("GST TDS/TCS Amount (LCY)"; Rec."GST TDS/TCS Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST TDS/TCS Amout (LCY) field.';
                }
                field("GST TDS/TCS Base Amount"; Rec."GST TDS/TCS Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST TDS/TCS Base Amount field.';
                }
                field("GST TDS/TCS %"; Rec."GST TDS/TCS %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST TDS/TCS% field.';
                }
                field("GST %"; Rec."GST %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GST% field.';
                }
                field("Grand Total"; Rec."Grand Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grand Total field.';
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Salary field.';
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSN/SAC Code field.';
                }
                field("Hold Amount"; Rec."Hold Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hold Amount field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Mandays; Rec.Mandays)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandays field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }
                field("No. of Man Power"; Rec."No. of Man Power")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Man Power field.';
                }
                field("Other Allowance"; Rec."Other Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Allowance field.';
                }
                field("Other Deduction Amount"; Rec."Other Deduction Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Deduction Amount field.';
                }
                field("Other Deduction %"; Rec."Other Deduction %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Deduction% field.';
                }
                field("PF Employer"; Rec."PF Employer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF Employer field.';
                }
                field("Payment Rate"; Rec."Payment Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Rate field.';
                }
                field("Payment Receipt Name"; Rec."Payment Receipt Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Receipt Name field.';
                }
                field("Payment Receipt Type"; Rec."Payment Receipt Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Receipt Type field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Present Days"; Rec."Present Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Present Days field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Registration Id"; Rec."Registration Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resignation Id field.';
                }
                field("SGST Amount"; Rec."SGST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SGST Amount field.';
                }
                field("SGST TDS"; Rec."SGST TDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SGST TDS field.';
                }
                field("Service Charge"; Rec."Service Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charges field.';
                }
                field("Service Charge %"; Rec."Service Charge %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charges % field.';
                }
                field("Service Charge Amount"; Rec."Service Charge Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Charges Amount field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
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
                field("TDS %"; Rec."TDS %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS % field.';
                }
                field("TDS Amount"; Rec."TDS Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS Amount field.';
                }
                field("TDS Base Amount"; Rec."TDS Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS Base Amount field.';
                }
                field("TDS Category"; Rec."TDS Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS Category field.';
                }
                field("TDS Group"; Rec."TDS Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS Group field.';
                }
                field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TDS Nature of Deduction field.';
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total field.';
                }
                field("Total GST Amount"; Rec."Total GST Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total GST Amount field.';
                }
                field("Total GST"; Rec."Total GST")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total GSt field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                }
            }
        }
    }
}
