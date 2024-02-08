page 50366 "SOF Receive - After Review L"
{
    CardPageID = "SOF Received - After Rev Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Advocate Assigning Entry";
    SourceTableView = SORTING("File No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Advocate Type" = FILTER(Internal), "Entry Type" = FILTER(SOF), "Internal Adv. Type" = filter(Reviewer));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
                {
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

    // trigger OnOpenPage()
    // begin

    //      FILTERGROUP(2);
    //      SETRANGE("SOF Received", FALSE);
    //      SETRANGE(Disposed, FALSE);
    //      UserSetup.GET(USERID);

    // end;

    var
        UserSetup: Record "User Setup";
}

