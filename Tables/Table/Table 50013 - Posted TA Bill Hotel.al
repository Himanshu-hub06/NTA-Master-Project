table 50013 "Posted TA Bill Hotel"
{
    //ExternalName = 'BILL_TA_BILL_HotelDA_DTL';
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Posted TA Bill Hotel';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Hotel DA ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PK_Hotel_DA_ID';
        }
        field(2; "Bill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_BILL_ID';
        }
        field(3; "Hotel Name & Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Hotel_Detail';
        }
        field(5; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            //ExternalName = 'Noofdays';
            MinValue = 0;
        }
        field(6; "Hotel Bill No."; Code[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Bill_No';
        }
        field(7; "Hotel Bill Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Bill_Date';
        }
        field(8; "Room Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Room_Rent';
            MinValue = 0;
        }
        field(9; "Food Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Food_Charge';
            MinValue = 0;
        }
        field(10; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Total_Amount';
            MinValue = 0;
        }
        field(14; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'LastModifiedOn';
        }
    }

    keys
    {
        key(Key1; "Hotel DA ID")
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

