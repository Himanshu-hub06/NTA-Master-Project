page 50037 "Approval Comments view"
{
    Caption = 'Approval Comments';
    //DataCaptionFields = "Record ID to Approve";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "Approval Comment Line";

    layout
    {
        area(content)
        {
            // repeater()
            //{
            field(Comment; Rec.Comment)
            {
            }
            field("User ID"; Rec."User ID")
            {
            }
            field("Date and Time"; Rec."Date and Time")
            {
            }
            field("Entry No."; Rec."Entry No.")
            {
                Visible = false;
            }
        }
    }


    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF UserId <> USERID THEN
            ERROR(Text002);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF UserId <> USERID THEN
            ERROR(Text001);
    end;

    var
        CommentEditable: Boolean;
        Text001: Label 'You cannot modify comments of other user.';
        Text002: Label 'You cannot delete comments of other user.';
}

