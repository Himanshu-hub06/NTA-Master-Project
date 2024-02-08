report 50019 "PostedPurchaseCreditMemo "
{
    ApplicationArea = All;
    Caption = 'PostedPurchaseCreditMemo ';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './reports/PostedPurchaseCreditMemo.rdl';
    dataset
    {
        dataitem(PurchCrMemoHdr; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Prices_Including_VAT; "Prices Including VAT")
            {

            }
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(Pay_to_Address; "Pay-to Address")
            {

            }
            column(Pay_to_City; "Pay-to City")
            {

            }
            column(Comp_Name; compinfo."Name")
            {

            }
            column(com_Phone; Compinfo."Phone No.")
            {

            }
            column(comp_Email; compinfo."E-Mail")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            column(comp_Bank; compinfo."Bank Name")
            {

            }
            column(Comp_Account_No; compinfo."Bank Account No.")
            {

            }
            column(Comp_Address; compinfo.Address)
            {

            }
            column(comp_City; compinfo.City)
            {

            }
            column(Purchaser_Code; "Purchaser Code")
            {

            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = filter(<> " "));

                column(No_1; "No.")
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
                column(VAT__; "VAT %")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                {

                }
                column(VAT_Base_Amount; "VAT Base Amount")
                {

                }
                column(compName; Compinfo.Name)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(CGSTAmt; CGSTAmt)
                {

                }
                column(SGST_; "SGST%")
                {

                }
                column(CGST_; "CGST%")
                {

                }
                column(IGST_; "IGST%")
                {

                }
                column(GST_Group_Code; "GST Group Code")
                {

                }
                column(GST_Group_Type; "GST Group Type")
                {

                }
                column(TotalAmt; TotalAmt)
                {

                }
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

                    DtlGstLdgEntry.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                    DtlGstLdgEntry.SetRange("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
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
        lineAmountTotal: Decimal;
        GSTAmt: Decimal;
        TaxamtSGST: Decimal;
        TaxamtCGST: Decimal;
        TaxamtIGST: Decimal;
        "SGST%": Decimal;
        "IGST%": Decimal;
        "CGST%": Decimal;
        TotalAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        GSTSetup: Record "GST Setup";



        TaxTransactionValue: Record "Tax Transaction Value";

}


