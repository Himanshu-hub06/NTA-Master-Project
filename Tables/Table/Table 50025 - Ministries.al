table 50025 Ministries
{

    fields
    {
        field(1; "Ministry Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ministry Name"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE(Description, UPPERCASE("Ministry Name"));
            end;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Landing UID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "MP Work Flow"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group".Code;
        }
        field(6; "OD MP Work Flow"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group".Code;
        }
        field(7; "OD Landing UID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "AV MP Work Flow"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group".Code;
        }
        field(9; "AV Landing UID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Controller Code"; code[3])
        {
            DataClassification = ToBeClassified;
        }
        // field(11; "PR Sectors"; enum "Producer Sectors Type")
        // {
        //     Caption = 'Production Sectors';
        //     DataClassification = ToBeClassified;
        // }
        // field(12; "PR Sector Code"; code[20])
        // {
        //     Caption = 'Production Sectors';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Producer Sectors Master"."PR Sector Code";
        // }
    }

    keys
    {
        key(Key1; "Ministry Code")
        {
        }
    }

    fieldgroups
    {
    }
}

