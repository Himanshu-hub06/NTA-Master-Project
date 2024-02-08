page 50362 "Disposed Case List"
{
    CardPageID = "Disposed Case Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "Writ/Case Header";
    SourceTableView = SORTING("File No.")
                      ORDER(Ascending)
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
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // UserSetup.GET(USERID);
        // UserSetup.SETRANGE("User Assigned", USERID);
        // IF UserSetup."Examination Code" <> '' THEN;
        // UserSetup.SETRANGE("User Exam Code", UserSetup."Examination Code");
    end;

    var

        UserSetup: Record "User Setup";
}

