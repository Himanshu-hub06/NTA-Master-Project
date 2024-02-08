page 50001 "User Location Role"
{
    PageType = List;
    SourceTable = "User Location";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Id"; rec."User Id")
                {
                }
                field("User Name"; rec."User Name")
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field("Location Name"; rec."Location Name")
                {
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                }
                field("Section Name"; rec."Section Name")
                {
                }
                field("All Location"; rec."All Location")
                {
                }
                field("Created By"; rec."Created By")
                {
                }
                field("Created Date"; rec."Created Date")
                {
                }
                field("Last Modified By"; rec."Last Modified By")
                {
                }
                field("Last Modified Date"; rec."Last Modified Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

