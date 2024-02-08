page 50340 "Approval History User Wise"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 454;

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
                field("Sender Details"; SenderDescription)
                {
                }
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
        UserTab.SETRANGE("User Name", rec."Last Modified By User ID");
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

    trigger OnOpenPage()
    begin
        rec.SETRANGE("Last Modified By User ID", USERID);
    end;

    var
        UserTab: Record "User BOC";
        SenderDescription: Text;
        ReceiverDescription: Text;
}

