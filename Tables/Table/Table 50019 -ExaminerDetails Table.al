table 50019 "Examiner Details"
{
    Caption = 'Examiner Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Exam Details ID"; Integer)
        {
            Caption = 'Exam Details ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Exam Code"; Code[100])
        {
            Caption = 'Exam Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Examinar Code"; Code[100])
        {
            Caption = 'Examinar Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Exam ID"; Integer)
        {
            Caption = 'Exam ID';
            DataClassification = ToBeClassified;
        }
        field(5; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Role ID"; Integer)
        {
            Caption = 'Role ID';
            DataClassification = ToBeClassified;
        }
        field(7; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
            DataClassification = ToBeClassified;
        }
        field(8; "Mobile No."; Code[50])
        {
            Caption = 'Mobile No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Exam Name"; Text[100])
        {
            Caption = 'Exam Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Exam Details ID")
        {
        }
        key(Key2; "Examinar Code", "Exam ID", "Exam Date")
        {
        }
        key(Key3; "Exam ID", "Exam Date")
        {
        }
    }

    fieldgroups
    {
    }
}
