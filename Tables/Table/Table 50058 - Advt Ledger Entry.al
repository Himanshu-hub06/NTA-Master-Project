// table 50058 "Advt Ledger Entry"
// {

//     fields
//     {
//         field(1;"Entry No.";Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2;"Advt No.";Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Advertisement Header"."External Advt. No.";
//         }
//         field(3;"Advt Agency";Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Advertisement Agency"."Agency Code";
//         }
//         field(4;"Posting Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5;Amount;Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6;"Advt Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1;"Entry No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

