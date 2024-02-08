report 50018 damm
{
    ApplicationArea = All;
    Caption = 'damm';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/damm.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group")
            {

            }
            column(Inventory_Posting_Group; "Inventory Posting Group")
            {

            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(StandardCost; "Standard Cost")
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

