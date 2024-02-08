page 50811 "Notification Master List Page "
{
    ApplicationArea = All;
    Caption = 'Notification Master List Page ';
    PageType = List;
    SourceTable = "Notification Master";
    UsageCategory = Lists;
    CardPageId = 50809;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Title"; Rec."Document Title")
                {
                    ToolTip = 'Specifies the value of the Document Title field.';
                }
                field("Notification No."; Rec."Notification No.")
                {
                    ToolTip = 'Specifies the value of the Notification No. field.';
                }
                field("Notification"; Rec."Notification")
                {
                    ToolTip = 'Specifies the value of the Notification field.';
                }
                field("Active From"; Rec."Active From")
                {
                    ToolTip = 'Specifies the value of the Active From field.';
                }
                field("Active to"; Rec."Active to")
                {
                    ToolTip = 'Specifies the value of the Active to field.';
                }
            }
        }
    }
}
