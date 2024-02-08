table 50018 "Posted Approved Bills"
{
    // LookupPageID = 50030; Raj Block 

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
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Unique Code"; Code[30])
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
        field(21; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Exam Code"; Code[20])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Code" WHERE (Exam ID=FIELD(Exam ID)));
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
            //TableRelation = State.Code;
        }
        field(30; "E-mail ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Mobile; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bill Type", "Bill ID", "Line No.")
        {
        }
        key(Key2; "Unique Code")
        {
        }
    }

    fieldgroups
    {
    }
}

