page 50401 "NTA Legal Cell"
{
    ApplicationArea = All;
    Caption = 'NTA Legal Cell';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            group(GRP01)
            {
                // part("Store Activities"; "Store Activities")
                part("NTA Activities"; 50400)
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
        area(Sections)
        {

            group("NTA Legal Managemement")
            {
                Caption = 'NTA Legal Managemement';
                action("Advocate List")
                {
                    ApplicationArea = All;
                    Caption = 'Advocate List';
                    RunObject = Page 50301;
                    //RunPageMode = 
                    //RunPageView = where(status = filter(Open));
                }

                action("Write Cases;")
                {
                    ApplicationArea = All;
                    Caption = 'Write Case';
                    RunObject = Page 50350;
                    //RunPageMode = 
                    //RunPageView = where(status = filter(Open));
                }
                action("Disposed Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Disposed Cases';
                    RunObject = Page 50362;
                }

                action("Report Legal Case Status")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Case Status';
                    RunObject = report 50129;
                }

                action("Case Satus  - Details")
                {
                    ApplicationArea = All;
                    Caption = 'Case Status  - Details';
                    RunObject = report 50130;
                }

                action("Adv. Wise Case Assign Details")
                {
                    ApplicationArea = All;
                    Caption = 'Adv. Wise Case Assign Details';
                    RunObject = report 50134;
                }

                action("Case Type Wise SOF Status")
                {
                    ApplicationArea = All;
                    Caption = 'Case Type Wise SOF Status';
                    RunObject = report 50135;
                }

                action("Section Wise SOF Details")
                {
                    ApplicationArea = All;
                    Caption = 'Section Wise SOF Details';
                    RunObject = report 50136;
                }


            }



        }
    }
}
