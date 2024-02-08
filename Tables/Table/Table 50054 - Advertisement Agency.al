// table 50054 "Advertisement Agency"
// {

//     fields
//     {
//         field(1;"Agency Code";Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2;"Agency Name";Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3;"Annual Budget";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4;"Empanelment Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5;"No. Of Advertisement";Integer)
//         {
//             CalcFormula = Count("Advt Ledger Entry" WHERE (Advt Agency=FIELD(Agency Code)));
//             FieldClass = FlowField;
//         }
//         field(6;Rate;Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13;UOM;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Sq cm,sq inch';
//             OptionMembers = "Sq cm","sq inch";
//         }
//         field(14;"E-mail ID";Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15;"Contact Person";Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16;"Contact No.";Code[15])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(17;"Spent Amount";Decimal)
//         {
//             CalcFormula = Sum("Advt Ledger Entry".Amount WHERE (Advt Agency=FIELD(Agency Code)));
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1;"Agency Code")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

