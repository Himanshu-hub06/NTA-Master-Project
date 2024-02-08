page 50310 "Legal Comment Factbox"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 50213;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; NoteSheet)
                {
                    Caption = 'Comment';
                }
                field("User ID"; rec."User ID")
                {
                }
                field("Date and Time"; DateTime)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS("Note Sheet");
        IF Rec."Note Sheet".HASVALUE THEN BEGIN
            Rec."Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
            InStr.READ(NoteSheet);
        END;
        IF Rec."Date and Time" <> 0DT THEN
            DateTime := (Rec."Date and Time" - ((1000 * 60) * 330))
        ELSE
            DateTime := 0DT
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Note Sheet");
        IF Rec."Note Sheet".HASVALUE THEN BEGIN
            Rec."Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
            InStr.READ(NoteSheet);
        END;
        IF Rec."Date and Time" <> 0DT THEN
            DateTime := (Rec."Date and Time" - ((1000 * 60) * 330))
        ELSE
            DateTime := 0DT
    end;

    var
        NoteSheet: Text;
        InStr: InStream;
        OutStr: OutStream;
        LegalCommentLine: Record "Legal Comment Line";
        DateTime: DateTime;
}

