// page 50318 "Legal User Activity-OnDesk Top"
// {
//     Caption = 'User Activities - On Desk';
//     PageType = CardPart;
//     SourceTable = "Writ/Case Header";

//     layout
//     {
//         area(content)
//         {
//             cuegroup()
//             {
//                 field(CountNewCase;CountNewCase)
//                 {
//                     Caption = 'New';
//                     Image = Funnel;
//                     Style = Subordinate;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("User Assigned",USERID);
//                         WritTab.SETRANGE(Status,WritTab.Status::New);
//                         WritTab.SETFILTER("SOF Status",'%1|%2',"SOF Status"::" ","SOF Status"::Approved);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50403,WritTab);
//                     end;
//                 }
//                 field(SendforfactCollection;SendforfactCollection)
//                 {
//                     Caption = 'Sent for fact collection';
//                     Image = Funnel;
//                     Style = Subordinate;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         UserSetup.GET(USERID);
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("SOF Created",FALSE);
//                         WritTab.SETRANGE("At Concern Section",TRUE);
//                         //WritTab.SETRANGE("SOF Status",WritTab."SOF Status"::" ");
//                         WritTab.SETRANGE(Status,Status::New);
//                         WritTab.SETRANGE(Unread,TRUE);
//                         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50783,WritTab);
//                         //EXIT(WritTab.COUNT);
//                     end;
//                 }
//                 field(Sendtocreation;Sendtocreation)
//                 {
//                     Caption = 'Send to creation';
//                     Image = Funnel;
//                     Style = Subordinate;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         UserSetup.GET(USERID);
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         //WritTab.SETRANGE("SOF Created",FALSE);
//                         WritTab.SETFILTER("SOF Status",'%1|%2',WritTab."SOF Status"::"Under Preparation",WritTab."SOF Status"::Created);
//                         WritTab.SETRANGE(Disposed,FALSE);
//                         WritTab.SETRANGE(Status,WritTab.Status::New);
//                         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50783,WritTab);
//                         //EXIT(WritTab.COUNT);
//                     end;
//                 }
//                 field(Sendtoreview;Sendtoreview)
//                 {
//                     Caption = 'Send to Reviewed';
//                     Image = Funnel;
//                     Style = Subordinate;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         UserSetup.GET(USERID);
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         //WritTab.SETRANGE("SOF Created",FALSE);
//                         WritTab.SETRANGE("SOF Status",WritTab."SOF Status"::"Under Review");
//                         WritTab.SETRANGE(Disposed,FALSE);
//                         WritTab.SETRANGE(Status,WritTab.Status::New);
//                         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//                         WritTab.SETRANGE(Unread,FALSE);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50783,WritTab)
//                     end;
//                 }
//                 field(SendtoSectionforApproval;SendtoSectionforApproval)
//                 {
//                     Caption = 'Send to Section for Approval';
//                     Image = Funnel;
//                     Style = Subordinate;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         UserSetup.GET(USERID);
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("SOF Created",TRUE);
//                         WritTab.SETFILTER("SOF Status",'%1|%2',WritTab."SOF Status"::"Pending for Approval",WritTab."SOF Status"::Approved);
//                         WritTab.SETRANGE(Disposed,FALSE);
//                         WritTab.SETRANGE(Status,WritTab.Status::New);
//                         WritTab.SETRANGE("At Concern Section",TRUE);
//                         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//                         //WritTab.SETRANGE(Unread,TRUE);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50783,WritTab)
//                     end;
//                 }
//                 field(CountOngoingCase;CountOngoingCase)
//                 {
//                     Caption = 'Ongoing';
//                     Image = Funnel;
//                     Style = Favorable;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         UserSetup.GET(USERID);
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("User Assigned",USERID);
//                         WritTab.SETRANGE(Status,WritTab.Status::Ongoing);
//                         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50403,WritTab);
//                     end;
//                 }
//                 field(CountDisposedCase;CountDisposedCase)
//                 {
//                     Caption = 'Disposed';
//                     Image = Funnel;
//                     Style = Ambiguous;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("User Assigned",USERID);
//                         WritTab.SETRANGE(Status,WritTab.Status::Disposed);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50406,WritTab);
//                     end;
//                 }
//                 field(CountReminder;CountReminder)
//                 {
//                     Caption = 'Reminder';
//                     Image = Funnel;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         RemindEntry.RESET;
//                         RemindEntry.SETCURRENTKEY("Reminder No.");
//                         RemindEntry.SETRANGE("Receiver ID",USERID);
//                         RemindEntry.SETRANGE(Sent,TRUE);
//                         IF RemindEntry.FIND('-') THEN
//                           PAGE.RUN(50412,RemindEntry);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         WritTab: Record "50065";
//         RemindEntry: Record "50083";
//         UserSetup: Record "91";

//     local procedure CountNewCase(): Integer
//     begin
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("User Assigned",USERID);
//         WritTab.SETRANGE(Status,WritTab.Status::New);
//         //WritTab.SETRANGE("SOF Status","SOF Status"::" ");
//         WritTab.SETFILTER("SOF Status",'%1|%2',"SOF Status"::" ","SOF Status"::Approved);
//         EXIT(WritTab.COUNT);
//     end;

//     local procedure CountOngoingCase(): Integer
//     begin
//         UserSetup.GET(USERID);
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("User Assigned",USERID);
//         WritTab.SETRANGE(Status,WritTab.Status::Ongoing);
//         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//         EXIT(WritTab.COUNT);
//     end;

//     local procedure CountDisposedCase(): Integer
//     begin
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("User Assigned",USERID);
//         WritTab.SETRANGE(Status,WritTab.Status::Disposed);
//         EXIT(WritTab.COUNT);
//     end;

//     local procedure CountReminder(): Integer
//     begin
//         RemindEntry.RESET;
//         RemindEntry.SETCURRENTKEY("Reminder No.");
//         RemindEntry.SETRANGE(Sent,TRUE);
//         RemindEntry.SETRANGE("Receiver ID",USERID);
//         EXIT(RemindEntry.COUNT);
//     end;

//     local procedure SendforfactCollection(): Integer
//     begin
//         UserSetup.GET(USERID);
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("SOF Created",FALSE);
//         WritTab.SETRANGE("At Concern Section",TRUE);
//         //WritTab.SETRANGE("SOF Status",WritTab."SOF Status"::" ");
//         WritTab.SETRANGE(Status,Status::New);
//         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//         WritTab.SETRANGE(Unread,TRUE);
//         EXIT(WritTab.COUNT);
//     end;

//     local procedure Sendtocreation(): Integer
//     begin
//         UserSetup.GET(USERID);
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE(Disposed,FALSE);
//         //WritTab.SETRANGE("At Concern Section",TRUE);
//         WritTab.SETFILTER("SOF Status",'%1|%2',WritTab."SOF Status"::"Under Preparation",WritTab."SOF Status"::Created);
//         //WritTab.SETRANGE(Status,Status::New);
//         //WritTab.SETRANGE(Unread,TRUE);
//         WritTab.SETRANGE(Status,WritTab.Status::New);
//         WritTab.SETRANGE("User Section Code",UserSetup.Section);

//           EXIT(WritTab.COUNT);
//     end;

//     local procedure Sendtoreview(): Integer
//     begin
//         UserSetup.GET(USERID);
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE(Disposed,FALSE);
//         //WritTab.SETRANGE("At Concern Section",TRUE);
//         WritTab.SETRANGE("SOF Status",WritTab."SOF Status"::"Under Review");
//         //WritTab.SETRANGE(Status,Status::New);
//         //WritTab.SETRANGE(Unread,TRUE);
//         WritTab.SETRANGE(Status,WritTab.Status::New);
//         WritTab.SETRANGE(Unread,FALSE);
//         WritTab.SETRANGE("User Section Code",UserSetup.Section);

//           EXIT(WritTab.COUNT);
//     end;

//     local procedure SendtoSectionforApproval(): Integer
//     begin
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("SOF Created",TRUE);
//         WritTab.SETFILTER("SOF Status",'%1|%2',WritTab."SOF Status"::"Pending for Approval",WritTab."SOF Status"::Approved);
//         WritTab.SETRANGE(Disposed,FALSE);
//         WritTab.SETRANGE(Status,WritTab.Status::New);
//         WritTab.SETRANGE("At Concern Section",TRUE);
//         WritTab.SETRANGE("User Section Code",UserSetup.Section);
//         //WritTab.SETRANGE(Unread,TRUE);

//           EXIT(WritTab.COUNT);
//     end;
// }

