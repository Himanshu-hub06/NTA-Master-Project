#pragma implicitwith disable
page 50221 "Approved Indent List"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50090;
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Due Date"; Rec."Due Date")
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
    begin
        //SetSecurityFilter;
    end;

    var
        ProdJnlMgmt: Codeunit 5510;
        IndentLineRec: Record 50090;
        RedClr: Text;
}

#pragma implicitwith restore

