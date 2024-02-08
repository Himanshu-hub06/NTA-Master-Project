report 50004 "Note sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Note sheet1.rdl';

    dataset
    {
        dataitem(NoteSheet; NoteSheet)
        {
            RequestFilterFields = "Document No.";
            column(RunningNote_NAVNotesheet; NoteSheet."Running Note")
            {
            }
            column(Note_Display; NSVar)
            {
            }
            column(NS_Display_2; NSVar1)
            {
            }
            column(Note_1_; VarTxt[1])
            {
            }
            column(Note_2_; VarTxt[2])
            {
            }
            column(Note_3_; VarTxt[3])
            {
            }
            column(Note_4_; VarTxt[4])
            {
            }
            column(Note_5_; VarTxt[5])
            {
            }
            column(Note_6_; VarTxt[6])
            {
            }
            column(Note_7_; VarTxt[7])
            {
            }
            column(Note_8_; VarTxt[8])
            {
            }
            column(Note_9_; VarTxt[9])
            {
            }
            column(Note_10_; VarTxt[10])
            {
            }
            column(Note_11_; VarTxt[11])
            {
            }
            column(Note_12_; VarTxt[12])
            {
            }
            column(Note_13_; VarTxt[13])
            {
            }
            column(Note_14_; VarTxt[14])
            {
            }
            column(Note_15_; VarTxt[15])
            {
            }
            column(Note_16_; VarTxt[16])
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                "Running Note".CREATEINSTREAM(InStr,TEXTENCODING::UTF16);
                InStr.READ(NSVar);
                len1 := STRLEN(NSVar);
                NSVar1 := NSVar;
                REPEAT
                  len2 := STRPOS(NSVar1,'$$$$$');
                 // MESSAGE('%1',len2);
                  j += 1;
                  IF len2 <> 0 THEN
                    VarTxt[j] := COPYSTR(NSVar1,1,len2-1)
                  ELSE
                    VarTxt[j] := NSVar1;
                  NSVar1 := COPYSTR(NSVar1,len2+5);
                UNTIL len2=0;
                */
                CALCFIELDS("Running Note");
                IF "Running Note".HASVALUE THEN BEGIN
                    "Running Note".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
                    InStr.READ(NSVar);
                END;




                //NSVar := NSVar +'Chr(13)Chr(10)'+'Expedien e-solutions Pvt. Ltd.';
                /*
                NSVar := 'Our presentation is very important';
                NSVar1 := 'He exceeded our expectation';
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NSVar: Text;
        InStr: InStream;
        NSVar1: Text;
        VarTxt: array[50] of Text;
        len1: Integer;
        len2: Integer;
        j: Integer;
        k: Integer;
}

