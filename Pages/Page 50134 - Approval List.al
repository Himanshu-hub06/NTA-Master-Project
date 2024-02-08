page 50134 "Approval List"
{
    PageType = List;
    SourceTable = 50082;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    DelayedInsert = false;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User';
                }
                field("User Full Name"; rec."User Full Name")
                {
                    ApplicationArea = All;
                }
                field("User Description"; rec."User Description")
                {
                    ApplicationArea = All;
                    Caption = 'Designation';
                }
            }
        }
    }

    actions
    {
    }
}

