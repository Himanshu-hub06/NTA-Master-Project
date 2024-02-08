page 50154 "Purchase Proposal List"
{
    CardPageID = "Purchase Proposal Header";
    DeleteAllowed = false;
    InsertAllowed = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = CONST(Open),
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
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    StyleExpr = RedClr;
                    ApplicationArea = All;
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
                    StyleExpr = RedClr;
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

    trigger OnAfterGetRecord()
    begin
        RedClr := '';
        IF Rec.Priority = Rec.Priority::Urgent THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := 'StrongAccent';
    end;

    trigger OnOpenPage()
    var
        usersetup: Record 91;
    begin
        Rec.SetsecuirityFilter;
    end;

    var
        ProdJnlMgmt: Codeunit 5510;
        // IndentLineRec: Record 50040;
        IndentLineRec: Record "Indent Line";
        RedClr: Text;
}

