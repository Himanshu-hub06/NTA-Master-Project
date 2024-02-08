#pragma implicitwith disable
page 50090 "NTA Bill Set-up"
{
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = 50021;
    Editable = true;

    layout
    {
        area(content)
        {
            group("TA Bill Landing UID Group")
            {
                Caption = 'TA Bill Landing UID';
                field("TA Bill Landing UID"; Rec."TA Bill Landing UID")
                {
                    ApplicationArea = All;
                }
                field("Budget Approval code"; Rec."Budget Approval code")
                {
                    ApplicationArea = All;
                }
                field("TA & Centre Bill UID"; Rec."TA & Centre Bill UID")
                {
                    ApplicationArea = All;
                }
                field("Transport Approval Code"; Rec."Transport Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Workflow Code2"; Rec."Workflow Code2")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(creation)
    //     {
    //         action("Run Media Plan Set-up")
    //         {
    //             Image = Production;
    //             Promoted = true;

    //             trigger OnAction()
    //             begin
    //                 REPORT.RUN(50102);
    //                 CurrPage.CLOSE;
    //             end;
    //         }
    //     }
    // }
}

#pragma implicitwith restore

