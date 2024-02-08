page 50808 "CheckList Master Card"
{
    ApplicationArea = All;
    Caption = 'CheckList Master Card';
    PageType = Card;
    SourceTable = "CheckList Master ";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Display Order"; Rec."Display Order")
                {
                    ToolTip = 'Specifies the value of the Display Order field.';
                }
                field(Session; Rec.Session)
                {
                    ToolTip = 'Specifies the value of the Session field.';
                }
            }
        }
    }
}
