// page 50349 "Invoice Activity"
// {
//     PageType = CardPart;
//     SourceTable = "Purchase Cue";

//     layout
//     {
//         area(content)
//         {
//             cuegroup(fd)
//             {
//                 field(Open;rec."Invoice-Open")
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         PurchaseHdr.RESET;
//                         IF UserSetup.GET(USERID) THEN
//                             PurchaseHdr.SETRANGE("Shortcut Dimension 2 Code", UserSetup.Section);
//                         PAGE.RUN(50169, PurchaseHdr);
//                     end;
//                 }
//                 field(Pending; "Invoice-Pending")
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         PurchaseHdr.RESET;
//                         IF UserSetup.GET(USERID) THEN
//                             PurchaseHdr.SETRANGE("Shortcut Dimension 2 Code", UserSetup.Section);
//                         PAGE.RUN(50425, PurchaseHdr);
//                     end;
//                 }
//                 field(Approved; "Invoice-Approved")
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         PurchaseHdr.RESET;
//                         IF UserSetup.GET(USERID) THEN
//                             PurchaseHdr.SETRANGE("Shortcut Dimension 2 Code", UserSetup.Section);
//                         PAGE.RUN(50427, PurchaseHdr);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         PurchaseHdr: Record "38";
//         UserSetup: Record "91";
//         AdvocateInvOpen: Page "50169";

//     local procedure CountOpenInvoice(): Integer
//     var
//         PurchHdr: Record "38";
//     begin
//         PurchHdr.RESET;
//         PurchHdr.SETCURRENTKEY("No.", "Document Type");
//         PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Invoice);
//         PurchHdr.SETRANGE(Status, PurchHdr.Status::Open);
//         PurchHdr.SETFILTER("Vendor Type", '%1|%2|%3', PurchHdr."Vendor Type"::"Internal Advocate", PurchHdr."Vendor Type"::"External Advocate", PurchHdr."Vendor Type"::"Advocate Clerk");
//         EXIT(PurchHdr.COUNT);
//     end;

//     local procedure CountPendingInvoice(): Integer
//     var
//         PurchHdr: Record "38";
//     begin
//         PurchHdr.RESET;
//         PurchHdr.SETCURRENTKEY("No.", "Document Type");
//         PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Invoice);
//         PurchHdr.SETRANGE(Status, PurchHdr.Status::"Pending Approval");
//         PurchHdr.SETFILTER("Vendor Type", '%1|%2|%3', PurchHdr."Vendor Type"::"Internal Advocate", PurchHdr."Vendor Type"::"External Advocate", PurchHdr."Vendor Type"::"Advocate Clerk");
//         EXIT(PurchHdr.COUNT);
//     end;

//     local procedure CountApprovedInvoice(): Integer
//     var
//         PurchHdr: Record "38";
//     begin
//         PurchHdr.RESET;
//         PurchHdr.SETCURRENTKEY("No.", "Document Type");
//         PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Invoice);
//         PurchHdr.SETRANGE(Status, PurchHdr.Status::Released);
//         PurchHdr.SETFILTER("Vendor Type", '%1|%2|%3', PurchHdr."Vendor Type"::"Internal Advocate", PurchHdr."Vendor Type"::"External Advocate", PurchHdr."Vendor Type"::"Advocate Clerk");
//         EXIT(PurchHdr.COUNT);
//     end;
// }

