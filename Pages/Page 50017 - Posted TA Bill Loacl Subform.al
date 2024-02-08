page 50017 "Posted TA Bill Loacl Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "Posted TA Bill Local";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill ID"; rec."Bill ID")
                {
                }
                field("Journey Date"; rec."Journey Date")
                {
                }
                field("Journey Remarks"; rec."Journey Remarks")
                {
                }
                field("Departure From"; rec."Departure From")
                {
                }
                field("Arrival To"; rec."Arrival To")
                {
                }
                field("Mode Of Journey"; rec."Mode Of Journey")
                {
                }
                field("Distance Of Journey"; rec."Distance Of Journey")
                {
                }
                field("Receipt No."; rec."Receipt No.")
                {
                }
                field(Amount; rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

