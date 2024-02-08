page 50016 "Posted TA Bill Hotel Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;

    SourceTable = "Posted TA Bill Hotel";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill ID"; rec."Bill ID")
                {
                }
                field("Hotel Name & Address"; rec."Hotel Name & Address")
                {
                }
                field("Room Rent"; rec."Room Rent")
                {
                }
                field("Food Charges"; rec."Food Charges")
                {
                }
                field("Total Amount"; rec."Total Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

