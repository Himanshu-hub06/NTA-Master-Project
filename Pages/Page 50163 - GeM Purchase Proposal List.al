page 50163 "GeM Purchase Proposal List"
{
    Caption = 'Gems Purchase Proposal List';
    CardPageID = "Gems Purchase Proposal Head";
    DeleteAllowed = false;
    InsertAllowed = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Proposal Header";
    SourceTableView = ORDER(Descending)
                      WHERE(Posted = FILTER(false),
                            Status = FILTER(Open),
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
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
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
                    StyleExpr = RedClr;
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
    end;

    var
        ProdJnlMgmt: Codeunit 5510;
        // IndentLineRec: Record "50040";
        IndentLineRec: Record "Indent Line";
        RedClr: Text;
}

