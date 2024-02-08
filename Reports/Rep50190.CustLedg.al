// report 50191 CustLedg
// {
//     ApplicationArea = All;
//     Caption = 'CustLedg';
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Reports/CustLedg.rdl';

//     dataset
//     {
//         dataitem(CustLedgerEntry; "Cust. Ledger Entry")
//         {
//             column(CustomerNo; "Customer No.")
//             {
//             }
//             column(DocumentNo; "Document No.")
//             {
//             }
//             column(AmountLCY; "Amount (LCY)")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 Reccustor.Reset();
//                 Reccustor.SetRange("No.","Customer No.");
//                 if Reccustor.FindFirst() then
//                 CONTACTNM 


//     }


//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     var
//     Reccustor : Record Customer;
//     CONTACTNM : Text[30] ;
// }
