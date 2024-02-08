codeunit 50002 "InsertApprovalEntry"
{
    procedure InsertApprovalEntry(TabID: Integer; DocType: Option; DocNo: Code[20]; ApproverID: Code[20]; RecIDToApprove: RecordID)
    var
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
    begin
        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.RESET;
        ApprovalEntryRec."Table ID" := TabID;
        ApprovalEntryRec."Document No." := DocNo;
        ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Quote;
        ApprovalEntryRec."Entry No." := EntryNo + 1;
        ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
        ApprovalEntryRec."Sender ID" := USERID;
        ApprovalEntryRec."Approver ID" := ApproverID;
        ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
        ApprovalEntryRec."Last Modified By User ID" := USERID;
        ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
        ApprovalEntryRec."Record ID to Approve" := RecIDToApprove;
        ApprovalEntryRec.INSERT;
    end;

    //     local procedure CheckTABillApprovalsWorkflowEnabled(VAR TABillHdr : Record "TA Bill Header") : Boolean
    //     var

    // NoWorkflowEnabledErr: Label	'This record is not supported by related approval workflow';
    //     begin
    //        IF NOT IsTABillApprovalsWorkflowEnabled(TABillHdr) THEN                                               
    //   ERROR(NoWorkflowEnabledErr);

    // EXIT(TRUE); 
    //     end;


    //     local procedure IsTABillApprovalsWorkflowEnabled(VAR TABillHdr : Record "TA Bill Header") : Boolean
    //     var
    //         WorkflowManagement: codeunit "Workflow Management" ;
    //         WorkflowEventHandling: Codeunit "Workflow Event Handling";
    //     begin
    //         EXIT(WorkflowManagement.CanExecuteWorkflow(TABillHdr,WorkflowEventHandling.RunWorkflowOnSendTABillforApprovalCode));
    //     end;

}