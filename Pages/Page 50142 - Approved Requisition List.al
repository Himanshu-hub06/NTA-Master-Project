#pragma implicitwith disable
/// <summary>
/// Page Approved Requisition List (ID 50142).
/// </summary>
page 50142 "Approved Requisition List"
{
    CardPageID = "Approved Requisition";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Approved),
                            Issued = CONST(false),
                            Posted = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
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
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
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
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field(Declined; Rec.Declined)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Autherise/Decline By"; Rec."Autherise/Decline By")
                {
                    ApplicationArea = All;
                }
                field("Indent Close"; Rec."Indent Close")
                {
                    ApplicationArea = All;
                }
                field(Release; Rec.Release)
                {
                    ApplicationArea = All;
                }
                field("Approving UID"; Rec."Approving UID")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Time"; Rec."Creation Time")
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
        area(processing)
        {
            action("Approval History")
            {
                ApplicationArea = All;
                Caption = 'Approval History';
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
        /*
        usersetup.GET(USERID);
        IF NOT ((usersetup.Section = 'S079') OR (usersetup.Section = 'S078')) THEN
        SETRANGE("Shortcut Dimension 2 Code",usersetup.Section);
        */

    end;

    trigger OnAfterGetRecord()
    begin
        /*
        usersetup.GET(USERID);
        IF NOT ((usersetup.Section = 'S079') OR (usersetup.Section = 'S078')) THEN
        SETRANGE("Shortcut Dimension 2 Code",usersetup.Section);
        */

    end;

    trigger OnOpenPage()
    begin
        /*
        usersetup.GET(USERID);
        IF NOT ((usersetup.Section = 'S079') OR (usersetup.Section = 'S078')) THEN
        SETRANGE("Shortcut Dimension 2 Code",usersetup.Section);
        */
        /*
        //Corp - for locatione user access - start
        IF usersetup.GET(USERID) THEN BEGIN
          FILTERGROUP(2);
          IF usersetup."Indent Approval" <> '' THEN
            SETFILTER("Location Code",usersetup."Indent Approval");
          FILTERGROUP(0);
        END;
        //Corp - for location wise user access - end
        *///EXP
        // Rec.SetSecurityFilter;//nitin 25-08-23

    end;

    var
        usersetup: Record 91;
        ApprovalEntry: Record 454;
}

#pragma implicitwith restore

