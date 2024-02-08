report 50017 ItemTest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports./ItemTest.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(CompName; CompInfo.Name)
            { }
            column(CompAddress; CompInfo.Address)
            { }
            column(CompCity; CompInfo.City)
            { }
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Item_Category_Code; "Item Category Code")
            { }
            column(ItemCategoryName; ItemCategoryName)
            { }
            column(Unit_Cost; "Unit Cost")
            { }
            column(Unit_Price; "Unit Price")
            { }


            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");

                column(Entry_Type; "Entry Type")
                { }
                column(Document_Type; "Document Type")
                { }
                column(Document_No_; "Document No.")
                { }
                column(Posting_Date; "Posting Date")
                { }
                column(Quantity; Quantity)
                { }
                column(Remaining_Quantity; "Remaining Quantity")
                { }
                column(Location_Code; "Location Code")
                { }


            }

            trigger OnPreDataItem()
            begin
                CompInfo.get()
            end;


            trigger OnAfterGetRecord()
            Var
                Itemcategory: Record "Item Category";
            begin
                ItemCategoryName := '';
                Itemcategory.SetRange(Code, Item."Item Category Code");
                if Itemcategory.FindFirst() then
                    ItemCategoryName := Itemcategory.Description;
            end;





        }
    }








    var
        ItemCategoryName: Text[30];
        CompInfo: Record "Company Information";
}