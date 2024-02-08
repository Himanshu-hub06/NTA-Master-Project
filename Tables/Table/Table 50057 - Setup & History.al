table 50057 "Setup & History"
{
    Caption = 'Setup';
    Permissions =;

    fields
    {
        field(1; "P Code"; Code[10])
        {
        }
        field(2; "Page ID"; Integer)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Department; Code[20])
        {
        }
        field(5; "Sub Dept"; Code[20])
        {
        }
        field(6; "Page Type"; Option)
        {
            OptionCaption = ',Setup,History,Process';
            OptionMembers = ,Setup,History,Process;
        }
    }

    keys
    {
        key(Key1; "P Code")
        {
        }
        key(Key2; Department, "Page ID")
        {
        }
        key(Key3; Description)
        {
        }
        key(Key4; Department, "Sub Dept")
        {
        }
    }

    fieldgroups
    {
    }
}

