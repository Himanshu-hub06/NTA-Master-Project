page 50270 "Transport Role Center"
{
    ApplicationArea = All;
    Caption = 'Transport Role Center';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            group(Transport)
            {
                part("Transport Cue"; "Transport Cue")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Sections)
        {

            group("Transport/Fleet")
            {
                Caption = 'Transport/Fleet';
                action("Transport/Fleet Application")
                {
                    ApplicationArea = All;
                    Caption = 'Transport/Fleet Application';
                    RunObject = Page 50268;
                    RunPageMode = View;
                    RunPageView = where(status = filter(Open));
                }
                action("Under Approval")
                {
                    ApplicationArea = All;
                    RunObject = Page 50268;
                    RunPageMode = View;
                    RunPageView = where(Status = filter("Under Approval"));
                }
                action("Under GA Section")
                {
                    ApplicationArea = All;
                    RunObject = Page 50268;
                    RunPageView = where(Status = filter("Under GA Secton"));
                }
                action(Approved)
                {
                    ApplicationArea = All;
                    RunObject = Page 50268;
                    RunPageMode = View;
                    RunPageView = where(Status = filter(Approved));
                }
                action("End Trip")
                {
                    ApplicationArea = All;
                    RunObject = Page 50268;
                    RunPageMode = View;
                    RunPageView = where(Status = filter(Completed));
                }
            }
            group(Vehicle)
            {
                action(Vehicle1)
                {
                    Caption = 'Vehicle';
                    ApplicationArea = All;
                    RunObject = page 50264;
                }
            }
            group(Driver)
            {
                action(Driver1)
                {
                    Caption = 'Driver';
                    ApplicationArea = All;
                    RunObject = Page 50266;
                }
            }

        }
    }
}
