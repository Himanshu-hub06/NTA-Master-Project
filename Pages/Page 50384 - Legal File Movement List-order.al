page 50384 "File Movement List-order"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Movement Entry";
    SourceTableView = SORTING("Document No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER('LEGAL'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; REC."Document No.")
                {
                    StyleExpr = RedClr;
                }
                field("Sender ID"; REC."Sender ID")
                {
                }
                field("Sender Section Name"; REC."Sender Section Name")
                {
                }
                field("Sending Date"; REC."Sending Date")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Send Back Date"; rec."Last Modified Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part("File Movement Status"; "File Movement FactBox")
            {
                ApplicationArea = All;
                Caption = 'File Movement Status';
                SubPageLink = "Document type" = FIELD("Document Type");
                Visible = Enable;
            }
            part("Supporting Documents"; "Supporting Doc Factbox")
            {
                SubPageLink = "Document Type" = FIELD("Document type");
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
                    REC.TESTFIELD("Document No.");
                    IF (rec.Status = rec.Status::"Return To Legal") OR (rec.Status = rec.Status::"Sent Back") THEN
                        ERROR('File process completed')
                    ELSE
                        ;
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
                    REC.TESTFIELD("Document No.");
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
        WritCaseHdr.SETRANGE("File No.", REC."Document No.");
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
        rec.SETRANGE(Status, Status::Open);
        rec.SETRANGE("Receiver ID", USERID);
        rec.SETRANGE("Sent For Compliance", TRUE);
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
}

