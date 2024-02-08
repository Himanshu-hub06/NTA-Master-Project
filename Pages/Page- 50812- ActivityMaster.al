page 50812 "Activity Master"
{
    ApplicationArea = All;
    Caption = 'Activity Master';
    PageType = Card;
    SourceTable = "Activity Master";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("S.No."; Rec."S.No.")
                {
                    ToolTip = 'Specifies the value of the S.No. field.';
                }
                field("Activity Name"; Rec."Activity Name")
                {
                    ToolTip = 'Specifies the value of the Activity Name field.';
                }
                field("Display Order: "; Rec."Display Order: ")
                {
                    ToolTip = 'Specifies the value of the Display Order:  field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Name Of Activity: "; Rec."Name Of Activity: ")
                {
                    ToolTip = 'Specifies the value of the Name Of Activity:  field.';
                }
            }
        }
    }
}
