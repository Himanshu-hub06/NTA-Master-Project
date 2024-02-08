table 50007 "TA Bill Local"
{
    Caption = 'TA Bill Local';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Local Journey ID"; Integer)
        {
            Caption = 'Local Journey ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Bill ID"; Integer)
        {
            Caption = 'Bill ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Journey Date"; DateTime)
        {
            Caption = 'Journey Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Journey Remarks"; Text[150])
        {
            Caption = 'Journey Remarks';
            DataClassification = ToBeClassified;
        }
        field(5; "Departure Time"; DateTime)
        {
            Caption = 'Departure Time';
            DataClassification = ToBeClassified;
        }
        field(6; "Departure From"; Text[150])
        {
            Caption = 'Departure From';
            DataClassification = ToBeClassified;
        }
        field(7; "Arrival Time"; Text[50])
        {
            Caption = 'Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Arrival To"; Text[150])
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
        key(PK; "Local Journey ID")
        {
            Clustered = true;
        }
    }
}
