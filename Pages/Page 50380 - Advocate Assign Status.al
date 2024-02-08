page 50380 "Advocate Assign Status"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50207;
    SourceTableView = SORTING("File No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Active = FILTER('Yes'),
                           "Entry Type" = FILTER("Case Assign"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
                {
                }
                field("Advocate Code"; rec."Advocate Code")
                {
                }
                field("Advocate Name"; rec."Advocate Name")
                {
                }
                field("Advocate Type"; rec."Advocate Type")
                {
                }
                field("Internal Adv. Type"; rec."Internal Adv. Type")
                {
                }
                field("Assigned Date"; rec."Assigned Date")
                {
                }
                field(Remarks; rec.Remarks)
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
        UserSetup.GET(USERID);
        rec.FILTERGROUP(2);
        // IF UserSetup."Examination Code" <> '' THEN
        //  SETRANGE("User Exam Code",UserSetup."Examination Code");
    end;

    var
        UserSetup: Record "User Setup";
}

