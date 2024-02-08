report 50144 PostedPurchaseInvoice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/PostedPurchaseInvoice.rdl';


    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(compADD; Compinfo.Address) { }
            column(compADD2; Compinfo."Address 2") { }
            column(comCity; compinfo.City) { }
            column(compPost; Compinfo."Post Code") { }
            column(GSTIN; Compinfo."GST Registration No.") { }
            column(PAN; Compinfo."P.A.N. No.") { }
            column(Contact; compinfo."Contact Person") { }
            column(Email; compinfo."E-Mail") { }
            column(sNo_; "No.") { }
            column(Posting_Date; "Posting Date") { }

            column(compName; Compinfo.Name) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Location_State_Code; "Location State Code") { }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.") { }


            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }


            column(Order_Address_GST_Reg__No_; "Order Address GST Reg. No.") { }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Type::Item | Type::"G/L Account" | Type::Resource | Type::"Charge (Item)"));
                column(No_; "No.") { }

                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Description; Description) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Quantity; Quantity) { }
                column(MRP_Per_pair; "Direct Unit Cost") { }

                column(Line_Amount; "Line Amount") { }
                column(TotalAmt; TotalAmt)
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
                    DtlGstLdgEntry.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                    DtlGstLdgEntry.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
                    If DtlGstLdgEntry.FindFirst() then
                        repeat

                            if (DtlGstLdgEntry."GST Component Code" = 'IGST') then begin
                                "IGST%" := DtlGstLdgEntry."GST %";
                                IGSTAmt := DtlGstLdgEntry."GST Amount";
                            end;
                            if (DtlGstLdgEntry."GST Component Code" = 'CGST') then begin
                                "CGST%" := DtlGstLdgEntry."GST %";
                                CGSTAmt := DtlGstLdgEntry."GST Amount";
                            end;
                            if (DtlGstLdgEntry."GST Component Code" = 'SGST') then begin
                                "SGST%" := DtlGstLdgEntry."GST %";
                                SGSTAmt := DtlGstLdgEntry."GST Amount";
                            end;
                        Until DtlGstLdgEntry.Next() = 0;
                    TotalAmt := "Line Amount" + IGSTAmt + SGSTAmt + CGSTAmt;

                end;



            }
            trigger OnPreDataItem()
            begin
                CompInfo.get()
            end;


        }
    }
    var
        TotalAmt: Decimal;
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
}














