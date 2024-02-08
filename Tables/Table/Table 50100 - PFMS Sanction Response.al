table 50100 "PFMS Sanction Response"
{
    Caption = 'PFMS Sanction Response';
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
            DataClassification = ToBeClassified;
        }
        field(5; IsSuccess; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Error Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Status DateTime"; DateTime)
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
