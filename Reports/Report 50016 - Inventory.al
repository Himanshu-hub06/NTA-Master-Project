report 50016 Inventory
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Inventory.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            column(ItemCategoryName; ItemCategoryName)
            { }
            column(Item_Category_Code; "Item Category Code")
            {

            }
            column(Date___Time; "Date & Time")
            {

            }
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {

            }
            column(Inventory; Inventory)
            {

            }
            column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group")
            {

            }
            column(Inventory_Posting_Group; "Inventory Posting Group")
            {

            }
            column(GST_Group_Code; "GST Group Code")
            {

            }
            column(HSN_SAC_Code; "HSN/SAC Code")
            {

            }
            column(Unit_Price; "Unit Price")
            {

            }
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
        myInt: Integer;

        ItemCategoryName: Text[30];

}