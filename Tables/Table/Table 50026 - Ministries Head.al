/// <summary>
/// Table Ministries Head (ID 50026).
/// </summary>
table 50026 "Ministries Head"
{
    fields
    {
        field(1; "Old Ministry Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ministries Head"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Head Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Category; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address 1"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Address 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Address 3"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Address 4"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Address 5"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "New Ministry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Ministries;

        }
        // field(12; "No. Of LOA"; Integer)
        // {
        //     CalcFormula = Count("LOA Ledger" WHERE("Head Code" = FIELD("Ministries Head"),
        //                                             "Fund Type" = CONST(LOA)));
        //     FieldClass = FlowField;
        // }
        // field(13; "Total LOA Amount"; Decimal)
        // {
        //     CalcFormula = Sum("LOA Ledger"."Authorized Amount" WHERE("Head Code" = FIELD("Ministries Head"),
        //                                                               "Fund Type" = CONST(LOA)));
        //     FieldClass = FlowField;
        // }
        // field(14; "No. Of NEFT/Cheque"; Integer)
        // {
        //     CalcFormula = Count("LOA Ledger" WHERE("Head Code" = FIELD("Ministries Head"),
        //                                             "Fund Type" = CONST("Deposit account")));
        //     FieldClass = FlowField;
        // }
        // field(15; "Total NEFT/Cheque Amount"; Decimal)
        // {
        //     CalcFormula = Sum("LOA Ledger"."Authorized Amount" WHERE("Head Code" = FIELD("Ministries Head"),
        //                                                               "Fund Type" = CONST("Deposit account")));
        //     FieldClass = FlowField;
        // }
        // field(16; "O/S Amount"; Decimal)
        // {
        //     CalcFormula = Sum("LOA Ledger"."Authorized Amount" WHERE("Head Code" = FIELD("Ministries Head")));
        //     FieldClass = FlowField;
        // }
        field(17; "Old Min Head"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Print RO Nseries"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "OP RO Nseries"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Radio RO Nseries"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "TV RO Nseries"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "CNTB No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(23; "File No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(24; "Q Sheet No. Series-OD"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(25; "CNTB No. Series-OD"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(26; "File No. Series-OD"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(27; "Q Sheet No. Series-TV"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(28; "Q Sheet No. Series-Radio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "CNTB No. Series-TV"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "CNTB No. Series-Radio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(31; "File No. Series-TV"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(32; "File No. Series-Radio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "Digital RO Nseries"; code[20])//Rashmi 30-01-2023
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Website RO Nseries"; code[20])//Rashmi 31-03-2023
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Bulk SMS RO Nseries"; code[20])// Nitin 06-04-2023
        {
            DataClassification = ToBeClassified;
        }
        field(36; "CR RO Nseries"; code[20])//kc
        {
            DataClassification = ToBeClassified;
        }
        field(37; "AIR RO Nseries"; code[20])//kc
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Print Head Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'OT,MR,NR';
            OptionMembers = OT,MR,NR;
        }
        field(39; "PR RO Nseries"; code[20])//kc
        {
            Caption = 'Producer RO No. Series';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "New Ministry Code", "Ministries Head")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Ministries Head", "Head Name", Category)
        {
        }
    }
}

