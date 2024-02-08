page 50111 "Budget Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = all;
    layout
    {
        area(rolecenter)
        {
            group(GRP00)
            {
                part("G/L Budget Names Activities"; 50010)
                {
                    Caption = '';
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(sections)
        {
            group("Budget Processing")
            {
                Caption = 'Budget Processing';
                Image = ResourcePlanning;
                ToolTip = 'To Process the Budget Send for Approval .', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                group(Budgets)
                {
                    Caption = 'Budgets';
                    action("Approval Request-Budget")
                    {
                        Caption = 'Approval Request-Budgets';
                        ApplicationArea = All;
                        RunObject = Page 121;
                        RunPageView = SORTING(Name)
                                   ORDER(Ascending)
                                   WHERE(Status = FILTER(Open));
                    }
                    action(Pending)
                    {
                        Caption = 'Pending For Approval';
                        ApplicationArea = All;
                        RunObject = Page 121;
                        RunPageView = SORTING(Name)
                                   ORDER(Ascending) where(Status = filter("Pending Approval"));
                    }
                    action(Approved)
                    {
                        Caption = 'Approved Budgets';
                        ApplicationArea = All;
                        RunObject = Page 121;
                        RunPageView = SORTING(Name)
                                   ORDER(Ascending) where(Status = filter(Approved));
                    }
                    action(Rejected)
                    {
                        Caption = 'Rejected Budgets';
                        ApplicationArea = All;
                        RunObject = Page 121;
                        RunPageView = SORTING(Name)
                                   ORDER(Ascending) where(Status = filter(Rejected));
                    }
                }
            }
        }
    }
}
