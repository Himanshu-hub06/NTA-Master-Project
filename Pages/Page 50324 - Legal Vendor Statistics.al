page 50324 "Legal Vendor Statistics"
{
    Caption = 'Vendor Statistics';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Balance (LCY)"; rec."Balance (LCY)")
                {

                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", rec."No.");
                        rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field("Outstanding Orders (LCY)"; rec."Outstanding Orders (LCY)")
                {
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    Caption = 'Amt. Rcd. Not Invd. (LCY)';
                }
                field("Outstanding Invoices (LCY)"; rec."Outstanding Invoices (LCY)")
                {
                }
                field(GetTotalAmountLCY; rec.GetTotalAmountLCY)
                {
                    AutoFormatType = 1;
                    Caption = 'Total (LCY)';
                }
                field("Balance Due (LCY)"; rec.CalcOverDueBalance)
                {
                    CaptionClass = FORMAT(STRSUBSTNO(Text000, FORMAT(CurrentDate)));

                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETFILTER("Vendor No.", rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
                        rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnOverdueEntries(DtldVendLedgEntry);
                    end;
                }
                field(GetInvoicedPrepmtAmountLCY; rec.GetInvoicedPrepmtAmountLCY)
                {
                    Caption = 'Invoiced Prepayment Amount (LCY)';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        IF CurrentDate <> WORKDATE THEN BEGIN
            CurrentDate := WORKDATE;
            DateFilterCalc.CreateAccountingPeriodFilter(VendDateFilter[1], VendDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[2], VendDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(VendDateFilter[3], VendDateName[3], CurrentDate, -1);
        END;

        rec.SETRANGE("Date Filter", 0D, CurrentDate);

        FOR i := 1 TO 4 DO BEGIN
            rec.SETFILTER("Date Filter", VendDateFilter[i]);
            rec.CALCFIELDS(
              "Purchases (LCY)", "Inv. Discounts (LCY)", "Inv. Amounts (LCY)", "Pmt. Discounts (LCY)",
              "Pmt. Disc. Tolerance (LCY)", "Pmt. Tolerance (LCY)",
              "Fin. Charge Memo Amounts (LCY)", "Cr. Memo Amounts (LCY)", "Payments (LCY)",
              "Reminder Amounts (LCY)", "Refunds (LCY)", "Other Amounts (LCY)");
            VendPurchLCY[i] := rec."Purchases (LCY)";
            VendInvDiscAmountLCY[i] := rec."Inv. Discounts (LCY)";
            InvAmountsLCY[i] := rec."Inv. Amounts (LCY)";
            VendPaymentDiscLCY[i] := rec."Pmt. Discounts (LCY)";
            VendPaymentDiscTolLCY[i] := rec."Pmt. Disc. Tolerance (LCY)";
            VendPaymentTolLCY[i] := rec."Pmt. Tolerance (LCY)";
            VendReminderChargeAmtLCY[i] := rec."Reminder Amounts (LCY)";
            VendFinChargeAmtLCY[i] := rec."Fin. Charge Memo Amounts (LCY)";
            VendCrMemoAmountsLCY[i] := rec."Cr. Memo Amounts (LCY)";
            VendPaymentsLCY[i] := rec."Payments (LCY)";
            VendRefundsLCY[i] := rec."Refunds (LCY)";
            VendOtherAmountsLCY[i] := rec."Other Amounts (LCY)";
        END;
        rec.SETRANGE("Date Filter", 0D, CurrentDate);
    end;

    var
        Text000: Label 'Overdue Amounts (LCY) as of %1';
        DateFilterCalc: Codeunit "DateFilter-Calc";
        VendDateFilter: array[4] of Text[30];
        VendDateName: array[4] of Text[30];
        CurrentDate: Date;
        VendPurchLCY: array[4] of Decimal;
        VendInvDiscAmountLCY: array[4] of Decimal;
        VendPaymentDiscLCY: array[4] of Decimal;
        VendPaymentDiscTolLCY: array[4] of Decimal;
        VendPaymentTolLCY: array[4] of Decimal;
        VendReminderChargeAmtLCY: array[4] of Decimal;
        VendFinChargeAmtLCY: array[4] of Decimal;
        VendCrMemoAmountsLCY: array[4] of Decimal;
        VendPaymentsLCY: array[4] of Decimal;
        VendRefundsLCY: array[4] of Decimal;
        VendOtherAmountsLCY: array[4] of Decimal;
        i: Integer;
        InvAmountsLCY: array[4] of Decimal;
        Text001: Label 'Placeholder';
        UserSetup: Record "User Setup";
}

