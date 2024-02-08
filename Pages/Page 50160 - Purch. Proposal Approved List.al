page 50160 "Purch. Proposal Approved List"
{
    CardPageID = "Purch. Proposal Approved";
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    // SourceTable = Table50011;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER(Approved),
     "Purchase Type" = CONST(Direct));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Exam Name"; Rec."Exam Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
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
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
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
        Rec.SetsecuirityFilter;

    end;

    var
        RedClr: Text;
        usersetup: Record 91;
}

