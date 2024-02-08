// table 50059 "News Paper"
// {

//     fields
//     {
//         field(1;"NP Code";Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2;"NP Name";Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3;"Circulation State";Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = State;
//         }
//         field(4;"Current Normal Rate";Decimal)
//         {
//             CalcFormula = Max("NP Advt Rate"."Normal Rate" WHERE (Latest=CONST(Yes),
//                                                                   NP Code=FIELD(NP Code)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5;"Current Color Rate";Decimal)
//         {
//             CalcFormula = Max("NP Advt Rate"."Color Rate" WHERE (Latest=CONST(Yes),
//                                                                  NP Code=FIELD(NP Code)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(6;"Current Front Page Rate";Decimal)
//         {
//             CalcFormula = Max("NP Advt Rate"."Front Page Rate" WHERE (Latest=CONST(Yes),
//                                                                       NP Code=FIELD(NP Code)));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(7;UOM;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Sq Cm,Sq Inch';
//             OptionMembers = "Sq Cm","Sq Inch";
//         }
//         field(8;"No. Series";Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9;Language;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Hindi,English,Urdu';
//             OptionMembers = Hindi,English,Urdu;
//         }
//     }

//     keys
//     {
//         key(Key1;"NP Code")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         NoSeriesMgt: Codeunit "396";

//     procedure AssistEdit(ExistNP: Record "50059"): Boolean
//     var
//         NPTab: Record "50059";
//     begin
//         WITH NPTab DO BEGIN
//            NPTab  := Rec;
//            IF NoSeriesMgt.SelectSeries('NEWSPAP',ExistNP."No. Series","No. Series") THEN BEGIN
//               NoSeriesMgt.SetSeries("NP Code");
//               Rec := NPTab;
//               EXIT(TRUE);
//             END;
//         END;
//     end;
// }

