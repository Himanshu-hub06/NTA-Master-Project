table 50222 "Committee Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(4; Designation; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Email; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Mobile No."; Code[12])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
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