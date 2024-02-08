table 50060 "NP Advt Rate"
{

    fields
    {
        field(1; "NP Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "News Paper"."NP Code";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Normal Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Color Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Front Page Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; UOM; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Sq Cm,Sq Inch';
            OptionMembers = "Sq Cm","Sq Inch";
        }
        field(8; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Latest; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Mail Sent",Approved,Rejected;
            OptionCaption = 'Mail Sent,Approved,Rejected';
        }
        field(12; "Sender ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Receiver ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Meeting No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "NP Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

