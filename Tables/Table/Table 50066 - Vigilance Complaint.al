// table 50066 "Vigilance Complaint"
// {

//     fields
//     {
//         field(1; "Complaint No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Complaint Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Document Verification,Complaints,Suggestion';
//             OptionMembers = "Document Verification",Complaints,Suggestion;
//         }
//         field(3; Name; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; "External Ref No."; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5; "Global Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,1,1';
//             Caption = 'Global Dimension 1 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
//         }
//         field(6; "Global Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,1,2';
//             Caption = 'Global Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(7; "External/Internal"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'External,Internal';
//             OptionMembers = External,Internal;
//         }
//         field(8; "Complaint Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9; "Received Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10; "Registered Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11; "No. Series"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; Status; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Open,At VO,In Process,Closed';
//             OptionMembers = Open,"At VO","In Process",Closed;
//         }
//         field(13; "Section Assigned"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14; "User Assigned"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15; "Current User"; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16; "Exam Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = 'Secondary,Senior Secondary';
//             OptionMembers = Secondary,"Senior Secondary";
//         }
//     }

//     keys
//     {
//         key(Key1; "Complaint No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         VALIDATE("Registered Date", WORKDATE);
//         VALIDATE("Current User", USERID);
//     end;

//     var
//         CompTab: Record "Vigilance Complaint";
//         NoSeriesMgt: Codeunit NoSeriesManagement;

//     procedure AssistEdit(OldComp: Record "Vigilance Complaint"): Boolean
//     var
//         Comp2: Record "Vigilance Complaint";
//     begin
//         WITH CompTab DO BEGIN
//             COPY(Rec);
//             CASE "Complaint Type" OF
//                 "Complaint Type"::"Document Verification":
//                     IF NoSeriesMgt.SelectSeries('VIGI-DOCVE', OldComp."No. Series", "No. Series") THEN BEGIN
//                         NoSeriesMgt.SetSeries("Complaint No.");
//                         Rec := CompTab;
//                         EXIT(TRUE);
//                     END;
//                 "Complaint Type"::Complaints:
//                     IF NoSeriesMgt.SelectSeries('VIGI-COMPL', OldComp."No. Series", "No. Series") THEN BEGIN
//                         NoSeriesMgt.SetSeries("Complaint No.");
//                         Rec := CompTab;
//                         EXIT(TRUE);
//                     END;
//                 "Complaint Type"::Suggestion:
//                     IF NoSeriesMgt.SelectSeries('VIGI-OTHER', OldComp."No. Series", "No. Series") THEN BEGIN
//                         NoSeriesMgt.SetSeries("Complaint No.");
//                         Rec := CompTab;
//                         EXIT(TRUE);
//                     END;
//             END;
//         END;
//     end;
// }

