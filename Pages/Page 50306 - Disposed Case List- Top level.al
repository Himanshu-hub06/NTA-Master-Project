page 50306 "Disposed Case List- Top level"
{
    Caption = 'Disposed Case List';
    CardPageID = "Disposed Case Card - Top level";   //ppc
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Writ/Case Header";
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
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
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
        rec.FILTERGROUP(2);
        rec.SETRANGE("User Assigned", USERID);
        //IF UserSetup."Examination Code" <> '' THEN
        rec.SETRANGE("User Exam Code", UserSetup."Examination Code");
        IF rec.FINDFIRST THEN;
    end;

    var
        UserSetup: Record "User Setup";
}

