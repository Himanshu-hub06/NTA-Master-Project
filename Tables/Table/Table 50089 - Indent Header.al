table 50089 "Indent Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InvtSetup.GET;
                    NoSeriesMgt.TestManual(InvtSetup."Indent No. Series");
                    "No. Series" := '';

                END;
                /*
                NoSeries.SETRANGE(NoSeries.Code,"No. Series");
                IF NoSeries.FINDFIRST THEN BEGIN
                  "Consumption Type" := NoSeries."Consumption Type";
                   MODIFY;
                END;
                *///EXP
                TestStatusOpen()

            end;
        }
        field(10; "Rejection Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                IndentLine: Record 50090;
            begin
                TestStatusOpen();
                IndentLine.RESET;

                /*IndentLine.SETRANGE("Document No.","No.");
                IF IndentLine.FINDFIRST THEN
                  REPEAT
                    IndentLine."Due Date" := "Expiry Date";
                    IndentLine.MODIFY;
                  UNTIL IndentLine.NEXT = 0;
                 */

            end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                IndentLine: Record 50090;
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'EXAM');
                DimValue.SETRANGE(DimValue.Code, "Shortcut Dimension 1 Code");
                IF DimValue.FINDFIRST THEN
                    "Exam Name" := DimValue.Name
                ELSE
                    "Exam Name" := '';
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'Section');
                DimValue.SETRANGE(DimValue.Code, "Shortcut Dimension 2 Code");
                IF DimValue.FINDFIRST THEN BEGIN
                    "Section Name" := DimValue.Name;
                END ELSE
                    "Section Name" := '';
            end;
        }
        field(28; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location.Code;

            trigger OnValidate()
            var
                IndentLine: Record 50090;
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Location Code" := "Location Code";
                        IndentLine."Transfer form Code" := "Transfer form Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
                IF LocTab.GET("Location Code") THEN
                    "Location Name" := LocTab.Name
                ELSE
                    "Location Name" := '';
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Indent Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            var
                IndentLine: Record 50090;
            begin
                TestStatusOpen();
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Expiry Date" := "Expiry Date";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(50002; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            begin
                //LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50003; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Expr: Code[10];
                RefDate: Date;
            begin
                TestStatusOpen();
                //"Expiry Date":=CALCDATE('45D',"Posting Date"); //<<Indent days extend 45 days from 1 month

                "Expiry Date" := CALCDATE('10D', "Posting Date"); //<<Indent expire date 10 Days suggest by Mr. Farhat
            end;
        }
        field(50004; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50005; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending for Approval,Approved,Closed,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Closed,Rejected;
        }
        field(50006; "Bin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Category Code';
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Bin Code" := "Bin Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(50007; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                IndentLine: Record 50090;
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Expiry Date" := "Expiry Date";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(50008; "Location Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "Approved By"; Text[80])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                       Status = CONST(Approved)));
            FieldClass = FlowField;
        }
        field(50011; "Indented By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Exam Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Approving UID"; Code[50])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."),
                                                                       Status = CONST(Approved)));
            FieldClass = FlowField;
            TableRelation = "User Setup";
        }
        field(50020; "Approving Date and Time"; DateTime)
        {
            CalcFormula = Lookup("Approval Entry"."Last Date-Time Modified" WHERE("Document No." = FIELD("No."),
                                                                                   Status = CONST(Approved)));
            FieldClass = FlowField;
        }
        field(50021; "Approving Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Sent for Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Transfer Order"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);//REL_ARV
            end;
        }
        field(50052; "Transfer form Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //>>REL_ARV-Transfer Indnet
                TESTFIELD(Status, Status::Open);
                TESTFIELD("Transfer Order", TRUE);
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN
                    REPEAT
                        IndentLine."Transfer form Code" := "Transfer form Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;

                //<<REL_ARV-Transfer Indnet
            end;
        }
        field(50053; "Blanket Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Sell-to Customer No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50055; "Transfer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'As Per Schedule,Urgent';
            OptionMembers = "As Per Schedule",Urgent;
        }
        field(50057; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Posting Time"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Consumption Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Revenue,Capital';
            OptionMembers = " ",Revenue,Capital;

            trigger OnValidate()
            begin
                /*
                RequistionLine.SETRANGE(RequistionLine."Requisition No.","No.");
                IF RequistionLine.FINDFIRST THEN BEGIN
                  RequistionLine."Consumption Type" := "Consumption Type";
                  RequistionLine.MODIFY;
                END;
                 *///SLS

            end;
        }
        field(50108; "Sending UID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Sending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Sending Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; Attachment; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Rejected Remarks"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60003; "Manual Close"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60005; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Send For Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "From Planning Sheet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60011; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Direct,Quotation,GeM,Tender;

            trigger OnValidate()
            begin
                /*
                CALCFIELDS("Estimated Cost Including GST");
                IF "Purchase Type" = "Purchase Type"::Direct THEN BEGIN
                PurchaseCon.SETRANGE(PurchaseCon."Purchase Type","Purchase Type"::Direct);
                
                IF PurchaseCon.FINDFIRST THEN BEGIN
                  MESSAGE('%1-%2-%3',PurchaseCon."From Amount",PurchaseCon."To Amount","Estimated Cost Including GST");
                   IF NOT ((PurchaseCon."From Amount" >= "Estimated Cost Including GST") AND (PurchaseCon."To Amount" <= "Estimated Cost Including GST")) THEN
                     ERROR('You cannot select %1 Purchase Type',"Purchase Type");
                END;
                END;
                //ELSE
                //ERROR('You cannot select %1 Purchase Type',"Purchase Type");
                */

            end;
        }
        field(60013; "Proposal Created Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Proposal Created Date" < "Indent Date" THEN
                    ERROR('Praposal Created Date always greater Than Indent Date');
            end;
        }
        field(60014; "Estimated Cost Including GST"; Decimal)
        {
            CalcFormula = Sum("Indent Line"."Estimated Cost Including GST" WHERE("Document No." = FIELD("No."),
                                                                                  "Select Item For Proposal" = CONST(true)));
            FieldClass = FlowField;
        }
        field(60025; "Converted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60026; "Purchase Proposal Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60027; "Purchase Proposal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60028; "File No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60029; "Transfer User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" WHERE("Approval User Group Code" = CONST('INDENT'));

            trigger OnValidate()
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE(UserGroupp."User ID", "Transfer User Id");
                UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'INDENT');
                IF UserGroupp.FINDFIRST THEN begin
                    UserGroupp.CalcFields(UserGroupp."User Full Name");
                    "Transfer User name" := UserGroupp."User Full Name";
                end
                ELSE
                    "Transfer User name" := '';
            end;
        }
        field(60030; "Transfer User name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60031; "Pending From User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60032; "Pending From User Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60033; "Approver Name"; Text[120])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Approved By")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60034; "Rejected by Name"; Text[120])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Rejected By")));
            Editable = false;
            FieldClass = FlowField;
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
        fieldgroup(DropDown; "No.", "Indent Date", "Location Code", Status)
        {
        }
    }

    trigger OnDelete()
    begin
        IF Posted THEN
            ERROR('You can not delete posted Data');
        IndentLine2.RESET;
        IndentLine2.SETRANGE("Document No.", "No.");
        IF IndentLine2.FINDFIRST THEN
            REPEAT
                IndentLine2.DELETE;
            UNTIL IndentLine2.NEXT = 0;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            InvtSetup.GET;
            InvtSetup.TESTFIELD(InvtSetup."Indent No. Series");
            NoSeriesMgt.InitSeries(InvtSetup."Indent No. Series", xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        VALIDATE("Posting Date", WORKDATE);
        "Indent Date" := WORKDATE;
        "Indented By" := USERID;
        "User ID" := USERID;

        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            // VALIDATE("Shortcut Dimension 1 Code",UserSetup."Branch Code");
            VALIDATE("Shortcut Dimension 2 Code", UserSetup.Section);
            VALIDATE("Location Code", UserSetup."Location Code");
        END;
    end;

    var
        LoginMgt: Codeunit 418;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvtSetup: Record 313;
        NoSeriesCode: Code[20];
        IndentLine: Record 50090;
        InvtComnt: Record 5748;
        // DimMgt: Codeunit DimensionManagement;
        DimMgt: Codeunit "DimensionManagement Ext";//Custome Codeunit

        UserSetup: Record 91;
        UserMgt: Codeunit 5700;
        Text0001: Label 'Status must be Open for Indent %1';
        Text002: Label 'You cannot rename a %1.';
        IndentLine2: Record 50090;
        LocRec: Record 14;
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        IndentLine_gRec: Record 50090;
        UserSetup_gRec: Record 91;
        DimValue: Record 349;
        ReqHead: Record 50087;
        ReqLine: Record 50088;
        NoSeries: Record 308;
        LocTab: Record 14;
        FilePath: Text[100];
        UserGroupp: Record 50082;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="OldIndentHeader">Record 50172.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(OldIndentHeader: Record 50089): Boolean
    begin
        UserSetup.GET(USERID);
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Indent No. Series");
        IF NoSeriesMgt.SelectSeries(InvtSetup."Indent No. Series", OldIndentHeader."No. Series", "No. Series") THEN BEGIN

            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    /// <summary>
    /// TestStatusOpen.
    /// </summary>
    procedure TestStatusOpen()
    begin
        IF Status <> Status::Open THEN
            ERROR(Text0001, "No.");
    end;

    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        /*
        IF "No." <> '' THEN
          MODIFY;
        
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
          MODIFY;
          IF IndentLinesExist THEN
            UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
        
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "No." <> '' THEN
          DimMgt.SaveDocDim(
            DATABASE::"Indent Header",6{"Document Type"},"No.",0,FieldNumber,ShortcutDimCode)
        ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */

    end;

    /// <summary>
    /// ReleasedDoc.
    /// </summary>
    procedure ReleasedDoc()
    begin
        IF Status = Status::"Pending for Approval" THEN
            ERROR('Document Must be open');
    end;

    /// <summary>
    /// Release.
    /// </summary>
    procedure Release()
    begin
        /*
TESTFIELD("Shortcut Dimension 1 Code");
TESTFIELD("Shortcut Dimension 2 Code");
TESTFIELD("Location Code");
IF "Sale Order No." = '' THEN
TESTFIELD(Approved);

IF Status <> Status::Released THEN BEGIN
Status := Status::Released;
MESSAGE('Document no. %1 has successfully released',"No.");
END;
         */

    end;

    /// <summary>
    /// Reopen.
    /// </summary>
    procedure Reopen()
    begin
        TESTFIELD("Shortcut Dimension 1 Code");
        TESTFIELD("Shortcut Dimension 2 Code");
        TESTFIELD("Location Code");

        "Approved By" := USERID;
        IF Status = Status::"Pending for Approval" THEN BEGIN
            IndentLine.SETRANGE("Document No.", "No.");
            IndentLine.SETFILTER("Purchase Order No.", '<>%1', '');
            IF IndentLine.FINDFIRST THEN
                ERROR('Indent line used in Purchase order');
            "Send For Approval" := FALSE;
            Status := Status::Open;
            MODIFY;
            MESSAGE('Document no. %1 has successfully Send for Department', "No.");
        END;
    end;

    /// <summary>
    /// Approval.
    /// </summary>
    procedure Approval()
    begin
        TESTFIELD("Shortcut Dimension 1 Code");
        TESTFIELD("Shortcut Dimension 2 Code");
        TESTFIELD("Location Code");
        "Send For Approval" := TRUE;
    end;

    /// <summary>
    /// Approve.
    /// </summary>
    procedure Approve()
    begin
        "Approved By" := USERID;
        Approved := TRUE;

        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "No.");
        IF IndentLine.FINDFIRST THEN
            REPEAT
                IndentLine.Approved := TRUE;
                IndentLine.MODIFY;
            UNTIL IndentLine.NEXT = 0;

        IF Status <> Status::"Pending for Approval" THEN BEGIN
            Status := Status::"Pending for Approval";
            MESSAGE('Document no. %1 has successfully Approve and Released', "No.");
        END;
    end;

    /// <summary>
    /// SendforAppReq_gFnc.
    /// </summary>
    procedure SendforAppReq_gFnc()
    begin
        IndentLine_gRec.RESET;
        IndentLine_gRec.SETRANGE("Document No.", "No.");
        IF IndentLine_gRec.FINDFIRST THEN
            REPEAT
                IndentLine_gRec.TESTFIELD(Quantity);
            //IndentLine_gRec.TESTFIELD(IndentLine_gRec."Sub Cost Center");
            UNTIL IndentLine_gRec.NEXT = 0;


        IF CONFIRM(Text001_gTxt, FALSE) THEN BEGIN
            Status := Status::"Pending for Approval";
            "Send For Approval" := TRUE;
            MESSAGE(Text002_gTxt, "No.");
            MODIFY;

            IndentLine_gRec.RESET;
            IndentLine_gRec.SETRANGE("Document No.", "No.");
            IF IndentLine_gRec.FINDFIRST THEN BEGIN
                REPEAT
                    IndentLine_gRec.TESTFIELD(IndentLine_gRec.Quantity);
                    IndentLine_gRec.Status := IndentLine_gRec.Status::"Pending for Approval";
                    IndentLine_gRec.MODIFY;
                UNTIL IndentLine_gRec.NEXT = 0;
            END;
        END;
    end;

    /// <summary>
    /// ApprovedReq_gFnc.
    /// </summary>
    procedure ApprovedReq_gFnc()
    begin
        IF CONFIRM(Text003_gTxt, FALSE) THEN BEGIN
            IF UserSetup_gRec.GET(USERID) THEN
                UserSetup_gRec.TESTFIELD(UserSetup_gRec."Requisition Approval");
            Status := Status::Approved;
            Approved := TRUE;
            //"Approved Date Time" := CURRENTDATETIME;
            "Approved By" := USERID;
            MESSAGE(Text004_gTxt, "No.");
            MODIFY;

            IndentLine_gRec.RESET;
            IndentLine_gRec.SETRANGE("Document No.", "No.");
            IF IndentLine_gRec.FINDFIRST THEN BEGIN
                REPEAT
                    IndentLine_gRec.Status := IndentLine_gRec.Status::Approved;
                    IndentLine_gRec.MODIFY;
                UNTIL IndentLine_gRec.NEXT = 0;
            END;
        END;
    end;

    /// <summary>
    /// SendForApproval.
    /// </summary>
    procedure SendForApproval()
    var
        //  SMTP: Codeunit "400";
        MailToEmailID: Text;
        LoopCounter: Integer;
        Subject: Text;
        Body: Text;
        Window: Dialog;
        Text0001: Label 'Item No.                  ###################1###################';
        UserSetup: Record 91;
        LastArchieveVersion: Integer;
        SenderAddress: Text[100];
        Recipient: Text[200];
        SenderName: Text[100];
    begin
        /*
        UserSetup.RESET;
        UserSetup.SETRANGE(UserSetup."User ID",USERID);
        IF UserSetup.FIND('-') THEN BEGIN
          SenderAddress:=UserSetup."Sender's Email ID";
          Recipient :=UserSetup."Receiver's Email ID" ;
          SenderName := "User ID";
        END;
        
        LoopCounter := 0;
        
        Window.OPEN('Creating Email....\' + Text0001);
        Subject := '';
        Body := '';
        
        Subject := 'Indent for Approval ' + "No." + ' Requested By: ' + USERID;
        
        
        SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,'',TRUE);
        
        SMTP.AppendBody('Dear Sir, ');
        SMTP.AppendBody('<br>');
        SMTP.AppendBody('Please Approve Indent No. ' + "No.");
        SMTP.AppendBody('<br><br>');
        SMTP.AppendBody('Branch-' + "Shortcut Dimension 1 Code");
        SMTP.AppendBody('<br>');
        //SMTP.AppendBody('Department-' + Department);
        SMTP.AppendBody('<br>');
        SMTP.AppendBody('<Table border="1">');
        SMTP.AppendBody('<tr>');
        SMTP.AppendBody('<th>Item Code</th>');
        SMTP.AppendBody('<th>Item Description</th>');
        SMTP.AppendBody('<th>Requested Quantity</th>');
        SMTP.AppendBody('<th>Requested Date</th>');
        SMTP.AppendBody('<th>Available Stock</th>');
        SMTP.AppendBody('<th>Remarks</th>');
        SMTP.AppendBody('</tr>');
        //SMTP.AppendBody('<tr>');
        
        LoopCounter += 1;
        IndentLine.SETRANGE("Document No.","No.");
        IF IndentLine.FINDFIRST THEN BEGIN
          REPEAT
            IF LoopCounter = 1 THEN
              BEGIN
                SMTP.AppendBody('<tr>');
                SMTP.AppendBody('<td>'+ IndentLine."No." +'</td>');
                SMTP.AppendBody('<td>'+ IndentLine.Description +'</td>');
                SMTP.AppendBody('<td>'+ FORMAT(IndentLine.Quantity) +'</td>');
                SMTP.AppendBody('<td>'+ FORMAT("Indent Date") +'</td>');
                SMTP.AppendBody('<td>'+ FORMAT(IndentLine."Stock In Hand") +'</td>');
                SMTP.AppendBody('<td>'+ IndentLine.Remarks +'</td>');
                SMTP.AppendBody('</tr>');
              END;
          UNTIL IndentLine.NEXT =0;
        END;
        
        SMTP.AppendBody('</table>');
        SMTP.AppendBody('<br><br>');
        SMTP.AppendBody('<br><br>');
        SMTP.AppendBody('Thanks');
        SMTP.AppendBody('<br>');
        SMTP.AppendBody(SenderName);
        
        //SMTP.AddBCC(UserSetup."E-Mail");
        SLEEP(50);
        SMTP.Send;
        "Email Sent" := TRUE;
        MODIFY;
        MESSAGE('E-Mail Sent Successfully');
        *///EXP

    end;

    /// <summary>
    /// FillfromReq.
    /// </summary>
    /// <param name="Rec">Record "50172".</param>
    procedure FillfromReq(Rec: Record 50089)
    var
        Text000: Label 'Indent Line already exist do you want to regenerate Indent Line?';
    begin
        TESTFIELD("Requisition No.");
        IndentLine2.RESET;
        IndentLine2.SETRANGE(IndentLine2."Document No.", "No.");
        IF IndentLine2.FINDFIRST THEN
            IF NOT CONFIRM(Text000, FALSE) THEN
                EXIT;

        IndentLine2.DELETEALL(TRUE);
        ReqLine.RESET;
        ReqLine.SETRANGE(ReqLine."Requisition No.", "Requisition No.");
        IF ReqLine.FINDFIRST THEN BEGIN
            REPEAT
                IndentLine."Requisition No." := ReqLine."Requisition No.";
                IndentLine."Requisition Line No." := ReqLine."Line No.";
                IndentLine."Document No." := "No.";
                IndentLine."Line No." := ReqLine."Line No.";
                IndentLine.Type := ReqLine.Type;
                IndentLine.VALIDATE("No.", ReqLine."No.");
                IndentLine.Description := ReqLine.Description;
                IndentLine."Unit Of Measure Code" := ReqLine."Unit of Measure Code";
                IndentLine.Quantity := ReqLine."Remaining Qty";
                IndentLine."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
                IndentLine."Shortcut Dimension 2 Code" := ReqLine."Shortcut Dimension 2 Code";
                IndentLine.VALIDATE("Location Code", "Location Code");
                IndentLine."Due Date" := ReqLine."Required By Date";
                IndentLine.INSERT;
            UNTIL ReqLine.NEXT = 0;

        END;
    end;

    /// <summary>
    /// ShowDocDim.
    /// </summary>
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', '', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF IndentLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    /// <summary>
    /// IndentLinesExist.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IndentLinesExist(): Boolean
    begin

        IndentLine.RESET;
        IndentLine.SETRANGE(IndentLine."Document No.", "No.");
        EXIT(IndentLine.FINDFIRST);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record 904;
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "No.");
        IndentLine.LOCKTABLE;
        IF IndentLine.FINDFIRST THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(IndentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF IndentLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    IndentLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      IndentLine."Dimension Set ID", IndentLine."Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 2 Code");
                    IndentLine.MODIFY;

                END;
            UNTIL IndentLine.NEXT = 0;
    end;

    /// <summary>
    /// UploadAttachment.
    /// </summary>
    procedure UploadAttachment()
    var
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
    begin
        FilePath := 'C:\Purchase\';
        OldFileName := (FilePath + Attachment);
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ClientFileName);
        IF ClientFileName <> '' THEN BEGIN
            Attachment := DELCHR("No.", '=', '/') + '.' + FileExtension;
            MODIFY(TRUE);
        END ELSE BEGIN
            Attachment := '';
            MODIFY(TRUE);
        END;

        ClientFileName := FilePath + DELCHR("No.", '=', '/') + '.' + FileExtension;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
            FileManagement.DeleteServerFile(OldFileName);

        MESSAGE('Upload successfully');
    end;

    /// <summary>
    /// DownloadAttachment.
    /// </summary>
    procedure DownloadAttachment()
    var
        OldFileName: Text;
        ServerFileName: Text;
    begin
        /*IF Attachment <> '' THEN BEGIN
          //HYPERLINK(InvSetup."WritCase File Path" + "File Name");
          OldFileName:=Attachment;
          ServerFileName:='C:\Purchase\' + Attachment;
          DOWNLOAD(ServerFileName,'','','',OldFileName);
        END;
        */
        FilePath := 'http://115.243.18.40/bseb_ftp/Requisition/';
        IF Attachment <> '' THEN BEGIN
            OldFileName := Attachment;
            ServerFileName := FilePath + Attachment;
            HYPERLINK(ServerFileName);
        END;

    end;

    /// <summary>
    /// SetSecurityFilter.
    /// </summary>
    procedure SetSecurityFilter()
    var
        UserSetup: Record 91;
    begin

        UserSetup.GET(USERID);
        FILTERGROUP(2);
        IF UserSetup."Store Emp" THEN
            SETFILTER("Location Code", '%1', UserSetup."Location Code");

        /*
        IF NOT UeserSetup."Store Emp" THEN
        
          SETFILTER("User ID",'%1',USERID)
          ELSE
          SETFILTER("Requisition to Section",'%1',UserSetup."Store Section");
          */
        FILTERGROUP(0);

    end;
}

