table 50216 "External UMS User Master"
{
    ExternalName = 'UMS_User_Mst';
    TableType = ExternalSQL;

    fields
    {
        field(1; "User ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'PK_UserId';
        }
        field(2; "User Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            ExternalName = 'UserName';
        }
        field(3; "Full User Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            ExternalName = 'UserFullName';
        }
        field(5; "Nav User ID"; Text[250])
        {
            DataClassification = ToBeClassified;
            ExternalName = 'Fk_NavUserId';
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

