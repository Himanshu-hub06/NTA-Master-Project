page 50217 "Rejected Requisition List"
{
    CardPageID = "Rejected Requisition";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Rejected),
                            Issued = CONST(false));

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
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Time"; Rec."Creation Time")
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approval History")
            {
                ApplicationArea = all;
                Caption = 'Approval History';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.FILTERGROUP(2);
                    //ApprovalEntry.SETRANGE("Document No.", "No.");
                    //PAGE.RUNMODAL(PAGE::"Approval History", ApprovalEntry);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

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
        Rec.SetSecurityFilter;

    end;

    var
        usersetup: Record 91;
        ApprovalEntry: Record 454;
}

