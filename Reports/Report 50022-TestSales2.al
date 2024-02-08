report 50022 "Test SalesOrder2"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/TestSales2.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(CompName; CompInfo.Name)
            { }
            column(CompAdd; CompInfo.Address)
            { }
            column(CompAddress; CompInfo."Address 2")
            { }
            column(CompCity; CompInfo.City)
            { }
            column(CompContactNo; CompInfo."Phone No.")
            { }
            column(CompEmail; CompInfo."E-Mail")
            { }
            column(CompGSTIN; CompInfo."GST Registration No.")
            { }
            column(ComPanNo; CompInfo."P.A.N. No.")
            { }
            column(CompState; CompInfo."State Code")
            { }
            column(CompPostCode; CompInfo."Post Code")
            { }
            Column(Assigned_User_ID; "Assigned User ID")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Ship_to_Address; "Ship-to Address")
            { }
            column(Ship_to_Address_2; "Ship-to Address 2")
            { }
            column(Ship_to_City; "Ship-to City")
            { }
            column(State; State)
            { }
            column(Ship_to_Code; "Ship-to Code")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_Address_2; "Sell-to Address 2")
            { }
            column(Sell_to_City; "Sell-to City")
            { }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            { }
            column(Sell_to_County; "Sell-to County")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(InvoiceNo_; "No.")
            { }
            column(AmountInwords; AmountInwords)
            { }


            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = Field("No.");

                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(HSN_SAC_Code; "HSN/SAC Code")
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Document_No_; "Document No.")
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(IGSTAmt; IGSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(CGST_; "CGST%")
                { }
                column(SGST_; "SGST%")
                { }
                column(IGST_; "IGST%")
                { }
                column(LineAmountTotal; LineAmountTotal)
                { }

                trigger OnAfterGetRecord()
                var
                    TransSpeciF: Record 285;

                begin
                    LineAmountTotal := 0;
                    TaxamtCGST := 0;
                    TaxamtSGST := 0;
                    TaxamtIGST := 0;
                    "SGST%" := 0;
                    "CGST%" := 0;
                    "IGST%" := 0;

                    GSTSetup.Get();
                    GetGSTAmounts(TaxTransactionValue, "Sales Line", GSTSetup);
                    LineAmountTotal := "Sales Line"."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
                    LineAmntFinal += LineAmountTotal;


                end;

                trigger OnPreDataItem()
                begin
                    CompInfo.Get()
                end;


            }
            trigger OnPreDataItem()
            begin
                LineAmntFinal := 0;
            end;

            trigger OnPostDataItem()
            begin
                AmountInwords := '';
                RepCheck.InitTextVariable();
                RepCheck.FormatNoText(NoText, LineAmntFinal, '');
                AmountInwords := NoText[1];
            end;
        }
    }

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
       SalesLine1: Record "Sales Line";
       GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName(SalesLine1, GSTSetup);

        if (SalesLine1.Type <> SalesLine1.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine1.RecordId);
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

    local procedure GetComponentName(SalesLine1: Record "Sales Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if SalesLine1."GST Jurisdiction Type" = SalesLine1."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;



    var
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        CompInfo: Record "Company Information";
        GSTAmt: Decimal;
        TaxamtSGST: Decimal;
        TaxamtCGST: Decimal;
        TaxamtIGST: Decimal;
        "SGST%": Decimal;
        "IGST%": Decimal;
        "CGST%": Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SalesLine1: record "Sales Line";
        GSTAmount: Decimal;
        LineAmountTotal: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        RepCheck: Report Check;
        NoText: array[2] of Text[100];
        AmountInwords: Text[100];
        LineAmntFinal: Decimal;

}