/// <summary>
/// Page Posted Indent List (ID 50798).
/// </summary>
page 50245 "Posted Indent List"
{
    CardPageID = "Posted Indent Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50089;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Send For Approval" = FILTER(true),
                            Approved = FILTER(true),
                            Status = FILTER(<> Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    var
        usersetup: Record 91;
}

