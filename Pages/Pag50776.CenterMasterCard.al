page 50776 "Center Master Card"
{
    ApplicationArea = All;
    Caption = 'Center Master Card';
    PageType = Card;
    SourceTable = ERP_MASTER_Centre;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Centre_Address; Rec.Centre_Address)
                {
                    ToolTip = 'Specifies the value of the Centre_Address field.';
                }
                field(Centre_Capacity; Rec.Centre_Capacity)
                {
                    ToolTip = 'Specifies the value of the Centre_Capacity field.';
                }
                field(Centre_ContactNo; Rec.Centre_ContactNo)
                {
                    ToolTip = 'Specifies the value of the Centre_ContactNo field.';
                }
                field(Centre_Email; Rec.Centre_Email)
                {
                    ToolTip = 'Specifies the value of the Centre_Email field.';
                }
                field(Centre_Name; Rec.Centre_Name)
                {
                    ToolTip = 'Specifies the value of the Centre_Name field.';
                }
                field(City_Code; Rec.City_Code)
                {
                    ToolTip = 'Specifies the value of the City_Code field.';
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(IsActive; Rec.IsActive)
                {
                    ToolTip = 'Specifies the value of the IsActive field.';
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
