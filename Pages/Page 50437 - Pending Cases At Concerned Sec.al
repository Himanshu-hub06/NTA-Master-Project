// page 50337 "Pending Cases At Concerned Sec"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = ListPart;
//     SourceTable = Table50065;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("File No.";"File No.")
//                 {
//                     Width = 12;
//                 }
//                 field("Case Type";"Case Type")
//                 {
//                 }
//                 field("Case No.";"Case No.")
//                 {
//                 }
//                 field("Name Of Petitioner";"Name Of Petitioner")
//                 {
//                 }
//                 field("Section Name";"Section Name")
//                 {
//                 }
//                 field("Sent By To Concern Section";"Sent User Name")
//                 {
//                     Enabled = false;
//                 }
//                 field("Current User ID";"User Assigned")
//                 {
//                 }
//                 field("Current User Name";"Assigned User Name")
//                 {
//                     Enabled = false;
//                 }
//             }
//             group("Count Filter")
//             {
//                 Caption = '*';
//                 //The GridLayout property is only supported on controls of type Grid
//                 //GridLayout = Rows;
//                 Visible = true;
//                 field(COUNT;COUNT)
//                 {
//                     Caption = 'Total No. Of Records';
//                     ColumnSpan = 3;
//                     Editable = false;
//                     Enabled = false;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("File Outward")
//             {
//                 Caption = 'File Movement Status';
//                 Image = OrderList;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 var
//                     FileMovEntry: Record "50075";
//                 begin
//                     FileMovEntry.RESET;
//                     FileMovEntry.FILTERGROUP(2);
//                     FileMovEntry.SETRANGE("Document Type",FileMovEntry."Document Type"::Legal);
//                     FileMovEntry.SETRANGE("Document No.","File No.");
//                     FileMovEntry.FILTERGROUP(0);
//                     IF FileMovEntry.FIND('-') THEN
//                       PAGE.RUN(PAGE::"Legal File In-Out List",FileMovEntry)
//                     ELSE
//                       MESSAGE('Details not found');
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         SETRANGE("Sent By At Concern Section",USERID);
//         SETRANGE("At Concern Section",TRUE);
//     end;

//     var
//         WritCaseHdr: Record "50065";
//         "CaseNo.": Text;
//         Year: Integer;
//         CaseType: Text;
// }

