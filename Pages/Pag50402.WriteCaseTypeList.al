page 50402 "Write Case Type List"
{
    ApplicationArea = All;
    Caption = 'Write Case Type List';
    PageType = List;
    SourceTable = "Writ/Case Type";
    UsageCategory = Lists;

    layout

    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Court; Rec.Court)
                {
                    ToolTip = 'Specifies the value of the Court field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}
