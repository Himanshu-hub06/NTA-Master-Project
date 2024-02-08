report 50015 "Posted Sale invoice "
{
    ApplicationArea = All;
    Caption = 'Posted Sale invoice ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Posted Sale invoice.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(CompName; CompInfo.Name)
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CompInfo; CompInfo.Address + CompInfo.city + CompInfo."Post Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(Package_Tracking_No_; "Package Tracking No.")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                RequestFilterFields = "Line No.";
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {

                }
                column(No2_; "No.")
                {

                }
                column(Shipment_Date; "Shipment Date")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(VAT__; "VAT %")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }

            }
            trigger OnPreDataItem()
            begin
                CompInfo.get()
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
        CompInfo: Record "Company Information";
}
