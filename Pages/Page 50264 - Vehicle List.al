page 50264 "Vehicle List"
{
    CardPageID = "Vehicle Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 50106;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vehicle Code"; Rec."Vehicle Code")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

