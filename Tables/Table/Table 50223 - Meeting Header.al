table 50223 "Meeting Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meeting No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Meeting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Meeting Type"; Option)
        {
            OptionMembers = ,Online,Offline;
            DataClassification = ToBeClassified;
        }
        field(4; "Meeting Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            OptionMembers = Open,Pending,Reject,Release;
            DataClassification = ToBeClassified;
        }
        field(6; Venue; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Agenda; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Description; text[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Meeting No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}