table 50020 "NTA Role Master"
{
    //ExternalName = 'UMS_Role_Mst';
    // TableType = ExternalSQL;
    Caption = 'NTA Role Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Role ID"; Integer)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'PK_RoleId';
        }
        field(2; "Role Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'RoleName';
        }
        field(3; "Role Type"; Text[30])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'RoleType';
        }
    }

    keys
    {
        key(Key1; "Role ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Role ID", "Role Name")
        {
        }
    }
}

