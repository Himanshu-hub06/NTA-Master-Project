/// <summary>
/// </summary>
page 50241 "Indent Under App List"
{
    CardPageID = "Indent Under Approval Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 50089;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER("Pending for Approval"));

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Location Name"; Rec."Location Name")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RedClr;
                }
                field("Pending From User Id"; Rec."Pending From User Id")
                {
                    ApplicationArea = All;
                }
                field("Pending From User Name"; Rec."Pending From User Name")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
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

    trigger OnOpenPage()
    begin
        /*
        usersetup.GET(USERID);
        IF NOT usersetup."Indent Approval" = TRUE THEN
          ERROR('You do not have permission to open' + ' ' + CurrPage.CAPTION);
        */

    end;

    var
        RedClr: Text;
        usersetup: Record 91;
}

