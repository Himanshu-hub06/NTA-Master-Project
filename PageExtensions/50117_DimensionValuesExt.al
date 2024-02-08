/// <summary>
/// PageExtension Dimension Values Ext. (ID 50003) extends Record Dimension Values.
/// </summary>
pageextension 50117 "Dimension Values Ext." extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field("Issue Depatment"; Rec."Issue Depatment")
            {
                ApplicationArea = All;
            }
            field("Section Name"; Rec."Section Name")
            {
                ApplicationArea = All;
            }
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;

            }
        }
    }
}
