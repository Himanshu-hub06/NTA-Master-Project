table 50293 Testing
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmpCode; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Emp Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Emp City"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; EmpCode)
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