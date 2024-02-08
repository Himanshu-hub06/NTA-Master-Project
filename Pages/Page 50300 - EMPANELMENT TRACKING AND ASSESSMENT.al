page 50300 "EMPANELMENT AND ASSESSMENT"
{
    ApplicationArea = All;
    Caption = 'NTA EMPANELMENT TRACKING AND ASSESSMENT';
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

            group("NTA EMPANELMENT TRACKING & ASSESSMENT")
            {
                Caption = 'NTA EMPANELMENT TRACKING & ASSESSMENT';
                action("Notification Master")
                {
                    ApplicationArea = All;
                    Caption = 'Notification Master';
                    RunObject = Page 50811;

                }

                action("Empanelment date configuration;")
                {
                    ApplicationArea = All;
                    Caption = 'Empanelment Date Configuration';
                    RunObject = Page 50350;

                }
                action("Affiliation Type Master")
                {
                    ApplicationArea = All;
                    Caption = 'Affiliation Type Master';
                    RunObject = Page 50812;
                }

                action("AIC Committee Master")
                {
                    ApplicationArea = All;
                    Caption = 'AIC Committee Master';
                    RunObject = page 50813;
                }

                action("Checklist Master")
                {
                    ApplicationArea = All;
                    Caption = 'Checklist Master';
                    RunObject = page 50814;
                }

                action("Activity Master")
                {
                    ApplicationArea = All;
                    Caption = 'Activity Master';
                    RunObject = page 50812;
                }




            }


        }
    }
}
