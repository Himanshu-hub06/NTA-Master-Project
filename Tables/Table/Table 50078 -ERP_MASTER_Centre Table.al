table 50078 ERP_MASTER_Centre
{
    Caption = 'ERP MASTER Centre';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Centre_Name; Text[100])
        {
            Caption = 'Centre_Name';
            DataClassification = ToBeClassified;

        }
        field(3; Centre_Address; Text[100])
        {
            Caption = 'Centre_Address';
            DataClassification = ToBeClassified;
        }
        field(4; Centre_Email; Text[50])
        {
            Caption = 'Centre_Email';
            DataClassification = ToBeClassified;
        }
        field(5; Centre_Capacity; Integer)
        {
            Caption = 'Centre_Capacity';
            DataClassification = ToBeClassified;
        }
        field(6; IsActive; Boolean)
        {
            Caption = 'IsActive';
            DataClassification = ToBeClassified;
        }
        // field(7; CreatedDate; Date)
        // {
        //     Caption = 'CreatedDate';
        //     DataClassification = ToBeClassified;
        // }
        field(8; Centre_ContactNo; Text[50])
        {
            Caption = 'Centre_ContactNo';
            DataClassification = ToBeClassified;
        }
        field(9; City_Code; Code[20])
        {
            Caption = 'City_Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
