#pragma implicitwith disable
page 50214 "Requisition Recieved StoreList"
{
    CardPageID = "Requisition Recieved Store";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Status = FILTER(Approved),
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
                    Editable = false;
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
                field("User ID"; Rec."User ID")
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
                field("Approving UID"; Rec."Approving UID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
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
}

#pragma implicitwith restore

