table 50004 "Centre Bill Particulars"
{
    Caption = 'Centre Bill Particulars';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Particular ID"; Integer)
        {
            Caption = 'Particular ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;
        }
        field(4; "Fixed"; Boolean)
        {
            Caption = 'Fixed';
            DataClassification = ToBeClassified;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(6; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = ToBeClassified;
        }
        field(7; "Last Modified on"; DateTime)
        {
            Caption = 'Last Modified on';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Particular ID")
        {
            Clustered = true;
        }
    }
}
