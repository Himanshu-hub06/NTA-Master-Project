page 50341 "Approval History User"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approval Entry";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout

    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; REC."Document No.")
                {
                }
                field("Sender ID"; REC."Last Modified By User ID")
                {
                    Caption = 'Sender ID';
                }
                field("Sender Details"; SenderDescription)
                {
                }
                field("Last Date-Time Modified"; REC."Last Date-Time Modified")
                {
                    Caption = 'Sending Date & Time';
                }
                field("Approver ID"; REC."Approver ID")
                {
                    Caption = 'Receiver ID';
                }
                field("Receiver Details"; ReceiverDescription)
                {
                }
                field(Status; REC.Status)
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
        UserTab.SETRANGE("User Name", REC."Last Modified By User ID");
        IF UserTab.FIND('-') THEN
            SenderDescription := UserTab."Full Name"
        ELSE
            SenderDescription := '';

        UserTab.RESET;
        UserTab.SETRANGE("User Name", REC."Approver ID");
        IF UserTab.FIND('-') THEN
            ReceiverDescription := UserTab."Full Name"
        ELSE
            ReceiverDescription := '';
    end;

    trigger OnOpenPage()
    begin
        REC.SETRANGE("Approver ID", USERID);

        //DSC
        REC.SETFILTER(Status, '%1|%2', REC.Status::Approved, rec.Status::Forwarded)
    end;

    var
        //UserTab: Record "2000000120";
        UserTab: Record "User BOC";
        SenderDescription: Text;
        ReceiverDescription: Text;
}

