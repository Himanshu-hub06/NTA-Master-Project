table 50102 "PFMS Payment Response History"
{
    Caption = 'PFMS Payment Response History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Sanction No."; Code[20])
        {
            Caption = 'Sanction No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Response Status"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Request Source"; Text[20])
        {
            Caption = 'Request Source';
            DataClassification = ToBeClassified;
        }
        field(5; IsSuccess; Integer)
        {
            Caption = 'IsSuccess';
            DataClassification = ToBeClassified;
        }
        field(6; "Sanction Amount"; Decimal)
        {
            Caption = 'Sanction Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
        }
        field(8; "PFMS Transaction ID"; Text[20])
        {
            Caption = 'PFMS Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Scroll Status"; Text[50])
        {
            Caption = 'Scroll Status';
            DataClassification = ToBeClassified;
        }
        field(11; "Scroll No."; Text[20])
        {
            Caption = 'Scroll No.';
            DataClassification = ToBeClassified;
        }
        field(12; "Scroll Date"; Date)
        {
            Caption = 'Scroll Date';
            DataClassification = ToBeClassified;
        }
        field(13; "Bank Transaction Status"; Text[50])
        {
            Caption = 'Bank Transaction Status';
            DataClassification = ToBeClassified;
        }
        field(14; "Bank Transaction ID"; Text[20])
        {
            Caption = 'Bank Transaction ID';
            DataClassification = ToBeClassified;
        }
        field(15; "Reason For Failure"; Text[100])
        {
            Caption = 'Reason For Failure';
            DataClassification = ToBeClassified;
        }
        field(16; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
        }
        field(17; "Status DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
