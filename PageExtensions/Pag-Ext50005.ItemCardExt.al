pageextension 50005 "Item Card_Ext" extends "Item Card"

{
    layout
    {
        addafter("Item Category Code")
        {
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
        }
    }
}
