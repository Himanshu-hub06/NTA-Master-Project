table 50017 "Approved Bills"
{
    // LookupPageID = 50030; raj Block

    fields
    {
        field(1; "Bill ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Centre ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Centre No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Exam ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Exam Master"."Exam ID";
        }
        field(9; "Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Bank Name & Branch"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Account No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "IFSC Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Original Payable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Balance Payable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Exam Code"; Code[20])
        {
            // CalcFormula = Lookup("Exam Master"."Exam Code" WHERE (Exam ID=FIELD(Exam ID)));
            //FieldClass = FlowField;
        }
        field(23; "Exam Name"; Text[100])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Name" WHERE (Exam ID=FIELD(Exam ID)));
            //FieldClass = FlowField;
        }
        field(25; "Reference No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Bill Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Centre Bill,TA Bill';
            OptionMembers = "Centre Bill","TA Bill";
        }
        field(28; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = s;
        }
        field(30; "E-mail ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Mobile; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Current Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Current Payment Amount" > "Balance Payable Amount" THEN
                    ERROR('You are trying to pay more than payable amount');
                "Balance Amount" := "Balance Payable Amount" - "Current Payment Amount";
            end;
        }
        field(36; "Selection For Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bill Type", "Bill ID")
        {
        }
    }

    fieldgroups
    {
    }
}

