page 50809 "Notification Master "
{
    ApplicationArea = All;
    Caption = 'Notification Master ';
    PageType = Card;
    SourceTable = "Notification Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Notification No."; Rec."Notification No.")
                {
                    ToolTip = 'Specifies the value of the Notification No. field.';
                    trigger OnAssistEdit()

                    begin
                        If rec."Notification No." = '' THEN
                            IF rec.AssistEdit THEN
                                CurrPage.UPDATE;
                    end;

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
                field("Document Title"; Rec."Document Title")
                {
                    ToolTip = 'Specifies the value of the Document Title field.';
                }

            }
        }

    }
}
