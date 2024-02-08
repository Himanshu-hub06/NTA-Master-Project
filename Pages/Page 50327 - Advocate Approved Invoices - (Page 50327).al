// page 50327 "Advocate Approved Invoices"
// {
//     Caption = 'Service Invoices';
//     CardPageID = "Advocate Approved Invoice";
//     Editable = false;
//     PageType = List;
//     SourceTable = 38;
//     SourceTableView = WHERE("Document Type" = CONST(Invoice),
//                             Status = CONST(Released));

//     layout
//     {
//         area(content)
//         {
//             repeater(Placeholder)
//             {
//                 field("No."; rec."No.")
//                 {
//                     Width = 15;
//                 }
//                 field("Vendor No."; rec."Buy-from Vendor No.")
//                 {
//                     Caption = 'Advocate  No.';
//                 }
//                 field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
//                 {
//                     Caption = 'Advocate Name';
//                 }
//                 field("Buy-from Contact"; rec."Buy-from Contact")
//                 {
//                     Caption = 'Advocate  Contact';
//                     Visible = false;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     Visible = true;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     Visible = true;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     Visible = true;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     Visible = true;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//             }
//             part(MyPart; "Vendor Details FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No."),
//                               "Date Filter" = FIELD("Date Filter");
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Invoice")
//             {
//                 Caption = '&Invoice';
//                 Image = Invoice;
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         rec.CalcInvDiscForHeader;
//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Purch. Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                  "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                     Visible = false;
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         rec.ShowDocDim;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Approval History")
//                 {
//                     Caption = 'Approval History';
//                     Image = Hierarchy;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         ApprovalEntry.RESET;
//                         ApprovalEntry.FILTERGROUP(2);
//                         ApprovalEntry.SetRange("Document No.", rec."No.");
//                         PAGE.RUNMODAL(PAGE::"Approval History", ApprovalEntry);
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Releasing)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     ShortCutKey = 'Ctrl+F9';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = "Action";
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approval Mgmt";
//                     begin
//HYC 250923
//  IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
// ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approval Mgmt";
//                     begin
//HYC 250923
//ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     Caption = 'P&ost';
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action(TestReport)
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action(PostAndPrint)
//                 {
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action(PostBatch)
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action(RemoveFromJobQueue)
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         rec.CancelBackgroundPosting;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         SetControlAppearance;
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//     "Vendor Invoice Type" := "Vendor Invoice Type"::Legal;
//     end;

//     trigger OnOpenPage()
//     var
//         PurchasesPayablesSetup: Record 312;
//     begin
//         UserSetup.GET(USERID);
//         IF UserSetup."Allow all Location" = FALSE THEN
//SETRANGE("Shortcut Dimension 2 Code",UserSetup.Section);
//             rec.SetSecurityFilterOnRespCenter;

//         JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
//HYC 250923
//SETFILTER("Vendor Type", '%1|%2|%3', "Vendor Type"::"Internal Advocate", "Vendor Type"::"External Advocate", "Vendor Type"::"Advocate Clerk");
//     end;

//     var
//         ReportPrint: Codeunit 228;
//         [InDataSet]
//         JobQueueActive: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         UserSetup: Record 91;
//         ApprovalEntry: Record 454;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit "Approval Mgmt";
//     begin
//HYC 250923
// OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
//     end;
// }

