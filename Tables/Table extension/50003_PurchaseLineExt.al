tableextension 50003 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50000; "RO No."; Code[20])
        {
            Caption = 'RO No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "RO Line No."; Integer)
        {
            Caption = 'RO Line No.';
            DataClassification = ToBeClassified;
        }
        field(50002; "Total GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Total TDS Including SHE CESS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "GST TDS/TCS Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Amount To Vendor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Indent No."; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "RO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Print Media","Out Door","AV TV","AV Radio";
        }
        field(50008; "GST TDS/TCS"; Boolean)
        {
            trigger OnValidate()
            var
                TempPurchLine: Record "Purchase Line" temporary;
            begin
                GetPurchHeader;
                TestStatusOpen;
            end;
        }
        field(50009; "GST TCS State Code"; Code[20])
        {
            // TableRelation = State.Code;
            DataClassification = ToBeClassified;
        }
        field(50010; "GST TDS/TCS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "GST TDS/TCS %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Fund Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Compaign;
        }
        field(50013; "Compaign No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }


        field(60015; "Control No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60030; "LOE Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60035; "PFMS Unique Ref. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(60036; "Fund Type"; enum "Fund Type")
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(60037; "Loa No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60040; "Gst Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(60041; "Tds Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60042; "Gst %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60043; "Tds %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60044; "Campaign No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Campaign';
            // TableRelation = "Campaign Master".Code;

            trigger Onvalidate()
            var
            //     Camtab: Record "Campaign Master";
            begin
                //     Camtab.Reset();
                //     Camtab.SetRange(Code, rec."Campaign No.");
                //     if Camtab.FindFirst() then
                //         "campaign Name" := Camtab.Name
                //     ELSE
                //         "campaign Name" := '';
            end;
        }
        field(60045; "Campaign Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50063; "Client ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Client Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Bill No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Vehicle No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; Mandays; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Payment Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50077; Month; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","01","02","03","04","05","06","07","08","09","10","11","12";
        }
        field(50078; Year; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "2023","2024","2025","2026","2027","2028","2029","2030";
        }
        field(50080; "Saction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Sanction Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Sanction Ctrated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "No. of Cases"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }
    var


    procedure CalculateStructures(VAR PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        // StrOrderDetails: Record "Structure Order Details";
        // StrOrderLineDetails: Record "Structure Order Line Details";
        // StrOrderLines: Record "Structure Order Line Details";
        Currency: Record Currency;
        Vendor: Record Vendor;
        TotalAmount: Decimal;
        BaseAmount: Decimal;
        PurchTotalLine: Decimal;
        OriginalCurrencyFactor: Decimal;
    begin
        // WITH PurchHeader DO BEGIN
        //     Currency.Initialize("Currency Code");
        //     IF "Currency Code" <> '' THEN BEGIN
        //         TESTFIELD("Currency Factor");
        //         Currency.TESTFIELD("Amount Rounding Precision");
        //     END;

        //     IF "Currency Factor" <> 0 THEN
        //         CFactor := "Currency Factor"
        //     ELSE
        //         CFactor := 1;
        //     OriginalCurrencyFactor := CFactor;

        //     StrOrderLines.LOCKTABLE;
        //     StrOrderLines.RESET;
        //     StrOrderLines.SETCURRENTKEY("Document Type", "Document No.", Type);
        //     StrOrderLines.SETRANGE("Document Type", "Document Type");
        //     StrOrderLines.SETRANGE("Document No.", "No.");
        //     StrOrderLines.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        //     StrOrderLines.SETRANGE("Manually Changed", FALSE);
        //     IF StrOrderLines.FINDFIRST THEN
        //         StrOrderLines.DELETEALL(TRUE);

        //     IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
        //         IF PurchHeader."Invoice Type" = PurchHeader."Invoice Type"::"Non-GST" THEN
        //             ERROR(NonGSTInvTypeErr);
        //         GSTManagement.PurchasePostValidations(PurchHeader);
        //     END;

        //     PurchTotalLine := 0;
        //     PurchLine.SETRANGE("Document Type", "Document Type");
        //     PurchLine.SETRANGE("Document No.", "No.");
        //     PurchLine.SETFILTER(Type, '%1|%2', PurchLine.Type::Item, PurchLine.Type::"Fixed Asset");
        //     PurchTotalLine := PurchLine.COUNT;
        //     IF PurchLine.FIND('-') THEN
        //         REPEAT
        //             TotalAmount := TotalAmount + PurchLine.Quantity * PurchLine."Direct Unit Cost";
        //         UNTIL PurchLine.NEXT = 0;

        //     PurchLine.RESET;
        //     PurchLine.SETRANGE("Document Type", "Document Type");
        //     PurchLine.SETRANGE("Document No.", "No.");
        //     IF PurchLine.FIND('-') THEN BEGIN
        //         Vendor.GET("Buy-from Vendor No.");
        //         REPEAT
        //             IF (PurchLine.Quantity <> 0) AND (PurchLine."Direct Unit Cost" <> 0) THEN BEGIN
        //                 WITH PurchLine DO BEGIN
        //                     "Amount Added to Inventory" := 0;
        //                     "Amount Added to Excise Base" := 0;
        //                     "Amount Added to Tax Base" := 0;
        //                     "VAT Base Amount" := 0;
        //                     AssessableValueCalc := CheckAssessableValue(PurchHeader);
        //                     StrOrderDetails.RESET;
        //                     StrOrderDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
        //                     StrOrderDetails.SETRANGE("Document Type", "Document Type");
        //                     StrOrderDetails.SETRANGE("Document No.", "Document No.");
        //                     StrOrderDetails.SETRANGE(Type, StrOrderDetails.Type::Purchase);
        //                     IF StrOrderDetails.FIND('-') THEN
        //                         REPEAT
        //                             IF NOT StrOrderDetails.LCY THEN
        //                                 CFactor := 1;
        //                             StrOrderLineDetails.RESET;
        //                             StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        //                             StrOrderLineDetails.SETRANGE("Calculation Order", StrOrderDetails."Calculation Order");
        //                             StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
        //                             StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
        //                             StrOrderLineDetails.SETRANGE("Structure Code", Structure);
        //                             StrOrderLineDetails.SETRANGE("Item No.", "No.");
        //                             StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Type", StrOrderDetails."Tax/Charge Type");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Group", StrOrderDetails."Tax/Charge Group");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Code", StrOrderDetails."Tax/Charge Code");
        //                             IF NOT StrOrderLineDetails.FINDFIRST THEN BEGIN
        //                                 StrOrderLineDetails.INIT;
        //                                 StrOrderLineDetails.Type := StrOrderDetails.Type;
        //                                 StrOrderLineDetails."Document Type" := StrOrderDetails."Document Type";
        //                                 StrOrderLineDetails."Document No." := StrOrderDetails."Document No.";
        //                                 StrOrderLineDetails."Structure Code" := StrOrderDetails."Structure Code";
        //                                 StrOrderLineDetails."Item No." := "No.";
        //                                 StrOrderLineDetails."Line No." := "Line No.";
        //                                 StrOrderLineDetails."Calculation Order" := StrOrderDetails."Calculation Order";
        //                                 StrOrderLineDetails."Tax/Charge Type" := StrOrderDetails."Tax/Charge Type";
        //                                 StrOrderLineDetails."Tax/Charge Group" := StrOrderDetails."Tax/Charge Group";
        //                                 StrOrderLineDetails."Tax/Charge Code" := StrOrderDetails."Tax/Charge Code";
        //                                 StrOrderLineDetails."Calculation Type" := StrOrderDetails."Calculation Type";
        //                                 StrOrderLineDetails."Calculation Value" := StrOrderDetails."Calculation Value";
        //                                 StrOrderLineDetails."Quantity Per" := StrOrderDetails."Quantity Per";
        //                                 StrOrderLineDetails."Loading on Inventory" := StrOrderDetails."Loading on Inventory";
        //                                 StrOrderLineDetails."% Loading on Inventory" := StrOrderDetails."% Loading on Inventory";
        //                                 StrOrderLineDetails."Header/Line" := StrOrderDetails."Header/Line";
        //                                 StrOrderLineDetails."Include Base" := StrOrderDetails."Include Base";
        //                                 StrOrderLineDetails."Include Line Discount" := StrOrderDetails."Include Line Discount";
        //                                 StrOrderLineDetails."Include Invoice Discount" := StrOrderDetails."Include Invoice Discount";
        //                                 StrOrderLineDetails."Payable to Third Party" := StrOrderDetails."Payable to Third Party";
        //                                 StrOrderLineDetails."Available for VAT input" := StrOrderDetails."Available for VAT Input";
        //                                 StrOrderLineDetails.LCY := StrOrderDetails.LCY;
        //                                 IF GetReverseChargePct(Vendor."Service Entity Type") <> 100 THEN
        //                                     StrOrderLineDetails."Include in TDS Base" := StrOrderDetails."Include in TDS Base";
        //                                 IF NOT GSTManagement.GetReverseCharge("Pay-to Vendor No.") THEN
        //                                     StrOrderLineDetails."Inc. GST in TDS Base" := StrOrderDetails."Inc. GST in TDS Base";

        //                                 StrOrderLineDetails.CVD := StrOrderDetails.CVD;

        //                                 IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Sales Tax") OR
        //                                    (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Excise)
        //                                 THEN BEGIN
        //                                     StrOrderDetails.TESTFIELD("Payable to Third Party", FALSE);
        //                                     StrOrderDetails.TESTFIELD("Third Party Code", '');
        //                                 END;
        //                                 IF StrOrderDetails."Payable to Third Party" THEN
        //                                     StrOrderDetails.TESTFIELD("Third Party Code");
        //                                 StrOrderLineDetails."Third Party Code" := StrOrderDetails."Third Party Code";
        //                                 IF ((StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) OR
        //                                     (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Other Taxes"))
        //                                 THEN
        //                                     StrOrderDetails.TESTFIELD("Account No.");
        //                                 StrOrderLineDetails."Account No." := StrOrderDetails."Account No.";
        //                                 StrOrderLineDetails."Base Formula" := StrOrderDetails."Base Formula";
        //                                 IF StrOrderLineDetails."Base Formula" <> '' THEN
        //                                     BaseAmount := EvaluateExpressioninStructures(TRUE, StrOrderLineDetails."Base Formula", PurchLine, StrOrderDetails)
        //                                 ELSE
        //                                     BaseAmount := 0;

        //                                 IF StrOrderDetails."Include Base" THEN
        //                                     BaseAmount := BaseAmount + Quantity * "Direct Unit Cost";
        //                                 IF StrOrderDetails."Include Line Discount" THEN
        //                                     BaseAmount := BaseAmount - "Line Discount Amount";
        //                                 IF StrOrderDetails."Include Invoice Discount" THEN
        //                                     BaseAmount := BaseAmount - "Inv. Discount Amount";


        //                                 IF ((Type <> Type::"Charge (Item)") AND
        //                                     (Type <> Type::"G/L Account"))
        //                                 THEN
        //                                     IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) OR
        //                                        (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Other Taxes")
        //                                     THEN BEGIN
        //                                         IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Fixed Value" THEN BEGIN
        //                                             IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) THEN
        //                                                 StrOrderDetails.TESTFIELD("Charge Basis");
        //                                             IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Amount THEN BEGIN
        //                                                 StrOrderLineDetails."Base Amount" :=
        //                                                   ROUND(Quantity * "Direct Unit Cost", Currency."Amount Rounding Precision");
        //                                                 StrOrderLineDetails.Amount :=
        //                                                   (StrOrderDetails."Calculation Value" * CFactor) * (Quantity * "Direct Unit Cost") / TotalAmount;
        //                                             END;
        //                                             IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Equally THEN BEGIN
        //                                                 StrOrderLineDetails."Base Amount" := 0;
        //                                                 StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) / PurchTotalLine;
        //                                             END;
        //                                         END;
        //                                         IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::Percentage THEN BEGIN
        //                                             StrOrderLineDetails."Base Amount" := BaseAmount;
        //                                             StrOrderLineDetails.Amount := StrOrderDetails."Calculation Value" * BaseAmount / 100;
        //                                         END;
        //                                         IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Amount Per Qty" THEN BEGIN
        //                                             StrOrderLineDetails."Base Amount" := 0;
        //                                             StrOrderLineDetails.Amount := (StrOrderDetails."Calculation Value" * CFactor) * Quantity /
        //                                               StrOrderDetails."Quantity Per";
        //                                         END;
        //                                     END;

        //                                 IF Type IN [Type::"Charge (Item)", Type::"G/L Account"] THEN BEGIN
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Excise THEN BEGIN
        //                                         IF Trading THEN
        //                                             Location.CheckTradingLocation("Location Code");
        //                                         IF Trading AND ("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) THEN
        //                                             GetBaseAmt(BaseAmount, PurchLine);
        //                                         "Amount Added to Excise Base" := BaseAmount;
        //                                         CVD := StrOrderDetails.CVD;
        //                                         IF CVD AND ("CIF Amount" + "BCD Amount" <> 0) THEN
        //                                             "Amount Added to Excise Base" := ("CIF Amount" + "BCD Amount") * Quantity;
        //                                         IF AssessableValueCalc AND
        //                                            (NOT (Trading AND (PurchHeader."Applies-to Doc. No." <> ''))) AND
        //                                            (NOT CVD)
        //                                         THEN BEGIN
        //                                             "Amount Added to Excise Base" := "Assessable Value" * Quantity;
        //                                             "Excise Base Amount" := "Assessable Value" * Quantity;
        //                                         END;
        //                                         UpdateTaxAmounts;
        //                                         StrOrderLineDetails."Base Amount" := "Excise Base Amount";
        //                                         StrOrderLineDetails.Amount := "Excise Amount";
        //                                         StrOrderLineDetails."CVD Payable to Third Party" := StrOrderDetails."CVD Payable to Third Party";
        //                                         StrOrderLineDetails."CVD Third Party Code" := StrOrderDetails."CVD Third Party Code";
        //                                     END;
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::GST THEN BEGIN
        //                                         IF (Vendor."GST Vendor Type" IN [Vendor."GST Vendor Type"::Import,
        //                                                                           Vendor."GST Vendor Type"::SEZ]) AND
        //                                           ("GST Group Type" = "GST Group Type"::Goods) THEN BEGIN
        //                                             IF NOT (PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Credit Memo",
        //                                                                                     PurchHeader."Document Type"::"Return Order"]) THEN BEGIN
        //                                                 IF Type = Type::"G/L Account" THEN BEGIN
        //                                                     "GST Base Amount" := "Custom Duty Amount" + "GST Assessable Value";
        //                                                     UpdateGSTAmounts("Custom Duty Amount" + "GST Assessable Value");
        //                                                 END ELSE BEGIN
        //                                                     "GST Base Amount" := BaseAmount;
        //                                                     UpdateGSTAmounts(BaseAmount);
        //                                                 END
        //                                             END ELSE BEGIN
        //                                                 "GST Base Amount" := BaseAmount;
        //                                                 UpdateGSTAmounts(BaseAmount);
        //                                             END;
        //                                         END ELSE BEGIN
        //                                             "GST Base Amount" := BaseAmount;
        //                                             UpdateGSTAmounts(BaseAmount);
        //                                         END;
        //                                         StrOrderLineDetails."Base Amount" := "GST Base Amount";
        //                                         StrOrderLineDetails.Amount := "Total GST Amount";
        //                                     END;
        //                                 END;

        //                                 IF Type IN [Type::Item, Type::"Fixed Asset"] THEN BEGIN
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Excise THEN BEGIN
        //                                         IF Trading THEN
        //                                             Location.CheckTradingLocation("Location Code");
        //                                         IF Trading AND ("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) THEN
        //                                             GetBaseAmt(BaseAmount, PurchLine);
        //                                         "Amount Added to Excise Base" := BaseAmount;
        //                                         CVD := StrOrderDetails.CVD;
        //                                         IF CVD AND ("CIF Amount" + "BCD Amount" <> 0) THEN
        //                                             "Amount Added to Excise Base" := ("CIF Amount" + "BCD Amount") * Quantity;
        //                                         IF AssessableValueCalc AND
        //                                            (NOT (Trading AND (PurchHeader."Applies-to Doc. No." <> ''))) AND
        //                                            (NOT CVD)
        //                                         THEN BEGIN
        //                                             "Amount Added to Excise Base" := "Assessable Value" * Quantity;
        //                                             "Excise Base Amount" := "Assessable Value" * Quantity;
        //                                         END;
        //                                         UpdateTaxAmounts;
        //                                         StrOrderLineDetails."Base Amount" := "Excise Base Amount";
        //                                         StrOrderLineDetails.Amount := "Excise Amount";
        //                                         StrOrderLineDetails."CVD Payable to Third Party" := StrOrderDetails."CVD Payable to Third Party";
        //                                         StrOrderLineDetails."CVD Third Party Code" := StrOrderDetails."CVD Third Party Code";
        //                                     END;
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Sales Tax" THEN BEGIN
        //                                         "Amount Added to Tax Base" := ROUND(BaseAmount, Currency."Amount Rounding Precision");
        //                                         UpdateTaxAmounts;
        //                                         StrOrderLineDetails."Base Amount" := "Tax Base Amount";
        //                                         StrOrderLineDetails.Amount := "Amount Including Tax" - "Tax Base Amount";
        //                                     END;
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::GST THEN BEGIN
        //                                         IF (Vendor."GST Vendor Type" IN [Vendor."GST Vendor Type"::Import,
        //                                                                           Vendor."GST Vendor Type"::SEZ]) AND
        //                                           ("GST Group Type" = "GST Group Type"::Goods) THEN BEGIN
        //                                             IF NOT (PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Credit Memo",
        //                                                                                     PurchHeader."Document Type"::"Return Order"]) THEN BEGIN
        //                                                 "GST Base Amount" := "Custom Duty Amount" + "GST Assessable Value";
        //                                                 UpdateGSTAmounts("Custom Duty Amount" + "GST Assessable Value");
        //                                             END ELSE BEGIN
        //                                                 "GST Base Amount" := BaseAmount;
        //                                                 UpdateGSTAmounts(BaseAmount);
        //                                             END;
        //                                         END ELSE BEGIN
        //                                             "GST Base Amount" := BaseAmount;
        //                                             UpdateGSTAmounts(BaseAmount);
        //                                         END;

        //                                         StrOrderLineDetails."Base Amount" := "GST Base Amount";
        //                                         StrOrderLineDetails.Amount := "Total GST Amount";
        //                                     END;
        //                                 END;
        //                                 IF Type IN [Type::"G/L Account", Type::"Charge (Item)"] THEN BEGIN
        //                                     IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Sales Tax" THEN BEGIN
        //                                         "Amount Added to Tax Base" := ROUND(BaseAmount, Currency."Amount Rounding Precision");
        //                                         UpdateTaxAmounts;
        //                                         StrOrderLineDetails."Base Amount" := "Tax Base Amount";
        //                                         StrOrderLineDetails.Amount := "Amount Including Tax" - "Tax Base Amount";
        //                                     END;
        //                                 END;
        //                                 IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Service Tax" THEN BEGIN
        //                                     IF "Transaction No. Serv. Tax" <> 0 THEN
        //                                         "Service Tax Base" := ROUND(BaseAmount)
        //                                     ELSE
        //                                         "Service Tax Base" := ROUND(BaseAmount, Currency."Amount Rounding Precision");
        //                                     UpdateTaxAmounts;
        //                                     StrOrderLineDetails."Base Amount" := "Service Tax Base";
        //                                     StrOrderLineDetails.Amount :=
        //                                       PurchLine.RoundServiceTax("Service Tax Amount") + PurchLine.RoundServiceTax("Service Tax eCess Amount") +
        //                                       PurchLine.RoundServiceTax("Service Tax SHE Cess Amount") + PurchLine.RoundServiceTax("Service Tax SBC Amount") +
        //                                       PurchLine.RoundServiceTax("KK Cess Amount");
        //                                 END;
        //                                 CFactor := OriginalCurrencyFactor;

        //                                 IF "Currency Code" <> '' THEN
        //                                     Currency.GET("Currency Code");

        //                                 StrOrderLineDetails."Amount (LCY)" := StrOrderLineDetails.Amount / CFactor;
        //                                 StrOrderLineDetails.INSERT
        //                             END ELSE
        //                                 IF StrOrderLineDetails."Manually Changed" THEN BEGIN
        //                                     IF ((Type <> Type::"Charge (Item)") AND
        //                                         (Type <> Type::"G/L Account"))
        //                                     THEN
        //                                         IF (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges) OR
        //                                            (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Other Taxes")
        //                                         THEN BEGIN
        //                                             IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Fixed Value" THEN BEGIN
        //                                                 IF StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::Charges THEN
        //                                                     StrOrderDetails.TESTFIELD("Charge Basis");
        //                                                 IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Amount THEN
        //                                                     StrOrderLineDetails.Amount := StrOrderLineDetails."Calculation Value" * CFactor;
        //                                                 IF StrOrderDetails."Charge Basis" = StrOrderDetails."Charge Basis"::Equally THEN BEGIN
        //                                                     StrOrderLineDetails."Base Amount" := 0;
        //                                                     StrOrderLineDetails.Amount := StrOrderLineDetails."Calculation Value" * CFactor;
        //                                                 END;
        //                                             END;
        //                                             IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::Percentage THEN BEGIN
        //                                                 StrOrderLineDetails."Base Amount" := BaseAmount;
        //                                                 StrOrderLineDetails.Amount := StrOrderLineDetails."Calculation Value" * BaseAmount / 100;
        //                                             END;
        //                                             IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Amount Per Qty" THEN BEGIN
        //                                                 StrOrderLineDetails."Base Amount" := 0;
        //                                                 StrOrderLineDetails.Amount := (StrOrderLineDetails."Calculation Value" * CFactor) * Quantity /
        //                                                   StrOrderDetails."Quantity Per";
        //                                             END;

        //                                             CFactor := OriginalCurrencyFactor;

        //                                             StrOrderLineDetails."Amount (LCY)" := StrOrderLineDetails.Amount / CFactor;
        //                                             StrOrderLineDetails.MODIFY;
        //                                         END;
        //                                 END;
        //                         UNTIL StrOrderDetails.NEXT = 0;
        //                 END;
        //             END ELSE BEGIN
        //                 PurchLine."Amount Added to Tax Base" := 0;
        //                 PurchLine."Tax Base Amount" := 0;
        //                 PurchLine."Tax Amount" := 0;
        //                 PurchLine."GST Base Amount" := 0;
        //                 PurchLine."Total GST Amount" := 0;
        //                 PurchLine."GST %" := 0;
        //             END;
        //             PurchLine.MODIFY;
        //         UNTIL PurchLine.NEXT = 0;
        //         StrOrderLineDetails.RoundAmounts(
        //           PurchHeader."Document Type", PurchHeader."No.", CFactor, Currency."Amount Rounding Precision");
        //     END;
        // END;
    end;

    procedure AdjustStructureAmounts(VAR PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        // StrOrderDetails: Record "Structure Order Details";
        // StrOrderLineDetails: Record "Structure Order Line Details";
        // StrOrderLines: Record "Structure Order Line Details";
        // CFactor: Decimal;
        StructureAmount: Decimal;
        DiffAmount: Decimal;
        Adjusted: Boolean;
    begin
        // WITH PurchHeader DO BEGIN
        //     StrOrderDetails.RESET;
        //     StrOrderDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
        //     StrOrderDetails.SETRANGE("Document Type", "Document Type");
        //     StrOrderDetails.SETRANGE("Document No.", "No.");
        //     StrOrderDetails.SETRANGE("Structure Code", Structure);
        //     StrOrderDetails.SETFILTER(
        //       "Tax/Charge Type",
        //       '%1|%2',
        //       StrOrderDetails."Tax/Charge Type"::Charges,
        //       StrOrderDetails."Tax/Charge Type"::"Other Taxes");
        //     StrOrderDetails.SETRANGE("Calculation Type", StrOrderDetails."Calculation Type"::"Fixed Value");
        //     IF StrOrderDetails.FIND('-') THEN
        //         REPEAT
        //             CLEAR(StructureAmount);
        //             StrOrderLines.RESET;
        //             StrOrderLines.SETCURRENTKEY(
        //               "Document Type", "Document No.", "Calculation Order", Type, "Structure Code", "Tax/Charge Type", "Tax/Charge Group",
        //               "Tax/Charge Code", "Calculation Type");
        //             StrOrderLines.SETRANGE("Document Type", "Document Type");
        //             StrOrderLines.SETRANGE("Document No.", "No.");
        //             StrOrderLines.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        //             StrOrderLines.SETRANGE("Structure Code", Structure);
        //             StrOrderLines.SETRANGE("Tax/Charge Type", StrOrderDetails."Tax/Charge Type");
        //             StrOrderLines.SETRANGE("Tax/Charge Group", StrOrderDetails."Tax/Charge Group");
        //             StrOrderLines.SETRANGE("Tax/Charge Code", StrOrderDetails."Tax/Charge Code");
        //             StrOrderLines.SETRANGE("Calculation Type", StrOrderDetails."Calculation Type");
        //             IF StrOrderLines.FIND('-') THEN
        //                 REPEAT
        //                     StructureAmount := StructureAmount + StrOrderLines.Amount;
        //                 UNTIL StrOrderLines.NEXT = 0;

        //             IF "Currency Factor" <> 0 THEN
        //                 CFactor := "Currency Factor"
        //             ELSE
        //                 CFactor := 1;

        //             IF NOT StrOrderDetails.LCY THEN
        //                 CFactor := 1;

        //             Adjusted := FALSE;
        //             IF StrOrderDetails."Calculation Value" <> StructureAmount THEN BEGIN
        //                 DiffAmount := (StrOrderDetails."Calculation Value" * CFactor) - StructureAmount;
        //                 StrOrderLines.RESET;
        //                 StrOrderLines.SETCURRENTKEY(
        //                   "Document Type", "Document No.", "Calculation Order", Type, "Structure Code", "Tax/Charge Type", "Tax/Charge Group",
        //                   "Tax/Charge Code", "Calculation Type");
        //                 StrOrderLines.SETRANGE("Document Type", "Document Type");
        //                 StrOrderLines.SETRANGE("Document No.", "No.");
        //                 StrOrderLines.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        //                 StrOrderLines.SETRANGE("Structure Code", Structure);
        //                 StrOrderLines.SETRANGE("Tax/Charge Type", StrOrderDetails."Tax/Charge Type");
        //                 StrOrderLines.SETRANGE("Tax/Charge Group", StrOrderDetails."Tax/Charge Group");
        //                 StrOrderLines.SETRANGE("Tax/Charge Code", StrOrderDetails."Tax/Charge Code");
        //                 StrOrderLines.SETRANGE("Calculation Type", StrOrderDetails."Calculation Type");
        //                 IF StrOrderLines.FIND('-') THEN
        //                     REPEAT
        //                         IF PurchLine.GET(StrOrderLines."Document Type", StrOrderLines."Document No.", StrOrderLines."Line No.") THEN BEGIN
        //                             IF PurchLine.Type <> PurchLine.Type::"G/L Account" THEN BEGIN
        //                                 IF (StrOrderDetails."Calculation Value" <> 0) AND (NOT StrOrderLines."Manually Changed") THEN BEGIN
        //                                     StrOrderLines.Amount := ROUND(StrOrderLines.Amount + DiffAmount);
        //                                     StrOrderLines."Amount (LCY)" := ROUND(StrOrderLines."Amount (LCY)" + DiffAmount / CFactor);
        //                                     StrOrderLines.MODIFY;
        //                                     Adjusted := TRUE;
        //                                 END;
        //                             END;
        //                         END;
        //                     UNTIL (StrOrderLines.NEXT = 0) OR Adjusted;
        //             END;
        //         UNTIL StrOrderDetails.NEXT = 0;
        // END;
    end;

    procedure UpdatePurchLines(VAR PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        // StrOrderDetails:	Record	"Structure Order Details"	;
        // StrOrderLineDetails:	Record	"Structure Order Line Details";	
        Currency: Record Currency;
        ChargesToVendor: Decimal;
    begin
        // WITH PurchHeader DO BEGIN
        //     IF "Currency Code" = '' THEN
        //         Currency.InitRoundingPrecision
        //     ELSE
        //         Currency.GET("Currency Code");

        //     PurchLine.SETRANGE("Document Type", "Document Type");
        //     PurchLine.SETRANGE("Document No.", "No.");
        //     PurchLine.SETFILTER(Type, '%1|%2|%3|%4', PurchLine.Type::Item, PurchLine.Type::"G/L Account", PurchLine.Type::"Fixed Asset",
        //       PurchLine.Type::"Charge (Item)");
        //     IF PurchLine.FIND('-') THEN
        //         REPEAT
        //             IF PurchLine.Quantity <> 0 THEN
        //                 WITH PurchLine DO BEGIN
        //                     ChargesToVendor := 0;
        //                     StrOrderDetails.RESET;
        //                     StrOrderDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
        //                     StrOrderDetails.SETRANGE("Document Type", "Document Type");
        //                     StrOrderDetails.SETRANGE("Document No.", "Document No.");
        //                     StrOrderDetails.SETRANGE(Type, StrOrderDetails.Type::Purchase);
        //                     IF StrOrderDetails.FIND('-') THEN
        //                         REPEAT
        //                             StrOrderLineDetails.RESET;
        //                             StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        //                             StrOrderLineDetails.SETRANGE("Calculation Order", StrOrderDetails."Calculation Order");
        //                             StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
        //                             StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
        //                             StrOrderLineDetails.SETRANGE("Structure Code", Structure);
        //                             StrOrderLineDetails.SETRANGE("Item No.", "No.");
        //                             StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Type", StrOrderDetails."Tax/Charge Type");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Group", StrOrderDetails."Tax/Charge Group");
        //                             StrOrderLineDetails.SETRANGE("Tax/Charge Code", StrOrderDetails."Tax/Charge Code");
        //                             IF StrOrderLineDetails.FIND('-') THEN
        //                                 REPEAT
        //                                     IF StrOrderDetails."Loading on Inventory" AND
        //                                        NOT ((StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Sales Tax") OR
        //                                             (StrOrderDetails."Tax/Charge Type" = StrOrderDetails."Tax/Charge Type"::"Service Tax"))
        //                                     THEN
        //                                         "Amount Added to Inventory" :=
        //                                           "Amount Added to Inventory" + ROUND(StrOrderLineDetails."Amount (LCY)" *
        //                                             StrOrderLineDetails."% Loading on Inventory" / 100, Currency."Amount Rounding Precision");
        //                                     IF NOT StrOrderDetails."Payable to Third Party" THEN
        //                                         IF NOT (StrOrderDetails."Tax/Charge Type" IN [StrOrderDetails."Tax/Charge Type"::"Sales Tax",
        //                                                                                       StrOrderDetails."Tax/Charge Type"::Excise,
        //                                                                                       StrOrderDetails."Tax/Charge Type"::"Service Tax",
        //                                                                                       StrOrderDetails."Tax/Charge Type"::GST])
        //                                         THEN
        //                                             ChargesToVendor := ChargesToVendor + ROUND(StrOrderLineDetails.Amount, Currency."Amount Rounding Precision");
        //                                 UNTIL StrOrderLineDetails.NEXT = 0;
        //                         UNTIL StrOrderDetails.NEXT = 0;
        //                     "Charges To Vendor" := ChargesToVendor;
        //                     IF CVD AND GetCVDPayableToThirdParty(PurchLine) THEN
        //                         "Amount To Vendor" :=
        //                           "Line Amount" - "Inv. Discount Amount" + "Tax Amount" - "Bal. TDS Including SHE CESS" + "Total GST Amount" +
        //                             "Charges To Vendor" + FullServiceTaxAmount + FullServiceTaxSBCAmount + KKCessAmount
        //                     ELSE
        //                         "Amount To Vendor" :=
        //                           "Line Amount" -
        //                           "Inv. Discount Amount" + "Excise Amount" + "Tax Amount" - "Bal. TDS Including SHE CESS" + "Total GST Amount" +
        //                             "Charges To Vendor" + FullServiceTaxAmount + FullServiceTaxSBCAmount + KKCessAmount;
        //                     IF "GST Reverse Charge" THEN
        //                         "Amount To Vendor" := "Amount To Vendor" - "Total GST Amount";
        //                     MODIFY;
        //                 END;
        //         UNTIL PurchLine.NEXT = 0;
        // END;
    end;


}
