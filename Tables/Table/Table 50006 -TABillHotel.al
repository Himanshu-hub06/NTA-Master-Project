table 50006 "TA Bill Hotel"
{
    Caption = 'TA Bill Hotel';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Hotel DA ID"; Integer)
        {
            Caption = 'Hotel DA ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Bill ID"; Integer)
        {
            Caption = 'Bill ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Hotel Name & Address"; Text[250])
        {
            Caption = 'Hotel Name & Address';
            DataClassification = ToBeClassified;
        }
        field(4; "No of Days"; Decimal)
        {
            Caption = 'No. of Days';
            DataClassification = ToBeClassified;
        }
        field(5; "Hotel Bill No"; Code[50])
        {
            Caption = 'Hotel Bill No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Hotel Bill Date"; Date)
        {
            Caption = 'Hotel Bill Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Room Rent"; Decimal)
        {
            Caption = 'Room Rent';
            DataClassification = ToBeClassified;
        }
        field(8; "Food Charges"; Decimal)
        {
            Caption = 'Food Charges';
            DataClassification = ToBeClassified;
        }
        field(9; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(10; "Last Modified on"; DateTime)
        {
            Caption = 'Last Modified on';
            DataClassification = ToBeClassified;
        }
        field(11; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
        field(12; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "From Date"; date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(14; "To Date"; date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Hotel DA ID")
        {
            Clustered = true;
        }
    }
}
