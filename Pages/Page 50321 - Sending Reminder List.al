page 50321 "Sending Reminder List"
{
    CardPageID = "Sending Reminder Card";
    PageType = List;
    SourceTable = "Reminder Entry";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reminder No."; REC."Reminder No.")
                {
                }
                field("Document No."; REC."Document No.")
                {
                    Caption = 'File No.';
                }
                field("Receiver ID"; REC."Receiver ID")
                {
                }
                field("Receiver Description"; REC."Receiver Description")
                {
                    Caption = 'Receiver Name\Designation';
                }
                field(Sent; REC.Sent)
                {
                }
                field("Sent Date Time"; REC."Sent Date Time")
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
        REC.SETRANGE("Created By", USERID);
    end;
}

