page 50389 "Disposed Case List  First Leve"
{
    Caption = 'Disposed Case List';
    //CardPageID = 50364;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50203;
    SourceTableView = SORTING("Origin Date")
                      ORDER(Descending)
                      WHERE(Disposed = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
                {
                }
                field("Case Type"; rec."Case Type")
                {
                }
                field("Case No."; rec."Case No.")
                {
                }
                field(Year; rec.Year)
                {
                }
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                }
                field("Case Filing Date"; rec."Case Filing Date")
                {
                }
                field("Date Of Writ"; rec."Date Of Writ")
                {
                }
                field(Priority; rec.Priority)
                {
                }
                field(Status; rec.Status)
                {
                }
                field(Disposed; rec.Disposed)
                {
                }
                field("Disposed Date"; rec."Disposed Date")
                {
                }
                field("User Assigned"; rec."User Assigned")
                {
                }
                field("Assigned User Name"; rec."Assigned User Name")
                {
                    Enabled = false;
                }
            }
            group("Count Filter")
            {
                Caption = '*';

                Visible = true;
                field(COUNT; rec.COUNT)
                {
                    Caption = 'Total No. Of Records';
                    ColumnSpan = 3;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        rec.SETRANGE(rec."User Assigned", USERID);
        //IF UserSetup."Examination Code" <> '' THEN
        //  SETRANGE("User Exam Code",UserSetup."Examination Code");
        IF rec.FINDFIRST THEN;
    end;

    var
        UserSetup: Record "User Setup";
}

