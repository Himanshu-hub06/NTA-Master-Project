page 50359 "Legal File In-Out List"
{
    Caption = 'File Movement Status';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "File Movement Entry";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Descending)
                      WHERE("Document Type" = FILTER('Legal'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; REC."Document No.")
                {
                    Caption = 'File No.';
                    Width = 15;
                }
                field("Name Of Petitioner"; PetitionerName)
                {
                    Enabled = false;
                }
                field("Sender ID"; REC."Sender ID")
                {
                }
                field("Sender Name\Designation"; REC."Sender Description")
                {
                    Editable = false;
                    Enabled = false;
                }
                // field("Sender Section Name"; sen)
                // {
                // }
                // field("Sending Date"; REC."Sending Date")
                // {
                // }
                field("Receiver ID"; REC."Receiver ID")
                {
                }
                field("Receiver Name\Designation"; REC."Receiver Description")
                {
                    Editable = false;
                    Enabled = false;
                }
                // field("Receiver Section Name"; REC."Receiver Section Name")
                // {
                // }
                field(Status; REC.Status)
                {
                    Visible = true;
                }
                // field("Forwarded Date"; REC."Last Modified Date")
                // {
                // }
                // field("Current User"; rec."Current User")
                // {
                //     Editable = false;
                // }
                // field("Current User Name"; REC."Current User Name")
                // {
                //     Enabled = false;
                // }
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
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE("File No.", REC."Document No.");
                    IF WritCaseHdr.FIND('-') THEN
                        PAGE.RUN(50411, WritCaseHdr);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);

    end;

    var
        UserSetup: Record "User Setup";
        Text001: Label 'Do you want to receive file.?';
        Text002: Label 'File already received.';
        Received: Boolean;
        StatusOpen: Boolean;
        Text003: Label 'File not received.';
        WritCaseHdr: Record "Writ/Case Header";
        PetitionerName: Text[100];
}

