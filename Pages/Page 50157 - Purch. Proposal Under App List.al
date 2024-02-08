page 50157 "Purch. Proposal Under App List"
{
    CardPageID = "Purch. Proposal Under Approval";
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER("Pending for Approval"),
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
                    StyleExpr = RedClr;
                    ApplicationArea = All;
                }
                field("Exam Name"; Rec."Exam Name")
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
                field("Pending From User Id"; Rec."Pending From User Id")
                {
                    ApplicationArea = All;
                }
                field("Pending From User Name"; Rec."Pending From User Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    StyleExpr = RedClr;
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
                field("User ID"; Rec."User ID")
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
        // Rec.SetsecuirityFilter;// Nitin 25-08-23

    end;

    var
        RedClr: Text;
        usersetup: Record 91;
}

