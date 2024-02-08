// #pragma implicitwith disable
// page 50763 "Issued Requisition Header"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = Card;
//     SourceTable = 50170;
//     SourceTableView = SORTING("No.")
//                       ORDER(Ascending)
//                       WHERE(Issued = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;

//                     trigger OnAssistEdit()
//                     begin
//                         IF Rec.AssistEdit THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Issued Date"; Rec."Issued Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Department Name"; Rec."Department Name")
//                 {
//                 }
//                 field("Requisition to Section"; Rec."Requisition to Section")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Req. To Department Name"; Rec."Req. To Department Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Requisition Type"; Rec."Requisition Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Issued By"; Rec."Issued By")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Attachment; Rec.Attachment)
//                 {
//                     Editable = false;
//                     ApplicationArea = All;
//                     trigger OnDrillDown()
//                     begin
//                         FileDir.Get();

//                         FilePath := FileDir."Requisition Read";

//                         if Rec.Attachment <> '' THEN BEGIN
//                             OldFileName := Rec."Attachment";
//                             ServerFileName := FilePath + Rec."Attachment";
//                             HYPERLINK(ServerFileName);
//                         END;
//                     end;
//                 }
//                 field("Issue To"; Rec."Issue To")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Received By';
//                 }
//             }
//             part("Issued Requisition Subform"; "Issued Requisition Subform")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Requisition No." = FIELD("No.");
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
//         area(navigation)
//         {
//             action("&Requisition Slip")
//             {
//                 ApplicationArea = All;
//                 Image = "Report";
//                 Promoted = true;

//                 trigger OnAction()
//                 begin
//                     ReqHeadRec.RESET;
//                     ReqHeadRec.SETRANGE("No.", Rec."No.");
//                     IF ReqHeadRec.FIND('-') THEN BEGIN
//                         REPORT.RUNMODAL(50019, TRUE, TRUE, ReqHeadRec);
//                     END;
//                 end;
//             }
//             action("Return To Store")
//             {
//                 ApplicationArea = All;
//                 Image = ReturnReceipt;
//                 Promoted = true;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     IF CONFIRM('Do you want to return quantity', TRUE) THEN BEGIN
//                         IF Rec."Return To Store" = FALSE THEN BEGIN
//                             RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
//                             IF RequisitionLine.FINDFIRST THEN BEGIN
//                                 REPEAT
//                                     RequisitionLine.CALCFIELDS("Issued Quantity");
//                                     IF RequisitionLine.Quantity < RequisitionLine."Issued Quantity" THEN
//                                         //RequisitionLine."Balance Return Quantity" := RequisitionLine."Issued Quantity" - RequisitionLine.Quantity;
//                                         RequisitionLine."Return Store" := RequisitionLine."Balance Return Quantity";
//                                     ReturnQty += RequisitionLine."Balance Return Quantity";
//                                     RequisitionLine.MODIFY;
//                                 UNTIL RequisitionLine.NEXT = 0;
//                                 IF ReturnQty > 0 THEN
//                                     Rec."Return To Store" := TRUE;
//                                 Rec.MODIFY;
//                             END;
//                             CurrPage.UPDATE;
//                             MESSAGE('Return to store requisition slip has been created');
//                         END ELSE
//                             ERROR('Already Return To Store Created');
//                     END;
//                 end;
//             }
//             action(Issue)
//             {
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 begin
//                     // ItemJnlmanag.FillItemJournalFromRequisition1("No.");
//                 end;
//             }
//             action("Closed Requisition")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Closed Requisition';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ShortCutKey = 'F7';
//                 Visible = true;

//                 trigger OnAction()
//                 begin
//                     RequisitionHeader.RESET;
//                     RequisitionHeader.SETRANGE("No.", Rec."No.");
//                     IF RequisitionHeader.FIND('-') THEN
//                         IF RequisitionHeader.Status = RequisitionHeader.Status::Closed THEN BEGIN
//                             MESSAGE(Text50002, Rec."No.");
//                         END ELSE
//                             IF CONFIRM(Text50001, TRUE, Rec."No.") THEN BEGIN
//                                 RequisitionHeader.RESET;
//                                 // RequisitionHeader.SETRANGE("Document Type",RequisitionHeader."Document Type"::Requisition);
//                                 RequisitionHeader.SETRANGE("No.", Rec."No.");
//                                 IF RequisitionHeader.FIND('-') THEN
//                                     RequisitionHeader.Status := RequisitionHeader.Status::Closed;
//                                 RequisitionHeader.Posted := TRUE;
//                                 RequisitionHeader.MODIFY;
//                             END;
//                 end;
//             }
//         }
//     }

//     var
//         ReqHeadRec: Record 50170;
//         RequisitionLine: Record 50171;
//         ReturnQty: Decimal;
//         RequisitionHeader: Record 50170;
//         Text50001: Label 'Do you want to Post Requisition %1?';
//         Text50002: Label 'Requisition No. %1 already closed.';
//         Text50003: Label 'Requisition %1 posted successfully.';
//         Text50004: Label 'There is nothing to post?';
//         ItemJnlmanag: Codeunit 240;
//         OldFileName: Text;
//         ServerFileName: Text;
//         FilePath: Text[150];
//         FileDir: Record 50111;
// }

// #pragma implicitwith restore

