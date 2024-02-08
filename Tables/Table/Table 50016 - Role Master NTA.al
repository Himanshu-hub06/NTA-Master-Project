table 50016 "Role Master NTA"
{
    // ExternalName = 'UMS_Role_Mst';
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Role Master NTA';
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
        field(3; Alias; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Role ID")
        {
        }
        key(Key2; "Role Name")
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

