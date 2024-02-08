table 50030 "Vendor Payment Line"
{
    Caption = 'Payment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                /*

                IF Type = Type::"G/L Account" THEN
                  VALIDATE(Quantity,1);
                */

            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item;

            trigger OnValidate()
            var
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            //GSTGroup: Record "16404; //rk
            begin
                /*
                "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := PurchHeader."VAT Bus. Posting Group";

                  Type::"G/L Account":
                    BEGIN
                      GLAcc.GET("No.");
                      GLAcc.CheckGLAcc;

                        GLAcc.TESTFIELD("Direct Posting",TRUE);
                      Description := GLAcc.Name;
                      "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                      "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                      Quantity := 1;//EXP
                      "Tax Group Code" := GLAcc."Tax Group Code";
                      "Allow Invoice Disc." := FALSE;
                      "Allow Item Charge Assignment" := FALSE;
                      "Service Tax Group" := GLAcc."Service Tax Group Code";
                      IF PurchHeader."Location Code" <> '' THEN BEGIN
                        GetLocation(PurchHeader."Location Code");
                        "Service Tax Registration No." := Location."Service Tax Registration No.";
                      END ELSE BEGIN
                        GetCompanyInfo;
                        "Service Tax Registration No." := CompanyInfo."Service Tax Registration No.";
                      END;
                      "Excise Prod. Posting Group" := GLAcc."Excise Prod. Posting Group";
                      "Capital Item" := GLAcc."Capital Item";
                      InitDeferralCode;
                      IF GSTGroup.GET(GLAcc."GST Group Code") THEN;
                      UpdatePurchLineForGST(
                        GLAcc."GST Credit",GLAcc."GST Group Code",GSTGroup."GST Group Type",GLAcc."HSN/SAC Code",GLAcc.Exempted);
                    END;
                  Type::Item:
                    BEGIN
                      GetItem;
                      GetGLSetup;
                      Item.TESTFIELD(Blocked,FALSE);
                      Item.TESTFIELD("Gen. Prod. Posting Group");
                      IF Item.Type = Item.Type::Inventory THEN BEGIN
                        Item.TESTFIELD("Inventory Posting Group");
                        "Posting Group" := Item."Inventory Posting Group";
                      END;
                      Description := Item.Description;
                      "Description 2" := Item."Description 2";
                      "Unit Price (LCY)" := Item."Unit Price";
                      "Units per Parcel" := Item."Units per Parcel";
                      "Indirect Cost %" := Item."Indirect Cost %";
                      "Overhead Rate" := Item."Overhead Rate";
                      "Allow Invoice Disc." := Item."Allow Invoice Disc.";
                      "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                      "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                      "Tax Group Code" := Item."Tax Group Code";
                      Nonstock := Item."Created From Nonstock Item";
                      "Item Category Code" := Item."Item Category Code";
                      "Product Group Code" := Item."Product Group Code";
                      "Allow Item Charge Assignment" := TRUE;
                      PrepmtMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");
                      "Excise Prod. Posting Group" := Item."Excise Prod. Posting Group";
                      "Excise Accounting Type" := Item."Excise Accounting Type";
                      "Assessable Value" := Item."Assessable Value";
                      "Capital Item" := Item."Capital Item";

                      IF Item."Price Includes VAT" THEN BEGIN
                        IF NOT VATPostingSetup.GET(
                             Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
                        THEN
                          VATPostingSetup.INIT;
                        CASE VATPostingSetup."VAT Calculation Type" OF
                          VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                            VATPostingSetup."VAT %" := 0;
                          VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                            ERROR(
                              Text002,
                              VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                              VATPostingSetup."VAT Calculation Type");
                        END;
                        "Unit Price (LCY)" :=
                          ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT %" / 100),
                            GLSetup."Unit-Amount Rounding Precision");
                      END;

                      IF PurchHeader."Language Code" <> '' THEN
                        GetItemTranslation;

                      "Unit of Measure Code" := Item."Purch. Unit of Measure";
                      InitDeferralCode;
                      IF GSTGroup.GET(Item."GST Group Code") THEN;
                      IF NOT PurchHeader.Subcontracting THEN
                        UpdatePurchLineForGST(
                          Item."GST Credit",Item."GST Group Code",GSTGroup."GST Group Type",Item."HSN/SAC Code",Item.Exempted);
                    END;

                */

            end;
        }
        field(5; Description; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // GetHeader;
                // TestStatus;//rk
            end;
        }
        field(9; "Customer Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Bank Account".No.; //rk
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                //BankAccount.SETRANGE(BankAccount."No.",
                // rk
            end;
        }
        field(33; "Bank Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(42; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(44; Remarks; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF CustTab.GET("Customer No.") THEN
                    "Customer Name" := CustTab.Name
                ELSE
                    "Customer Name" := '';
            end;
        }
        field(55; "Customer Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Payment Receipt Type"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF VoucherRec.GET("Payment Receipt Type") THEN
                    "Payment Receipt Name" := VoucherRec."Voucher Type Descreiption"
                ELSE
                    "Payment Receipt Name" := '';
            end;
        }
        field(57; "Payment Receipt Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; "Applied Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; Month; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(13733; "TDS Category"; Option)
        {
            Caption = 'TDS Category';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,A,C,S,T';
            OptionMembers = " ",A,C,S,T;
        }
        field(13740; "TDS Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TDS Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
            DataClassification = ToBeClassified;
            //TableRelation = "TDS Nature of Deduction"; //rk

            trigger OnValidate()
            var
                Vend: Record 23;
            begin
            end;
        }
        field(13742; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Assessee Code";
        }
        field(13743; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16340; "Amount To Vendor"; Decimal)
        {
            Caption = 'Amount To Vendor';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Type);
                TESTFIELD(Quantity);
                TESTFIELD("Direct Unit Cost");
                /*
                "Amount To Vendor" := ROUND("Amount To Vendor",Currency."Amount Rounding Precision");
                Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
                "Tax Base Amount" := Amount;
                "Amount Including Tax" := Amount;
                InitOutstandingAmount;
                UpdateUnitCost;
                */

            end;
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Caption = 'TDS Base Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16363; "TDS Group"; Option)
        {
            Caption = 'TDS Group';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others,Rent for Plant & Machinery,Rent for Land & Building,Banking Services,Compensation On Immovable Property,PF Accumulated,Payment For Immovable Property';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others,"Rent for Plant & Machinery","Rent for Land & Building","Banking Services","Compensation On Immovable Property","PF Accumulated","Payment For Immovable Property";
        }
        field(16600; "GST Credit"; Option)
        {
            Caption = 'GST Credit';
            DataClassification = ToBeClassified;
            OptionCaption = 'Availment,Non-Availment';
            OptionMembers = Availment,"Non-Availment";
        }
        field(16609; "GST Jurisdiction Type"; Option)
        {
            Caption = 'GST Jurisdiction Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Intrastate,Interstate';
            OptionMembers = Intrastate,Interstate;
        }
        field(16612; "GST Reverse Charge"; Boolean)
        {
            Caption = 'GST Reverse Charge';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16613; "GST Assessable Value"; Decimal)
        {
            Caption = 'GST Assessable Value';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
            end;
        }
        field(16615; "Buy-From GST Registration No"; Code[15])
        {
            Caption = 'Buy-From GST Registration No';
            DataClassification = ToBeClassified;
        }
        field(50001; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "GST Group";
        }
        field(50002; "GST Group Type"; Option)
        {
            Caption = 'GST Group Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Goods,Service';
            OptionMembers = Goods,Service;
        }
        field(50003; "HSN/SAC Code"; Code[8])
        {
            Caption = 'HSN/SAC Code';
            DataClassification = ToBeClassified;
            // TableRelation = HSN/SAC.Code WHERE ("GST Group Code"=FIELD("GST Group Code")); //rk

            trigger OnValidate()
            begin
                //TestStatusOpen;
            end;
        }
        field(50004; "GST Base Amount"; Decimal)
        {
            Caption = 'GST Base Amount';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "GST %" := 0;
                "Total GST Amount" := 0;
            end;
        }
        field(50005; "GST %"; Decimal)
        {
            Caption = 'GST %';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Total GST Amount"; Decimal)
        {
            Caption = 'Total GST Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "GST TDS/TCS Amount (LCY)"; Decimal)
        {
            Caption = 'GST TDS Amount (LCY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "GST TDS/TCS"; Boolean)
        {
            Caption = 'GST TDS';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //GSTGroup: Record 16404;//rk
            begin
                /*
                IF "GST TDS/TCS" THEN
                  "GST TDS/TCS Base Amount" := "GST Base Amount"
                ELSE
                  "GST TDS/TCS Base Amount" := 0;
                IF "GST TDS/TCS"  = TRUE THEN BEGIN
                  TESTFIELD("GST TCS State Code");
                  GSTTDS.RESET;
                  GSTTDS.SETRANGE(GSTTDS."GST Jurisdiction",GSTTDS."GST Jurisdiction"::Interstate);
                  GSTTDS.SETRANGE(GSTTDS.Type,GSTTDS.Type::TCS);
                 IF GSTTDS.FINDFIRST THEN BEGIN
                    "GST TDS/TCS %" := GSTTDS."GST TDS/TCS %";
                    "GST TDS/TCS Amount (LCY)" := (("GST TDS/TCS Base Amount" * GSTTDS."GST TDS/TCS %") / 100);

                    END;
                END ELSE
                  BEGIN
                "GST TDS/TCS Amount (LCY)"  := 0;
                 END;
                 */

            end;
        }
        field(50009; "GST TCS State Code"; Code[10])
        {
            Caption = 'GST TDS State Code';
            DataClassification = ToBeClassified;
            TableRelation = State;

            trigger OnValidate()
            begin
                //TESTFIELD("GST TCS",FALSE);
            end;
        }
        field(50010; "GST TDS/TCS Base Amount"; Decimal)
        {
            Caption = 'GST TDS Base Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "GST TDS/TCS %"; Decimal)
        {
            Caption = 'GST TDS %';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
            //GSTGroup: Record "16404"; //rk
            begin
                /*
                IF "GST TDS/TCS"  = TRUE THEN BEGIN
                  GSTTDS.RESET;
                  GSTTDS.SETRANGE(GSTTDS."GST Jurisdiction",GSTTDS."GST Jurisdiction"::Interstate);
                  GSTTDS.SETRANGE(GSTTDS.Type,GSTTDS.Type::TCS);
                 IF GSTTDS.FINDFIRST THEN BEGIN
                   MESSAGE('%1-%2',"GST TDS/TCS Base Amount",GSTTDS."GST TDS/TCS %");
                    "GST TDS/TCS Amount (LCY)" := (("GST TDS/TCS Base Amount" * GSTTDS."GST TDS/TCS %") / 100);
                    END;
                END ELSE
                  BEGIN
                "GST TDS/TCS Amount (LCY)"  := 0;
                 END;
                */

            end;
        }
        field(50025; "SGST TDS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "CGST TDS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; Mandays; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Payment Rate" <> 0 THEN
                    "Direct Unit Cost" := Mandays * "Payment Rate";
                VALIDATE("Direct Unit Cost");
            end;
        }
        field(50029; "Payment Rate"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Mandays <> 0 THEN
                    "Direct Unit Cost" := Mandays * "Payment Rate";
                VALIDATE("Direct Unit Cost");
            end;
        }
        field(50030; "Service Charge %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Service Charge Amount" := ((Mandays * "Payment Rate") * "Service Charge %") / 100;
                "Direct Unit Cost" := (Mandays * "Payment Rate") + "Service Charge Amount" + "EPF Employer Amount" + "ESIC Employer Amount";
                VALIDATE("Direct Unit Cost");
            end;
        }
        field(50031; "Service Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "EPF Employer %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "EPF Employer Amount" := ((Mandays *"Payment Rate") * "EPF Employer %") / 100;
                "Direct Unit Cost" := (Mandays *"Payment Rate") + "EPF Employer Amount" + "Service Charge Amount"+ "ESIC Employer Amount";
                VALIDATE("Direct Unit Cost");
                */

            end;
        }
        field(50033; "EPF Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "ESIC Employer %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "ESIC Employer Amount" := ((Mandays *"Payment Rate") * "ESIC Employer %")/ 100;
                "Direct Unit Cost" := (Mandays *"Payment Rate") + "ESIC Employer Amount" + "Service Charge Amount" + "EPF Employer Amount";
                VALIDATE("Direct Unit Cost");
                */

            end;
        }
        field(50035; "ESIC Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Amount Hold %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "Hold Amount" :=
                  ROUND(
                    ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
                    "Amount Hold %" / 100,
                    Currency."Amount Rounding Precision");
                VALIDATE("Line Discount %");
                VALIDATE("Line Discount Amount");
                */

            end;
        }
        field(50037; "Hold Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "Amount Hold %" := ROUND(
                      "Hold Amount" / ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
                      0.01);
                VALIDATE("Line Discount %");
                VALIDATE("Line Discount Amount");
                */

            end;
        }
        field(50038; "Other Deduction %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "Other Deduction Amount" :=
                  ROUND(
                    ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
                    "Other Deduction %" / 100,
                    Currency."Amount Rounding Precision");
                VALIDATE("Line Discount %");
                VALIDATE("Line Discount Amount");
                */

            end;
        }
        field(50039; "Other Deduction Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                "Other Deduction %" := ROUND(
                      "Other Deduction Amount" / ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
                      0.01);
                VALIDATE("Line Discount %");
                VALIDATE("Line Discount Amount");
                */

            end;
        }
        field(50040; "Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Advance Paid Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Advance Paid Amount" > "Bill Amount" THEN
                    ERROR('Advance amount is always less than Bill Amount');
                "Direct Unit Cost" := "Bill Amount" - "Advance Paid Amount" - "Hold Amount";
                VALIDATE("Direct Unit Cost");
            end;
        }
        field(50042; "For The Month of"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Bill No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Ref. No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50046; "No. of Man Power"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Approved No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; Name; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Registration Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; Designation; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Absent Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Present Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; Basic; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Other Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Gross Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Service Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "PF Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "ESI Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; Total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Grand Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "SGST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "CGST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Total GST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayRecHead: Record 50097;
        "G/LAccount": Record 15;
        BankAcc: Record 270;
        DimMgt: Codeunit 50005;
        CustTab: Record 18;
        VoucherRec: Record 50092;
        BankAccount: Record 270;
        EmpCate: Record 50014;
        NtaBillHad: Record 50005;

    local procedure GetHeader()
    begin
        PayRecHead.RESET;
        PayRecHead.SETRANGE(PayRecHead."No.", "Document No.");
        IF PayRecHead.FINDFIRST THEN BEGIN
            "Posting Date" := PayRecHead."Posting Date";
            "Location Code" := PayRecHead."Location Code";
            //   Year := PayRecHead.Year;
            //   Month := PayRecHead.Month;//rk
        END;
    end;

    local procedure UpdateDescription(Name: Text[80])
    begin
        IF NOT IsAdHocDescription THEN
            Description := Name;
    end;

    local procedure IsAdHocDescription(): Boolean
    var
        GLAccount: Record 15;
        Customer: Record 18;
        Vendor: Record 23;
        BankAccount: Record 270;
        FixedAsset: Record 5600;
        ICPartner: Record 413;
    begin
        /*
        IF Description = '' THEN
          EXIT(FALSE);
        IF xRec."Account No." = '' THEN
          EXIT(TRUE);

        CASE xRec."Account Type" OF
          xRec."Account Type"::"G/L Account":
            EXIT(GLAccount.GET(xRec."Account No.") AND (GLAccount.Name <> Description));
          xRec."Account Type"::Customer:
            EXIT(Customer.GET(xRec."Account No.") AND (Customer.Name <> Description));
          xRec."Account Type"::Vendor:
            EXIT(Vendor.GET(xRec."Account No.") AND (Vendor.Name <> Description));
          xRec."Account Type"::"Bank Account":
            EXIT(BankAccount.GET(xRec."Account No.") AND (BankAccount.Name <> Description));
          xRec."Account Type"::"Fixed Asset":
            EXIT(FixedAsset.GET(xRec."Account No.") AND (FixedAsset.Description <> Description));

        END;
        EXIT(FALSE);
        */

    end;

    procedure TestStatus()
    begin
        PayRecHead.RESET;
        PayRecHead.SETRANGE("No.", "Document No.");
        PayRecHead.SETFILTER(PayRecHead.Status, '<>%1', PayRecHead.Status::Open);
        IF PayRecHead.FINDFIRST THEN
            ERROR('Document Must be Open');
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        // DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        // DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");// rk
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        // DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID"); //rk
    end;
}

