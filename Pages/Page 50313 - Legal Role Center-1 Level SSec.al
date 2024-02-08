// page 50313 "Legal Role Center-1 LevelSS"
// {
//     Caption = 'Legal Role Center-1LevelSSec';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)

//         {
//             group(ROLE)
//             {
//                 // part("User Activities - Unseen Cases by You"; 50416)  //DSC
//                 // {
//                 //     Caption = 'User Activities - Unseen Cases by You';
//                 // }
//                 // part("User Activities - All Pending Cases on Your Desk"; 50415)
//                 // {
//                 //     Caption = 'User Activities - All Pending Cases on Your Desk';
//                 // }
//                 // part("Writ/Case - All Cases"; 50409)
//                 // {
//                 //     Caption = 'Writ/Case - All Cases';
//                 //     Visible = true;
//                 // }
//                 // part("Invoice Activity"; 50449)
//                 // {
//                 //     Caption = 'Invoice Activity';
//                 //     SubPageView = WHERE(Vendor Type Filter=FILTER(Advocate Clerk|Internal Advocate|External Advocate),
//                 //                         Section Filter=CONST(S069));
//                 // }
//                 // part(;9030)
//                 // {
//                 //     Visible = false;
//                 // }
//             }
//             // group(ROLE2)
//             // {
//             //     chartpart("T36-08";"T36-08")
//             //     {
//             //         Editable = true;
//             //     }
//             //     part(;675)
//             //     {
//             //         Visible = false;
//             //     }
//             //     systempart(MUNOTES;MyNotes)
//             //     {
//             //     }
//             // }
//         }
//     }

//     actions
//     {
//         area(embedding)
//         {
//             action(Advocate)
//             {
//                 Caption = 'Advocate';
//                 RunObject = Page 50301;
//             }
//             action("Writ/Case")
//             {
//                 Caption = 'Writ/Case';
//                 RunObject = Page 50387;
//                 RunPageView = SORTING("Origin Date")
//                               ORDER(Descending);
//                 //WHERE("User Exam Code"=CONST('EXESSEC'));
//             }
//             action("<Page Receive - After Creation")
//             {
//                 Caption = 'SOF - Creator';
//                 RunObject = Page 50365;
//                 //RunPageView = WHERE("User Exam Code"=CONST('EXESSEC'));
//                 Visible = false;
//             }
//             action("<Page Receive - After Review")
//             {
//                 Caption = 'SOF - Reviewer';
//                 RunObject = Page 50366;
//                 ;
//                 //RunPageView = WHERE("User Exam Code"=CONST('EXESSEC'));
//                 Visible = false;
//             }
//             action("Advocate Assign Detail")
//             {
//                 Caption = 'Advocate Assign Detail';
//                 RunObject = Page 50380;
//                 //RunPageView = WHERE("User Exam Code"=CONST("EXESSEC"));
//             }
//             action("Writ/Case - All")
//             {
//                 Caption = 'Writ/Case - All';
//                 RunObject = Page 50305;
//                 //RunPageView = WHERE("User Exam Code"=CONST('EXESSEC'));  //
//             }
//             action("File Movement Status")
//             {
//                 Caption = 'File Movement Status';
//                 RunObject = Page 50359;
//                 //RunPageView = WHERE("Legal Exam Code"=CONST("EXESSEC));
//             }
//             action(Reminders)
//             {
//                 Caption = 'Reminders';
//                 RunObject = Page 50321;
//             }
//             action(Draft)
//             {
//                 Caption = 'Draft';
//                 RunObject = Page 50321;
//                 RunPageView = SORTING("Reminder No.")
//                               ORDER(Ascending)
//                               WHERE(Sent = FILTER(false));
//             }
//             action(Sent)
//             {
//                 Caption = 'Sent';
//                 RunObject = Page 50321;
//                 RunPageView = SORTING("Reminder No.")
//                               ORDER(Ascending)
//                               WHERE(Sent = FILTER(false));
//             }
//             // action(Setup)
//             // {
//             //     Caption = 'Setup';
//             //     RunObject = Page 50070;
//             //                     RunPageView = WHERE(Department=CONST(LEGAL),
//             //                         Page Type=CONST(Setup));
//             // }
//             // action(MIS)
//             // {
//             //     Caption = 'MIS';
//             //     RunObject = Page 50071;
//             //                     RunPageView = SORTING(R Code)
//             //                   WHERE(Department=CONST(LEGAL));
//             // }
//             // action("User Password")
//             // {
//             //     Caption = 'User Password';
//             //     RunObject = Page 50070;
//             //                     RunPageView = SORTING(Department,Page ID)
//             //                   WHERE(Department=CONST(ADMIN),
//             //                         Page Type=CONST(Setup),
//             //                         Sub Dept=CONST(PASS));
//             // }
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
//                     //RunPageView = WHERE("Shortcut Dimension 2 Code"=FILTER(S069));
//                 }
//                 action("Pending Invoice")
//                 {
//                     Caption = 'Pending Invoice';
//                     RunObject = Page 50325;
//                     //RunPageView = WHERE(Shortcut Dimension 2 Code=FILTER(S069));
//                 }
//                 // action("Approved Invoice")
//                 // {
//                 //     Caption = 'Approved Invoice';
//                 //     RunObject = Page 50327;
//                 //                     //RunPageView = WHERE(Shortcut Dimension 2 Code=FILTER(S069));
//                 // }
//             }
//             //     group(Requisition)
//             //     {
//             //         Caption = 'Requisition';
//             //         Image = ResourcePlanning;
//             //         action(Requisition)
//             //         {
//             //             Caption = 'Requisition';
//             //             Ellipsis = true;
//             //             RunObject = Page 50039;
//             //         }
//             //         action("Requisition Under Approval")
//             //         {
//             //             Caption = 'Requisition Under Approval';
//             //             Ellipsis = true;
//             //             RunObject = Page 50046;
//             //         }
//             //         action("Rejected Requisition")
//             //         {
//             //             Caption = 'Rejected Requisition';
//             //             Ellipsis = true;
//             //             RunObject = Page 50307;
//             //         }
//             //         action("Approved Requisition")
//             //         {
//             //             Caption = 'Approved Requisition';
//             //             Ellipsis = true;
//             //             RunObject = Page 50084;
//             //         }
//             //     }
//             // }
//         }
//     }
// }

