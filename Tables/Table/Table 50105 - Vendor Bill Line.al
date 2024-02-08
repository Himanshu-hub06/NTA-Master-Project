table 50105 "Vendor Bill Line"
{
    Caption = 'Vendor Bill Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor Code"; Code[20])
        {
            Caption = 'Vendor Code';
            DataClassification = ToBeClassified;
            TableRelation = Vendor where("Vendor Type" = const(" "));

            trigger OnValidate()
            var
                vendtab: Record Vendor;
            begin
                If vendtab.Get("Vendor Code") then Begin
                    "Vendor Name" := vendtab.Name;
                    "GST TCS State Code" := vendtab."State Code";
                End
                ELSE
                    "Vendor Name" := '';

            end;
        }
        field(6; "Vendor Name"; Text[120])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Base Amount"; Decimal)
        {
            Caption = 'Base Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Amount Gst Included"; Decimal)
        {
            Caption = 'Amount Gst Included';
            DataClassification = ToBeClassified;
        }
        field(9; "Tds Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "TDS Concessional Codes"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TDS Concessional Code".Section;

        }
        field(11; "Assessee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Assessee Code";
        }
        field(12; "TDS %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Tds Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others,"Rent for Plant & Machinery","Rent for Land & Building","Banking Services","Compensation On Immovable Property","PF Accumulated","Payment For Immovable Property";
        }
        field(15; "GST Jurisdiction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Intrastate,Interstate;
        }
        field(16; "GST Assessable Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "GST Registration No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "GST Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "GST Group";
            trigger onValidate()
            var
                myInt: Integer;
            begin
                gstGroup.Reset();
                gstGroup.SetRange(gstGroup.Code, "GST Group Code");
                If gstGroup.FindFirst() then
                    Validate("GST %", gstGroup."GST %")
                ELSE
                    Validate("GST %", 0);
            end;
        }
        field(19; "GST Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Goods,Service;
        }
        field(20; "HSN/SAC Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HSN/SAC".Code WHERE("GST Group Code" = FIELD("GST Group Code"));
        }
        field(21; "GST Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "GST %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Total GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "GST TDS/TCS Amount "; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "GST TDS/TCS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "GST TCS State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = State;
        }
        field(27; "GST TDS/TCS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "GST TDS/TCS %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Tds Applicable"; Boolean)

        {

            DataClassification = ToBeClassified;

            trigger onvalidate()
            var
                myInt: Integer;
                TdsPer: Decimal;
                VendBillLine: Record "Vendor Bill Line";

            begin
                rec.TestField("Vendor Code");
                VendBillLine.Reset();
                VendBillLine.SetRange("Document No.", rec."Document No.");
                VendBillLine.SetRange("Line No.", rec."Line No.");
                If VendBillLine.FindFirst() Then Begin
                    If vendorTab.Get(rec."Vendor Code") Then begin
                        "Assessee Code" := vendorTab."Assessee Code";
                        TDSConcode.Reset();
                        TDSConcode.SetRange("Vendor No.", Rec."Vendor Code");
                        if TDSConcode.FindFirst() Then
                            "TDS Concessional Codes" := TDSConcode.Section;
                        "Assessee Code" := vendorTab."Assessee Code";
                        TdsPer := GetTdsPer(VendBillLine.RecordId());

                        // tdsRate.Reset();
                        // tdsRate.SetRange("Tax Type", 'TDS');
                        //  tdsRate.SetRange(tdsRate.s);
                    end;
                end;
            End;
        }
        field(30; "Purchase Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Vendor Bill No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Vendor Invoice Attachment"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Submission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Fund Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Vendor Bill Date"; Date)

        {
            DataClassification = ToBeClassified;
        }
        field(36; "Amount To Vendor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Claim Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Base Amount" := "Claim Amount";
                "Amount Gst Included" := "Claim Amount";
            end;
        }
        field(40; Remarks; Text[120])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        tdsRate: Record 20251;
        vendorTab: Record vendor;
        TDSConcode: Record "TDS Concessional Code";
        gstGroup: Record "GST Group";

    local procedure GetTDSPer(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
    begin
        if not TDSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindFirst() then
            Message('fIND');
        //TaxTransactionValue.CalcSums(Percent);
        //message('%1-P', TaxTransactionValue.Percent);
        exit(TaxTransactionValue.Percent);
    end;

    local procedure GetGSTPer(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);
        exit(TaxTransactionValue.Percent);

    end;

}
