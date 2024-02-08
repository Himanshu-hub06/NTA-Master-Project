// page 50391 "Legal Role Center-1 Level Sec"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(A001)
//             {
//                 part("User Activities - Unseen Cases by You";50316)
//                 {
//                     Caption = 'User Activities - Unseen Cases by You';
//                     ToolTip = 'Unseen Cases by you';
//                 }
//                 part("User Activities - All Pending Cases on Your Desk";50415)
//                 {
//                     Caption = 'User Activities - All Pending Cases on Your Desk';
//                 }
//                 part("Writ/Case - All Cases";50308)
//                 {
//                     Caption = 'Writ/Case - All Cases';
//                     Visible = true;
//                 }
//                 // part("Invoice Activity";50449)
//                 // {
//                 //     Caption = 'Invoice Activity';
//                 //     SubPageView = WHERE(Vendor Type Filter=FILTER(Advocate Clerk|Internal Advocate|External Advocate),
//                 //                         Section Filter=CONST(S070));
//                 // }
//                 part("Writ/Case - Sen. Secondary";50309)
//                 {
//                     Caption = 'Writ/Case - Sen. Secondary';
//                     Visible = false;
//                 }
//                 part(;9030)
//                 {
//                     Visible = false;
//                 }
//             }
//             group()
//             {
//                 chartpart("T36-08";"T36-08")
//                 {
//                     Editable = true;
//                 }
//                 part(;675)
//                 {
//                     Visible = false;
//                 }
//                 systempart(;MyNotes)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(embedding)
//         {
//             action(Advocate)
//             {
//                 Caption = 'Advocate';
//                 RunObject = Page "Advocate List";
//             }
//             action("Writ/Case")
//             {
//                 Caption = 'Writ/Case';
//                 RunObject = Page 50177;
//                 //RunPageView = SORTING("File No.")
//                               //ORDER(Ascending)
//                               //WHERE("User Exam Code"=CONST(EXESEC));
//             }
//             action("<Page Receive - After Creation")
//             {
//                 Caption = 'SOF - Creator';
//                 RunObject = Page 50365;
//                 RunPageView = WHERE("User Exam Code"=CONST(EXESEC));
//                 Visible = false;
//             }
//             action("<Page Receive - After Review")
//             {
//                 Caption = 'SOF - Reviewer';
//                 RunObject = Page 50154;
//                 RunPageView = WHERE(User Exam Code=CONST(EXESEC));
//                 Visible = false;
//             }
//             action("Advocate Assign Detail")
//             {
//                 Caption = 'Advocate Assign Detail';
//                 RunObject = Page 50170;
//                 RunPageView = WHERE(User Exam Code=CONST(EXESEC));
//             }
//             action("Writ/Case - All")
//             {
//                 Caption = 'Writ/Case - All';
//                 RunObject = Page 50405;
//                 RunPageView = WHERE(User Exam Code=CONST(EXESEC));
//             }
//             action("File Movement Status")
//             {
//                 Caption = 'File Movement Status';
//                 RunObject = Page 50147;
//                 RunPageView = WHERE(Legal Exam Code=CONST(EXESEC));
//             }
//             action(Reminders)
//             {
//                 Caption = 'Reminders';
//                 RunObject = Page 50421;
//             }
//             action(Draft)
//             {
//                 Caption = 'Draft';
//                 RunObject = Page 50421;
//                 RunPageView = SORTING(Reminder No.)
//                               ORDER(Ascending)
//                               WHERE(Sent=FILTER(No));
//             }
//             action(Sent)
//             {
//                 Caption = 'Sent';
//                 RunObject = Page 50421;
//                 RunPageView = SORTING(Reminder No.)
//                               ORDER(Ascending)
//                               WHERE(Sent=FILTER(Yes));
//             }
//             action(Setup)
//             {
//                 Caption = 'Setup';
//                 RunObject = Page 50070;
//                 RunPageView = WHERE(Department=CONST(LEGAL),
//                                     Page Type=CONST(Setup));
//             }
//             action(MIS)
//             {
//                 Caption = 'MIS';
//                 RunObject = Page 50071;
//                 RunPageView = SORTING(R Code)
//                               WHERE(Department=CONST(LEGAL));
//             }
//             action("User Password")
//             {
//                 Caption = 'User Password';
//                 RunObject = Page 50070;
//                 RunPageView = SORTING(Department,Page ID)
//                               WHERE(Department=CONST(ADMIN),
//                                     Page Type=CONST(Setup),
//                                     Sub Dept=CONST(PASS));
//             }
//         }
//         area(sections)
//         {
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 Image = ResourcePlanning;
//                 action(Vendors)
//                 {
//                     Caption = 'Vendors';
//                     RunObject = Page 50172;
//                 }
//                 action("New Invoice")
//                 {
//                     Caption = 'New Invoice';
//                     RunObject = Page 50169;
//                     RunPageView = WHERE(Shortcut Dimension 2 Code=FILTER(S070));
//                 }
//                 action("Pending Invoice")
//                 {
//                     Caption = 'Pending Invoice';
//                     RunObject = Page 50425;
//                     RunPageView = WHERE(Shortcut Dimension 2 Code=FILTER(S070));
//                 }
//                 action("Approved Invoice")
//                 {
//                     Caption = 'Approved Invoice';
//                     RunObject = Page 50427;
//                     RunPageView = WHERE(Shortcut Dimension 2 Code=FILTER(S070));
//                 }
//             }
//             group(Requisition)
//             {
//                 Caption = 'Requisition';
//                 Image = ResourcePlanning;
//                 action(Requisition)
//                 {
//                     Caption = 'Requisition';
//                     Ellipsis = true;
//                     RunObject = Page 50039;
//                 }
//                 action("Requisition Under Approval")
//                 {
//                     Caption = 'Requisition Under Approval';
//                     Ellipsis = true;
//                     RunObject = Page 50046;
//                 }
//                 action("Rejected Requisition")
//                 {
//                     Caption = 'Rejected Requisition';
//                     Ellipsis = true;
//                     RunObject = Page 50307;
//                 }
//                 action("Approved Requisition")
//                 {
//                     Caption = 'Approved Requisition';
//                     Ellipsis = true;
//                     RunObject = Page 50084;
//                 }
//             }
//         }
//     }
// }

