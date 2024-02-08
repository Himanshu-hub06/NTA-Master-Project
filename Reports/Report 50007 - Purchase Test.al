report 50007 "Report 50007 - Purchase Test"
{
    ApplicationArea = All;
    Caption = 'Purchase Test';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Purchase Test.rdl';
    dataset
    {

        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddress; CompInfo.Address)
            { }
            column(CompCity; CompInfo.City)
            { }
            column(CompState; CompInfo."State Code")
            { }
            column(CompCountry; CompInfo."Country/Region Code")
            { }
            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(ReceiptNo; "Receiving No.")
            {

            }
            column(RcptNo; RcptNo)
            {

            }
            column(Invoiceno; Invoiceno)
            {

            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                { }
                column(Quantity; Quantity)
                { }

                column(Quantity_Received; "Quantity Received")
                { }
                column(Qty__to_Receive; "Qty. to Receive")
                { }
                column(Quantity_Invoiced; "Quantity Invoiced")
                { }


            }

            trigger OnPreDataItem()
            begin
                CompInfo.get();
            end;

            trigger OnAfterGetRecord()
            var
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PostedPurchLine: Record "Purch. Inv. Line";
            begin
                PurchRcptHeader.SetRange("Order No.", PurchaseHeader."No.");
                if PurchRcptHeader.FindFirst() then begin
                    ReceiptNo := PurchRcptHeader."No.";
                end;
                PostedPurchLine.SetRange("Order No.", "No.");
                if PostedPurchLine.FindFirst() then begin
                    Invoiceno := PostedPurchLine."Document No.";

                end;
                RecPostHeader.Reset();
                RecPostHeader.SetRange("Order No.", "No.");
                if RecPostHeader.FindFirst() then
                    RcptNo := RecPostHeader."No."
            end;

        }


    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        ReceiptNo: Code[20];
        Invoiceno: Code[20];
        CompInfo: Record "Company Information";
        RecPostHeader: Record "Purch. Rcpt. Header";
        RcptNo: code[20];

}
