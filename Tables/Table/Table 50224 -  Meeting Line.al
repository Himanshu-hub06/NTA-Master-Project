table 50224 "Meeting Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Agency Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Media; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Application No.")
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