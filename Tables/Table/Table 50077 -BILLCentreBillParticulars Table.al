table 50077 BILL_CentreBillParticularsDeta
{
    Caption = 'BILL_CentreBillParticularsDeta';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; CentreBillDetails_ID; Integer)
        {
            Caption = 'CentreBillDetails_ID';
            DataClassification = ToBeClassified;
        }
        field(3; Particular_ID; Integer)
        {
            Caption = 'Particular_ID';
            DataClassification = ToBeClassified;
        }
        field(4; Particulars_Name; Text[150])
        {
            Caption = 'Particulars_Name';
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; UploadBills; Text[250])
        {
            Caption = 'UploadBills';
            DataClassification = ToBeClassified;
        }
        field(8; IsActive; Boolean)
        {
            Caption = 'IsActive';
            DataClassification = ToBeClassified;
        }
        field(9; CreatedDate; DateTime)
        {
            Caption = 'CreatedDate';
            DataClassification = ToBeClassified;
        }
        field(10; Particulars_Rate; Decimal)
        {
            Caption = 'Particulars_Rate';
            DataClassification = ToBeClassified;
        }
        field(11; Description_remark; Text[250])
        {
            Caption = 'Description_remark';
            DataClassification = ToBeClassified;

        }

        field(12; Particular_type; Text[50])
        {
            Caption = 'Particular_type';
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
