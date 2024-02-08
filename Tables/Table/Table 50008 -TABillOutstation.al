table 50008 "TA Bill Outstation"
{
    Caption = 'TA Bill Outstation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Outstation ID"; Integer)
        {
            Caption = 'Outstation ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Bill ID"; Integer)
        {
            Caption = 'Bill ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Departure Date"; DateTime)
        {
            Caption = 'Departure Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Departure Time"; Text[50])
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(5; "Departure From"; Text[100])
        {
            Caption = 'Departure From';
            DataClassification = ToBeClassified;
        }
        field(6; "Arrival Date"; DateTime)
        {
            Caption = 'Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Arrival Time"; Text[50])
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Arrival To"; Text[100])
        {
            Caption = 'Arrival To';
            DataClassification = ToBeClassified;
        }
        field(9; "Mode Of Journey"; Text[100])
        {
            Caption = 'Mode Of Journey';
            DataClassification = ToBeClassified;
        }
        field(10; "Distance Of Journey"; Text[100])
        {
            Caption = 'Distance Of Journey';
            DataClassification = ToBeClassified;
        }
        field(11; "Receipt No"; Code[50])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Last Modified On"; DateTime)
        {
            Caption = 'Last Modified On';
            DataClassification = ToBeClassified;
        }
        field(14; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
        field(15; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Outstation ID")
        {
            Clustered = true;
        }
    }
}
