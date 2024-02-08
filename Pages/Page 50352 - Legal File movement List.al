page 50352 "Legal File movement List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Movement Entry";
    SourceTableView = SORTING("Document No.", "Sender ID", "Sending Date")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Legal));


    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("Document No."; rec."Document No.")
                {
                    StyleExpr = RedClr;
                }
                field("Sender ID"; rec."Sender ID")
                {
                }
                field("User Name\Designation"; rec."Sender Description")
                {
                    Editable = false;
                }
                field("Sender Section Name"; rec."Sender Section Name")
                {
                }
                field("Sending Date"; rec."Sending Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part("File Movement Status"; 50399)
            {
                Caption = 'File Movement Status';
                SubPageLink = "Document No." = FIELD("Document No.");
                Visible = Enable;
            }
            part("Supporting Documents"; 50398)
            {
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.TESTFIELD("Document No.");
                    rec.OpenRecord;
                end;
            }
            action(Receive)
            {
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    rec.TESTFIELD("Document No.");
                    IF Received THEN
                        ERROR(Text002);
                    IF NOT CONFIRM(Text001) THEN
                        EXIT;
                    rec.Status := rec.Status::"Assigned To Section";
                    rec."Received Date" := TODAY;
                    Received := TRUE;
                    rec.MODIFY;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RedClr := '';
        WritCaseHdr.RESET;
        WritCaseHdr.SETRANGE("File No.", rec."Document No.");
        IF WritCaseHdr.FIND('-') THEN
            IF WritCaseHdr.Priority = WritCaseHdr.Priority::High THEN
                RedClr := 'Unfavorable'
            ELSE
                RedClr := '';
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Section Approver" THEN
            Enable := TRUE
        ELSE
            Enable := FALSE;
        rec.FILTERGROUP(2);
        rec.SETRANGE("Receiver ID", USERID);
        //SETRANGE("Receiver Section",UserSetup.Section);
        rec.SETRANGE("Sent For SOF", TRUE);
        rec.SETRANGE("Current User", USERID);
        rec.SETRANGE(Status, Status::Open);
        rec.FILTERGROUP(0);
    end;

    var
        UserSetup: Record "User Setup";
        Text001: Label 'Do you want to receive file.?';
        Text002: Label 'File already received.';
        Received: Boolean;
        StatusOpen: Boolean;
        Text003: Label 'File not received.';
        Enable: Boolean;
        WritCaseHdr: Record "Writ/Case Header";
        RedClr: Text;
        UserDesignation: Text[150];
        UserTab: Record "User BOC";
}

