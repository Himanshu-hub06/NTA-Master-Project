report 50024 "Posted Sales Credit"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/PostedSalescr.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {

            column(Comp_Name; CompInfo.Name)
            { }
            column(Comp_Address; CompInfo.Address)
            { }
            column(Comp_Address2; CompInfo."Address 2")
            { }
            column(Comp_City; CompInfo.City)
            { }
            column(Comp_Code; CompInfo."Post Code")
            { }
            column(No_; "No.")
            { }
            column(Due_Date; "Due Date")
            { }
            column(Your_Reference; "Your Reference")
            { }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_City; "Sell-to City")
            { }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            { }
            column(Sell_to_County; "Sell-to County")
            { }
            column(Location_Code; "Location Code")
            { }
            column(Posting_Date; "Posting Date")
            { }


            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");


                column(Description; Description)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Shipment_Date; "Shipment Date")
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(VAT__; "VAT %")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(No_I; "No.")
                { }
                column(IncVat; IncVat)
                { }
                column(Amount; Amount)
                { }


            }
            trigger OnPreDataItem()
            begin
                CompInfo.get()
            end;

            trigger OnAfterGetRecord()
            var
                VatTbl: Record "VAT Entry";
            begin
                //  VatTbl.SetRange("Document Line No.","Sales Cr.Memo Header"."Line No.");

            end;




        }
    }








    var
        CompInfo: Record "Company Information";
        IncVat: Decimal;
        Amount: Decimal;

}