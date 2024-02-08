page 50377 "SOF Approval Comments"
{
    Caption = 'Approval Comments';
    DataCaptionFields = "Record ID to Approve";
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = 455;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; rec.Comment)
                {
                }
                field("User ID"; rec."User ID")
                {
                }
                field("Date and Time"; rec."Date and Time")
                {
                }
                field("Entry No."; rec."Entry No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF rec."User ID" <> USERID THEN
            ERROR('You cannot delete other user comment');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF rec."User ID" <> USERID THEN
            ERROR('You cannot modify other user comment');
    end;

}

