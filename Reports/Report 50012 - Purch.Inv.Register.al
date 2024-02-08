report 50012 "Purch.Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Purch.Register.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddress; CompInfo.Address + CompInfo.City + CompInfo."Post Code")
            {

            }
            column(VenGSTNo; VenGSTNo)
            {

            }
            column(CompCountry; CompInfo."Country/Region Code")
            {

            }
            column(No_; "No.")
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            {

            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Location_Code; "Location Code")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Description; Description)
                {

                }
                column(Type; Type)
                {

                }

            }
            trigger OnPreDataItem()
            begin
                CompInfo.get()
            end;

            trigger OnAfterGetRecord()
            var
                vend: Record Vendor;
            // begin
            //     Vend.Reset();
            //     Vend.SetRange("No.", "Buy-from Vendor No.");
            //     if vend.FindFirst() then
            //         VenGSTNo := vend."GST Registration No.";
            // end;
            begin
                If Vend.Get("Buy-from Vendor No.") then
                    VenGSTNo := Vend."GST Registration No."
                else
                    VenGSTNo := '';

            end;
        }


    }
    requestpage
    {
        layout
        {

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
        VenGSTNo: Code[20];

}