table 50210 Districts
{
    //LookupPageID = 50390;             //DSC

    fields
    {
        field(1; "State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code;
        }
        field(2; "District Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Commissionerate; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Commissionerate;    //DSC
        }
    }

    keys
    {
        key(Key1; "State Code", "District Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "District Name")
        {
        }
    }
}

