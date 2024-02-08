// page 50143 "NTA User Statics"
// {
//     PageType = CardPart;
//     SourceTable = "TA Bill Header";
//     ApplicationArea = all;

//     layout
//     {
//         area(content)
//         {
//             cuegroup("For Submitted Bills")
//             {
//                 field("Submitted Bills"; CountSubmittedBill)
//                 {
//                     Caption = 'Total Bills';
//                     Editable = false;

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field(SendForApproval; CountSendForApproval)
//                 {
//                     Caption = 'Sent for Approval';
//                     Editable = false;

//                     trigger OnDrillDown()
//                     begin
//                         TotalSendForApproval := 0;
//                         ApprovalEntry.RESET;
//                         ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
//                         ApprovalEntry.SETRANGE("Bill Type", ApprovalEntry."Bill Type"::"TA/DA Bill");
//                         ApprovalEntry.SETRANGE("Approver ID", USERID);
//                         ApprovalEntry.SETFILTER("Sequence No.", '=%1', 1);
//                         PAGE.RUN(50144, ApprovalEntry);
//                     end;
//                 }
//                 field(OpenBill; CountOpenBill)
//                 {
//                     Caption = 'Open Bills';
//                     DrillDown = true;

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.UPDATE;
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         TaBillHdr: Record "TA Bill Header";
//         ApprovalEntry: Record "Approval Entry";
//         TotalOpenBill: Integer;
//         TotalSendForApproval: Integer;
//         TotalSubmittedBill: Integer;

//     local procedure CountSubmittedBill(): Integer
//     begin
//         TotalSubmittedBill := 0;
//         TaBillHdr.RESET;
//         TaBillHdr.SETRANGE(Submitted, TRUE);
//         TaBillHdr.SETRANGE("First Level User", USERID);
//         IF TaBillHdr.FIND('-') THEN
//             REPEAT
//                 TotalSubmittedBill := TotalSubmittedBill + 1;
//             UNTIL TaBillHdr.NEXT = 0;
//         EXIT(TotalSubmittedBill);
//     end;

//     local procedure CountSendForApproval(): Integer
//     begin
//         TotalSendForApproval := 0;
//         ApprovalEntry.RESET;
//         ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
//         ApprovalEntry.SETRANGE("Bill Type", ApprovalEntry."Bill Type"::"TA/DA Bill");
//         ApprovalEntry.SETRANGE("Approver ID", USERID);
//         ApprovalEntry.SETFILTER("Sequence No.", '=%1', 1);
//         IF ApprovalEntry.FIND('-') THEN
//             REPEAT
//                 TotalSendForApproval := TotalSendForApproval + 1;
//             UNTIL ApprovalEntry.NEXT = 0;
//         EXIT(TotalSendForApproval)

//     end;

//     local procedure CountOpenBill(): Integer
//     begin
//         TotalOpenBill := 0;
//         TaBillHdr.RESET;
//         TaBillHdr.SETRANGE(Submitted, TRUE);
//         TaBillHdr.SETRANGE(Status, TaBillHdr.Status::Open);
//         TaBillHdr.SETRANGE("First Level User", USERID);
//         IF TaBillHdr.FIND('-') THEN
//             REPEAT
//                 TotalOpenBill := TotalOpenBill + 1;
//             UNTIL TaBillHdr.NEXT = 0;
//         EXIT(TotalOpenBill);
//     end;
// }

