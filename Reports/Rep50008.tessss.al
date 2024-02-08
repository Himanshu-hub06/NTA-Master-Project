report 50008 tessss
{
    ApplicationArea = All;
    Caption = 'tessss';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(Document_Type; "Document Type")
            {
            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(order_No; "No.")
            {

            }



            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type");
                // RequestFilterFields = "Outstation ID";
                column(No_; "No.")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Quantity_Shipped; "Quantity Shipped")
                {

                }
                column(Quantity_Invoiced; "Quantity Invoiced")
                {

                }

                trigger OnAfterGetRecord()
                var
                    SalesShipHeader: Record "Sales Shipment Header";
                    PostedSalesLine: Record "Sales Invoice Line";
                begin
                    SalesShipHeader.SetRange("Order No.", SalesHeader."No.");
                    if SalesShipHeader.FindFirst() then begin
                        "Shipment No." := SalesShipHeader."No.";
                    end;
                    PostedSalesLine.SetRange("Shipment No.", "Shipment No.");
                    if PostedSalesLine.FindFirst() then begin
                        Invoiceno := PostedSalesLine."Document No."
                    end;
                end;



            }
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
        InvoiceNo: Code[20];
}
