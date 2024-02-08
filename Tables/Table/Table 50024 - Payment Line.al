table 50024 "Payment Line"
{
    Caption = 'Payment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(7; "Direct unit Cost"; Decimal)
        {
            Caption = 'Direct unit Cost';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; "Customer Account No."; Code[20])
        {
            Caption = 'Customer Account No.';
        }
        field(10; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
        field(11; "Bank Name"; Text[80])
        {
            Caption = 'Bank Name';
        }
        field(12; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
        }
        field(13; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(16; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(17; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(18; Remarks; Text[80])
        {
            Caption = 'Remarks';
        }
        field(19; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(20; "Customer Name"; Text[80])
        {
            Caption = 'Customer Name';
        }
        field(21; "Payment Receipt Type"; Code[20])
        {
            Caption = 'Payment Receipt Type';
        }
        field(22; "Payment Receipt Name"; Text[80])
        {
            Caption = 'Payment Receipt Name';
        }
        field(23; "Applied Document No."; Code[20])
        {
            Caption = 'Applied Document No.';
        }
        field(24; Year; Integer)
        {
            Caption = 'Year';
        }
        field(25; Month; Option)
        {
            Caption = 'Month';
            OptionMembers = " ";
        }
        field(26; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
        }
        field(27; "TDS Category"; Option)
        {
            Caption = 'TDS Category';
            OptionMembers = " ";
        }
        field(28; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
        }
        field(29; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
        }
        field(30; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
        }
        field(31; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
        }
        field(32; "Amount To Vendor"; Decimal)
        {
            Caption = 'Amount To Vendor';
        }
        field(33; "TDS Base Amount"; Decimal)
        {
            Caption = 'TDS Base Amount';
        }
        field(34; "TDS Group"; Option)
        {
            Caption = 'TDS Group';
            OptionMembers = " ";
        }
        field(35; "GST Credit"; Option)
        {
            Caption = 'GST Credit';
            OptionMembers = " ";
        }
        field(36; "GST Jurisdiction Type"; Option)
        {
            Caption = 'GST Jurisdiction Type';
            OptionMembers = " ";
        }
        field(37; "GST Reverse Charge"; Boolean)
        {
            Caption = 'GST Reverse Charge';
        }
        field(38; "GST Assessable Value"; Decimal)
        {
            Caption = 'GST Assessable Value';
        }
        field(39; "Buy-From GST Registration No."; Code[15])
        {
            Caption = 'Buy-From GST Registration No.';
        }
        field(40; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
        }
        field(41; "GST Group Type"; Option)
        {
            Caption = 'GST Group Type';
            OptionMembers = " ";
        }
        field(42; "HSN/SAC Code"; Code[8])
        {
            Caption = 'HSN/SAC Code';
        }
        field(43; "GST Base Amount"; Decimal)
        {
            Caption = 'GST Base Amount';
        }
        field(44; "GST%"; Decimal)
        {
            Caption = 'GST%';
        }
        field(45; "Total GST Amount"; Decimal)
        {
            Caption = 'Total GST Amount';
        }
        field(46; "GST TDS/TCS Amout (LCY)"; Decimal)
        {
            Caption = 'GST TDS/TCS Amout (LCY)';
        }
        field(47; "GST TDS/TCS"; Boolean)
        {
            Caption = 'GST TDS/TCS';
        }
        field(48; "GST TCS State Code"; Code[10])
        {
            Caption = 'GST TCS State Code';
        }
        field(49; "GST TDS/TCS Base Amount"; Decimal)
        {
            Caption = 'GST TDS/TCS Base Amount';
        }
        field(50; "GST TDS/TCS%"; Decimal)
        {
            Caption = 'GST TDS/TCS%';
        }
        field(51; "SGST TDS"; Decimal)
        {
            Caption = 'SGST TDS';
        }
        field(52; "CGST TDS"; Decimal)
        {
            Caption = 'CGST TDS';
        }
        field(53; Mandays; Decimal)
        {
            Caption = 'Mandays';
        }
        field(54; "Payment Rate"; Decimal)
        {
            Caption = 'Payment Rate';
        }
        field(55; "Service Charges %"; Decimal)
        {
            Caption = 'Service Charges %';
        }
        field(56; "Service Charges Amount"; Decimal)
        {
            Caption = 'Service Charges Amount';
        }
        field(57; "EPF Employer%"; Decimal)
        {
            Caption = 'EPF Employer%';
        }
        field(58; "EPF Employer Amount"; Decimal)
        {
            Caption = 'EPF Employer Amount';
        }
        field(59; "ESIC Employer%"; Decimal)
        {
            Caption = 'ESIC Employer%';
        }
        field(60; "ESIC Employer Amount"; Decimal)
        {
            Caption = 'ESIC Employer Amount';
        }
        field(61; "Amount Hold%"; Decimal)
        {
            Caption = 'Amount Hold%';
        }
        field(62; "Hold Amount"; Decimal)
        {
            Caption = 'Hold Amount';
        }
        field(63; "Other Deduction%"; Decimal)
        {
            Caption = 'Other Deduction%';
        }
        field(64; "Other Deduction Amount"; Decimal)
        {
            Caption = 'Other Deduction Amount';
        }
        field(65; "Bill Amount"; Decimal)
        {
            Caption = 'Bill Amount';
        }
        field(66; "Advance Paid Amount"; Decimal)
        {
            Caption = 'Advance Paid Amount';
        }
        field(67; "For The Month of"; Text[120])
        {
            Caption = 'For The Month of';
        }
        field(68; "Bill No."; Code[20])
        {
            Caption = 'Bill No.';
        }
        field(69; "Bill Date"; Date)
        {
            Caption = 'Bill Date';
        }
        field(70; "Ref. No."; Code[20])
        {
            Caption = 'Ref. No.';
        }
        field(71; "No. of Man Power"; Integer)
        {
            Caption = 'No. of Man Power';
        }
        field(72; "No. of Days"; Integer)
        {
            Caption = 'No. of Days';
        }
        field(73; "Approved No. of Days"; Integer)
        {
            Caption = 'Approved No. of Days';
        }
        field(74; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(75; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
        }
        field(76; Name; Text[120])
        {
            Caption = 'Name';
        }
        field(77; "Resignation Id"; Code[20])
        {
            Caption = 'Resignation Id';
        }
        field(78; Designation; Text[120])
        {
            Caption = 'Designation';
        }
        field(79; "Absent Days"; Integer)
        {
            Caption = 'Absent Days';
        }
        field(80; "Present Days"; Integer)
        {
            Caption = 'Present Days';
        }
        field(81; Basic; Decimal)
        {
            Caption = 'Basic';
        }
        field(82; "Other Allowance"; Decimal)
        {
            Caption = 'Other Allowance';
        }
        field(83; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
        }
        field(84; "Service Charges"; Decimal)
        {
            Caption = 'Service Charges';
        }
        field(85; "PF Employer"; Decimal)
        {
            Caption = 'PF Employer';
        }
        field(86; "ESI Employer"; Decimal)
        {
            Caption = 'ESI Employer';
        }
        field(87; Total; Decimal)
        {
            Caption = 'Total';
        }
        field(88; "Grand Total"; Decimal)
        {
            Caption = 'Grand Total';
        }
        field(89; "SGST Amount"; Decimal)
        {
            Caption = 'SGST Amount';
        }
        field(90; "CGST Amount"; Decimal)
        {
            Caption = 'CGST Amount';
        }
        field(91; "Total GST"; Decimal)
        {
            Caption = 'Total GSt';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
