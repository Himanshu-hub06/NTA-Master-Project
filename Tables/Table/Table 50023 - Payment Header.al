// table 50023 "Payment Header"
// {
//     DataClassification = ToBeClassified;
//     Caption = 'NTA Payment';

//     fields
//     {
//         field(1; "No."; Code[20])

//         {
//             trigger OnValidate()
//             var
//                 myInt: Integer;
//             begin
//                 IF "No." <> xRec."No." THEN BEGIN
//                     GenLedSetup.GET;
//                     //NoSeriesMgt.TestManual(GenLedSetup."Payment Receipt No.");
//                     "No. Series" := '';
//                 END;

//             end;


//         }
//         field(2; "Posting Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; "Location Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; "Location Name"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5; "User Id"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; "From Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(7; "To Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8; "User Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9; "Status"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = Open,"Pending for Approval",Approved,Rejected;
//         }
//         field(10; "No. Series"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11; "Pay To."; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; "File No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13; "e-office No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14; "Budgetary Head"; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15; "Budgetary Head Name"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16; "BShortcut Dimension 1 Code"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(17; "Shortcut Dimension 2 Code"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18; "Posted"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(19; "Bank Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(20; "Bank Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(21; "Cheque No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(22; "Cheque Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(23; "Total Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(24; "Rejected Remarks"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(25; Attachement; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(26; "Due Date With penalty"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(27; "Payment Receipt"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(28; "Remark"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(29; "Payment Personal Created"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(30; "Proposal Status"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = Open,"Pending for Approval",Approved,Rejected;
//         }
//         field(31; "Proposal Approved"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(32; "Payment Done"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(33; "Proposal Remarks"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(34; "Transfer File User ID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(35; "Year"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(36; "Vendor Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(37; "Vendor Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(38; "Expence Type"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(39; "Expence Description"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(40; "Invoice No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(41; "Vendor Invoice No."; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(42; "Vendor Invoice Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(43; "Dimension Set ID"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(44; "vendor Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = "",Register,UnRegister;
//         }
//         field(45; Month; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(46; "Total Salary"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(47; "Amount to Vendor"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(48; "IT Tds Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(49; "GST Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50; "GST IGST Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(51; "GST SGST Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(52; "GST CGST Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(53; "Base Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(54; "On Amount Of"; Blob)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(55; "Main Budgetary Account No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(56; "Main Budgetary Name"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(57; "Letter No."; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(58; "EPF Contribution Account"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(59; "EPF Contribution Account Name"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60; "EPF Cheque No"; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(61; "EPF Cheque Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(62; "EPF Letter Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(63; "Letter Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(64; "EPF Letter No."; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(65; "Order Details"; Blob)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(66; "Bill Book No."; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(67; "Voucher No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(68; "Voucher Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(69; "Expense Voucher"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(70; "Beltron Voucher"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(71; "Due Date Without Penalty"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }


//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//             Clustered = true;
//         }
//     }

//     var

//     VAR
//         GenLedSetup: Record 98;
//         NoSeriesMgt: Codeunit 396;
//         Usersetup: Record 91;
//         LocTab: Record 14;
//         DimMgt: Codeunit 408;
//         PayReceipt: Record 50095;
//         BankAccount: Record 270;
//         //Con_G_001 : TextConst 'ENU=Do you want to post Payement Receipt?';
//         SanctionAmount: Decimal;
//         PayReceiptLine: Record 50096;
//         PayReceiptHead: Record 50095;
//         Genline: Record 81;
//         //Text003 : TextConst 'ENU=Posting Payment Receipt lines     #2######';
//         LineNo: Integer;
//         GenJnlTemplate: Record 80;
//         GenJnlBatch: Record 232;
//         GenJnlPostline: Codeunit 12;
//         Window: Dialog;
//         UserGroupp: Record 50091;
//         VouTypeTab: Record 50092;
//         "G/LAccount": Record 15;

//     trigger OnInsert()
//     begin

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }