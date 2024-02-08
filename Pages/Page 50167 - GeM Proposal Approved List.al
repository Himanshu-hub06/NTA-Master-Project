page 50167 "GeM Proposal Approved List"
{
    Caption = 'Gems Proposal Approved List';
    CardPageID = "Gems Proposal Approved";
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER(Approved),
                            "Purchase Type" = CONST(GeM));

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
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approving Date and Time"; Rec."Approving Date and Time")
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

