table 50289 "AIC Commitee Master"
{
    Caption = 'AIC Commitee Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Session; Integer)
        {
            Caption = 'Session';
        }
        field(2; "Committee Code"; Code[20])
        {
            Caption = 'Committee Code';
        }
        field(3; "Committee Name"; Text[20])
        {
            Caption = 'Committee Name';
        }
        field(4; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
        }
        field(5; "Employee Name"; Text[20])
        {
            Caption = 'Employee Name';
        }
        field(6; Location; Code[20])
        {
            Caption = 'Location';
        }
        field(7; Designation; Text[50])
        {
            Caption = 'Designation';
        }
        field(8; "Posting City"; Text[50])
        {
            Caption = 'Posting City';
        }
    }
    keys
    {
        key(PK; Session)
        {
            Clustered = true;
        }
    }
}
