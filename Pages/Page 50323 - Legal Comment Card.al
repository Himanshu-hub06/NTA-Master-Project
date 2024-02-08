page 50323 "Legal Comment Card"
{
    Caption = 'Legal Comment Card';
    PageType = Card;
    SourceTable = "Legal Comment Line";
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            field(Comment; NoteSheet)
            {
                Caption = 'Comment';
                Editable = ComEditable;
                MultiLine = true;

                trigger OnValidate()
                begin
                    rec."Note Sheet".CREATEOUTSTREAM(OutStr, TEXTENCODING::UTF16);
                    OutStr.WRITE(NoteSheet);
                    //MODIFY
                end;
            }
            field("User ID"; rec."User ID")
            {
            }
            field("User Name"; rec."User Description")
            {
                Caption = 'User Name';
                Editable = false;
                Enabled = false;
            }
            field("Date and Time"; DateTime)
            {
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF rec.Active THEN
            ComEditable := FALSE
        ELSE
            ComEditable := TRUE;
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
        rec.CALCFIELDS("Note Sheet");
        IF rec."Note Sheet".HASVALUE THEN BEGIN
            rec."Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
            InStr.READ(NoteSheet);
        END;
        IF rec."Date and Time" <> 0DT THEN
            DateTime := (rec."Date and Time" - ((1000 * 60) * 330))
        ELSE
            DateTime := 0DT
    end;

    var
        NoteSheet: Text;
        InStr: InStream;
        OutStr: OutStream;
        ComEditable: Boolean;
        DateTime: DateTime;
}

