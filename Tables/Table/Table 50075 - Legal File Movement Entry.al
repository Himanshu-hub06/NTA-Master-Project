// table 50075 "Legal File Movement Entry"
// {

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Document No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; "Sender ID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "User Setup"."User ID";
//         }
//         field(4; "Sender Branch Code"; Code[10])
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 DimValue.RESET;
//                 DimValue.SETRANGE(DimValue."Dimension Code", 'BRANCH');
//                 DimValue.SETRANGE(DimValue.Code, "Sender Branch Code");  //DCCOMMENT NEED TO CHECK ONCE
//                 IF DimValue.FINDFIRST THEN
//                     "Sender Branch Name" := DimValue.Name
//                 ELSE
//                     "Sender Branch Name" := '';
//             end;
//         }
//         field(5; "Sender Branch Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; "Sender Section"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             // tableRelation = "Dimension Value".Code WHERE ("Dimension Value ID" =CONST(SECTION));   //DSC

//             trigger OnValidate()
//             begin
//                 DimValue.RESET;
//                 DimValue.SETRANGE(DimValue."Dimension Code", 'SECTION');
//                 DimValue.SETRANGE(DimValue.Code, "Sender Section");
//                 DimValue.SETRANGE(DimValue.Code, "Sender Section");  //DSC NEED TO CHECK IF CODE NOT WORK

//                 IF DimValue.FINDFIRST THEN
//                     "Sender Section Name" := DimValue.Name
//                 ELSE
//                     "Sender Section Name" := '';
//             end;
//         }
//         field(7; "Sender Section Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8; "Sender Location Code"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Location.Code;
//         }
//         field(9; "Sender location Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10; "Sending Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11; "Receiver ID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "User Setup"."User ID";
//         }
//         field(12; "Receiver Branch Code"; Code[10])
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 DimValue.RESET;
//                 DimValue.SETRANGE(DimValue."Dimension Code", 'BRANCH');
//                 DimValue.SETRANGE(DimValue.Code, "Receiver Branch Code"); //DS COMMENT NEED TO CHECK CODE ONCE
//                 DimValue.SETRANGE(DimValue."Dimension Code", "Receiver Branch Code");
//                 IF DimValue.FINDFIRST THEN
//                     "Receiver Branch Name" := DimValue.Name
//                 ELSE
//                     "Receiver Branch Name" := '';
//             end;
//         }
//         field(13; "Receiver Branch Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14; "Receiver Section"; Code[10])
//         {
//             DataClassification = ToBeClassified;

//             //TableRelation = "Dimension Value".Code where ("Dimension Code" = const(SECTION)

//             trigger OnValidate()
//             begin
//                 DimValue.RESET;
//                 DimValue.SETRANGE(DimValue."Dimension Code", 'SECTION');
//                 DimValue.SETRANGE(DimValue.Code, "Receiver Section");
//                 //DimValue.SETRANGE(DimValue.Code, "Receiver Section");
//                 IF DimValue.FINDFIRST THEN
//                     "Receiver Section Name" := DimValue.Name
//                 ELSE
//                     "Receiver Section Name" := '';
//             end;
//         }
//         field(15; "Receiver Section Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16; "Receiver Location Code"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Location.Code;
//         }
//         field(17; "Receiver Location Name"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18; "Received Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(19; Status; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Open,In-Process,Closed';
//             OptionMembers = Open,"In-Process",Closed;
//         }
//         field(20; "Record ID"; RecordID)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(21; "Sent For SOF"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(22; Received; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1; "Entry No.")
//         {
//         }
//         key(Key2; "Document No.", "Sender ID", "Sending Date")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         NextEntryNo: Integer;
//         LegalFileEntry: Record "Legal File Movement Entry";
//         UserSetup: Record User;
//         PageManagement: Codeunit "Page Management";
//         //TenderHdr: Record "50021";
//         DimValue: Record "Dimension Value";

//     local procedure GetNextEntryNo(): Integer
//     begin
//         IF LegalFileEntry.FIND('+') THEN
//             EXIT((LegalFileEntry."Entry No.") + 1)
//         ELSE
//             EXIT(1);
//     end;

//     procedure OpenRecord()
//     var
//         RecRef: RecordRef;
//         WritHdr: Record "Writ/Case Header";
//     begin
//         /*
//         IF NOT RecRef.GET("Record ID") THEN
//           EXIT;
//         RecRef.SETRECFILTER;
//         PageManagement.PageRun(RecRef);
//         */
//         // WritHdr.RESET;
//         // WritHdr.SETRANGE(WritHdr."File No.","Document No.");
//         // IF WritHdr.FIND('-') THEN
//         //   PAGE.RUNMODAL(50141,WritHdr);

//     end;
// }

