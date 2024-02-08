// page 50784 "Committe List"
// {
//     PageType = ListPart;
//     //ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "AV Committee Line";
//     AutoSplitKey = true;
//     Caption = 'Commitee';



//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 // field("Document No."; rec."Document No.")
//                 // {
//                 //     ApplicationArea = All;

//                 // }
//                 field("Line No."; Rec."Line No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("E-mail ID"; Rec."E-mail ID")
//                 {

//                     ApplicationArea = All;
//                 }
//                 field(Designation; Rec.Designation)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     // actions
//     // {
//     //     area(Processing)
//     //     {
//     //         action(ActionName)
//     //         {
//     //             ApplicationArea = All;

//     //             trigger OnAction()
//     //             begin

//     //             end;
//     //         }
//     //     }
//     // }

//     // var
//     //     myInt: Integer;
// }