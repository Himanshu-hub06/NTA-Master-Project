table 50056 "Management Report"
{
    Caption = 'Management Report';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "R Code"; Code[10])
        {
        }
        field(2; "Report ID"; Integer)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Department; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "R Code")
        {
        }
        key(Key2; Department, "Report ID")
        {
        }
    }

    fieldgroups
    {
    }
}

