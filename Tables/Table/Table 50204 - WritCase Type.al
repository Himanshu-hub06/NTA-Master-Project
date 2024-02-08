table 50204 "Writ/Case Type"
{
    LookupPageId = 50402;
    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Civil,Criminal,Other';
            OptionMembers = Civil,Criminal,Other;
        }
        field(4; Court; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Supreme Court of India,High Court of Patna,High Court of Jharkhand,Bihar Anudanit Shikshan Sansthan Pradhikar,Civil/Lower Court,Other High Court,State Appellate Authority';
            OptionMembers = " ","Supreme Court of India","High Court of Patna","High Court of Jharkhand","Bihar Anudanit Shikshan Sansthan Pradhikar","Civil/Lower Court","Other High Court","State Appellate Authority";
        }
    }

    keys
    {
        key(Key1; "Code", Type, Court)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Type)
        {
        }
    }
}

