/// <summary>
/// Page Transport Cue (ID 50040).
/// </summary>
page 50040 "Transport Cue"
{
    ApplicationArea = All;
    Caption = '';
    PageType = CardPart;
    SourceTable = "NTA Cue";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            Cuegroup(Transport)
            {
                Caption = '';

                field("Transport All Application"; Rec."Transport All Application")
                {
                    Caption = 'Transport All Application';
                    DrillDown = true;
                    DrillDownPageID = "Transport/Fleet Log List";
                }
                field("Transport Under Approval"; Rec."Transport Under Approval")
                {
                    Caption = 'Under Approval';
                    DrillDown = true;
                    DrillDownPageID = "Transport/Fleet Log List";
                }
                field("Transport Under GA Section"; Rec."Transport Under GA Section")
                {
                    Caption = 'Under GA Secton';
                    DrillDown = true;
                    DrillDownPageID = "Transport/Fleet Log List";
                }
                field("Trasport Approved"; Rec."Trasport Approved")
                {
                    Caption = 'Approved';
                    DrillDown = true;
                    DrillDownPageID = "Transport/Fleet Log List";
                }
                field("Transport End Trip"; Rec."Transport End Trip")
                {
                    Caption = 'End Trip';
                    DrillDown = true;
                    DrillDownPageID = "Transport/Fleet Log List";
                }
            }
        }
    }
}
