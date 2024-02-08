table 50290 "Activity Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Name Of Activity: "; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Display Order: "; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "S.No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Activity Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; EDIT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; DELETE; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Name Of Activity: ")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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