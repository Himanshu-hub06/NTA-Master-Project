page 50794 "Member List Part"
{
    PageType = ListPart;
    //ApplicationArea = All;
    UsageCategory = Lists;
    //SourceTable = 50287;
    SourceTable = 50284;
    // CardPageId = 50792;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
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
                    //  Visible = false;
                }
                field("Member Id"; Rec."Member Id")
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;

                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;

                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;

                }
                field("E-mail ID"; Rec."E-mail ID")
                {
                    ApplicationArea = All;

                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;

                }
                // field("Contact No."; Rec."Contact No.")
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