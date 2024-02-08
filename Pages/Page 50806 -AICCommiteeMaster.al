page 50806 "AIC Commitee Master"
{
    ApplicationArea = All;
    Caption = 'AIC Commitee Master';
    PageType = Card;
    SourceTable = "AIC Commitee Master";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Committee Code"; Rec."Committee Code")
                {
                    ToolTip = 'Specifies the value of the Committee Code field.';
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ToolTip = 'Specifies the value of the Committee Name field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("Posting City"; Rec."Posting City")
                {
                    ToolTip = 'Specifies the value of the Posting City field.';
                }
                field(Session; Rec.Session)
                {
                    ToolTip = 'Specifies the value of the Session field.';
                }
            }
        }
    }
}
