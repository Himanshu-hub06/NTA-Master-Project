pageextension 50012 VendorList extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}