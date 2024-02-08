#pragma implicitwith disable
/// <summary>
/// Page NoteSheet Card (ID 50621).
/// </summary>
page 50152 "NoteSheet Card"
{
    PageType = Card;
    SourceTable = 50084;
    PromotedActionCategories = 'New,Process,Report,Note Sheet';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Creator UID"; Rec."Creator UID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Creator User Name"; Rec."Creator User Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Creation Date Time"; Rec."Creation Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sender UID"; Rec."Sender UID")
                {
                    ApplicationArea = All;
                }
                field("Sender User Name"; Rec."Sender User Name")
                {
                    ApplicationArea = All;
                }
                field("Receiving Date Time"; Rec."Receiving Date Time")
                {
                    ApplicationArea = All;
                }
            }
            group(Noting)
            {
                grid(Noting1)
                {
                    field(Notes; NsheetOld)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("My Comment"; Nsheet)
                    {
                        ApplicationArea = All;
                        AutoFormatType = 5;
                        MultiLine = true;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            Rec."Current Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
                            ostrm.WRITE(Nsheet);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Save)
            {
                Enabled = Edtble;
                Image = Filed;
                Promoted = true;
                Visible = true;
                ApplicationArea = All;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    SaveBLOB;
                    CurrPage.CLOSE;
                end;
            }
            action("Report")
            {
                ApplicationArea = All;
                PromotedCategory = Category4;
                Promoted = true;
                trigger OnAction()
                begin
                    NoteSheetTab.RESET;
                    NoteSheetTab.SETRANGE("Document No.", Rec."Document No.");
                    NoteSheetTab.SETRANGE("Document Line No.", Rec."Document Line No.");
                    IF NoteSheetTab.FINDFIRST THEN
                        REPORT.RUN(50004, TRUE, TRUE, NoteSheetTab);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF USetup.GET(USERID) THEN
            Rec."Creator Section Code" := USetup.Section;
        Rec."Current Section" := USetup.Section;
        Rec."Creator Section Name" := SectionName(USetup.Section);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Creator UID" := USERID;
        Rec."Creation Date Time" := CURRENTDATETIME;
        Rec."Current UID" := USERID;
        UserTab.RESET;
        UserTab.SETRANGE(UserTab."User Name", USERID);
        IF UserTab.FINDFIRST THEN
            Rec."Creator User Name" := UserTab."Full Name";
    end;

    trigger OnOpenPage()
    begin
        Rec.CALCFIELDS("Running Note");
        IF Rec."Running Note".HASVALUE THEN BEGIN
            Rec."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
            Isstream.READ(NsheetOld);
        END;
        Rec.CALCFIELDS("Current Note");
        IF Rec."Current Note".HASVALUE THEN BEGIN
            Rec."Current Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
            Isstream.READ(Nsheet);
        END;

        IF Rec.status <> Rec.status::New THEN
            Edtble := FALSE
        ELSE
            Edtble := TRUE;
        Entryno := Rec."Last Entry No." + 1;
    end;

    var
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        Newline: Text;
        NSheetTab: Record 50084;
        USetup: Record 91;
        SectCode: Code[10];
        SectUser: Code[20];
        USetupList: Page 119;
        NStTab: Record 50084;
        SaveTxt: Text;
        len: Integer;
        Edtble: Boolean;
        UserTab: Record 50000;
        Char10: Char;
        NoteSheetTab: Record 50084;
        Entryno: Integer;

    /// <summary>
    /// SectionName.
    /// </summary>
    /// <param name="SecCode">Code[20].</param>
    /// <returns>Return variable SecName of type Text[50].</returns>
    procedure SectionName(SecCode: Code[20]) SecName: Text[50]
    var
        DimValTab: Record 349;
    begin
        DimValTab.RESET;
        DimValTab.SETRANGE("Dimension Code", 'SECTION');
        DimValTab.SETRANGE(DimValTab.Code, SecCode);
        IF DimValTab.FINDFIRST THEN
            SecName := DimValTab.Name;
    end;

    /// <summary>
    /// SaveBLOB.
    /// </summary>
    procedure SaveBLOB()
    begin
        Char10 := 10;
        //MESSAGE('In Save');
        IF Nsheet <> '' THEN BEGIN
            IF NsheetOld <> '' THEN
                SaveTxt := NsheetOld + '  ' + Nsheet + '    '
            ELSE BEGIN
                SaveTxt += Nsheet;
            END;
            //MESSAGE('After Init');
            Rec."Running Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
            len := STRLEN(SaveTxt);
            SaveTxt += FORMAT(Char10) + FORMAT(Char10);
            SaveTxt := INSSTR(SaveTxt, '         ', len + 2);
            UserTab.RESET;
            UserTab.SETRANGE("User Name", USERID);
            IF UserTab.FINDFIRST THEN
                IF UserTab.Designation <> '' THEN
                    SaveTxt += UserTab."Full Name" + '(' + UserTab.Designation + ')' + ' Dt.-' + FORMAT(CURRENTDATETIME)
                ELSE
                    SaveTxt += UserTab."Full Name" + ' Dt.-' + FORMAT(CURRENTDATETIME);
            SaveTxt += FORMAT(Char10) + FORMAT(Char10);
            ostrm.WRITE(SaveTxt);
            IF Rec.MODIFY THEN BEGIN
                Rec."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                ostrm1.WRITE('');
                Rec.MODIFY;
            END;
        END;
    end;

    /// <summary>
    /// InitialData.
    /// </summary>
    /// <param name="PlanNo">Code[20].</param>

}

#pragma implicitwith restore

