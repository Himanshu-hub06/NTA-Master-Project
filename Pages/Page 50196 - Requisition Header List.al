#pragma implicitwith disable
/// <summary>
/// Page Requisition Header List (ID 50743).
/// </summary>
page 50196 "Requisition Header List"
{
    CardPageID = "Requisition Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Open));

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
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition To Section';
                    Editable = false;
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    StyleExpr = RedClr;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
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

    trigger OnAfterGetCurrRecord()
    begin
        // usersetup.GET(USERID);
        //  IF NOT ((usersetup.Section = 'STORE') OR (usersetup.Section = 'STORE')) THEN
        //     Rec.SETRANGE("Shortcut Dimension 2 Code", usersetup.Section);

    end;

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

        // Rec.SetSecurityFilter1;//ExpNitin
    end;

    var
        usersetup: Record 91;
        RedClr: Text;
}

#pragma implicitwith restore

