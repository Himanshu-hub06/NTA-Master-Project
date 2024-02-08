page 50322 "Legal Approval List"
{
    Caption = 'User List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approval User Group Member";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Name"; Rec."User Full Name")
                {
                    Caption = 'User ID';
                }
                field("User Description"; rec."User Description")
                {
                    Caption = 'Name';
                }
                // field("User Designation";rec."User Designation")
                // {
                //     Caption = 'Designation';
                // }
                // field(Section;"Department Name")
                // {
                //     Caption = 'Section';
                // }
            }
        }
    }

    actions
    {
    }
}

