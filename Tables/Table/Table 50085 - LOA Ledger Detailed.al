table 50085 "LOA Ledger Detailed"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Ministry Code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Head Code"; Code[20])
        {
            Caption = 'Head/Department Code';
            DataClassification = ToBeClassified;

        }
        field(4; "Head Name"; Text[200])
        {
            Caption = 'Head/Department Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Vendor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Grant No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Major Head No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; SCCD; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Major Head SL. No."; Code[8])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Accounts Code"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Authorized Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Client Email"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(16; "Client Mobile No."; Code[10])
        {
            CharAllowed = '09';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
            Numeric = true;
        }
        field(17; "Fund Type"; Enum "Fund Type")
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(22; "AUTH. LTR. NO."; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "AUTH. DATE"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Received DATE"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Alpha Code"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Sanction No."; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Sanction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Entry Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Category; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Remarks; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Pfms Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Loa Attachment"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "NEFT/RTGS Ref. No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Loa Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Vendor Bill No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Vendor Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "ministry Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Ministries."Ministry Name";
        }
        field(45; "Media Type"; Option)
        {
            OptionMembers = ,"Print Media","Out Door",AV;
            DataClassification = ToBeClassified;
        }

        field(47; "Loa No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Balance Amt"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("LOA Ledger Detailed"."Authorized Amount" where("Head Code" = field("Head Code"), "Loa No." = field("Loa No."), "Media Type" = field("Media Type")));
        }
        field(41; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "contigent No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Contigent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50; Cancel; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Campaign Code"; Integer)
        {
            DataClassification = ToBeClassified;

            // TableRelation = "Campaign Master".Code;

            // trigger Onvalidate()
            // var
            //     Camtab: Record "Campaign Master";
            // begin
            //     Camtab.Reset();
            //     Camtab.SetRange(Code, rec."Campaign Code");
            //     if Camtab.FindFirst() then
            //         "campaign Name" := Camtab.Name
            //     ELSE
            //         "campaign Name" := '';
            // end;

        }
        field(85; "Campaign Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(86; "Financial Year"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Expense Amt"; Decimal)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = sum("LOA Ledger Detailed"."Debit Amount" where("Head Code" = field("Head Code"), "Loa No." = field("Loa No.")));
        }
        field(90; "Ro No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Ro Specific"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Fund Category"; Enum "Fund Category")
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No.", "Loa No.")
        {
        }
        key(Key2; "Media Type", "Loa No.")
        {
            SumIndexFields = "Authorized Amount", "Balance Amount";
            MaintainSiftIndex = false;
        }
        key(Key3; "contigent No.", "Contigent Line No.")
        {

        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loa No.", "Head Code", "Head Name", "Authorized Amount", "Balance Amt")
        {

        }
    }

    var

}

