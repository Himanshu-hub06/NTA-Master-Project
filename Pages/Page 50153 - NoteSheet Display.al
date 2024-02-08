/// <summary>
/// Page NoteSheet Display (ID 50153).
/// </summary>
#pragma implicitwith disable
page 50153 "NoteSheet Display"
{
    Caption = 'Note Sheet';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = 50084;

    layout
    {
        area(content)
        {
            group("Note Sheet")
            {
                field(NsheetOld; NsheetOld)
                {
                    Caption = 'Note Sheet';
                    ShowCaption = false;
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Note Sheet Report")
            {
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    NoteSheetTab.RESET;
                    NoteSheetTab.SETRANGE("Table Id", Rec."Table Id");
                    NoteSheetTab.SETRANGE("Document No.", Rec."Document No.");
                    //NoteSheetTab.SETRANGE("Document Line No.","Document Line No.");
                    IF NoteSheetTab.FINDFIRST THEN
                        REPORT.RUN(50004, TRUE, TRUE, NoteSheetTab);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS("Running Note");
        IF Rec."Running Note".HASVALUE THEN BEGIN
            Rec."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
            Isstream.READ(NsheetOld);
        END;
    end;

    trigger OnOpenPage()
    begin
        Rec.CALCFIELDS("Running Note");
        IF Rec."Running Note".HASVALUE THEN BEGIN
            Rec."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
            Isstream.READ(NsheetOld);
        END;
    end;

    var
        NsheetOld: Text;
        Isstream: InStream;
        NoteSheetTab: Record 50084;
}

#pragma implicitwith restore

