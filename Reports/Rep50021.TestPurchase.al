report 50021 TestPurchase
{
    ApplicationArea = All;
    Caption = 'TestPurchase';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/TestPurchase.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(Document_Date; "Document Date")
            {

            }
            column(Payment_Date; "Payment Date")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(No_; "No.")
                {

                }

                column(Line_Amount; "Line Amount")
                {

                }
                column(lineAmountTotal; lineAmountTotal)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(GST_Group_Code; "GST Group Code")
                {

                }


                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(Allow_Invoice_Disc_; "Allow Invoice Disc.")
                {

                }
                column(VAT_Identifier; "VAT Identifier")
                {

                }
                column(Amount; Amount)
                {

                }

                column(TaxamtCGST; TaxamtCGST)
                {
                }
                column(CGST_; "CGST%")
                {
                }

                column(TaxamtSGST; TaxamtSGST)
                {
                }
                column(SGST_; "SGST%")
                {
                }
                column(TaxamtIGST; TaxamtIGST)
                {
                }
                column(IGST_; "IGST%")
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                trigger OnAfterGetRecord()
                var
                    TransSpeciF: Record 285;

                begin

                    TaxamtCGST := 0;
                    TaxamtSGST := 0;
                    TaxamtIGST := 0;
                    "SGST%" := 0;
                    "CGST%" := 0;
                    "IGST%" := 0;

                    GSTSetup.Get();
                    GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                    lineAmountTotal := "Purchase Line"."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;


                end;


            }
        }
    }

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";



      PurchLine1: Record "Purchase Line";
      GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName(PurchLine1, GSTSetup);

        if (PurchLine1.Type <> PurchLine1.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchLine1.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                TaxamtSGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                "SGST%" := TaxTransactionValue.Percent;
                                SGSTAmt += taxamtSGST;
                            end;
                        2:
                            begin
                                TaxAmtCGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                "CGST%" := TaxTransactionValue.Percent;
                                CGSTAmt += TaxAmtCGST;
                            end;
                        3:
                            begin
                                TaxamtIGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                "IGST%" := TaxTransactionValue.Percent;
                                IGSTAmt += taxamtIGST;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;


    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    local procedure GetComponentName(PurchLine1: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin


        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchLine1."GST Jurisdiction Type" = PurchLine1."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;




    var
        lineAmountTotal: Decimal;
        GSTAmt: Decimal;
        TaxamtSGST: Decimal;
        TaxamtCGST: Decimal;
        TaxamtIGST: Decimal;
        "SGST%"
        : Decimal;
        "IGST%": Decimal;
        "CGST%": Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        GSTSetup: Record "GST Setup";
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchLine1: record "Purchase Line";
}
