table 50281 "Establisment Claim Master"
{
    Caption = 'Establisment Claim Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bill ID"; Integer)
        {
            Caption = 'Bill ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Bill Description"; Text[100])
        {
            Caption = 'Bill Description';
            DataClassification = ToBeClassified;
        }

        field(3; "PD Code"; Code[20])
        {
            Caption = 'PD Code';
            DataClassification = ToBeClassified;
        }
        field(4; "PD Name"; Text[100])
        {
            Caption = 'PD Name';
            DataClassification = ToBeClassified;
        }

        field(5; "Bill Category"; Text[100])
        {
            Caption = 'Bill Category';
            DataClassification = ToBeClassified;

        }

        field(6; "Bill Type"; integer)
        {
            Caption = 'Bill Type';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(Key1; "Bill ID", "Bill Category", "Bill Description")
        {
            Clustered = true;
        }

    }
}
