page 50814 "CheckList Master.al"
{
    ApplicationArea = All;
    Caption = 'CheckList Master.al';
    PageType = List;
    SourceTable = "CheckList Master ";
    UsageCategory = Lists;
    CardPageId = 50808;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Session; Rec.Session)
                {
                    ToolTip = 'Specifies the value of the Session field.';
                }
                field("Display Order"; Rec."Display Order")
                {
                    ToolTip = 'Specifies the value of the Display Order field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
            }
        }
    }
}
