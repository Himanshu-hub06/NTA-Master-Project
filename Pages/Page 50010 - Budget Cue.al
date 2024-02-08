page 50010 "Budget Cue"
{
    ApplicationArea = All;
    Caption = 'Budget Dashboard';
    PageType = CardPart;
    SourceTable = "NTA Cue";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Budgets")
            {
                field("Budget Open"; Rec."Budget Open")
                {

                    DrillDown = true;
                    DrillDownPageId = 121;
                    Editable = false;
                }

                field("Budget Pending Approval Req"; Rec."Budget Pending Approval Req")
                {


                    DrillDown = true;
                    DrillDownPageId = 121;
                    Editable = false;

                }
                field("Budget Approval"; Rec."Budget Approval")
                {

                    DrillDown = true;
                    DrillDownPageId = 121;
                    Editable = false;
                }
                field("Budget Reject"; Rec."Budget Reject")
                {

                    DrillDown = true;
                    DrillDownPageId = 121;
                    Editable = false;
                }
            }
        }
    }
}


