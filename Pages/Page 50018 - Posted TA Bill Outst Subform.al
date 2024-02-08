page 50018 "Posted TA Bill Outst Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "Posted TA Bill Outstation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill ID"; rec."Bill ID")
                {
                }
                field("Departure Date"; rec."Departure Date")
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

