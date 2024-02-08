/// <summary>
/// Table Genre Category Selection (ID 50038).
/// </summary>
table 50038 "Genre Category Selection"
{

    fields
    {
        field(1; "Client Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Client Request Header";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Genre Category"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Client Request No.", "Line No.")
        {
        }
        key(Key2; "Client Request No.", Selected)
        {
        }
    }

    fieldgroups
    {
    }
}

