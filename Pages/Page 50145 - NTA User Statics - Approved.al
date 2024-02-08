// page 50145 "NTA User Statics - Approved"
// {
//     PageType = CardPart;
//     SourceTable = Table454;

//     layout
//     {
//         area(content)
//         {
//             cuegroup()
//             {
//                 field(PendingBill;CountPendingBill)
//                 {
//                     Caption = 'Pending For Approval';

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field(TotApproved;CountApprovedBill)
//                 {
//                     Caption = 'Approved';
//                     Editable = false;

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.UPDATE;
//                         /*TotalApproved:=0;
//                         ApprovalEntry.RESET;
//                         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Approved);
//                         ApprovalEntry.SETRANGE("Bill Type",ApprovalEntry."Bill Type"::"TA/DA Bill");
//                         ApprovalEntry.SETRANGE("Approver ID",USERID);
//                         ApprovalEntry.SETFILTER("Sequence No.",'=%1',1);
//                         PAGE.RUNMODAL(50144,ApprovalEntry);
//                         */

//                     end;
//                 }
//                 field(TotRejected;CountRejectedBill)
//                 {
//                     Caption = 'Rejected';

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field(TotReques;TotalApproved+TotalPendingApproval+TotalRejected)
//                 {
//                     Caption = 'Total Received';
//                     Editable = false;

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
//         TaBillHdr: Record "50005";
//         ApprovalEntry: Record "454";
//         TotalRequestForApproval: Integer;
//         TotalApproved: Integer;
//         TotalPendingApproval: Integer;
//         TotalRejected: Integer;

//     local procedure CountRequestBill(): Integer
//     begin
//         TotalRequestForApproval:=0;
//         ApprovalEntry.RESET;
//         ApprovalEntry.SETRANGE("Bill Type",ApprovalEntry."Bill Type"::"TA/DA Bill");
//         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
//         ApprovalEntry.SETRANGE("Approver ID",USERID);
//         ApprovalEntry.SETFILTER("Sequence No.",'>%1',1);
//         IF ApprovalEntry.FIND('-') THEN
//           REPEAT
//             TotalRequestForApproval := TotalRequestForApproval + 1;
//           UNTIL ApprovalEntry.NEXT=0;
//         EXIT(TotalRequestForApproval);
//     end;

//     local procedure CountApprovedBill(): Integer
//     begin
//         TotalApproved:=0;
//         ApprovalEntry.RESET;
//         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Approved);
//         ApprovalEntry.SETRANGE("Bill Type",ApprovalEntry."Bill Type"::"TA/DA Bill");
//         ApprovalEntry.SETRANGE("Approver ID",USERID);
//         ApprovalEntry.SETFILTER("Sequence No.",'>%1',1);
//         IF ApprovalEntry.FIND('-') THEN
//           REPEAT
//             TotalApproved := TotalApproved + 1;
//           UNTIL ApprovalEntry.NEXT=0;
//         EXIT(TotalApproved);

//     end;

//     local procedure CountPendingBill(): Integer
//     begin
//         TotalPendingApproval:=0;
//         ApprovalEntry.RESET;
//         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
//         ApprovalEntry.SETRANGE("Bill Type",ApprovalEntry."Bill Type"::"TA/DA Bill");
//         ApprovalEntry.SETRANGE("Approver ID",USERID);
//         ApprovalEntry.SETFILTER("Sequence No.",'>%1',1);
//         IF ApprovalEntry.FIND('-') THEN
//           REPEAT
//             TotalPendingApproval := TotalPendingApproval + 1;
//           UNTIL ApprovalEntry.NEXT=0;
//         EXIT(TotalPendingApproval);
//     end;

//     local procedure CountRejectedBill(): Integer
//     begin
//         TotalRejected:=0;
//         ApprovalEntry.RESET;
//         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Rejected);
//         ApprovalEntry.SETRANGE("Bill Type",ApprovalEntry."Bill Type"::"TA/DA Bill");
//         ApprovalEntry.SETRANGE("Approver ID",USERID);
//         ApprovalEntry.SETFILTER("Sequence No.",'>%1',1);
//         IF ApprovalEntry.FIND('-') THEN
//           REPEAT
//             TotalRejected := TotalRejected + 1;
//           UNTIL ApprovalEntry.NEXT=0;
//         EXIT(TotalRejected);

//     end;
// }

