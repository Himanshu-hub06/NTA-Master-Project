// table 50053 "Advertisement Header"
// {

//     fields
//     {
//         field(1;"Advt. No.";Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2;Description;Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3;"Date Of Creation";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4;Department;Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5;"Creation Time";DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6;"Sent To PRO";Boolean)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF "Sent To PRO" THEN
//                   VALIDATE(Status,Status::"Sent To PRO");
//             end;
//         }
//         field(7;"Sent To Agency";Boolean)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF "Sent To Agency" THEN
//                   VALIDATE(Status,Status::"Sent To Agency ");
//             end;
//         }
//         field(8;"Sending DateTime";DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9;"Advertisement Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10;"Agency Code";Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Advertisement Agency"."Agency Code";

//             trigger OnValidate()
//             begin
//                 IF AgencyTab.GET("Agency Code") THEN
//                   AgencyName := AgencyTab."Agency Name";
//                 VALIDATE("Agency Name",AgencyName);
//             end;
//         }
//         field(11;"Agency Name";Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12;size;Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 AdvtLine.RESET;
//                 AdvtLine.SETRANGE(AdvtLine."No.","Advt. No.");
//                 IF AdvtLine.FINDFIRST THEN REPEAT
//                   AdvtLine.size := size;
//                   AdvtLine.MODIFY;
//                  UNTIL AdvtLine.NEXT=0;
//             end;
//         }
//         field(13;UOM;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Sq cm,sq inch';
//             OptionMembers = "Sq cm","sq inch";
//         }
//         field(14;"No. Series";Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15;"Creator UID";Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16;Status;Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Open,Sent To PRO,Sent To Agency ';
//             OptionMembers = Open,"Sent To PRO","Sent To Agency ";
//         }
//         field(17;"Proposed Advt Date";Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18;"External Advt. No.";Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1;"Advt. No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         AdvtLine.RESET;
//         AdvtLine.SETRANGE("No.","Advt. No.");
//         IF AdvtLine.FINDSET THEN REPEAT
//           AdvtLine.DELETE(TRUE);
//          UNTIL AdvtLine.NEXT=0;
//     end;

//     var
//         NoSeriesMgt: Codeunit "396";
//         AgencyTab: Record "Advertisement Header";
//         AgencyName: Text;
//         AdvtLine: Record "Advertisement Line";

//     procedure AssistEdit(OldAdv: Record "50053"): Boolean
//     var
//         AdvTab: Record "50053";
//     begin
//         WITH AdvTab DO BEGIN
//            AdvTab  := Rec;
//            IF NoSeriesMgt.SelectSeries('ADVT',OldAdv."No. Series","No. Series") THEN BEGIN
//               NoSeriesMgt.SetSeries("Advt. No.");
//               Rec := AdvTab;
//               EXIT(TRUE);
//             END;
//         END;
//     end;

//     procedure AssistEdit11(OldAdv: Record "Advertisement Header"): Boolean
//     var
//         AdvTab: Record "Advertisement Header";
//     begin
//         WITH AdvTab DO BEGIN
//            AdvTab  := Rec;
//            IF NoSeriesMgt.SelectSeries('ADVT-EXT',OldAdv."No. Series","No. Series") THEN BEGIN
//               NoSeriesMgt.SetSeries("External Advt. No.");
//               Rec := AdvTab;
//               EXIT(TRUE);
//             END;
//         END;
//     end;
// }

