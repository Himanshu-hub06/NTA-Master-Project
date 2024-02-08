report 50013 Itemrr
{
    ApplicationArea = All;
    Caption = 'Itemrr';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/Itemrr.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(BaseUnitofMeasure; "Base Unit of Measure")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(GenProdPostingGroup; "Gen. Prod. Posting Group")
            {
            }
            column(InventoryPostingGroup; "Inventory Posting Group")
            {
            }
            column(GSTGroupCode; "GST Group Code")
            {
            }
            column(HSNSACCode; "HSN/SAC Code")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {

            }
            column(ItmCatName; ItmCatName)
            {

            }
            trigger OnAfterGetRecord()

            begin
                ItmCatName := '';
                ItemCat.SetRange(Code, Item."Item Category Code");
                if ItemCat.FindFirst() then
                    ItmCatName := ItemCat.Description;
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
        ItmCatName: Text[20];
        ItemCat: Record "Item Category";
}
