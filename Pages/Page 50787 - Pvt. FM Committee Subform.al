// page 50787 " Committee Subform"
// {
//     AutoSplitKey = true;
//     Caption = 'Committee Members';
//     MultipleNewLines = false;
//     PageType = ListPart;
//     // SourceTable = 50063;
//     ApplicationArea = all;
//     UsageCategory = Documents;
//     SourceTable = 50284;
//     //CardPageId = 50791;
//     //CardPageId = 50794;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Committee Code"; Rec."Committee Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'PAC Code';
//                     Editable = false;
//                     //Visible = false;
//                 }
//                 // field(Salutation; Rec.Salutation)//kc 23062023
//                 // {
//                 //     ApplicationArea = All;
//                 // }  // ROHIT
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Designation; Rec.Designation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<E-mail>"; Rec."E-mail ID")
//                 {
//                     Caption = 'E-mail';
//                     ApplicationArea = all;
//                 }
//                 field("Login ID"; Rec."Member ID")
//                 {
//                     Editable = false;
//                     ApplicationArea = all;
//                     DrillDownPageId = 50794;

//                 }
//                 field("Committee Chairman"; Rec."Committee Chairman")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         // IF ("Minimum Price For Approval" <> 0) AND ("Maximum Price For Approval" = 0) THEN
//         //  "Maximum Price For Approval" := 999999999999999.99;
//         //
//         // IF ("Minimum Price For Approval" = 0) AND ("Maximum Price For Approval" <> 0) THEN
//         //  "Maximum Price For Approval" := 0.0;
//     end;
// }

