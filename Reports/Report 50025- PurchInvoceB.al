report 50025 "Purch.IvoiceB"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Purch.InvoiceB.rdl';
    //DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(ComName; CompInfo.Name)
            { }
            column(CompAddress; CompInfo.Address)
            { }
            column(CompCity; CompInfo.City)
            { }
            column(CompMail; CompInfo."E-Mail")
            { }
            column(CompCountry; CompInfo.County)
            { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            { }
            column(Pay_to_Name; "Pay-to Name")
            { }
            column(InvoiceNo; "No.")
            { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Due_Date; "Due Date")
            { }
            column(Payment_Method_Code; "Payment Method Code")
            { }
            column(Shipment_Method_Code; "Shipment Method Code")
            { }
            column(Pay_to_Contact_No_; "Pay-to Contact No.")
            { }
            column(VAT_Registration_No_; "VAT Registration No.")
            { }
            column(Bal__Account_No_; "Bal. Account No.")
            { }
            column(Purchaser_Code; "Purchaser Code")
            { }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                { }
                column(Line_Discount_Amount; "Line Discount Amount")
                { }
                column(Allow_Invoice_Disc_; "Allow Invoice Disc.")
                { }
                column(VAT_Identifier; "VAT Identifier")
                { }
                column(Amount; Amount)
                { }
                column(VAT_Base_Amount; "VAT Base Amount")
                { }
                column(VAT__; "VAT %")
                { }

            }
            trigger OnPreDataItem()
            begin
                CompInfo.Get
            end;
        }
    }
    var
        CompInfo: Record "Company Information";





}