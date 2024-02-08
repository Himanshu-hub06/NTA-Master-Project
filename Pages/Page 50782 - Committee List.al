page 50782 MyPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Committee Header";
    CardPageId = 50783;
    Caption = 'Commitee List';





    layout
    {
        area(Content)
        {
            repeater(Application)
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