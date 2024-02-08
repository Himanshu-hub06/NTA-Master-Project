table 50015 "Posted TA Bill Outstation"
{
    //ExternalName = 'BILL_TA_BILL_OutStationJourney_DTL';
    //ExternalSchema = 'dbo';
    // TableType = ExternalSQL;
    Caption = 'Posted TA Bill Outstation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Outstation ID"; Integer)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'PK_OUTJOURNEY_ID';
        }
        field(2; "Bill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_BILL_ID';
        }
        field(3; "Departure Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Departure_Date';
        }
        field(4; "Departure Time"; Text[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Departure_Time';
        }
        field(5; "Departure From"; Text[30])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Departure_From';
        }
        field(6; "Arrival Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Arrival_Date';
        }
        field(7; "Arrival Time"; Text[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Arrival_Time';
        }
        field(8; "Arrival To"; Text[30])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Arrival_To';
        }
        field(9; "Mode Of Journey"; Text[30])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Mode_OfJourney';
        }
        field(10; "Distance Of Journey"; Text[30])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Distance_Of_journey';
        }
        field(11; "Receipt No."; Code[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Receipt_no';
        }
        field(12; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(19; "Last Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'LastModifiedOn';
        }
    }

    keys
    {
        key(Key1; "Outstation ID")
        {
        }
    }

    fieldgroups
    {
    }
}

