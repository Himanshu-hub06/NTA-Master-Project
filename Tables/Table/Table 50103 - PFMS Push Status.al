table 50103 "PFMS Push Status"
{
    Caption = 'PFMS Push Status';
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
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(4; "Error Description"; Text[100])
        {
            Caption = 'Error Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Status DateTime"; DateTime)
        {
            Caption = 'Status DateTime';
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
