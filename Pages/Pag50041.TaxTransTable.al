page 50041 TaxTransTable
{
    ApplicationArea = All;
    Caption = 'TaxTransTable';
    PageType = List;
    SourceTable = "Tax Transaction Value";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                }
                field("Case ID"; Rec."Case ID")
                {
                    ToolTip = 'Specifies the value of the Case ID field.';
                }
                field("Column Name"; Rec."Column Name")
                {
                    ToolTip = 'Specifies the value of the Column Name field.';
                }
                field("Column Value"; Rec."Column Value")
                {
                    ToolTip = 'Specifies the value of the Column Value field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field("Option Index"; Rec."Option Index")
                {
                    ToolTip = 'Specifies the value of the Option Index field.';
                }
                field(Percent; Rec.Percent)
                {
                    ToolTip = 'Specifies the value of the Percent field.';
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
                field("Tax Record ID"; Rec."Tax Record ID")
                {
                    ToolTip = 'Specifies the value of the Tax Record ID field.';
                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ToolTip = 'Specifies the value of the Tax Type field.';
                }
                field("Value ID"; Rec."Value ID")
                {
                    ToolTip = 'Specifies the value of the Value ID field.';
                }
                field("Value Type"; Rec."Value Type")
                {
                    ToolTip = 'Specifies the value of the Value Type field.';
                }

            }
        }
    }
}
