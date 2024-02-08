report 50185 "Tem Vendor  Ledger Entry"
{
    ApplicationArea = All;
    Caption = 'Tem Vendor  Ledger Entry';
    UsageCategory = ReportsAndAnalysis;



    RDLCLayout = './Layouts/VendorLedgerReport.rdl';
    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {

            RequestFilterFields = "Vendor No.";

            column(DocumentType; "Document Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
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
}
