// table 50282 "Bidder Items"
// {

//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; Name; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; "Line No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; "Item Code"; Code[30])
//         {
//             DataClassification = ToBeClassified;
//             // TableRelation = "Tender Item"."Item No." WHERE (No.=FIELD(No.));

//             trigger OnValidate()
//             begin
//                 IF ItemTab.GET("Item Code") THEN BEGIN
//                     VALIDATE(UOM, ItemTab."Base Unit of Measure");
//                     VALIDATE("Item Description", ItemTab.Description);
//                 END;
//             end;
//         }
//         field(5; "Tender Rate"; Decimal)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 /*
//                 BidItem1.COPY(Rec);
//                 IF BidItem1.FINDFIRST THEN BEGIN
//                   BidItem1."Tender Rate" := "Tender Rate";
//                   BidItem1.MODIFY(TRUE);
//                   COMMIT;
//                  END;
//                 BidItem.SETRANGE("No.","No.");
//                 //BidItem.SETRANGE(Name,Name);
//                 BidItem.SETRANGE("Item Code","Item Code");
//                 BidItem.SETCURRENTKEY("No.","Item Code","Tender Rate");
//                 IF BidItem.FINDFIRST THEN BEGIN
//                   L1Rt := BidItem."Tender Rate";
//                   BidItem.NEXT;
//                   L2Rt := BidItem."Tender Rate";
//                  END;
//                 MESSAGE('%1....%2',L1Rt,L2Rt);
//                 */

//             end;
//         }
//         field(6; UOM; Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; Quantity; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13; "Item Description"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(33; "Global Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,1,1';
//             Caption = 'Global Dimension 1 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(1));
//         }
//         field(34; "Global Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,1,2';
//             Caption = 'Global Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(2));
//         }
//     }

//     keys
//     {
//         key(Key1; "No.", Name, "Item Code", "Line No.")
//         {
//         }
//         key(Key2; "No.", "Item Code", "Tender Rate")
//         {
//         }
//         key(Key3; Name)
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         ItemTab: Record "27";
//         BidItem: Record "50005";
//         L1Rt: Decimal;
//         L2Rt: Decimal;
//         H1Rt: Decimal;
//         H2Rt: Decimal;
//         BidItem1: Record "50005";
// }

