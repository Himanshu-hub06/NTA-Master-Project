report 50029 "Posted Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // AccessByPermission = Report ;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/PostedInvoice.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
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
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
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
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.")
            { }
            column(Sell_to_E_Mail; "Sell-to E-Mail")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(iNVONo_; "No.")
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

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document NO." = field("No.");
                DataItemTableView = where(Type = filter(<> " "));//Type::Item | Type::"G/L Account" | Type::Resource | Type::"Charge (Item)"));
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
                column(Unit_Cost; "Unit Cost")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(IGSTAmt; IGSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(IGST_; "IGST%")
                { }
                column(SGST_; "SGST%")
                { }
                column(CGST_; "CGST%")
                { }
                column(TotalAmt; TotalAmt)
                { }

                trigger OnAfterGetRecord()
                Var
                    DtlGstLdgEntry: Record "Detailed GST Ledger Entry";
                begin
                    GSTAmt := 0;
                    IGSTAmt := 0;
                    CGSTAmt := 0;
                    SGSTAmt := 0;
                    "IGST%" := 0;
                    "SGST%" := 0;
                    "CGST%" := 0;

                    DtlGstLdgEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    DtlGstLdgEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                    If DtlGstLdgEntry.FindFirst() then
                        repeat

                            if (DtlGstLdgEntry."GST Component Code" = 'IGST') then begin
                                "IGST%" := DtlGstLdgEntry."GST %";
                                IGSTAmt := DtlGstLdgEntry."GST Amount" * (-1);
                            end;
                            if (DtlGstLdgEntry."GST Component Code" = 'CGST') then begin
                                "CGST%" := DtlGstLdgEntry."GST %";
                                CGSTAmt := DtlGstLdgEntry."GST Amount" * (-1);
                            end;
                            if (DtlGstLdgEntry."GST Component Code" = 'SGST') then begin
                                "SGST%" := DtlGstLdgEntry."GST %";
                                SGSTAmt := DtlGstLdgEntry."GST Amount" * (-1);
                            end;
                        Until DtlGstLdgEntry.Next() = 0;

                    TotalAmt := "Line Amount" + SGSTAmt + IGSTAmt + CGSTAmt;

                end;



            }
            trigger OnPreDataItem()
            begin
                CompInfo.get()
            end;


        }
    }








    var
        CompInfo: Record "Company Information";
        // DtlGstLdgEntry: Record "Detailed GST Ledger Entry";
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
        GSTSetup: Record "GST Setup";
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        TotalAmt: Decimal;
}