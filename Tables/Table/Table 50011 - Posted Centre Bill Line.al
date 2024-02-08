table 50011 "Posted Centre Bill Line"
{
    //ExternalName = 'BILL_CentreBill_Particular_DTL';
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Posted Centre Bill Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Centre Particular ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PK_CentreParticular_ID';
        }
        field(2; "Centre Bill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_CentreBill_ID';
        }
        field(3; "Particular ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_Particular_ID';
            TableRelation = "Centre Bill Particulars"."Particular ID";
        }
        field(4; Partuculars; Text[150])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'ParticularText';
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'ParticularQty';
        }
        field(6; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'DefinedRate';
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Amount';
        }
        field(9; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Approved_Amount';
        }
    }

    keys
    {
        key(Key1; "Centre Particular ID", "Centre Bill ID")
        {
        }
    }

    fieldgroups
    {
    }
}

