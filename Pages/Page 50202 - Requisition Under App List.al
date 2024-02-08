/// <summary>
/// Page Requisition Under App List (ID 50749).
/// </summary>
page 50202 "Requisition Under App List"
{
    CardPageID = "Requisition Under App Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER("Pending for Approval"));

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
                }
                field("Pending From User Id"; Rec."Pending From User Id")
                {
                    ApplicationArea = All;
                }
                field("Pending From User"; Rec."Pending From User")
                {
                    ApplicationArea = All;
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
        area(processing)
        {
            action("Approval Flow")
            {
                ApplicationArea = All;
                Caption = 'Approval Flow';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.FILTERGROUP(2);
                    ApprovalEntry.SETRANGE("Document No.", Rec."No.");
                    // PAGE.RUNMODAL(PAGE::Page50429, ApprovalEntry);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        usersetup.GET(USERID);
        //  IF NOT ((usersetup.Section = 'S079') OR (usersetup.Section = 'S078')) THEN//EXPDIP
        //     Rec.SETRANGE("Shortcut Dimension 2 Code", usersetup.Section);//EXPDIP
    end;

    trigger OnAfterGetRecord()
    begin
        RedClr := '';
        IF Rec.Priority = Rec.Priority::Urgent THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := 'StrongAccent';
        usersetup.GET(USERID);
        // IF NOT ((usersetup.Section = 'S02') ) THEN//EXPDIP
        //      Rec.SETRANGE("Shortcut Dimension 2 Code", usersetup.Section);//EXPDIP
    end;

    trigger OnOpenPage()
    begin

        // Rec.SetSecurityFilter1; //EXPDIP
    end;

    var
        usersetup: Record 91;
        RedClr: Text;
        ApprovalEntry: Record 454;
}

