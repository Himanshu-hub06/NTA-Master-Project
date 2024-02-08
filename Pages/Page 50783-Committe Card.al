page 50783 "Committe Card"
{
    PageType = Card;
    SourceTable = "Committee Header";
    AutoSplitKey = true;
    ApplicationArea = all;
    UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;
                }
                field("committee Name"; Rec."committee Name")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
            // group(Line)
            // {
            // part(CommitteLine; "Committe List")
            // {
            //     SubPageLink = "Document No." = field("No.");
            //     ApplicationArea = all;
            // }
            // //}
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    // var
    //     myInt: Integer;
}