page 50764 "ADD TO 50057"
{
    ApplicationArea = All;
    Caption = 'ADD TO 50057';
    PageType = List;
    SourceTable = "Setup & History";
    UsageCategory = Lists;
    Permissions = TableData 50057 = rimd;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("P Code"; Rec."P Code")
                {
                    ToolTip = 'Specifies the value of the P Code field.';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ToolTip = 'Specifies the value of the Page ID field.';
                }
                field("Page Type"; Rec."Page Type")
                {
                    ToolTip = 'Specifies the value of the Page Type field.';
                }
                field("Sub Dept"; Rec."Sub Dept")
                {
                    ToolTip = 'Specifies the value of the Sub Dept field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
