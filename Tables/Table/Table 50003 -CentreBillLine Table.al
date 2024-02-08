table 50003 "Centre Bill Line"
{
    Caption = 'Centre Bill Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Centre Particular ID"; Integer)
        {
            Caption = 'Centre Particular ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Centre Bill ID"; Integer)
        {
            Caption = 'Centre Bill ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Particular ID"; Integer)
        {
            Caption = 'Particular ID';
            DataClassification = ToBeClassified;
        }
        field(4; Partuculars; Text[150])
        {
            Caption = 'Partuculars';
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(6; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                NetAppAmount: Decimal;
                Text001: TextConst ENU = 'Approved amount should be less than submitted amount.';
            begin
                NetAppAmount := 0;
                IF "Approved Amount" > Amount THEN
                    ERROR(Text001);
            end;
        }
        field(9; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Centre Particular ID")
        {
            Clustered = true;
        }
    }
}
