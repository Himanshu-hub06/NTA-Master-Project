page 50371 "SOF - Pending Approval List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Movement Entry";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; REC."Document No.")
                {
                    Caption = 'File No.';
                }
                field("Sender ID"; REC."Sender ID")
                {
                }
                // field("Sender Name\Designation";REC."Sender Description")
                // {
                // }
                field("Sender Section Name"; REC."Sender Section Name")
                {
                }
                field("Sending Date"; REC."Sending Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Download SOF")
            {
                Caption = 'SOF Document';
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
                    AdvAssignEntry.SETRANGE("File No.", rec."Document No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
                    AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
                    AdvAssignEntry.SETRANGE("SOF Received", TRUE);
                    IF AdvAssignEntry.FIND('-') THEN BEGIN
                        IF AdvAssignEntry."SOF File Name" <> '' THEN BEGIN
                            InvSetup.GET;
                            OldFileName := AdvAssignEntry."SOF File Name";
                            ServerFileName := InvSetup."Writ Case Write Path" + AdvAssignEntry."SOF File Name";
                            DOWNLOAD(ServerFileName, '', '', '', OldFileName);
                        END ELSE
                            ERROR('SOF document not found');
                    END;
                end;
            }
            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalCommentLine: Record "Approval Comment Line";
                begin
                    /*ApprovalCommentLine.SETRANGE("Table ID",50065);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve","Record ID to Approve");
                    PAGE.RUN(PAGE::"Approval Comments",ApprovalCommentLine);
                    */

                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approval Mgmt";
                begin
                    IF NOT CONFIRM(Text0001) THEN
                        EXIT;

                    MESSAGE('Approved successfully');

                end;
            }
            action("Send Back")
            {
                Caption = 'Send Back';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF NOT CONFIRM(Text0003) THEN
                        EXIT;
                    IF SOFAppEntry.Status <> SOFAppEntry.Status::Open THEN
                        ERROR(SendBackOnlyOpenRequestsErr);
                    IF SOFAppEntry."Approver ID" <> USERID THEN
                        ERROR(NotApproverUserErr);

                    IF SOFAppEntry."Sequence No." = 1 THEN
                        ERROR('Already on first level');

                    IF SOFAppEntry.Status = SOFAppEntry.Status::Open THEN BEGIN
                        SOFAppEntry.VALIDATE(Status, SOFAppEntry.Status::Created);
                        SOFAppEntry.MODIFY(TRUE);
                    END;

                    SOFAppEntry1.RESET;
                    SOFAppEntry1.SETRANGE("Document No.", SOFAppEntry."Document No.");
                    SOFAppEntry1.SETRANGE("Table ID", SOFAppEntry."Table ID");
                    SOFAppEntry1.SETRANGE("Sequence No.", (SOFAppEntry."Sequence No." - 1));
                    IF SOFAppEntry1.FIND('-') THEN BEGIN
                        SOFAppEntry1.VALIDATE(Status, SOFAppEntry1.Status::Open);
                        SOFAppEntry1.MODIFY;
                    END;
                    MESSAGE('Sent back successfully');
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF NOT CONFIRM(Text0002) THEN
                        EXIT;
                    SOFAppEntry.RESET;
                    SOFAppEntry.SETCURRENTKEY("Document No.", "Sequence No.");
                    SOFAppEntry.SETRANGE("Document No.", rec."Document No.");
                    IF SOFAppEntry.FIND('-') THEN BEGIN
                        REPEAT
                            SOFAppEntry.VALIDATE(Status, SOFAppEntry.Status::Rejected);
                            SOFAppEntry.MODIFY(TRUE);
                        UNTIL SOFAppEntry.NEXT = 0;
                    END;
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETCURRENTKEY("File No.");
                    WritCaseHdr.SETRANGE("File No.", rec."Document No.");
                    IF WritCaseHdr.FIND('-') THEN BEGIN
                        WritCaseHdr."SOF Status" := WritCaseHdr."SOF Status"::Reviewed;
                        WritCaseHdr.MODIFY;
                    END;
                end;
            }
            action(Open)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF rec."Document No." <> '' THEN
                        rec.OpenRecord;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetNextApprover();
    end;

    trigger OnAfterGetRecord()
    begin
        GetNextApprover();
    end;

    trigger OnOpenPage()
    begin
        rec.FILTERGROUP(2);
        // rec.SETRANGE(rec.sent), TRUE);
        rec.SETRANGE(Status, Status::Open);
        rec.SETRANGE("Receiver ID", USERID);
    end;

    var
        Text0001: Label 'Do you want to approve ?';
        Text0002: Label 'Do you want to reject ?';
        SOFAppEntry: Record "SOF Approval entry";
        SOFAppEntry1: Record "SOF Approval entry";
        WritCaseHdr: Record "Writ/Case Header";
        AdvAssignEntry: Record "Advocate Assigning Entry";
        UserSetup: Record "User Setup";
        DimVal: Record "Dimension Value";
        SOFAttacment: Text;
        InvSetup: Record "Inventory Setup";
        OldFileName: Text;
        ServerFileName: Text;
        NextApproverID: Code[50];
        NextApproverSec: Text;
        Text0003: Label 'Do you want to send back ?';
        SendBackOnlyOpenRequestsErr: Label 'You can send back only open entry. ';
        NotApproverUserErr: Label 'You are not authorize to send back.';

    local procedure GetNextApprover()
    begin
        /*SOFAppEntry.RESET;
        SOFAppEntry.SETCURRENTKEY("Document No.","Sequence No.");
        SOFAppEntry.SETRANGE("Document No.","Document No.");
        SOFAppEntry.SETRANGE("Sequence No.",("Sequence No."+1));
        SOFAppEntry.SETRANGE(Status,SOFAppEntry.Status::Created);
        IF SOFAppEntry.FIND('-') THEN BEGIN
          NextApproverID := SOFAppEntry."Approver ID";
          UserSetup.GET(NextApproverID);
          DimVal.RESET;
          DimVal.SETRANGE("Dimension Code",'SECTION');
          DimVal.SETRANGE(Code,UserSetup.Section);
          IF DimVal.FIND('-') THEN
            NextApproverSec := DimVal.Name
          ELSE
            NextApproverSec :='';
        END;
        */

    end;
}

