// page 50663 "Pending Payment Proposals"
// {
//     Caption = 'Purchase Invoices';
//     // CardPageID = "Pending Payment Proposal";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = 38;
//     SourceTableView = WHERE("Document Type" = CONST('Invoice'),
//                             "Payment Proposal Created" = CONST(True),
//                             "Proposal Status" = CONST("Pending Approval"));

//     layout
//     {
//         area(content)
//         {
//             repeater(repeater1)
//             {
//                 field("No."; Rec."No.")
//                 {
//                 }
//                 field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
//                 {
//                 }
//                 field("Buy-from Vendor Name"; "Buy-from Vendor Name")
//                 {
//                 }
//                 field("Buy-from Post Code"; "Buy-from Post Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Buy-from Country/Region Code"; "Buy-from Country/Region Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Location Code"; "Location Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Document Date"; "Document Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Proposal Status"; "Proposal Status")
//                 {
//                     Visible = false;
//                 }
//                 field("Old File No."; "Old File No.")
//                 {
//                 }
//                 field("e-office File No."; "e-office File No.")
//                 {
//                 }
//                 field("Pending To User ID"; "Pending To User ID")
//                 {
//                 }
//                 field("Pending To User Name"; "Pending To User Name")
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//             }
//             part("9093"; 9093)
//             {
//                 Caption = 'Vendor Details';
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No."),
//                               "Date Filter" = FIELD("Date Filter");
//                 Visible = true;
//             }
//             systempart(; Links)
//             {
//                 Visible = false;
//             }
//             systempart(; Notes)
//             {
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
//                         CalcInvDiscForHeader;
//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 66;
//                     RunPageLink = Document Type=FIELD(Document Type),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348=R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "658";
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Release)
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
//                         ReleasePurchDoc: Codeunit "415";
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
//                         ReleasePurchDoc: Codeunit "415";
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
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
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
//                         SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit "91";
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action(TestReport)
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
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
//                         SendToPosting(CODEUNIT::"Purch.-Post + Print");
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
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices",TRUE,TRUE,Rec);
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
//                         CancelBackgroundPosting;
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

//     trigger OnOpenPage()
//     var
//         PurchasesPayablesSetup: Record "312";
//     begin
//         SetSecurityFilterOnRespCenter;

//         JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
//     end;

//     var
//         ReportPrint: Codeunit "228";
//         [InDataSet]
//         JobQueueActive: Boolean;
//         OpenApprovalEntriesExist: Boolean;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit "1535";
//     begin
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;
// }

