page 50179 "Payment Proposal Statistics"
{
    Caption = 'Purchase Statistics';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SourceTable = "Purchase Header";
    // SourceTable = 38;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                /* //kamlesh date 08-02-2023
                field("Base Amount"; TotalPurchLine."Line Discount Amount")) //kamlesh date 08-02-2023                    
                {
                    Caption = 'Base Amount';
                    Editable = false;                   
                    ApplicationArea=All;
                }
                field("Other Deduction";TotalPurchLine."Line Discount Amount")    
                {
                    Caption = 'Other Deduction';
                    Editable = false;
                    ApplicationArea=All;
                }
                field(Amount; TotalPurchLine."Line Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, FALSE);
                    Caption = 'Amount';
                    Editable = false;
                    ApplicationArea=All;
                }
                */
                /*
                field(InvDiscountAmount; TotalPurchLine."Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Inv. Discount Amount';
                    Visible = false;
                    ApplicationArea=All;

                    trigger OnValidate()
                    begin
                        UpdateInvDiscAmount;
                    end;
                }
               
                field(TotalAmount1; TotalAmount1)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text002, FALSE);
                    Caption = 'Total';
                    Editable = false;
                    ApplicationArea=All;

                    trigger OnValidate()
                    begin
                        UpdateTotalAmount;
                    end;
                }

                field(TotalPurchLine."Tax Amount"; TotalPurchLine."Tax Amount")
                {
                    Caption = 'Tax Amount';
                    Editable = false;
                    ApplicationArea=All;
                }
                  //kamlesh date 08-02-2023
                field(ABS(TotalGSTInvoiced) - TotalAdvGSTInvoiced; ABS(TotalGSTInvoiced) -  TotalAdvGSTInvoiced)
                {
                    Caption = 'GST Amount';
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Service Tax Amount" + TotalPurchLine."Service Tax eCess Amount" + TotalPurchLine."Service Tax SHE Cess Amount" + TotalPurchLine."Service Tax SBC Amount" + TotalPurchLine."KK Cess Amount";
                    TotalPurchLine."Service Tax Amount" + TotalPurchLine."Service Tax eCess Amount" + TotalPurchLine."Service Tax SHE Cess Amount" + TotalPurchLine."Service Tax SBC Amount" + TotalPurchLine."KK Cess Amount")
                {
                    Caption = 'Service Tax Amount';
                    Editable = false;
                    Visible = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Charges To Vendor"; TotalPurchLine."Charges To Vendor")
                {
                    Caption = 'Charges';
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Bal. TDS Including SHE CESS";
                    TotalPurchLine."Bal. TDS Including SHE CESS")
                {
                    Caption = 'TDS ';
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."GST TDS/TCS Amount (LCY)";
                    TotalPurchLine."GST TDS/TCS Amount (LCY)")
                {
                    Caption = 'GST TDS';
                    Editable = false;
                    ApplicationArea=All;
                }

                field(TotalPurchLine."Amount To Vendor" - ReverseChargeGST;
                    TotalPurchLine."Amount To Vendor" - ReverseChargeGST)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Net Total';
                    Editable = false;
                    ApplicationArea=All;
                }
                field(Quantity; TotalPurchLine.Quantity)
                {
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Units per Parcel";
                    TotalPurchLine."Units per Parcel")
                {
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Net Weight";
                    TotalPurchLine."Net Weight")
                {
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Gross Weight";
                    TotalPurchLine."Gross Weight")
                {
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLine."Unit Volume";
                    TotalPurchLine."Unit Volume")
                {
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea=All;
                }
                field(TotalPurchLineLCY.Amount;
                    TotalPurchLineLCY.Amount)
                {
                    AutoFormatType = 1;
                    Caption = 'Purchase (LCY)';
                    Editable = false;
                    ApplicationArea=All;
                }
                 */ //kamlesh date 08-02-2023
            }
        }
    }

    // actions   //kamlesh date 08-02-2023
    // {
    // }
    /*
        trigger OnAfterGetRecord()
        var
            PurchLine: Record 39;
            TempPurchLine: Record 39 temporary;
            GLSetup: Record 98;
            // GSTManagement: Codeunit 16401; //commented by kamlesh date 08-02-2023
            Transactiontype: Option Purchase,Sale,Transfer,Service;
        begin
            CurrPage.CAPTION(STRSUBSTNO(Text000, "Document Type"));
            IF PrevNo = "No." THEN BEGIN
                GetVATSpecification;
                EXIT;
            END;
            GLSetup.GET;
            PrevNo := "No.";
            FILTERGROUP(2);
            SETRANGE("No.", PrevNo);
            FILTERGROUP(0);
            CLEAR(PurchLine);
            CLEAR(TotalPurchLine);
            CLEAR(TotalPurchLineLCY);
            CLEAR(PurchPost);
            CLEAR(TotalAdvGSTInvoiced);
            CLEAR(TotalGSTInvoiced);
            PurchPost.GetPurchLines(Rec, TempPurchLine, 0);
            CLEAR(PurchPost);
            PurchPost.SumPurchLinesTemp(
              Rec, TempPurchLine, 0, TotalPurchLine, TotalPurchLineLCY, VATAmount, VATAmountText);

            IF (TotalPurchLine."Service Tax Amount" = 0) AND
               (TotalPurchLine."Service Tax eCess Amount" + TotalPurchLine."Service Tax SHE Cess Amount" <> 0) THEN BEGIN
                TotalPurchLine."Line Amount" += TotalPurchLine."Service Tax eCess Amount" + TotalPurchLine."Service Tax SHE Cess Amount";
                TotalPurchLine.Amount += TotalPurchLine."Service Tax eCess Amount" + TotalPurchLine."Service Tax SHE Cess Amount";
                TotalPurchLine."Amount Including VAT" += TotalPurchLine."Service Tax eCess Amount" +
                TotalPurchLine."Service Tax SHE Cess Amount";
                TotalPurchLine."Service Tax eCess Amount" := 0;
                TotalPurchLine."Service Tax SHE Cess Amount" := 0;
                TotalPurchLine."Service Tax SBC Amount" := 0;
            END;

            IF "Prices Including VAT" THEN BEGIN
                TotalAmount2 := TotalPurchLine.Amount;
                TotalAmount1 := TotalAmount2 + VATAmount;
                TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
            END ELSE BEGIN
                TotalAmount1 := TotalPurchLine.Amount;
                TotalAmount2 := TotalPurchLine."Amount Including VAT";
            END;
            ClearGSTStatisticsAmount;
            PurchLine.SETRANGE("Document Type", "Document Type");
            PurchLine.SETRANGE("Document No.", "No.");
            PurchLine.SETFILTER(Quantity, '<>%1', 0);
            IF PurchLine.FINDSET THEN BEGIN
                REPEAT
                    TotalGSTInvoiced +=
                      GSTManagement.RoundTotalGSTAmountQtyFactor(
                        Transactiontype::Purchase, PurchLine."Document Type",
                        PurchLine."Document No.", PurchLine."Line No.", 1, "Currency Code", FALSE);
                    ReverseChargeGSTAmount += PurchLine."Total GST Amount";
                UNTIL PurchLine.NEXT = 0;
                IF GLSetup."GST Inv. Rounding Precision" <> 0 THEN
                    IF TotalGSTInvoiced <> 0 THEN
                        TotalGSTInvoiced := GSTManagement.RoundGSTInvoicePrecision(TotalGSTInvoiced, "Currency Code");
                IF PurchLine."GST Reverse Charge" THEN
                    ReverseChargeGST := TotalGSTInvoiced;

                IF GLSetup."GST Inv. Rounding Precision" <> 0 THEN
                    TotalPurchLine."Amount To Vendor" :=
                      TotalAmount1 + GSTManagement.RoundGSTInvoicePrecision(ReverseChargeGSTAmount, "Currency Code") -
                      TotalPurchLine."Total TDS Including SHE CESS" + TotalPurchLine."Charges To Vendor" -
                      TotalPurchLine."GST TDS/TCS Amount (LCY)" //EXP
                ELSE
                    TotalPurchLine."Amount To Vendor" :=
                      TotalAmount1 + ReverseChargeGSTAmount - TotalPurchLine."Total TDS Including SHE CESS" +
                      TotalPurchLine."Charges To Vendor" -
                      TotalPurchLine."GST TDS/TCS Amount (LCY)";//EXP

            END;
            IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN BEGIN
                TotalAdvGSTInvoiced := GSTApplicationAmount;
                TotalAmountApplied := GetApplicableAmount(TotalAdvGSTInvoiced, TotalGSTInvoiced);
            END;

            IF Vend.GET("Pay-to Vendor No.") THEN
                Vend.CALCFIELDS("Balance (LCY)")
            ELSE
                CLEAR(Vend);

            PurchLine.CalcVATAmountLines(0, Rec, TempPurchLine, TempVATAmountLine);
            TempVATAmountLine.MODIFYALL(Modified, FALSE);
            SetVATSpecification;
        end;
        */

    trigger OnOpenPage()
    begin
        PurchSetup.GET;
        AllowInvDisc :=
          NOT (PurchSetup."Calc. Inv. Discount" AND VendInvDiscRecExists(Rec."Invoice Disc. Code"));
        AllowVATDifference :=
          PurchSetup."Allow VAT Difference" AND
          NOT (Rec."Document Type" IN [Rec."Document Type"::Quote, Rec."Document Type"::"Blanket Order"]);
        CurrPage.EDITABLE := AllowVATDifference OR AllowInvDisc;
        SetVATSpecification;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        GetVATSpecification;
        IF TempVATAmountLine.GetAnyLineModified THEN
            UpdateVATOnPurchLines;
        EXIT(TRUE);
    end;
    //kamles date 08-02-2023
    var
        Text000: Label 'Purchase %1 Statistics';
        Text001: Label 'Amount';
        Text002: Label 'Total';
        Text003: Label '%1 must not be 0.';
        Text004: Label '%1 must not be greater than %2.';
        Text005: Label 'You cannot change the invoice discount because a vendor invoice discount with the code %1 exists.';
        TotalPurchLine1, TotalPurchLineLCY : Record 39;
        Vend: Record 23;
        TempVATAmountLine: Record 290 temporary;
        PurchSetup: Record 312;
        PurchPost: Codeunit 90;
        TotalAmount1, TotalAmount2, VATAmount : Decimal;
        VATAmountText: Text[30];
        PrevNo: Code[20];
        AllowInvDisc, AllowVATDifference : Boolean;
        TotalGSTInvoiced, TotalAdvGSTInvoiced, TotalAmountApplied, ReverseChargeGST, ReverseChargeGSTAmount : Decimal;

    local procedure UpdateHeaderInfo()
    var
        CurrExchRate: Record 330;
        UseDate: Date;
    begin
        TotalPurchLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1 :=
          TotalPurchLine."Line Amount" - TotalPurchLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount;
        IF Rec."Prices Including VAT" THEN BEGIN
            TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT;
            TotalAmount2 := TotalAmount1 - VATAmount;
            TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE
            TotalAmount2 := TotalAmount1 + VATAmount;

        IF Rec."Prices Including VAT" THEN
            TotalPurchLineLCY.Amount := TotalAmount2
        ELSE
            TotalPurchLineLCY.Amount := TotalAmount1;
        IF Rec."Currency Code" <> '' THEN BEGIN
            IF (Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Quote]) AND
               (Rec."Posting Date" = 0D)
            THEN
                UseDate := WORKDATE
            ELSE
                UseDate := Rec."Posting Date";

            TotalPurchLineLCY.Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, Rec."Currency Code", TotalPurchLineLCY.Amount, Rec."Currency Factor");
        END;
    end;

    local procedure GetVATSpecification()
    begin
        // CurrForm.SubForm.PAGE.GetTempVATAmountLine(TempVATAmountLine);
        IF TempVATAmountLine.GetAnyLineModified THEN
            UpdateHeaderInfo;
    end;

    local procedure SetVATSpecification()
    begin
        // CurrForm.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        // CurrForm.SubForm.PAGE.InitGlobals(
        // "Currency Code",AllowVATDifference,AllowVATDifference,
        // "Prices Including VAT",AllowInvDisc,"VAT Base Discount %");
    end;

    local procedure UpdateTotalAmount()
    var
        SaveTotalAmount: Decimal;
    begin
        CheckAllowInvDisc;
        IF Rec."Prices Including VAT" THEN BEGIN
            SaveTotalAmount := TotalAmount1;
            UpdateInvDiscAmount;
            TotalAmount1 := SaveTotalAmount;
        END;

        WITH TotalPurchLine DO
            "Inv. Discount Amount" := "Line Amount" - TotalAmount1;
        UpdateInvDiscAmount;
    end;

    local procedure UpdateInvDiscAmount()
    var
        InvDiscBaseAmount: Decimal;
    begin
        CheckAllowInvDisc;
        InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(FALSE, Rec."Currency Code");
        IF InvDiscBaseAmount = 0 THEN
            ERROR(Text003, TempVATAmountLine.FIELDCAPTION("Inv. Disc. Base Amount"));

        IF TotalPurchLine."Inv. Discount Amount" / InvDiscBaseAmount > 1 THEN
            ERROR(
              Text004,
              TotalPurchLine.FIELDCAPTION("Inv. Discount Amount"),
              TempVATAmountLine.FIELDCAPTION("Inv. Disc. Base Amount"));

        TempVATAmountLine.SetInvoiceDiscountAmount(
          TotalPurchLine."Inv. Discount Amount", Rec."Currency Code", Rec."Prices Including VAT", Rec."VAT Base Discount %");
        // CurrForm.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
        UpdateHeaderInfo;

        Rec."Invoice Discount Calculation" := Rec."Invoice Discount Calculation"::Amount;
        Rec."Invoice Discount Value" := TotalPurchLine."Inv. Discount Amount";
        Rec.MODIFY;
        UpdateVATOnPurchLines;
    end;

    local procedure GetCaptionClass(FieldCaption: Text[100]; ReverseCaption: Boolean): Text[80]
    begin
        IF Rec."Prices Including VAT" XOR ReverseCaption THEN
            EXIT('2,1,' + FieldCaption);

        EXIT('2,0,' + FieldCaption);
    end;

    local procedure UpdateVATOnPurchLines()
    var
        PurchLine: Record 39;
    begin
        GetVATSpecification;
        IF TempVATAmountLine.GetAnyLineModified THEN BEGIN
            PurchLine.UpdateVATOnLines(0, Rec, PurchLine, TempVATAmountLine);
            PurchLine.UpdateVATOnLines(1, Rec, PurchLine, TempVATAmountLine);
        END;
        PrevNo := '';
    end;

    local procedure VendInvDiscRecExists(InvDiscCode: Code[20]): Boolean
    var
        VendInvDisc: Record 24;
    begin
        VendInvDisc.SETRANGE(Code, InvDiscCode);
        EXIT(VendInvDisc.FINDFIRST);
    end;

    local procedure CheckAllowInvDisc()
    begin
        IF NOT AllowInvDisc THEN
            ERROR(Text005, Rec."Invoice Disc. Code");
    end;

    procedure GSTApplicationAmount(): Decimal
    var
        VendorLedgerEntry: Record 25;
        // DetailedGSTLedgerEntry: Record 16419;
        // GSTApplicationBuffer: Record 16423;
        TotalAdvAmount: Decimal;
    begin
        VendorLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Buy-from Vendor No.");
        IF Rec."Applies-to Doc. No." <> '' THEN BEGIN
            VendorLedgerEntry.SETRANGE("Document Type", Rec."Applies-to Doc. Type");
            VendorLedgerEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
        END;
        IF Rec."Applies-to ID" <> '' THEN
            VendorLedgerEntry.SETRANGE("Applies-to ID", Rec."Applies-to ID");
        VendorLedgerEntry.SETRANGE("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
        // VendorLedgerEntry.SETRANGE("GST on Advance Payment", TRUE);
        VendorLedgerEntry.SETRANGE(Open, TRUE);
        VendorLedgerEntry.SETRANGE("On Hold", '');
        VendorLedgerEntry.SETFILTER("Amount to Apply", '<>%1', 0);
        IF VendorLedgerEntry.FINDSET THEN
            REPEAT
            //kamlesh date 08-02-2023
            // GSTApplicationBuffer.SETRANGE("Transaction Type", GSTApplicationBuffer."Transaction Type"::Purchase);
            // GSTApplicationBuffer.SETRANGE("Original Document Type", GSTApplicationBuffer."Original Document Type"::Payment);
            // GSTApplicationBuffer.SETRANGE("Original Document No.", VendorLedgerEntry."Document No.");
            // GSTApplicationBuffer.SETRANGE("GST Group Code", VendorLedgerEntry."GST Group Code");
            // GSTApplicationBuffer.SETRANGE("CLE/VLE Entry No.", VendorLedgerEntry."Entry No.");
            // IF GSTApplicationBuffer.FINDSET THEN
            //     REPEAT
            //         TotalAdvAmount += ABS(GSTApplicationBuffer."Applied Amount");//* QtyFactor;
            //     UNTIL GSTApplicationBuffer.NEXT = 0;
            UNTIL VendorLedgerEntry.NEXT = 0;
        EXIT(TotalAdvAmount);
    end;

    local procedure GetApplicableAmount(TotalAdvAmount: Decimal; TotalGSTAmountInvShip: Decimal): Decimal
    var
        TotalGSTAmountApplied: Decimal;
    begin
        IF ABS(TotalGSTAmountInvShip) > ABS(TotalAdvAmount) THEN
            TotalGSTAmountApplied := ABS(TotalAdvAmount)
        ELSE
            TotalGSTAmountApplied := ABS(TotalGSTAmountInvShip);
        EXIT(TotalGSTAmountApplied);
    end;

    local procedure ClearGSTStatisticsAmount()
    begin
        TotalGSTInvoiced := 0;
        TotalAmountApplied := 0;
        TotalAdvGSTInvoiced := 0;
        ReverseChargeGST := 0;
    end;

    var
        TotalPurchLine: Record 39;
}

