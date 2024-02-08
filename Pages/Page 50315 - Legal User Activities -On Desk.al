// page 50315 "Legal User Activities -On Desk"
// {
//     Caption = 'User Activities - On Desk';
//     PageType = CardPart;
//     SourceTable = Table50065;

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
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50177,WritTab);
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
//                         WritTab.RESET;
//                         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//                         WritTab.SETRANGE("User Assigned",USERID);
//                         WritTab.SETRANGE(Status,WritTab.Status::Ongoing);
//                         IF WritTab.FIND('-') THEN
//                           PAGE.RUN(50177,WritTab);
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
//                           PAGE.RUN(50179,WritTab);
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

//     local procedure CountNewCase(): Integer
//     begin
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("User Assigned",USERID);
//         WritTab.SETRANGE(Status,WritTab.Status::New);
//         EXIT(WritTab.COUNT);
//     end;

//     local procedure CountOngoingCase(): Integer
//     begin
//         WritTab.RESET;
//         WritTab.SETCURRENTKEY(Status,"User Assigned","User Exam Code",Unread);
//         WritTab.SETRANGE("User Assigned",USERID);
//         WritTab.SETRANGE(Status,WritTab.Status::Ongoing);
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
// }

