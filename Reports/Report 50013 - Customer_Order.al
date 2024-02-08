// report 50013 "Customer Detail"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Reports/Customer_Order.rdl';

//     dataset
//     {
//         dataitem(Customer;Customer)
//         {
//             column(No_;"No.")
//             {

//             }
//             column(Name;Name)
//             {

//             }
//             column(Shipment)
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(Name; SourceExpression)
//                     {
//                         ApplicationArea = All;

//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     // rendering
//     // {
//     //     layout(LayoutName)
//     //     {
//     //         Type = Excel;
//     //         LayoutFile = 'mySpreadsheet.xlsx';
//     //     }
//     // }

//     var
//         myInt: Integer;
// }