page 50396 "BOC File movement List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Movement Entry";
    ApplicationArea = all;


    layout

    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; REC."Document No.")
                {
                }
                field("Sender ID"; REC."Sender ID")
                {
                }

                // field("Media Subcategory";REC."Media Subcategory")
                // {
                // }
                field("Sender Description"; REC."Sender Description")
                {
                }
                field("Receiver ID"; REC."Receiver ID")
                {
                }
                field("Receiver Description"; REC."Receiver Description")
                {
                }
                // field("Receiver Committtee Code";REC."Receiver Committtee Code")
                // {
                // }
                // field("Receiver Committtee Name";REC."Receiver Committtee Name")
                // {
                // }
                field("Received Date"; REC."Received Date")
                {
                }
                field(Status; REC.Status)
                {
                }
                // field("Send Back For Correction";REC."Send Back For Correction")
                // {
                // }
                field(Received; Received)
                {
                }
                field("Created by"; REC."Created by")
                {
                }
                // field("Created Date Time";REC."Created Date Time")
                // {
                // }
                // field("Last Modified by";REC."Receiver ID""Last Modified by")
                // {
                // }
                // field("Last Modified Date Time";REC."Last Modified Date Time")
                // {
                // }
                // field(Rejected;REC.Rejected)
                // {
                // }
                // field(Approved;REC.Approved)
                // {
                // }
            }
        }
        // area(factboxes)
        // {
        //     part("File Movement Status";50160)
        //     {
        //         Caption = 'File Movement Status';
        //         SubPageLink = Document Type=FIELD(Document No.);
        //         Visible = Enable;
        //     }
        // }
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
                    // TESTFIELD("Document No.");
                    // IF ("Send Back For Correction" = "Send Back For Correction"::"4") OR ("Send Back For Correction" = "Send Back For Correction"::"5") THEN
                    //  ERROR('File process completed')
                    // ELSE
                    //OpenRecord;
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

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnOpenPage()
    begin
        // UserSetup.GET(USERID);
        // IF UserSetup."Section Approver" THEN
        //  Enable:=TRUE
        // ELSE
        //  Enable:=FALSE;
        rec.FILTERGROUP(2);
        rec.SETRANGE("Receiver ID", USERID);
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
        RedClr: Text;
}

