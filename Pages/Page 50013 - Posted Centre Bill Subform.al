page 50013 "Posted Centre Bill Subform"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Posted Centre Bill Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Partuculars; Rec.Partuculars)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field(Rate; Rec.Rate)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

