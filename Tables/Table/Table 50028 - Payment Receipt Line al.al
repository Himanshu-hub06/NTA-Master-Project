// table 50028 "Payment Receipt Line"
// {
//     Caption = 'Payment Line';
//     DataClassification = ToBeClassified;
//     fields
//     {
//         field(1; "Document No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Line No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; "DDO No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; Description; Text[80])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(5; "From Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; "To Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(7; Amount; Decimal)
//         {
//             DataClassification = ToBeClassified;

//             // trigger OnValidate()
//             // begin
//             //     GetHeader;
//             //     TestStatus;
//             // end;
//         }
//         field(8; "Customer Account No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9; "Bill No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10; "Post Meter Reading"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11; "Post Meter Reading Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; "Present Meater Reading"; Integer)
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF "Post Meter Reading" > "Present Meater Reading" THEN
//                     ERROR('Present meter reading ISCLEAR less than past meter reading');
//                 "Difference Meter Reading" := "Present Meater Reading" - "Post Meter Reading";
//             end;
//         }
//         field(13; "Present Meater Reading Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14; "Difference Meter Reading"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15; "Account Type"; Option)
//         {
//             Caption = 'Account Type';
//             DataClassification = ToBeClassified;
//             OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
//             OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";

//             trigger OnLookup()
//             begin
//                 // TestStatus;
//             end;

//             trigger OnValidate()
//             var
//             // GSTComponent: Record "16405";
//             begin
//             end;
//         }
//         field(16; "Account No."; Code[20])
//         {
//             Caption = 'Account No.';
//             DataClassification = ToBeClassified;
//             TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
//                                                                                       Blocked = CONST(false))
//             ELSE
//             IF ("Account Type" = CONST(Customer)) Customer
//             ELSE
//             IF ("Account Type" = CONST(Vendor)) Vendor
//             ELSE
//             IF ("Account Type" = CONST("Bank Account")) "Bank Account"
//             ELSE
//             IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";

//             trigger OnValidate()
//             begin
//                 // // TestStatus;
//                 // // GetHeader;
//                 CASE "Account Type" OF
//                     "Account Type"::"G/L Account":
//                         BEGIN
//                             GLAccount.GET("Account No.");
//                             GLAccount.TESTFIELD("GLAccount".Blocked, FALSE);
//                             //UpdateDescription("G/LAccount".Name);
//                             IF "Account No." <> '' THEN
//                                 Description := "GLAccount".Name
//                             ELSE
//                                 Description := '';
//                         END;
//                     "Account Type"::"Bank Account":
//                         BEGIN
//                             BankAcc.GET("Account No.");
//                             BankAcc.TESTFIELD(Blocked, FALSE);
//                             UpdateDescription(BankAcc.Name);
//                         END;
//                 END;

//                 // "Account Type"::Customer:
//                 //   UpdateAccNoCustomer;
//                 // "Account Type"::Vendor:
//                 //   UpdateAccNoVendor;
//                 // "Account Type"::"Bank Account":
//                 //   BEGIN
//                 //     BankAcc.GET("Account No.");
//                 //     BankAcc.TESTFIELD(Blocked, FALSE);
//                 //     IF ReplaceDescription THEN
//                 //         UpdateDescription(BankAcc.Name); // rk


//             end;
//         }
//         field(40; "Shortcut Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,2,1';
//             Caption = 'Shortcut Dimension 1 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
//                                                           Blocked = CONST(false));

//             trigger OnValidate()
//             begin
//                 //ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
//             end;
//         }
//         field(41; "Shortcut Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
//                                                           Blocked = CONST(false));

//             trigger OnValidate()
//             begin
//                 //ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
//             end;
//         }
//         field(42; "Posting Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(43; "Location Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Location;
//         }
//         field(44; Remarks; Text[80])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(54; "Customer No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer;

//             trigger OnValidate()
//             begin
//                 IF CustTab.GET("Customer No.") THEN
//                     "Customer Name" := CustTab.Name
//                 ELSE
//                     "Customer Name" := '';  // rk
//             end;
//         }
//         field(55; "Customer Name"; Text[80])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(56; "Payment Receipt Type"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             //TableRelation = "Voucher Type".Code WHERE("Payment Receipt"=CONST(true));//rk

//             // trigger OnValidate()
//             // begin
//             //     IF VoucherRec.GET("Payment Receipt Type") THEN
//             //         "Payment Receipt Name" := VoucherRec."Voucher Type Descreiption"
//             //     ELSE
//             //         "Payment Receipt Name" := '';
//             // end; //rk
//         }
//         field(57; "Payment Receipt Name"; Text[80])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(58; "Applied Document No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(59; "Serial No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60; "Date Receiving By The Section"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(61; "Receiving Section"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(62; "Date of Hand Over The IPO"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(63; "Received Name"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(64; "Head of Account"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(65; "Issuing Bank Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(66; "Draft No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(67; "Date Of Instrument"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(68; "Date Of Hand Over to Bank"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(69; "Date of Receipt Section"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(70; "Letter No."; Code[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(71; "Letter Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(72; "Particulars/Head of Account"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(73; "Receipt Type"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(74; "Receipt Description"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(480; "Dimension Set ID"; Integer)
//         {
//             Caption = 'Dimension Set ID';
//             DataClassification = ToBeClassified;
//             Editable = false;
//             TableRelation = "Dimension Set Entry";

//             trigger OnLookup()
//             begin
//                 //ShowDimensions;
//             end;
//         }
//         field(50001; "GST Group Code"; Code[20])
//         {
//             Caption = 'GST Group Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "GST Group";

//             trigger OnValidate()
//             begin
//                 /*
//                 //TestStatusOpen;
//                 TESTFIELD("Work Tax Nature Of Deduction",'');
//                 "HSN/SAC Code" := '';
//                 VALIDATE("GST Reverse Charge",FALSE);
//                 IF "GST Group Code" <> '' THEN BEGIN
//                   "Service Tax Group" := '';
//                   "Service Tax Registration No." := '';
//                 END;
//                 IF GSTGroup.GET("GST Group Code") THEN BEGIN
//                   "GST Group Type" := GSTGroup."GST Group Type";
//                   GetPurchHeader;
//                   "GST Reverse Charge" :=
//                     PurchHeader."GST Vendor Type" IN [PurchHeader."GST Vendor Type"::Import,
//                                                       PurchHeader."GST Vendor Type"::Unregistered,
//                                                       PurchHeader."GST Vendor Type"::SEZ];
//                   IF PurchHeader."GST Vendor Type"= PurchHeader."GST Vendor Type"::Registered THEN
//                     VALIDATE("GST Reverse Charge",GSTGroup."Reverse Charge");

//                   IF ("GST Group Type" = "GST Group Type"::Service) OR (Type = Type::"Charge (Item)") THEN BEGIN
//                     TESTFIELD("Custom Duty Amount",0);
//                     TESTFIELD("GST Assessable Value",0);
//                     END;
//                 END;*/// rk


//             end;
//         }
//         field(50002; "GST Group Type"; Option)
//         {
//             Caption = 'GST Group Type';
//             DataClassification = ToBeClassified;
//             Editable = false;
//             OptionCaption = 'Goods,Service';
//             OptionMembers = Goods,Service;
//         }
//         field(50003; "HSN/SAC Code"; Code[8])
//         {
//             Caption = 'HSN/SAC Code';
//             DataClassification = ToBeClassified;
//             //TableRelation = HSN/SAC.Code WHERE (GST Group Code=FIELD(GST Group Code)); //rk

//             trigger OnValidate()
//             begin
//                 //TestStatusOpen;
//             end;
//         }
//         field(50004; "GST Base Amount"; Decimal)
//         {
//             Caption = 'GST Base Amount';
//             DataClassification = ToBeClassified;
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 "GST %" := 0;
//                 "Total GST Amount" := 0;
//             end;
//         }
//         field(50005; "GST %"; Decimal)
//         {
//             Caption = 'GST %';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50006; "Total GST Amount"; Decimal)
//         {
//             Caption = 'Total GST Amount';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50007; "GST TDS/TCS Amount (LCY)"; Decimal)
//         {
//             Caption = 'GST TDS Amount (LCY)';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50008; "GST TDS/TCS"; Boolean)
//         {
//             Caption = 'GST TDS';
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             var
//             //GSTGroup: Record "16404";
//             begin
//                 /*
//                 IF "GST TDS/TCS" THEN
//                   "GST TDS/TCS Base Amount" := "GST Base Amount"
//                 ELSE
//                   "GST TDS/TCS Base Amount" := 0;
//                 IF "GST TDS/TCS"  = TRUE THEN BEGIN
//                   TESTFIELD("GST TCS State Code");
//                   GSTTDS.RESET;
//                   GSTTDS.SETRANGE(GSTTDS."GST Jurisdiction",GSTTDS."GST Jurisdiction"::Interstate);
//                   GSTTDS.SETRANGE(GSTTDS.Type,GSTTDS.Type::TCS);
//                  IF GSTTDS.FINDFIRST THEN BEGIN
//                     "GST TDS/TCS %" := GSTTDS."GST TDS/TCS %";
//                     "GST TDS/TCS Amount (LCY)" := (("GST TDS/TCS Base Amount" * GSTTDS."GST TDS/TCS %") / 100);

//                     END;
//                 END ELSE
//                   BEGIN
//                 "GST TDS/TCS Amount (LCY)"  := 0;
//                  END;*/// rk


//             end;
//         }
//         field(50009; "GST TCS State Code"; Code[10])
//         {
//             Caption = 'GST TDS State Code';
//             DataClassification = ToBeClassified;
//             TableRelation = State;

//             trigger OnValidate()
//             begin
//                 //TESTFIELD("GST TCS",FALSE);
//             end;
//         }
//         field(50010; "GST TDS/TCS Base Amount"; Decimal)
//         {
//             Caption = 'GST TDS Base Amount';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50011; "GST TDS/TCS %"; Decimal)
//         {
//             Caption = 'GST TDS %';
//             DataClassification = ToBeClassified;
//             Editable = false;

//             trigger OnValidate()
//             var
//             //GSTGroup: Record "16404";
//             begin
//                 /*
//                 IF "GST TDS/TCS"  = TRUE THEN BEGIN
//                   GSTTDS.RESET;
//                   GSTTDS.SETRANGE(GSTTDS."GST Jurisdiction",GSTTDS."GST Jurisdiction"::Interstate);
//                   GSTTDS.SETRANGE(GSTTDS.Type,GSTTDS.Type::TCS);
//                  IF GSTTDS.FINDFIRST THEN BEGIN
//                    MESSAGE('%1-%2',"GST TDS/TCS Base Amount",GSTTDS."GST TDS/TCS %");
//                     "GST TDS/TCS Amount (LCY)" := (("GST TDS/TCS Base Amount" * GSTTDS."GST TDS/TCS %") / 100);
//                     END;
//                 END ELSE
//                   BEGIN
//                 "GST TDS/TCS Amount (LCY)"  := 0;
//                  END;
//                 */  // rk

//             end;
//         }
//         field(50030; "Applied To Entry No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1; "Document No.", "Line No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         GetHeader;
//     end;

//     var
//         PayRecHead: Record 50027;
//         "GLAccount": Record "G/L Account";
//         BankAcc: Record "Bank Account";
//         DimMgt: Codeunit 408;
//         //CustTab: Record cus;
//         VoucherRec: Record 50092;
//         CustTab: Record 18;

//     local procedure GetHeader()
//     begin
//         PayRecHead.RESET;
//         PayRecHead.SETRANGE(PayRecHead."No.", "Document No.");
//         IF PayRecHead.FINDFIRST THEN BEGIN
//             "Posting Date" := PayRecHead."Posting Date";
//             "Location Code" := PayRecHead."Location Code";
//             "Receipt Type" := PayRecHead."Receipt Type";
//             "Receipt Description" := PayRecHead."Receipt Description";
//             //  "Customer No." := PayRecHead."Customer No.";
//             // "Customer Name" := PayRecHead."Customer Name";
//             // "Payment Receipt Type":= PayRecHead."Payment Receipt Type";
//             // "Payment Receipt Name" := PayRecHead."Payment Receipt Name";
//         END;
//     end;

//     local procedure UpdateDescription(Name: Text[80])
//     begin
//         IF NOT IsAdHocDescription THEN
//             Description := Name;
//     end;

//     local procedure IsAdHocDescription(): Boolean
//     var
//         GLAccount: Record 15;
//         Customer: Record 18;
//         Vendor: Record 23;
//         BankAccount: Record 270;
//         FixedAsset: Record 5600;
//         ICPartner: Record 413;
//     begin
//         IF Description = '' THEN
//             EXIT(FALSE);
//         IF xRec."Account No." = '' THEN
//             EXIT(TRUE);

//         CASE xRec."Account Type" OF
//             xRec."Account Type"::"G/L Account":
//                 EXIT(GLAccount.GET(xRec."Account No.") AND (GLAccount.Name <> Description));
//             xRec."Account Type"::Customer:
//                 EXIT(Customer.GET(xRec."Account No.") AND (Customer.Name <> Description));
//             xRec."Account Type"::Vendor:
//                 EXIT(Vendor.GET(xRec."Account No.") AND (Vendor.Name <> Description));
//             xRec."Account Type"::"Bank Account":
//                 EXIT(BankAccount.GET(xRec."Account No.") AND (BankAccount.Name <> Description));
//             xRec."Account Type"::"Fixed Asset":
//                 EXIT(FixedAsset.GET(xRec."Account No.") AND (FixedAsset.Description <> Description));

//         END;
//         EXIT(FALSE);
//     end;

//     procedure TestStatus()
//     begin
//         PayRecHead.RESET;
//         PayRecHead.SETRANGE(PayRecHead."No.", "Document No.");
//         PayRecHead.SETFILTER(PayRecHead.Status, '<>%1', PayRecHead.Status::Open);
//         IF PayRecHead.FINDFIRST THEN
//             ERROR('Document Must be Open');
//     end;

//     procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
//         DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
//     end;

//     procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
//     end;
// }

