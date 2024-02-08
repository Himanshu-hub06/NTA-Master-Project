page 50813 "AIC Committee Master list.al"
{
    ApplicationArea = All;
    Caption = 'AIC Committee Master list.al';
    PageType = List;
    SourceTable = "Notification Master";
    UsageCategory = Lists;
    CardPageId = 50806;

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
                field("Notification"; Rec."Notification")
                {
                    ToolTip = 'Specifies the value of the Notification field.';
                }
                field("Notification No."; Rec."Notification No.")
                {
                    ToolTip = 'Specifies the value of the Notification No. field.';
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
