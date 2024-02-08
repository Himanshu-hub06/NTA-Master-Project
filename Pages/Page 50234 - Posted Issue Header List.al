#pragma implicitwith disable
page 50234 "Posted Issue Header List"
{
    CardPageID = "Posted Issue Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50093;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Posted = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Issue From Department';
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Issue From Department Name';
                }
                field("Issue to Section"; Rec."Issue to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Issue to Department';
                    Editable = false;
                }
                field("Issue To Section Name"; Rec."Issue To Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Issue To Department Name';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
            }
        }
        area(factboxes)
        {
            systempart("Notes"; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        RedClr := '';
        IF Rec.Priority = Rec.Priority::Urgent THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := 'StrongAccent';
    end;

    var
        usersetup: Record 91;
        RedClr: Text;
}

#pragma implicitwith restore

