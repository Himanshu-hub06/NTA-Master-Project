table 50221 "Committee Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Committee Table';

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "committee Name"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula  = lookup()

            DataClassification = ToBeClassified;

        }
        field(3; "Committee Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

    }


    keys
    {
        key(Key1; "No.")
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