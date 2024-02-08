table 50288 "Affiliation Type"
{
    Caption = 'Affiliation Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sr. No."; Integer)
        {
            Caption = 'Sr. No.';
            AutoIncrement = true;
        }
        field(2; "Affiliation Type"; text[20])
        {
            Caption = 'Affiliation Type';
        }
        field(3; Remarks; Text[100])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(PK; "Sr. No.")
        {
            Clustered = true;
        }
    }
}
