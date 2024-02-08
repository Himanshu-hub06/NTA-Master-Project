page 50792 "Member Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Member;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Member Id"; Rec."Member Id")
                {
                    Caption = 'Member ID';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;

                }

                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;

                }
                field("Email-Id"; Rec."Email-Id")
                {
                    Caption = 'EmaiDl-ID';
                    ApplicationArea = All;

                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;

                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;

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