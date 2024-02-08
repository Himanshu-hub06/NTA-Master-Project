table 50001 "User Location"
{

    fields
    {
        field(1; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                UserTab.RESET;
                UserTab.SETRANGE(UserTab."User Name", "User Id");
                IF UserTab.FINDFIRST THEN
                    "User Name" := UserTab."Full Name"
                ELSE
                    "User Name" := '';
            end;
        }
        field(2; "User Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                IF LocationTab.GET("Location Code") THEN
                    "Location Name" := LocationTab.Name
                ELSE
                    "Location Name" := '';
            end;
        }
        field(4; "Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "All Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(true));

            trigger OnValidate()
            begin

                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");

                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'Section');
                DimValue.SETRANGE(DimValue.Code, "Shortcut Dimension 2 Code");
                IF DimValue.FINDFIRST THEN
                    "Section Name" := DimValue.Name
                ELSE
                    "Section Name" := '';

            end;
        }
        field(31; "Section Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "User Id", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created Date" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := USERID;
        "Last Modified Date" := TODAY;
    end;

    var
        UserTab: Record "User";
        LocationTab: Record Location;
        DimValue: Record "Dimension Value";
}

