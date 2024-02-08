#pragma implicitwith disable
page 50208 "Posted Requisition List"
{
    CardPageID = "Posted Requisition Header";
    DeleteAllowed = false;
    Editable = true;
    //InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = 50087;
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Posted = FILTER(true),
                            Issued = CONST(false),
                            Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    AssistEdit = false;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Caption = 'Requisition to Section';
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name';
                }
                field("Posting Date"; Rec."Posting Date")
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
        area(factboxes)
        {
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

