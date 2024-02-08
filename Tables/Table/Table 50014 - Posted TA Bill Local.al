table 50014 "Posted TA Bill Local"
{
    //ExternalName = Rec."BILL_TA_BILL_LocalJourney_DTL";
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Posted TA Bill Local';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Local Journey ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PK_Local_Journey_ID';
        }
        field(2; "Bill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_BILL_ID';
        }
        field(3; "Journey Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Journey_Date';
        }
        field(4; "Journey Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Journey_Remarks';
        }
        field(5; "Departure Time"; Text[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Departure_Time';
        }
        field(6; "Departure From"; Text[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Departure_From';
        }
        field(7; "Arrival Time"; Text[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Arrival_Time';
        }
        field(8; "Arrival To"; Text[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Arrival_To';
        }
        field(9; "Mode Of Journey"; Text[30])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Mode_OfJourney';
        }
        field(10; "Distance Of Journey"; Text[30])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Distance_Of_journey';
        }
        field(11; "Receipt No."; Code[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Receipt_no';
        }
        field(12; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Amount';
            MinValue = 0;
        }
        field(19; "Last Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'LastModifiedOn';
        }
    }

    keys
    {
        key(Key1; "Local Journey ID")
        {
        }
        key(Key2; "Bill ID")
        {
        }
    }

    fieldgroups
    {
    }
}

