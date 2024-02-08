// #pragma implicitwith disable
// page 50762 "Issued Requisition List"
// {
//     // CardPageID = "Current User Client Requests";
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = 50170;
//     SourceTableView = SORTING("No.")
//                       ORDER(Descending)
//                       WHERE(Issued = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Issued Date"; Rec."Issued Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Department; Rec.Department)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Department Name"; Rec."Department Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Requisition to Section"; Rec."Requisition to Section")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Req. To Department Name"; Rec."Req. To Department Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("No. Series"; Rec."No. Series")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Last Date Modified"; Rec."Last Date Modified")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Authorized; Rec.Authorized)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Sent for Authorization"; Rec."Sent for Authorization")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Declined; Rec.Declined)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Authorise; Rec.Authorise)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Location Name"; Rec."Location Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Autherise/Decline By"; Rec."Autherise/Decline By")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Indent Close"; Rec."Indent Close")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Release; Rec.Release)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Approving UID"; Rec."Approving UID")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Approving Date"; Rec."Approving Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Approving Time"; Rec."Approving Time")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Creation Date"; Rec."Creation Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Creation Time"; Rec."Creation Time")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Notes; Notes)
//             {
//                 ApplicationArea = All;
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         usersetup: Record 91;
// }

// #pragma implicitwith restore

