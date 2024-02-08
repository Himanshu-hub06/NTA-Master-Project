// page 50325 "Advocate Pending Invoices"
// {
//     Caption = 'Service Invoices';
//     CardPageID = "Advocate Pending Invoice";

//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Editable = false;
//     PageType = List;
//     SourceTable = "Purchase Header";
//     SourceTableView = WHERE("Document Type" = CONST(Invoice),
//                             Status = CONST("Pending Approval"));

//     layout
//     {
//         area(content)
//         {

//             //repeater()

//             field("No."; rec."No.")
//             {
//                 Width = 15;
//             }
//             field("Vendor No."; rec."Buy-from Vendor No.")
//             {
//                 Caption = 'Advocate No.';
//             }
//             field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
//             {
//                 Caption = 'Advocate Name';
//             }
//             field("Buy-from Contact"; rec."Buy-from Contact")
//             {
//                 Caption = 'Advocate Contact';
//                 Visible = false;
//             }
//             field("Document Date"; rec."Document Date")
//             {
//                 Visible = true;
//             }
//             field("Posting Date"; rec."Posting Date")
//             {
//                 Visible = false;
//             }
//             field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//             {
//                 Visible = false;
//             }
//             field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//             {
//                 Visible = true;
//             }
//             field("Section Name"; rec."Section Name")
//             {
//             }
//             field("Pending To User ID"; rec."Pending To User ID")
//             {
//             }
//             field("Pending To User Name"; rec."Pending To User Name")
//             {
//             }
//             field(Status; rec.Status)
//             {
//                 Visible = true;
//             }
//         }
//     }
//     // area(factboxes)
//     // {
//     //     part(IncomingDocAttachFactBox; 193)
//     //     {
//     //         ShowFilter = false;
//     //     }
//     //     part("Vendor detail factbox"; 9093)
//     //     {
//     //         SubPageLink = No.=FIELD("Buy-from Vendor No.),
//     //                       Date Filter=FIELD(Date Filter);
//     //         Visible = true;
//     //     }
//     // }
// }

// //area(navigation)
// // {
// //     // group("&Invoice")
// // {
// //     Caption = '&Invoice';
// //     Image = Invoice;
// //     action(Statistics)
// //     {
// //         Caption = 'Statistics';
// //         Image = Statistics;
// //         Promoted = true;
// //         PromotedCategory = Process;
// //         ShortCutKey = 'F7';

// //         trigger OnAction()
// //         begin
// //             CalcInvDiscForHeader;
// //             COMMIT;
// //             PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
// //         end;
// //     }
// // action("Co&mments")
// // {
// //     Caption = 'Co&mments';
// //     Image = ViewComments;
// //     RunObject = Page 66;
// //     RunPageLink = "Document Type"=FIELD("Document Type"),
// //                   No.=FIELD(No.),
// //                   Document Line No.=CONST(0);
// //     Visible = false;
// // }
// // action(Dimensions)
// // {
// //     AccessByPermission = TableData 348 = R;
// //     Caption = 'Dimensions';
// //     Image = Dimensions;
// //     ShortCutKey = 'Shift+Ctrl+D';

// //     trigger OnAction()
// //     begin
// //         //ShowDocDim;
// //     end;
// // }
// // action(Approvals)
// // {
// //     Caption = 'Approvals';
// //     Image = Approvals;
// //     Visible = false;

// //     trigger OnAction()
// //     var
// //         ApprovalEntries: Page "658";
// //     begin
// //         ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
// //         ApprovalEntries.RUN;
// //     end;
// // }
// // action("Approval History")
// // {
// //     Caption = 'Approval Flow';
// //     Image = Hierarchy;
// //     Promoted = true;
// //     PromotedCategory = Process;

// //     trigger OnAction()
// //     begin
// //         ApprovalEntry.RESET;
// //         ApprovalEntry.FILTERGROUP(2);
// //         ApprovalEntry.SETRANGE("Document No.","No.");
// //         PAGE.RUNMODAL(PAGE::"Approval History",ApprovalEntry);
// //     end;
// // }
// //     }
// // }
// //     area(processing)
// //     {
// //         group(Release)
// //         {
// //             Caption = 'Release';
// //             Image = ReleaseDoc;
// // action(Release)
// // {
// //     Caption = 'Re&lease';
// //     Image = ReleaseDoc;
// //     ShortCutKey = 'Ctrl+F9';
// //     Visible = false;

// //     trigger OnAction()
// //     var
// //         ReleasePurchDoc: Codeunit "415";
// //     begin
// //         ReleasePurchDoc.PerformManualRelease(Rec);
// //     end;
// // }
// // action(Reopen)
// // {
// //     Caption = 'Re&open';
// //     Image = ReOpen;
// //     Visible = false;

// //     trigger OnAction()
// //     var
// //         ReleasePurchDoc: Codeunit "415";
// //     begin
// //         ReleasePurchDoc.PerformManualReopen(Rec);
// //     end;
// // }
// //}
// // group("Request Approval")
// // {
// //     Caption = 'Request Approval';
// //     Image = "Action";
// //     action(SendApprovalRequest)
// //     {
// //         Caption = 'Send A&pproval Request';
// //         Enabled = NOT OpenApprovalEntriesExist;
// //         Image = SendApprovalRequest;

// //         trigger OnAction()
// //         var
// //             ApprovalsMgmt: Codeunit 
// //         begin
// //             IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
// //               ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
// //         end;
// //     }
// //     action(CancelApprovalRequest)
// //     {
// //         Caption = 'Cancel Approval Re&quest';
// //         Enabled = OpenApprovalEntriesExist;
// //         Image = Cancel;
// //         Visible = false;

// //         trigger OnAction()
// //         var
// //             ApprovalsMgmt: Codeunit "1535";
// //         begin
// //             ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
// //         end;
// //     }
// // }
// // group("P&osting")
// // {
// //     Caption = 'P&osting';
// //     Image = Post;
// //     action(Post)
// //     {
// //         Caption = 'P&ost';
// //         Image = PostOrder;
// //         Promoted = true;
// //         PromotedCategory = Process;
// //         PromotedIsBig = true;
// //         ShortCutKey = 'F9';
// //         Visible = false;

// //         trigger OnAction()
// //         begin
// //             SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
// //         end;
// //     }
// // action(Preview)
// // {
// //     Caption = 'Preview Posting';
// //     Image = ViewPostedOrder;
// //     Visible = false;

// //     trigger OnAction()
// //     var
// //         PurchPostYesNo: Codeunit "91";
// //     begin
// //         PurchPostYesNo.Preview(Rec);
// //     end;
// // }
// // action(TestReport)
// // {
// //     Caption = 'Test Report';
// //     Ellipsis = true;
// //     Image = TestReport;
// //     Visible = false;

// //     trigger OnAction()
// //     begin
// //         ReportPrint.PrintPurchHeader(Rec);
// //     end;
// // }
// // action(PostAndPrint)
// // {
// //     Caption = 'Post and &Print';
// //     Image = PostPrint;
// //     Promoted = true;
// //     PromotedCategory = Process;
// //     PromotedIsBig = true;
// //     ShortCutKey = 'Shift+F9';
// //     Visible = false;

// //     trigger OnAction()
// //     begin
// //         SendToPosting(CODEUNIT::"Purch.-Post + Print");
// //     end;
// // }
// // action(PostBatch)
// // {
// //     Caption = 'Post &Batch';
// //     Ellipsis = true;
// //     Image = PostBatch;
// //     Promoted = true;
// //     PromotedCategory = Process;
// //     Visible = false;

// //     trigger OnAction()
// //     begin
// //         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices",TRUE,TRUE,Rec);
// //         CurrPage.UPDATE(FALSE);
// //     end;
// // }
// // action(RemoveFromJobQueue)
// // {
// //     Caption = 'Remove From Job Queue';
// //     Image = RemoveLine;
// //     Visible = false;

// //     trigger OnAction()
// //     begin
// //         CancelBackgroundPosting;
// //     end;
// // }
// //}
// // }
// //}

// // trigger OnAfterGetCurrRecord()
// // begin
// //     SetControlAppearance;
// //     CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
// // end;

// // trigger OnNewRecord(BelowxRec: Boolean)
// // begin
// //     "Vendor Invoice Type" := "Vendor Invoice Type"::Legal;
// // end;

// // trigger OnOpenPage()
// // var
// //     PurchasesPayablesSetup: Record "312";
// // begin
// //     UserSetup.GET(USERID);
// //     IF UserSetup."Allow all Location"=FALSE THEN
// //     //SETRANGE("Shortcut Dimension 2 Code",UserSetup.Section);
// //     SetSecurityFilterOnRespCenter;

// //     JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
// //     SETFILTER("Vendor Type",'%1|%2|%3',"Vendor Type"::"Internal Advocate","Vendor Type"::"External Advocate","Vendor Type"::"Advocate Clerk");
// // end;

// // var
// //     ReportPrint: Codeunit "228";
// //     [InDataSet]
// //     JobQueueActive: Boolean;
// //     OpenApprovalEntriesExist: Boolean;
// //     UserSetup: Record "91";
// //     ApprovalEntry: Record "454";

// // local procedure SetControlAppearance()
// // var
// //     ApprovalsMgmt: Codeunit "1535";
// // begin
// //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
// // end;


