page 50266 "Driver List"
{
    CardPageID = "Driver Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 50107;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = all;
                }
                field("Aadhar No."; Rec."Aadhar No.")
                {
                    ApplicationArea = all;
                }
                field("Contact No."; Rec."Contact No.")
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

