page 50073 "ERP Master List"
{
    ApplicationArea = All;
    Caption = 'ERP Master List';
    PageType = List;
    SourceTable = ERP_MASTER_Centre;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Centre_Name; Rec.Centre_Name)
                {
                    ToolTip = 'Specifies the value of the Centre_Name field.';
                }
                field(Centre_Address; Rec.Centre_Address)
                {
                    ToolTip = 'Specifies the value of the Centre_Address field.';
                }
                field(Centre_ContactNo; Rec.Centre_ContactNo)
                {
                    ToolTip = 'Specifies the value of the Centre_ContactNo field.';
                }
                field(Centre_Email; Rec.Centre_Email)
                {
                    ToolTip = 'Specifies the value of the Centre_Email field.';
                }
                field(City_Code; Rec.City_Code)
                {
                    ToolTip = 'Specifies the value of the City_Code field.';
                }
                field(IsActive; Rec.IsActive)
                {
                    ToolTip = 'Specifies the value of the IsActive field.';
                }
                field(Centre_Capacity; Rec.Centre_Capacity)
                {
                    ToolTip = 'Specifies the value of the Centre_Capacity field.';
                }
            }
        }
    }
}
