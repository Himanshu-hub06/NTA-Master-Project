// table 50055 "Event/Function"
// {

//     fields
//     {
//         field(1;"Event ID";Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2;Name;Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3;Section;Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4;"Event Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5;Type;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Internal,External';
//             OptionMembers = Internal,External;
//         }
//         field(6;"No. Of Person";Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(7;"No. Of Invitee";Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8;"No. Of Days";Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9;"Chief Guest";Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10;"Total Expense";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11;"Total Revenues";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12;"Source Of Income";Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13;"Type Of Event";Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Unique,Repetitive';
//             OptionMembers = Unique,Repetitive;
//         }
//         field(14;"No. Series";Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1;"Event ID")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         NoSeriesMgt: Codeunit "396";

//     procedure AssistEdit(OldEvent: Record "50055"): Boolean
//     var
//         EventTab: Record "50055";
//     begin
//         WITH EventTab DO BEGIN
//            EventTab  := Rec;
//            IF NoSeriesMgt.SelectSeries('EVENT',OldEvent."No. Series","No. Series") THEN BEGIN
//               NoSeriesMgt.SetSeries("Event ID");
//               Rec := EventTab;
//               EXIT(TRUE);
//             END;
//         END;
//     end;
// }

