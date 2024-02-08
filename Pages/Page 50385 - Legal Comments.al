page 50385 "Legal Comments"
{
    Caption = 'Legal Comments';
    CardPageID = "Legal Comment Card";
    DataCaptionFields = "Document No.";
    Editable = false;
    PageType = List;
    SourceTable = "Legal Comment Line";
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(group)
            {

                field(Comment; NoteSheet)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("User Name\Designation"; Rec."User Description")
                {
                    Enabled = false;
                }
                field("Date and Time"; (Rec."Date and Time" - ((1000 * 60) * 330)))
                {
                }
                field("Last Modified on"; Rec."Last Modified on")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Download Note Sheet")
            {
                Image = ViewJob;
                Promoted = true;



                // trigger OnAction()
                // begin
                //     LegalNoteSheet.SETTABLEVIEW(Rec);
                //     LegalNoteSheet.RUN;
                // end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF rec.Active THEN
            ComEditable := FALSE
        ELSE
            ComEditable := TRUE;
        CLEAR(InStr);
        CLEAR(NoteSheet);
        rec.CALCFIELDS("Note Sheet");
        IF rec."Note Sheet".HASVALUE THEN BEGIN
            rec."Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
            InStr.READ(NoteSheet);
        END
    end;

    trigger OnAfterGetRecord()
    begin
        IF rec.Active THEN
            ComEditable := FALSE
        ELSE
            ComEditable := TRUE;
        CLEAR(InStr);
        CLEAR(NoteSheet);
        rec.CALCFIELDS("Note Sheet");
        IF rec."Note Sheet".HASVALUE THEN BEGIN
            rec."Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
            InStr.READ(NoteSheet);
        END
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF rec."User ID" <> USERID THEN
            ERROR('You Cannot delete comment of other user');

        IF rec.Active THEN
            ERROR('You cannot delete previous comments');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF rec."User ID" <> USERID THEN
            ERROR('You Cannot modify comment of other user');
        IF rec.Active THEN
            ERROR('You cannot modify previous comments');
    end;

    var
        ComEditable: Boolean;
        InStr: InStream;
        OutStr: OutStream;
        NoteSheet: Text;
        LegalCommentLine: Record "Legal Comment Line";
    // LegalNoteSheet: Report "Legal Note Sheet;                     HCY

}

