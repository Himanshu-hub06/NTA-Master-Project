page 50800 MEetingActivities
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "NTA Cue";
    Caption = 'Committee & Cell Managment Dashbord';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(Meeting)
            {
                field("Meeting Open"; Rec."Meeting Open")
                {
                    DrillDownPageId = "Meeting List";
                    Editable = false;
                    DrillDown = true;
                }
                field("Meeting Pending Approval"; Rec."Meeting Pending Approval")
                {
                    DrillDownPageId = "Meeting List";
                    Editable = false;
                    DrillDown = true;
                }
                field("Meeting Approved"; Rec."Meeting Approved")
                {
                    DrillDownPageId = "Meeting List";
                    DrillDown = true;
                    Editable = false;
                }
                field("Meeting Rejected"; Rec."Meeting Rejected")
                {
                    DrillDownPageId = "Meeting List";
                    DrillDown = true;
                    Editable = false;
                }


            }
            cuegroup(Committee)
            {
                field("Committee Draft"; Rec."Committee Draft")
                {
                    DrillDownPageId = "Committee List";
                    DrillDown = true;
                    Editable = false;
                }
                field("Committee Active"; Rec."Committee Active")
                {
                    DrillDownPageId = "Committee List";
                    DrillDown = true;
                    Editable = false;
                }
                field("Committee InActive"; Rec."Committee InActive")
                {
                    DrillDownPageId = "Committee List";
                    DrillDown = true;
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}