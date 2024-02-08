page 50312 "Legal Reminder List"
{
    CardPageID = "Legal Reminder Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Sender ID"; REC."Sender ID")
                {
                }
                field("Sender Description"; REC."Sender Description")
                {
                    Caption = 'Sender Name\Designation';
                }
                field("Sender Section Code"; REC."Sender Section Code")
                {
                }
                field("Receiver ID"; REC."Receiver ID")
                {
                }
                field("Receiver Description"; REC."Receiver Description")
                {
                    Caption = 'Receiver Name\Designation';
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
        REC.SETRANGE(Sent, TRUE);

    end;
}

