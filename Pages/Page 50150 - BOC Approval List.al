page 50150 "BOC Approval List"
{
    Caption = 'User List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approval User Group Member";
    SourceTableView = SORTING("Approval User Group Code", "Sequence No.", "User ID")
    ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("User Full Name"; Rec."User Full Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("User Description"; Rec."User Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

