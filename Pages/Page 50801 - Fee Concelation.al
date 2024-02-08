page 50801 FeeRecancelation
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = all;
    // PageType = RoleCenter;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    // //SourceTable = 273;

    layout
    {
        area(RoleCenter)
        {
            group(Recenciltion)
            {
                part(Rececilition; 50804)
                {
                    Caption = '';
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }
}

profile FeeRecanceltion
{
    ProfileDescription = 'RoleCenter';
    RoleCenter = FeeRecancelation;
    Caption = 'Fee Reconciliation';
}



