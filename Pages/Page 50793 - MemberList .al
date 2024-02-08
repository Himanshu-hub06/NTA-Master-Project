page 50793 "Member List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    //SourceTable = Member;
    SourceTable = 50284;
    //CardPageId = 50792;
    // InsertAllowed = false;
    // DeleteAllowed = false;
    // ModifyAllowed = false;
    MultipleNewLines = true;
    AutoSplitKey = true;


    layout
    {
        area(Content)
        {
            repeater("Member List")

            {
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;

                }
                field("Member Id"; Rec."Member Id")
                {
                    ApplicationArea = All;
                    Visible = False;


                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-mail ID"; Rec."E-mail ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // fielD(M)
                // {
                //     ApplicationArea = All;
                // }

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