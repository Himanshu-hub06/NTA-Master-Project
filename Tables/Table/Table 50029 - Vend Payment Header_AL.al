table 50029 "Vendor Payment Header"
{
    DataClassification = ToBeClassified;
    Caption = 'NTA Payment';
    LookupPageID = 50005;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "No. Series";

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InvtSetup.GET;
                    NoSeriesMgt.TestManual(InvtSetup."Payment Receipt No.");
                    "No. Series" := '';

                END;
            end;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                IF LocTab.GET("Location Code") THEN
                    "Location Name" := LocTab.Name
                ELSE
                    "Location Name" := '';

            end;
        }
        field(4; "Location Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "User Name"; Text[80])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User Id")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }
        field(10; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                //TESTFIELD(Release,FALSE);
            end;
        }
        field(13; "Pay To."; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "File No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "e-office No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Budgetary Head"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                IF GLAccount.GET("Budgetary Head") THEN
                    "Budgetary Head Name" := GLAccount.Name
                ELSE
                    "Budgetary Head Name" := '';
            end;
        }
        field(17; "Budgetary Head Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin

                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code"); rk
                /*
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code",'Branch');
                DimValue.SETRANGE(DimValue.Code,"Shortcut Dimension 1 Code");
                IF DimValue.FINDFIRST THEN
                  "Exam Name" := DimValue.Name
                ELSE
                 "Exam Name" :='';
                 */

            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin

                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");//rk
                /*
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code",'Section');
                DimValue.SETRANGE(DimValue.Code,"Shortcut Dimension 2 Code");
                IF DimValue.FINDFIRST THEN
                  "Section Name" := DimValue.Name
                ELSE
                 "Section Name" :='';
                 */

            end;
        }
        field(31; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                //BankAccount.SETRANGE(BankAccount."No.",
                IF BankAccount.GET("Bank Code") THEN
                    "Bank Name" := BankAccount.Name
                ELSE
                    "Bank Name" := '';
            end;
        }
        field(33; "Bank Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Total Amount"; Decimal)
        {
            //CalcFormula = Sum("Electricity Bill Line".Amount WHERE ("Document No."=FIELD("No.")));  //RK
            Editable = false;
            //FieldClass = FlowField;
        }
        field(37; "Rejected Remarks"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(38; Attachment; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Due Date Without Penalty"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Due Date With Penalty"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Payment Receipt"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Payment Proposal Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Proposal Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }
        field(49; "Proposal Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Payment Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Proposal Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Transfer File User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Vendor Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF VendorTab.GET("Vendor Code") THEN BEGIN
                    "Vendor Name" := VendorTab.Name;
                    "Vendor Type" := VendorTab."Vendor Type"
                END
                ELSE BEGIN
                    "Vendor Name" := '';
                    "Vendor Type" := "Vendor Type"::" ";
                END;
            end;
        }
        field(61; "Vendor Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(62; "Expense Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Voucher Type"; //rk

            trigger OnValidate()
            begin
                IF ExpType.GET("Expense Type") THEN
                    "Expense Description" := ExpType."Voucher Type Descreiption"
                ELSE
                    "Expense Description" := '';
            end;
        }
        field(63; "Expense Description"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = "Voucher Type"; //rk
        }
        field(64; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Vendor Invoice No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(13730; "Vendor Type"; Option)
        {
            Caption = 'Vendor Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Manufacturer,First Stage Dealer,Second Stage Dealer,Importer,Media,Internal Advocate,External Advocate,Advocate Clerk';
            OptionMembers = " ",Manufacturer,"First Stage Dealer","Second Stage Dealer",Importer,Media,"Internal Advocate","External Advocate","Advocate Clerk";
        }
        field(50001; Month; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Integer.Number WHERE(Number = FILTER(1 .. 12));
        }
        field(50005; "Total Salary"; Decimal)
        {
            //CalcFormula = Sum("Salary Payment Line"."Amount" WHERE ("Document No."=FIELD("No."))); //RK
            //FieldClass = FlowField;
        }
        field(50006; "Amount to Vendor"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50007; "IT Tds Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50008; "GST Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50009; "GST IGST Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50010; "GST SGST Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50011; "GST CGST Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50012; "Base Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50013; "On Account Of"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Main Budgetary Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                IF GLAccount.GET("Main Budgetary Account No.") THEN
                    "Main Budgetary Name" := GLAccount.Name
                ELSE
                    "Main Budgetary Name" := '';
            end;
        }
        field(50015; "Main Budgetary Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Letter No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "EPF Contribution Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin

                IF BankAccount.GET("EPF Contribution Account") THEN
                    "EPF Contribution Account Name" := BankAccount."Name 2"
                ELSE
                    "EPF Contribution Account Name" := '';

            end;
        }
        field(50018; "EPF Contribution Account Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "EPF Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "EPF Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "EPF Letter Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Letter Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "EPF Letter No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Order Details"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Bill Book No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Voucher No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Voucher Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Expense Voucher"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Beltron Voucher"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            GenLedSetup.GET;
            // GenLedSetup.TESTFIELD(GenLedSetup."Vendor Posting No.");
            // NoSeriesMgt.InitSeries(GenLedSetup."Vendor Posting No.", xRec."No. Series", 0D, "No.", "No. Series");//rk

        END;
        "Posting Date" := WORKDATE;
        "User Id" := USERID;
        IF Usersetup.GET(USERID) THEN
            VALIDATE("Location Code", Usersetup."Location Code")
        ELSE
            VALIDATE("Location Code", '');
    end;

    var

        GenLedSetup: Record 98;
        NoSeriesMgt: Codeunit 396;
        Usersetup: Record 91;
        LocTab: Record 14;
        DimMgt: Codeunit 408;
        VenPay: Record 50029;
        BankAccount: Record 270;
        Con_G_001: Label 'Do you want to post Vendor Payment Bill?';
        SanctionAmount: Decimal;
        SalExpLine: Record 50098;
        SalExpHead: Record 50097;
        Genline: Record 81;
        Text003: Label 'Posting Vendor Payment lines     #2######';
        Genline1: Record 81;
        LineNo: Integer;
        GenJnlTemplate: Record 80;
        GenJnlBatch: Record 232;
        GenJnlPostline: Codeunit 12;
        Window: Dialog;
        VendorTab: Record 23;
        ExpType: Record 50092;
        SalaryProcessSetup: Record 50099;
        ArrAcct: array[50] of Code[20];
        ArrVal: array[20, 50] of Decimal;
        i: Integer;
        j: Integer;
        Len: Integer;
        MinusValue: Decimal;
        Employeecate: Record 50014;
        PlusValue: Decimal;
        ExternalSalMaster: Record 50100;
        "DocNo.": Code[20];
        VendPayHead: Record 50029;
        VendPayLine: Record 50030;
        GLAccount: Record 15;
        InvtSetup: Record 313;

    procedure AssistEdit(): Boolean
    begin
        WITH VendPayHead DO BEGIN
            VendPayHead := Rec;
            InvtSetup.GET;
            InvtSetup.TESTFIELD(InvtSetup."Payment Receipt No.");
            IF NoSeriesMgt.SelectSeries(InvtSetup."Payment Receipt No.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := VendPayHead;
                EXIT(TRUE);
            END;
        END;
    end;
    // procedure AssistEdit(): Boolean
    // begin

    //     WITH VenPay DO BEGIN
    //         VenPay := Rec;
    //         GenLedSetup.GET;
    //         GenLedSetup.TESTFIELD(GenLedSetup."Vendor Posting No.");
    //         IF NoSeriesMgt.SelectSeries(GenLedSetup."Vendor Posting No.", xRec."No. Series", "No. Series") THEN BEGIN
    //             NoSeriesMgt.SetSeries("No.");
    //             Rec := VenPay;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;

    // procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    //     //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    // end;

    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    // end;

    // procedure ShowDocDim()
    // var
    //     OldDimSetID: Integer;
    // begin

    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet2(
    //         "Dimension Set ID", STRSUBSTNO('%1 %2', '', "No."),
    //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    //     /*
    //     IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
    //       MODIFY;
    //       IF ReqLinesExist THEN
    //         UpdateAllLineDim("Dimension Set ID",OldDimSetID);

    //     END;
    //     */

    // end;

    // procedure Postingtabill()
    // begin

    //     GenLedSetup.GET;
    //     GenLedSetup.TESTFIELD(GenLedSetup."Gen. Jour. Template");
    //     GenLedSetup.TESTFIELD(GenLedSetup."Gen. Jour. Batch");
    //     //TESTFIELD("Bank Code");//EXP
    //     IF NOT (CONFIRM(Con_G_001, FALSE)) THEN
    //         EXIT;

    //     VendPayHead.RESET;
    //     VendPayHead.SETFILTER(VendPayHead."No.", "No.");
    //     IF VendPayHead.FIND('-') THEN BEGIN
    //         Window.OPEN(
    //               '#1#################################\\' +
    //            Text003);

    //         //REPEAT
    //         Genline.SETRANGE("Journal Template Name", GenLedSetup."Gen. Jour. Template");
    //         Genline.SETRANGE("Journal Batch Name", GenLedSetup."Gen. Jour. Batch");
    //         LineNo := 10000;
    //         IF Genline.FIND('+') THEN
    //             LineNo := Genline."Line No." + LineNo;
    //         GenJnlTemplate.GET(GenLedSetup."Gen. Jour. Template");
    //         GenJnlBatch.GET(GenLedSetup."Gen. Jour. Template", GenLedSetup."Gen. Jour. Batch");
    //         //GenJnlBatch.TESTFIELD("No. Series");//EXP


    //         Genline.VALIDATE("Journal Template Name", GenLedSetup."Gen. Jour. Template");
    //         Genline.VALIDATE("Journal Batch Name", GenLedSetup."Gen. Jour. Batch");
    //         Genline.VALIDATE("Posting Date", "Posting Date");
    //         Genline.VALIDATE("Document Type", Genline."Document Type"::Payment);
    //         Genline."Document No." := "No.";
    //         Genline.VALIDATE("Party Type", Genline."Party Type"::Vendor);
    //         Genline.VALIDATE(Genline."Party Code", "Vendor Code");
    //         Genline.VALIDATE("Account Type", Genline."Account Type"::Vendor);
    //         Genline.VALIDATE("Account No.", "Vendor Code");

    //         Genline."Source Code" := GenJnlTemplate."Source Code";
    //         Genline."Reason Code" := GenJnlBatch."Reason Code";
    //         Genline."Posting No. Series" := GenJnlBatch."Posting No. Series";
    //         Genline.VALIDATE("Shortcut Dimension 1 Code", VendPayHead."Shortcut Dimension 1 Code");
    //         Genline.VALIDATE("Shortcut Dimension 2 Code", VendPayHead."Shortcut Dimension 2 Code");
    //         Genline.VALIDATE("Dimension Set ID", VendPayHead."Dimension Set ID");
    //         Genline.VALIDATE("Line No.", LineNo);
    //         Genline.VALIDATE(Genline."Location Code", "Location Code");
    //         Genline.VALIDATE(Genline.Amount, ROUND((VendPayHead."Base Amount" + VendPayHead."GST Amount"), 1));
    //         Genline."Bal. Account Type" := Genline."Bal. Account Type"::"Bank Account";
    //         Genline."Bal. Account No." := "Bank Code";
    //         //Genline."TDS Nature of Deduction" :=
    //         /*
    //         Genline."TDS Nature of Deduction"
    //         Genline."Assessee Code"
    //         Genline."TDS/TCS %"
    //         Genline."TDS Category"
    //         Genline."GST Group Code"

    //         */
    //         IF "IT Tds Amount" <> 0 THEN BEGIN
    //             VendPayLine.RESET;
    //             VendPayLine.SETRANGE(VendPayLine."Document No.", "No.");
    //             IF VendPayLine.FINDFIRST THEN BEGIN

    //                 Genline.VALIDATE("TDS Nature of Deduction", VendPayLine."TDS Nature of Deduction");

    //                 Genline.VALIDATE("GST Group Code", VendPayLine."GST Group Code");
    //                 Genline.VALIDATE("GST TCS State Code", VendPayLine."GST TCS State Code");
    //                 Genline.VALIDATE("GST Group Type", VendPayLine."GST Group Type");
    //                 IF ("GST IGST Amount" <> 0) OR ("GST SGST Amount" <> 0) OR ("GST CGST Amount" <> 0) THEN BEGIN
    //                     Genline.VALIDATE("GST Base Amount", ((("GST IGST Amount" + "GST SGST Amount" + "GST CGST Amount") * 100) / VendPayLine."GST TDS/TCS %"));
    //                     Genline.VALIDATE("GST %", VendPayLine."GST %");
    //                     Genline.VALIDATE("GST Jurisdiction Type", VendPayLine."GST Jurisdiction Type");
    //                     Genline."GST TDS/TCS Base Amount (LCY)" := ((("GST IGST Amount" + "GST SGST Amount" + "GST CGST Amount") * 100) / VendPayLine."GST TDS/TCS %");
    //                     Genline.VALIDATE("GST TDS/TCS Base Amount", Genline."GST TDS/TCS Base Amount (LCY)");
    //                     Genline.VALIDATE(Genline."GST TCS", TRUE);
    //                 END;
    //                 //Genline."GST Place of Supply" :=
    //                 //Genline.VALIDATE("HSN/SAC Code",VendPayLine."HSN/SAC Code");

    //                 // Genline."GST Bill-to/BuyFrom State Code" :=
    //             END;






    //         END;

    //         //Genline.INSERT;
    //         // Genline.VALIDATE("Amount Excl. GST","Base Amount");//EXp
    //         Genline.VALIDATE(Amount, "Base Amount");
    //         GenJnlPostline.RunWithCheck(Genline);

    //         //UNTIL "travel line".NEXT = 0;
    //         Window.CLOSE;


    //     END;
    //     /*
    //     VendPayHead.SETRANGE(VendPayHead."No.","No.");
    //      IF VendPayHead.FIND('-') THEN BEGIN

    //              VendPayHead.Posted:=TRUE;
    //              VendPayHead.MODIFY;
    //       END;
    //       */

    // end;

    // procedure UploadAttachment()
    // var
    //     ServerFileName: Text;
    //     ClientFileName: Text;
    //     FileManagement: Codeunit 419;
    //     DialogTitle: Text;
    //     OldFileName: Text;
    //     FilePath: Text;
    //     FileExtension: Text;
    //     FileName: Text;
    // begin
    //     IF Attachment <> '' THEN
    //         IF NOT CONFIRM('Attachment is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
    //     FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\VendorPayment\';
    //     OldFileName := (FilePath + Attachment);
    //     ServerFileName := FileManagement.UploadFile(DialogTitle, '');
    //     ClientFileName := FileManagement.GetFileName(ServerFileName);
    //     IF ClientFileName <> '' THEN BEGIN
    //         Attachment := DELCHR("No.", '=', '/') + ClientFileName;
    //         MODIFY(TRUE);
    //     END;
    //     ClientFileName := FilePath + DELCHR("No.", '=', '/') + ClientFileName;
    //     FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
    //     IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
    //         FileManagement.DeleteServerFile(OldFileName);
    //     MESSAGE('Uploaded Successfully');
    // end;

    // procedure DownLoadAttachment()
    // var
    //     OldFileName: Text;
    //     ServerFileName: Text;
    //     FilePath: Text;
    // begin
    //     FilePath := 'http://115.243.18.40/bseb_ftp/VendorPayment/';
    //     OldFileName := Attachment;
    //     IF OldFileName <> '' THEN BEGIN
    //         ServerFileName := FilePath + OldFileName;
    //         HYPERLINK(ServerFileName);
    //     END;
    // end;

    // procedure UploadReceiptAttachment()
    // var
    //     ServerFileName: Text;
    //     ClientFileName: Text;
    //     FileManagement: Codeunit 419;
    //     DialogTitle: Text;
    //     OldFileName: Text;
    //     FilePath: Text;
    //     FileExtension: Text;
    //     FileName: Text;
    // begin
    //     IF "Payment Receipt" <> '' THEN
    //         IF NOT CONFIRM('Attachment is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
    //     FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\SalaryPayment\';
    //     OldFileName := (FilePath + "Payment Receipt");
    //     ServerFileName := FileManagement.UploadFile(DialogTitle, '');
    //     ClientFileName := FileManagement.GetFileName(ServerFileName);
    //     IF ClientFileName <> '' THEN BEGIN
    //         "Payment Receipt" := DELCHR('R_' + "No.", '=', '/') + ClientFileName;
    //         MODIFY(TRUE);
    //     END;
    //     ClientFileName := FilePath + DELCHR('R_' + "No.", '=', '/') + ClientFileName;
    //     FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
    //     IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
    //         FileManagement.DeleteServerFile(OldFileName);
    //     MESSAGE('Uploaded Successfully');
    // end;

    // procedure DownLoadReceiptAttachment()
    // var
    //     OldFileName: Text;
    //     ServerFileName: Text;
    //     FilePath: Text;
    // begin
    //     FilePath := 'http://115.243.18.40/bseb_ftp/SalaryPayment/';
    //     OldFileName := "Payment Receipt";
    //     IF OldFileName <> '' THEN BEGIN
    //         ServerFileName := FilePath + OldFileName;
    //         HYPERLINK(ServerFileName);
    //     END;
    // end;

    // procedure SetAmountArray()
    // var
    //     varRecordRef: RecordRef;
    //     varFieldRef: FieldRef;
    //     FieldTab: Record 2000000041;
    //     m: Integer;
    //     k: Integer;
    // begin
    //     varRecordRef.OPEN(50098, FALSE);
    //     IF varRecordRef.FINDSET THEN
    //         REPEAT
    //             m += 1;
    //             FieldTab.SETRANGE(TableNo, 50098);
    //             FieldTab.SETRANGE("No.", 50034, 50056);
    //             IF FieldTab.FINDSET THEN
    //                 REPEAT
    //                     k += 1;
    //                     varFieldRef := varRecordRef.FIELD(FieldTab."No.");
    //                     IF FieldTab."No." <= 50046 THEN
    //                         ArrVal[m] [k] := varFieldRef.VALUE
    //                     ELSE BEGIN
    //                         MinusValue := varFieldRef.VALUE;
    //                         ArrVal[m] [k] := -MinusValue;
    //                     END;
    //                 UNTIL FieldTab.NEXT = 0;
    //             Len := k;
    //             k := 0;
    //         UNTIL varRecordRef.NEXT = 0;
    // end;

    // procedure SetAccountArray(SalSet: Record "50099")
    // begin
    //     IF SalSet.GET THEN BEGIN
    //         ArrAcct[1] := SalSet."Basic Pay";
    //         ArrAcct[2] := SalSet.DA;
    //         ArrAcct[3] := SalSet.HRA;
    //         ArrAcct[4] := SalSet."Convence Allowance";
    //         ArrAcct[5] := SalSet."Medical Allowance";
    //         ArrAcct[6] := SalSet."Arrears Salary";
    //         ArrAcct[7] := SalSet."Driver Allowance";
    //         ArrAcct[8] := SalSet."Special Remunation";
    //         ArrAcct[9] := SalSet."PF Employer Contribution";
    //         ArrAcct[10] := SalSet."Pay Protection";
    //         ArrAcct[11] := SalSet."PF Extra Contribution";
    //         ArrAcct[12] := SalSet."Other Earning";
    //         ArrAcct[13] := SalSet."PF Employee Contribution";
    //         ArrAcct[14] := SalSet.GI;
    //         ArrAcct[15] := SalSet."Co-OP Deduction";
    //         ArrAcct[16] := SalSet."PF Contribution Arears";
    //         ArrAcct[17] := SalSet."Excess Salary Recover";
    //         ArrAcct[18] := SalSet."I. Tax";
    //         ArrAcct[19] := SalSet."P. Tax";
    //         ArrAcct[20] := SalSet."Union Fee";
    //         ArrAcct[21] := SalSet."Other Deduction";
    //         ArrAcct[22] := SalSet.NPS;

    //     END;
    // end;
}

