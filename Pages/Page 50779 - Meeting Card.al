// page 50779 "Meeting Card"
// {
//     PageType = Card;
//     SourceTable = "Meeting Header";
//     AutoSplitKey = true;

//     layout
//     {
//         area(Content)
//         {
//             group("Meeting Header")
//             {
//                 field("Meeting No."; Rec."Meeting No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Meeting Date"; Rec."Meeting Date")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Meeting Type"; Rec."Meeting Type")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Meeting Time"; Rec."Meeting Time")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Venue; Rec.Venue)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Agenda; Rec.Agenda)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = All;

//                 }


//             }
//             // part(MeetingLine; "Meeting ListPart")
//             // {
//             //     SubPageLink = "Application No." = field("Meeting No.");
//             //     ApplicationArea = all;
//             // }

//         }
//     }

//     // actions
//     // {
//     //     area(processing)
//     //     {
//     //         action("Send Approval Request")
//     //         {
//     //             Caption = 'Send Approval Request';
//     //             Image = SendTo;
//     //             Promoted = true;
//     //             PromotedCategory = Process;
//     //             PromotedOnly = true;
//     //             ApplicationArea = all;
//     //             Visible = Vis001;
//     //             trigger OnAction()
//     //             begin

//     //                 NTASetup.Get();
//     //                 SelctedUser := '';
//     //                 // IF Rec.Receiver_ID <> USERID THEN
//     //                 //     ERROR('You can not Forward it due to user ID mismatch');
//     //                 CurrPage.SetSelectionFilter(Glbudet1);
//     //                 AppUserMem.RESET();
//     //                 AppUserMem.FILTERGROUP(2);
//     //                 AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
//     //                 AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
//     //                 AppUserMem.SETFILTER("User ID", '<>%1', USERID);
//     //                 IF AppUserMem.FindFirst() then
//     //                     IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN
//     //                         SelctedUser := AppUserMem."User ID";
//     //                 SequenceNo := AppUserMem."Sequence No.";
//     //                 IF SelctedUser = '' THEN
//     //                     EXIT;

//     //                 IF NOT CONFIRM('Do you want to send approval request to %1?', FALSE, SelctedUser) THEN
//     //                     EXIT;
//     //                 AppEntInit.RESET;
//     //                 // AppEntInit.SETRANGE("Document No.", Rec."Meeting No.");
//     //                 AppEntInit.SetRange("Approver ID", UserId);
//     //                 AppEntInit.SetRange(Status, AppEntInit.Status::Open);
//     //                 IF AppEntInit.FindFirst() THEN BEGIN
//     //                     AppEntInit.Status := AppEntInit.Status::Forwarded;
//     //                     AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
//     //                     AppEntInit."Last Modified By User ID" := USERID;
//     //                     AppEntInit.MODIFY;
//     //                 END;
//     //                 InsertApprovalEntry();
//     //                 GLBudget.RESET;
//     //                 GLBudget.SETRANGE(GLBudget.Name, Rec.Name);
//     //                 IF GLBudget.FINDFIRST THEN BEGIN
//     //                     GLBudget.Sender_ID := UserID;
//     //                     GLBudget.Receiver_ID := SelctedUser;
//     //                     GLBudget.Status := GLBudget.Status::"Pending Approval";
//     //                     IF GLBudget.MODIFY THEN
//     //                         MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
//     //                     // CurrPage.CLOSE;
//     //                 END;
//     //             end;
//     //         }
//     //         action(Approve)
//     //         {
//     //             Image = Approve;
//     //             Promoted = true;
//     //             PromotedCategory = Process;
//     //             ApplicationArea = All;
//     //             Visible = Vis002; //rk

//     //             trigger OnAction()
//     //             begin
//     //                 IF Rec.Receiver_ID <> USERID THEN
//     //                     ERROR('You are not allowed to approve, due to user ID mismatch');
//     //                 if not Confirm('Do you want to Approve.?') then
//     //                     exit;

//     //                 NTASetup.Get();
//     //                 AppUserMem.RESET;
//     //                 AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
//     //                 AppUserMem.SETRANGE("User ID", UserId);
//     //                 AppUserMem.SETRANGE("Approval Permission", TRUE);
//     //                 IF AppUserMem.FIND('-') THEN BEGIN
//     //                     // FILTERGROUP(10);
//     //                     AppEntInit.RESET;
//     //                     AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
//     //                     AppEntInit.SETRANGE("Document No.", rec.Name);
//     //                     IF AppEntInit.FINDLAST THEN BEGIN
//     //                         AppEntInit.Status := AppEntInit.Status::Approved;
//     //                         AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
//     //                         AppEntInit."Last Modified By User ID" := USERID;
//     //                         AppEntInit.MODIFY;
//     //                     END;
//     //                     Metting.RESET;
//     //                     Metting.SETRANGE(GLBudget.Name, rec.Name);
//     //                     IF Metting.FINDFIRST THEN BEGIN
//     //                         GLBudget.Status := GLBudget.Status::Approved;
//     //                         GLBudget.Sender_ID := USERID;
//     //                         GLBudget.Receiver_ID := SelctedUser;
//     //                         GLBudget.Blocked := true;
//     //                         IF GLBudget.MODIFY THEN
//     //                             MESSAGE('Application has been successfully Approved!');
//     //                         // CurrPage.CLOSE;
//     //                     END;
//     //                     // FILTERGROUP(0);
//     //                     //CurrPage.Close();
//     //                 END
//     //             end;
//     //         }
//     //         action(Reject)
//     //         {
//     //             ApplicationArea = All;
//     //             Image = Reject;
//     //             Promoted = true;
//     //             PromotedCategory = Process;
//     //             Visible = Vis002;//rk
//     //             trigger OnAction()
//     //             begin
//     //                 IF rec.Receiver_ID <> USERID THEN
//     //                     ERROR('You are not allowed to reject, due to user ID mismatch');

//     //                 if not Confirm('Do you want to Reject.?') then
//     //                     exit;

//     //                 // FILTERGROUP(10);
//     //                 AppEntInit.RESET;
//     //                 AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
//     //                 AppEntInit.SETRANGE("Document No.", Rec.Name);
//     //                 if AppEntInit.FINDLAST THEN BEGIN
//     //                     AppEntInit.Status := AppEntInit.Status::Rejected;
//     //                     AppEntInit."Date-Time Sent for Approval" := CURRENTDATETIME;
//     //                     AppEntInit."Last Modified By User ID" := USERID;
//     //                     AppEntInit.MODIFY;
//     //                 END;
//     //                 Metting.RESET;
//     //                 Metting.SETRANGE(Metting.Name, rec.Name);
//     //                 IF Metting.FINDFIRST THEN BEGIN
//     //                     Metting.Status := Metting.Status::Rejected;
//     //                     Metting.Sender_ID := USERID;
//     //                     Metting.Receiver_ID := SelctedUser;
//     //                     IF Metting.MODIFY THEN
//     //                         MESSAGE('Application request has been rejected!!');
//     //                     CurrPage.CLOSE;
//     //                 END;
//     //                 // FILTERGROUP(0);
//     //                 //CurrPage.Close();
//     //             END;
//     //         }


//     //     }
//     // }
//     // trigger OnAfterGetRecord()
//     // var
//     //     myInt: Integer;
//     // begin
//     //     if rec.status = rec.status::Open then begin
//     //         Vis001 := true;
//     //         Vis002 := false;
//     //     end;
//     //     if rec.status = rec.status::Open then begin
//     //         NTASetup.Get;
//     //         AppUserMem.Reset();
//     //         AppUserMem.SetRange("Approval User Group Code", NTASetup."Budget Approval code");
//     //         AppUserMem.SetRange("User ID", UserId);
//     //         AppUserMem.SetRange("Approval Permission", true);
//     //         if AppUserMem.Find('-') then begin
//     //             Vis001 := false;
//     //             Vis002 := false;
//     //         end;
//     //     end;

//     //     IF (rec.Status = rec.Status::"Pending Approval") then begin
//     //         NTASetup.GET;
//     //         AppUserMem.RESET;
//     //         AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
//     //         AppUserMem.SETRANGE("User ID", USERID);
//     //         AppUserMem.SETRANGE("Approval Permission", TRUE);
//     //         IF AppUserMem.FIND('-') THEN BEGIN
//     //             Vis002 := TRUE;
//     //             Vis001 := false;
//     //         END
//     //         ELSE BEGIN
//     //             // Vis002 := FALSE;
//     //             // Vis001 := false;
//     //         END;
//     //     end;
//     //     IF (rec.Status = rec.Status::Approved) OR (rec.Status = rec.Status::Rejected) THEN BEGIN
//     //         Vis001 := FALSE;
//     //         Vis002 := FALSE;
//     //         Edit001 := false;
//     //         EnabledBtn1 := false;
//     //     END
//     //     ELSE BEGIN
//     //         Edit001 := true;
//     //         EnabledBtn1 := true;
//     //     END;

//     // end;


//     // var
//     //     NTASetup: Record "NTA Bill Setup";
//     //     AppUserMem: Record "Approval User Group Member";
//     //     AppEntInit: Record "Approval Entry";
//     //     SelctedUser: code[20];
//     //     SequenceNo: Integer;

//     //     Metting, Metting1 : Record "Meeting Header";
//     //     Vis001, Vis002, Edit001, EnabledBtn1 : Boolean;
//     //     edite: Boolean;

//     //     editwar: Boolean;



//     // local procedure InsertApprovalEntry()
//     // var
//     //     ApproverId: Code[20];
//     //     ApprovalEntryRec: Record 454;
//     //     EntryNo: Integer;

//     // begin

//     //     ApprovalEntryRec.RESET;
//     //     IF ApprovalEntryRec.FINDLAST THEN
//     //         EntryNo := ApprovalEntryRec."Entry No.";
//     //     ApprovalEntryRec.RESET;
//     //     ApprovalEntryRec."Table ID" := 95;
//     //     ApprovalEntryRec."Sequence No." := 1;
//     //     // ApprovalEntryRec."Document No." := Rec.Name;   //eXPROHIT
//     //     ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Budget;
//     //     ApprovalEntryRec."Entry No." := EntryNo + 1;
//     //     ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
//     //     ApprovalEntryRec."Sender ID" := USERID;
//     //     ApprovalEntryRec."Approver ID" := SelctedUser;
//     //     ApprovalEntryRec."Shortcut Dimension 2 Code" := 'S01';
//     //     ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
//     //     ApprovalEntryRec."Last Modified By User ID" := USERID;
//     //     ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
//     //     ApprovalEntryRec."Record ID to Approve" := Metting1.RECORDID;
//     //     ApprovalEntryRec.INSERT;


//     // end;



//     // trigger OnOpenPage()
//     // var
//     //     StatusL: Text;
//     // begin
//     // end;

//     // var
//     //     SinglCU: Codeunit 50012;

// }