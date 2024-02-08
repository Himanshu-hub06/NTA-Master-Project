#pragma implicitwith disable
page 50212 "Closed/Issued Requisition List"
{
    CardPageID = "Closed/Issued Requisition";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50091;
    SourceTableView = SORTING("Requisition No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Closed | Issued));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Document No';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name>';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Authorise; Rec.Authorise)
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilter;
    end;

    var
        usersetup: Record 91;
}

#pragma implicitwith restore

