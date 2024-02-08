report 50010 "Indent Slip"
{
    ApplicationArea = All;
    // Caption = 'Indent Slip';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Indent Slip.rdl';
    dataset

    {
        dataitem(IndentHeader; "Indent Header")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(Priority; Priority)
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Indent_Date; "Indent Date")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Location_Name; "Location Name")
            {
            }
            dataitem("Indent Line"; "Indent line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(No_; "No.")
                {

                }
                column(Item_Category; "Item Category")
                {

                }
                column(Approved_Quantity; "Approved Quantity")
                {

                }
                column(Remarks; Remarks)
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }


            }
        }
    }
}