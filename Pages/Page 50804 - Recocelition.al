page 50804 Recencilition
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "NTA Cue";
    RefreshOnActivate = True;

    layout
    {
        area(Content)
        {
            cuegroup("Bank Acc. Reconciliation")
            {
                field("Fee Recancilition"; Rec."Fee Recancilition")
                {
                    DrillDownPageId = "Bank Acc. Reconciliation";
                    Editable = false;
                    DrillDown = true;

                }
                field("Fee Reconc List"; Rec."Fee Reconc List")
                {
                    DrillDownPageId = "Bank Acc. Reconciliation List";
                    Editable = false;
                    DrillDown = true;

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