page 50365 "SOF Receive - After Creation L"
{
    CardPageID = "SOF Received - After Cre Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50207;
    SourceTableView = SORTING()
                      ORDER(Ascending)
                      WHERE("Advocate Type" = FILTER(Internal),
                           "Internal Adv. Type" = FILTER(Creator),
                            "Entry Type" = FILTER(SOF));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
                {
                    Editable = false;
                }
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                    Enabled = false;
                }
                field("Case No."; rec."Case No.")
                {
                    Enabled = false;
                }
                field(Year; rec.Year)
                {
                    Enabled = false;
                }
                field("Advocate Name"; rec."Advocate Name")
                {
                }
                field("Assigned Date"; rec."Assigned Date")
                {
                }
                field("SOF Sent"; rec."SOF Sent")
                {
                }
                field("SOF Sending Date"; rec."SOF Sending Date")
                {
                    Caption = 'SOF Sent Date';
                }
                field("SOF Received"; rec."SOF Received")
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
        rec.FILTERGROUP(2);
        rec.SETRANGE("SOF Received", FALSE);
        rec.SETRANGE(Disposed, FALSE);
        UserSetup.GET(USERID);
        //IF UserSetup."Examination Code"<>'' THEN
        //  SETRANGE("User Exam Code",UserSetup."Examination Code");
    end;

    var
        UserSetup: Record "User Setup";
}

