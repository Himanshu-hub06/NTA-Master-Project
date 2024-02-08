// table 50027 "Payment Receipt Header"
// {
//     DataClassification = ToBeClassified;
//     Caption = 'NTA Payment';
//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF "No." <> xRec."No." THEN BEGIN
//                     GenLedSetup.GET;
//                     NoSeriesMgt.TestManual(GenLedSetup."Payment Receipt No.");
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
//             TableRelation = Location;

//             trigger OnValidate()
//             begin
//                 IF LocTab.GET("Location Code") THEN
//                     "Location Name" := LocTab.Name
//                 ELSE
//                     "Location Name" := '';
//             end;
//         }
//         field(4; "Location Name"; Text[80])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
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
//         field(8; "User Name"; Text[80])
//         {
//             CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User Id")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(9; Status; Option)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//             OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
//             OptionMembers = Open,"Pending for Approval",Approved,Rejected;
//         }
//         field(10; "No. Series"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//             TableRelation = "No. Series";

//             trigger OnValidate()
//             begin
//                 //TESTFIELD(Release,FALSE);
//             end;
//         }
//         field(13; "Pay To."; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(29; "Shortcut Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,2,1';
//             Caption = 'Shortcut Dimension 1 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
//                                                           Blocked = CONST(false));

//             trigger OnValidate()
//             begin

//                 //ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");// RK

//                 /* DimValue.RESET;
//                  DimValue.SETRANGE(DimValue."Dimension Code",'Branch');
//                  DimValue.SETRANGE(DimValue.Code,"Shortcut Dimension 1 Code");
//                  IF DimValue.FINDFIRST THEN
//                    "Exam Name" := DimValue.Name
//                  ELSE
//                   "Exam Name" :='';*/  //rk 


//             end;
//         }
//         field(30; "Shortcut Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
//                                                           Blocked = CONST(false));

//             trigger OnValidate()
//             begin

//                 //ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");//RK
//                 /*
//                 DimValue.RESET;
//                 DimValue.SETRANGE(DimValue."Dimension Code",'Section');
//                 DimValue.SETRANGE(DimValue.Code,"Shortcut Dimension 2 Code");
//                 IF DimValue.FINDFIRST THEN
//                   "Section Name" := DimValue.Name
//                 ELSE
//                  "Section Name" :=''; */  //rk 


//             end;
//         }
//         field(31; Posted; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(32; "Bank Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Bank Account"."No.";

//             trigger OnValidate()
//             begin
//                 //BankAccount.SETRANGE(BankAccount."No.",
//                 /*IF BankAccount.GET("Bank Code") THEN
//                     "Bank Name" := BankAccount.Name
//                 ELSE
//                     "Bank Name" := '';*/ //RK
//             end;
//         }
//         field(33; "Bank Name"; Text[80])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(34; "Cheque No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(35; "Cheque Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(36; "Total Amount"; Decimal)
//         {
//             CalcFormula = Sum("Payment Receipt Line".Amount WHERE("Document No." = FIELD("No.")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(37; "Rejected Remarks"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(38; Attachment; Text[80])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(41; "Due Date Without Penalty"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(42; "Due Date With Penalty"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(43; "Payment Receipt"; Text[80])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(46; Remarks; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(47; "Payment Proposal Created"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(48; "Proposal Status"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = Open,"Pending for Approval",Approved,Rejected;
//         }
//         field(49; "Proposal Approved"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50; "Payment Done"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(51; "Proposal Remarks"; Text[150])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(52; "Transfer File User ID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             //TableRelation = "Approval User Group Member"."User Name" WHERE ("Approval User Group Code"=CONST(ALLEXP));

//             trigger OnValidate()
//             begin
//                 /* UserGroupp.RESET;
//                  UserGroupp.SETRANGE(UserGroupp."User Name", "Transfer File User ID");
//                  UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'ALLEXP');
//                  IF UserGroupp.FINDFIRST THEN
//                      "Transfer File User Name" := UserGroupp."User Description"
//                  ELSE
//                      "Transfer File User Name" := '';*/ // RK
//             end;
//         }
//         field(53; "IFSC Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60; "Transfer File User Name"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(62; "Pending From User Id"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(63; "Pending From User Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(64; "Receiving Bank Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(65; "Receipt Type"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             // TableRelation = "Voucher Type".Code WHERE ("Payment Receipt"=CONST(true)); //RK

//             trigger OnValidate()
//             begin
//                 VouTypeTab.RESET;
//                 VouTypeTab.SETRANGE(VouTypeTab."Requisition No.", "Receipt Type");
//                 IF VouTypeTab.FINDFIRST THEN BEGIN
//                     "Receipt Description" := VouTypeTab."Voucher Type Descreiption";
//                     //VALIDATE("G/L Account", VouTypeTab."Expense Account"); //rk
//                 END ELSE BEGIN
//                     "Receipt Description" := '';
//                     VALIDATE("G/L Account", '');
//                 END;
//             end;
//         }
//         field(66; "Receipt Description"; Text[120])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(67; "G/L Account"; Code[10])
//         {
//             DataClassification = ToBeClassified;

//             trigger OnValidate()
//             begin
//                 IF "G/LAccount".GET("G/L Account") THEN
//                     "G/L Acoount Name" := "G/LAccount".Name
//                 ELSE
//                     "G/L Acoount Name" := '';
//             end;
//         }
//         field(68; "G/L Acoount Name"; Text[120])
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
//                 //ShowDocDim;
//             end;
//         }
//         field(50001; "File No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50002; "Computer No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         TESTFIELD(Status, Status::Open);
//     end;

//     trigger OnInsert()
//     begin
//         IF "No." = '' THEN BEGIN
//             GenLedSetup.GET;
//             GenLedSetup.TESTFIELD(GenLedSetup."Payment Receipt No.");
//             NoSeriesMgt.InitSeries(GenLedSetup."Payment Receipt No.", xRec."No. Series", 0D, "No.", "No. Series");

//         END;
//         "Posting Date" := WORKDATE;
//         "User Id" := USERID;
//         IF Usersetup.GET(USERID) THEN
//             VALIDATE("Location Code", Usersetup."Location Code")
//         ELSE
//             VALIDATE("Location Code", '');
//     end;

//     trigger OnModify()
//     begin
//         //TESTFIELD(Status,Status::Open);
//     end;

//     var
//         GenLedSetup: Record 98;
//         NoSeriesMgt: Codeunit 396;

//         Usersetup: Record 91;
//         LocTab: Record 14;
//         DimMgt: Codeunit 408;
//         BankAccount: Record 270;
//         Con_G_001: Label 'Do you want to post Payement Receipt?';
//         SanctionAmount: Decimal;
//         PayReceiptLine: Record 50028;
//         PayReceiptHead: Record 50027;
//         Genline: Record 81;
//         Text003: Label 'Posting Payment Receipt lines     #2######';
//         LineNo: Integer;
//         GenJnlTemplate: Record 80;
//         GenJnlBatch: Record 232;
//         //GenJnlPostline: Codeunit "12";
//         Window: Dialog;
//         UserGroupp: Record 50091;
//         VouTypeTab: Record 50092;
//         "G/LAccount": Record 15;

//     procedure AssistEdit(): Boolean
//     begin
//         WITH PayReceiptHead DO BEGIN
//             PayReceiptHead := Rec;
//             GenLedSetup.GET;
//             GenLedSetup.TESTFIELD(GenLedSetup."Payment Receipt No.");
//             IF NoSeriesMgt.SelectSeries(GenLedSetup."Payment Receipt No.", xRec."No. Series", "No. Series") THEN BEGIN
//                 NoSeriesMgt.SetSeries("No.");
//                 Rec := PayReceiptHead;
//                 EXIT(TRUE);
//             END;
//         END;
//     end;

//     procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
//         //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
//     end;

//     procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
//     end;

//     // procedure ShowDocDim()
//     // var
//     //     OldDimSetID: Integer;
//     // begin

//     //     OldDimSetID := "Dimension Set ID";
//     //     "Dimension Set ID" :=
//     //       DimMgt.EditDimensionSet2(
//     //         "Dimension Set ID", STRSUBSTNO('%1 %2', '', "No."),
//     //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
//     //     /*
//     //     IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
//     //       MODIFY;
//     //       IF ReqLinesExist THEN
//     //         UpdateAllLineDim("Dimension Set ID",OldDimSetID);

//     //     END;
//     //     */

//     // end;

//     // procedure Postingtabill()
//     // begin

//     //     GenLedSetup.GET;
//     //     GenLedSetup.TESTFIELD(GenLedSetup."Payment Receipt Template");
//     //     GenLedSetup.TESTFIELD(GenLedSetup."Payment Receipt Batch");
//     //     //GenLedSetup.TESTFIELD(GenLedSetup."Electricity Account No.");
//     //     IF NOT (CONFIRM(Con_G_001, FALSE)) THEN
//     //         EXIT;
//     //     //SanctionAmount:= 0;
//     //     PayReceiptLine.RESET;
//     //     PayReceiptLine.SETFILTER(PayReceiptLine."Document No.", "No.");
//     //     IF PayReceiptLine.FIND('-') THEN BEGIN
//     //         Window.OPEN(
//     //               '#1#################################\\' +
//     //            Text003);

//     //         REPEAT
//     //             PayReceiptLine.TESTFIELD(PayReceiptLine.Amount);
//     //             Genline.SETRANGE("Journal Template Name", GenLedSetup."Payment Receipt Template");
//     //             Genline.SETRANGE("Journal Batch Name", GenLedSetup."Payment Receipt Batch");
//     //             LineNo := 10000;
//     //             IF Genline.FIND('+') THEN
//     //                 LineNo := Genline."Line No." + LineNo;
//     //             GenJnlTemplate.GET(GenLedSetup."Payment Receipt Template");
//     //             GenJnlBatch.GET(GenLedSetup."Payment Receipt Template", GenLedSetup."Payment Receipt Batch");
//     //             GenJnlBatch.TESTFIELD("No. Series");
//     //             Genline."Document No." := "No.";
//     //             Genline.VALIDATE("Account Type", Genline."Account Type"::"G/L Account");
//     //             Genline.VALIDATE("Account No.", PayReceiptLine."Account No.");
//     //             //Genline.Narrations := 'From  '+FORMAT("From Period")+' To  '+FORMAT("To Period");
//     //             Genline."Source Code" := GenJnlTemplate."Source Code";
//     //             Genline."Reason Code" := GenJnlBatch."Reason Code";
//     //             Genline."Posting No. Series" := GenJnlBatch."Posting No. Series";
//     //             Genline."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
//     //             Genline."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
//     //             Genline."Dimension Set ID" := "Dimension Set ID";
//     //             Genline.VALIDATE("Journal Template Name", GenLedSetup."Payment Receipt Template");
//     //             Genline.VALIDATE("Journal Batch Name", GenLedSetup."Payment Receipt Batch");
//     //             Genline.VALIDATE("Document Type", Genline."Document Type"::" ");
//     //             Genline.VALIDATE("Line No.", LineNo);
//     //             // Genline.VALIDATE("Account Type",Genline."Account Type":: "G/L Account");
//     //             // Genline.VALIDATE("Account No.","travel line"."Account No.");
//     //             Genline.VALIDATE("Posting Date", "Posting Date");
//     //             CALCFIELDS("Total Amount");
//     //             Genline.VALIDATE(Amount, PayReceiptLine.Amount);
//     //             Genline."Bal. Account Type" := Genline."Bal. Account Type"::"Bank Account";
//     //             Genline."Bal. Account No." := "Bank Code";
//     //             Genline."Cheque No." := "Cheque No.";
//     //             Genline."Cheque Date" := "Cheque Date";
//     //             //SanctionAmount := SanctionAmount + "travel line"."Sanction Amount";

//     //             //Genline.INSERT;

//     //             GenJnlPostline.RunWithCheck(Genline);
//     //         UNTIL PayReceiptLine.NEXT = 0;
//     //         Window.CLOSE;


//     //     END;
//     //     PayReceiptHead.RESET;
//     //     PayReceiptHead.SETRANGE(PayReceiptHead."No.", "No.");
//     //     IF PayReceiptHead.FIND('-') THEN BEGIN

//     //         PayReceiptHead.Posted := TRUE;
//     //         PayReceiptHead.MODIFY;
//     //     END;

//     //     /*
//     //        IF "Emp Type" = "Emp Type"::EMP THEN BEGIN
//     //        Genline1.SETRANGE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.SETRANGE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        LineNo1:=10000;
//     //        IF Genline1.FIND('+') THEN
//     //        LineNo1:= Genline1."Line No." + LineNo1;
//     //        Genline1."Document No.":= "No.";
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 1 Code");
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 2 Code");
//     //     //   Genline1.VALIDATE("Account Type",GenJnlBatch."Bal. Account Type");
//     //        Genline1."Account Type" := Genline1."Account Type"::Vendor;
//     //        Genline1."Account No." := "Emp Code";
//     //        Genline1.Narrations := 'From  '+FORMAT("From Period")+' To  '+FORMAT("To Period");
//     //        Genline1."Source Code":= GenJnlTemplate."Source Code";
//     //        Genline1."Reason Code":= GenJnlBatch."Reason Code";
//     //        Genline1."Posting No. Series":= GenJnlBatch."Posting No. Series";
//     //        Genline1."Shortcut Dimension 1 Code" := "travel line"."Shortcut Dimension 1 Code";
//     //        Genline1."Shortcut Dimension 2 Code" := "travel line"."Shortcut Dimension 2 Code";
//     //        Genline1."Dimension Set ID"  := "travel line"."Dimension Set ID";

//     //        Genline1.VALIDATE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.VALIDATE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        Genline1.VALIDATE("Document Type",Genline1."Document Type":: " ");
//     //        Genline1.VALIDATE("Line No.",LineNo1);
//     //        Genline1.VALIDATE("Posting Date",Date);
//     //        Genline1.VALIDATE(Amount,-SanctionAmount);
//     //        END;


//     //        IF (("Emp Type" = "Emp Type"::NFA) OR ("Emp Type" = "Emp Type"::CDO)) THEN BEGIN
//     //        Genline1.SETRANGE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.SETRANGE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        LineNo1:=10000;
//     //        IF Genline1.FIND('+') THEN
//     //        LineNo1:= Genline1."Line No." + LineNo1;
//     //        Genline1."Document No.":= "No.";
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 1 Code");
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 2 Code");
//     //        Genline1."Account Type" := Genline1."Account Type"::Vendor;
//     //        Genline1."Account No." := "Emp Code";
//     //        Genline1.Narrations := 'From  '+FORMAT("From Period")+' To  '+FORMAT("To Period");
//     //        Genline1."Source Code":= GenJnlTemplate."Source Code";
//     //        Genline1."Reason Code":= GenJnlBatch."Reason Code";
//     //        Genline1."Posting No. Series":= GenJnlBatch."Posting No. Series";
//     //        Genline1."Shortcut Dimension 1 Code" := "travel line"."Shortcut Dimension 1 Code";
//     //        Genline1."Shortcut Dimension 2 Code" := "travel line"."Shortcut Dimension 2 Code";
//     //        Genline1."Dimension Set ID"  := "travel line"."Dimension Set ID";
//     //        Genline1.VALIDATE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.VALIDATE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        Genline1.VALIDATE("Document Type",Genline1."Document Type":: " ");
//     //        Genline1.VALIDATE("Line No.",LineNo1);
//     //        Genline1.VALIDATE("Posting Date",Date);
//     //        Genline1.VALIDATE(Amount,-SanctionAmount);
//     //        END;


//     //        IF "Emp Type" = "Emp Type"::OTH THEN BEGIN
//     //        Genline1.SETRANGE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.SETRANGE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        LineNo1:=10000;
//     //        IF Genline1.FIND('+') THEN
//     //        LineNo1:= Genline1."Line No." + LineNo1;
//     //        Genline1."Document No.":= "No.";
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 1 Code");
//     //        "travel line".TESTFIELD("travel line"."Shortcut Dimension 2 Code");
//     //        Genline1."Account Type" := Genline1."Account Type"::Vendor;
//     //        Genline1."Account No." := "Emp Code";

//     //        Genline1.Narrations := 'From  '+FORMAT("From Period")+' To  '+FORMAT("To Period");
//     //        Genline1."Source Code":= GenJnlTemplate."Source Code";
//     //        Genline1."Reason Code":= GenJnlBatch."Reason Code";
//     //        Genline1."Posting No. Series":= GenJnlBatch."Posting No. Series";
//     //        Genline1."Shortcut Dimension 1 Code" := "travel line"."Shortcut Dimension 1 Code";
//     //        Genline1."Shortcut Dimension 2 Code" := "travel line"."Shortcut Dimension 2 Code";
//     //        Genline1."Dimension Set ID"  := "travel line"."Dimension Set ID";
//     //        Genline1.VALIDATE("Journal Template Name",Location."Traveller Gen. Jour. Template");
//     //        Genline1.VALIDATE("Journal Batch Name",Location."Traveller Gen. Jour. Batch");
//     //        Genline1.VALIDATE("Document Type",Genline1."Document Type":: " ");
//     //        Genline1.VALIDATE("Line No.",LineNo1);
//     //        Genline1.VALIDATE("Posting Date",Date);
//     //        Genline1.VALIDATE(Amount,-SanctionAmount);
//     //        END;

//     //       GenJnlPostline.RunWithCheck(Genline1);


//     //      TravellerHeader.SETRANGE(TravellerHeader."No.","No.");
//     //      IF TravellerHeader.FIND('-') THEN BEGIN
//     //        IF TravellerHeader."Win Tech ID"<>0 THEN BEGIN
//     //           IF DailyActivity.GET(TravellerHeader."Win Tech ID") THEN BEGIN
//     //              DailyActivity.Posted:=TRUE;
//     //              DailyActivity.MODIFY;
//     //           END;
//     //        END;
//     //        TravellerHeader.Posted := TRUE;
//     //        TravellerHeader.MODIFY;
//     //      END;
//     //      */


//     // end;

//     // procedure UploadAttachment()
//     // var
//     //     ServerFileName: Text;
//     //     ClientFileName: Text;
//     //     // FileManagement: Codeunit "419";
//     //     DialogTitle: Text;
//     //     OldFileName: Text;
//     //     FilePath: Text;
//     //     FileExtension: Text;
//     //     FileName: Text;
//     // begin
//     //     IF Attachment <> '' THEN
//     //         IF NOT CONFIRM('Attachment is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
//     //     FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PaymentReceipt\';
//     //     OldFileName := (FilePath + Attachment);
//     //     ServerFileName := FileManagement.UploadFile(DialogTitle, '');
//     //     ClientFileName := FileManagement.GetFileName(ServerFileName);
//     //     IF ClientFileName <> '' THEN BEGIN
//     //         Attachment := DELCHR("No.", '=', '/') + ClientFileName;
//     //         MODIFY(TRUE);
//     //     END;
//     //     ClientFileName := FilePath + DELCHR("No.", '=', '/') + ClientFileName;
//     //     FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
//     //     IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
//     //         FileManagement.DeleteServerFile(OldFileName);
//     //     MESSAGE('Uploaded Successfully');
//     // end;

//     // procedure DownLoadAttachment()
//     // var
//     //     OldFileName: Text;
//     //     ServerFileName: Text;
//     //     FilePath: Text;
//     // begin
//     //     FilePath := 'http://115.243.18.40/bseb_ftp/PaymentReceipt/';
//     //     OldFileName := Attachment;
//     //     IF OldFileName <> '' THEN BEGIN
//     //         ServerFileName := FilePath + OldFileName;
//     //         HYPERLINK(ServerFileName);
//     //     END;
//     // end;

//     // procedure UploadReceiptAttachment()
//     // var
//     //     ServerFileName: Text;
//     //     ClientFileName: Text;
//     //     //FileManagement: Codeunit "419";
//     //     DialogTitle: Text;
//     //     OldFileName: Text;
//     //     FilePath: Text;
//     //     FileExtension: Text;
//     //     FileName: Text;
//     // begin
//     //     IF "Payment Receipt" <> '' THEN
//     //         IF NOT CONFIRM('Attachment is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
//     //     FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PaymentReceipt\';
//     //     OldFileName := (FilePath + "Payment Receipt");
//     //     ServerFileName := FileManagement.UploadFile(DialogTitle, '');
//     //     ClientFileName := FileManagement.GetFileName(ServerFileName);
//     //     IF ClientFileName <> '' THEN BEGIN
//     //         "Payment Receipt" := DELCHR('R_' + "No.", '=', '/') + ClientFileName;
//     //         MODIFY(TRUE);
//     //     END;
//     //     ClientFileName := FilePath + DELCHR('R_' + "No.", '=', '/') + ClientFileName;
//     //     FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
//     //     IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
//     //         FileManagement.DeleteServerFile(OldFileName);
//     //     MESSAGE('Uploaded Successfully');
//     // end;

//     // procedure DownLoadReceiptAttachment()
//     // var
//     //     OldFileName: Text;
//     //     ServerFileName: Text;
//     //     FilePath: Text;
//     // begin
//     //     FilePath := 'http://115.243.18.40/bseb_ftp/PaymentReceipt/';
//     //     OldFileName := "Payment Receipt";
//     //     IF OldFileName <> '' THEN BEGIN
//     //         ServerFileName := FilePath + OldFileName;
//     //         HYPERLINK(ServerFileName);
//     //     END;
//     // end;

// }

