table 50051 "Pending Documents"
{

    fields
    {
        field(1;"Document ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document ID")
        {
        }
    }

    fieldgroups
    {
    }
}

