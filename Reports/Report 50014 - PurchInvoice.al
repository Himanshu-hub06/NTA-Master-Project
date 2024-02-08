report 50014 PurchInvoice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/PurchInvoice.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddress; CompInfo.Address + CompInfo.City + CompInfo."Post Code")
            {

            }

            column(CompCountry; CompInfo."Country/Region Code")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(No1_; "No.")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_County; "Buy-from County")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Pay_to_Contact_No_; "Pay-to Contact No.")
            {

            }
            column(Pay_to_Address; "Pay-to Address")
            {

            }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            column(Bal__Account_No_; "Bal. Account No.")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            column(Prices_Including_VAT; "Prices Including VAT")
            {

            }
            column(Purchaser_Code; "Purchaser Code")
            {

            }




            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {

                DataItemLink = "Document No." = field("No.");
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
                column(No_; "No.")
                {

                }





            }
            trigger OnPreDataItem()
            begin
                CompInfo.get
            end;



        }



    }

    requestpage
    {
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {
            //             ApplicationArea = All;

            //         }
            //     }
            // }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        CompInfo: Record "Company Information";
}