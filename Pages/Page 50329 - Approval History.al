page 50329 "Approval History"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approval Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                }
                field("Sender ID"; rec."Last Modified By User ID")
                {
                    Caption = 'Sender ID';
                }
                // field("Sender Details";rec.SenderDescription)
                // {
                // }
                field("Last Date-Time Modified"; rec."Last Date-Time Modified")
                {
                    Caption = 'Sending Date & Time';
                }
                field("Approver ID"; rec."Approver ID")
                {
                    Caption = 'Receiver ID';
                }
                field("Receiver Details"; ReceiverDescription)
                {
                }
                field(Status; rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        UserTab.RESET;
        UserTab.SETRANGE("User Name", Rec."Last Modified By User ID");
        IF UserTab.FIND('-') THEN
            SenderDescription := UserTab."Full Name"
        ELSE
            SenderDescription := '';

        UserTab.RESET;
        UserTab.SETRANGE("User Name", rec."Approver ID");
        IF UserTab.FIND('-') THEN
            ReceiverDescription := UserTab."Full Name"
        ELSE
            ReceiverDescription := '';
    end;

    var
        UserTab: Record "user";
        SenderDescription: Text;
        ReceiverDescription: Text;
}

