page 50171 "GeM Purch. Proposal Under App"
{
    Caption = 'Gems Purch. Proposal Under Approval';
    CardPageID = "Gems Proposal Under Approval";
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER("Pending for Approval"),
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
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }

                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Demand Order No."; Rec."Demand Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Demand Order Date"; Rec."Demand Order Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
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
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = RedClr;
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

