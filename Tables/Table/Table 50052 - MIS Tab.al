table 50052 "MIS Tab"
{

    fields
    {
        field(1; "Object Code"; Code[10])
        {

        }
        field(2; "Object ID"; Integer)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Department; Option)
        {
            OptionCaption = ',Accounts,Purchase,PRO,Legal';
            OptionMembers = ,Accounts,Purchase,PRO,Legal;
        }
        field(5; "Object Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Page,Report';
            OptionMembers = "Page","Report";
        }
        field(6; "Approving ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID")
        {
        }
        key(Key2; Department, "Object ID")
        {
        }
    }

    fieldgroups
    {
    }
}

