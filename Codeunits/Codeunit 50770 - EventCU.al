// codeunit 50770 EventCU
// {

//     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
//     procedure CopyfromCustomer(SellToCustomer: Record Customer; var SalesHeader: Record "Sales Header")
//     begin

//         SalesHeader."Additional Remark" := SellToCustomer."Custom Remarks";


//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]

//     procedure Copyfromsaleheader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
//     begin

//         GenJournalLine."Aditional Remarks" := SalesHeader."Additional Remark";


//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]

//     procedure copyfromjournaltoledger(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
//     begin

//         CustLedgerEntry."Aditional Remarks" := GenJournalLine."Aditional Remarks";


//     end;



// }
