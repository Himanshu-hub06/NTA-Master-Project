table 50096 "Purchase Proposal Header"
{

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Purchase Proposal Nos.");
                    "No. Series" := '';

                END;

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
                PurchPraposalLine.RESET;
                PurchPraposalLine.SETRANGE("Document No.", "No.");
                IF PurchPraposalLine.FINDFIRST THEN
                    REPEAT
                        PurchPraposalLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        PurchPraposalLine.MODIFY;
                    UNTIL PurchPraposalLine.NEXT = 0;
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
                PurchPraposalLine.RESET;
                PurchPraposalLine.SETRANGE("Document No.", "No.");
                IF PurchPraposalLine.FINDFIRST THEN
                    REPEAT
                        PurchPraposalLine."Location Code" := "Location Code";
                        PurchPraposalLine."Transfer form Code" := "Transfer form Code";
                        PurchPraposalLine.MODIFY;
                    UNTIL PurchPraposalLine.NEXT = 0;
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
            end;
        }
        field(50002; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

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
            end;
        }
        field(50004; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

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

            trigger OnValidate()
            begin
                PurchPraposalLine.RESET;
                PurchPraposalLine.SETRANGE(PurchPraposalLine."Document No.", "No.");
                IF PurchPraposalLine.FINDFIRST THEN BEGIN
                    REPEAT
                        PurchPraposalLine.Status := Status;
                        PurchPraposalLine.MODIFY;
                    UNTIL PurchPraposalLine.NEXT = 0;
                END;
            end;
        }
        field(50006; "Bin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(50007; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Location Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50010; "Approved By"; Code[50])
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
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(50052; "Transfer form Code"; Code[10])
        {
            DataClassification = ToBeClassified;
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
            Editable = false;

            trigger OnLookup()
            begin
                DownloadAttachment;
            end;
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
        }
        field(60012; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Quotation End Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Quotation Date  and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60017; "No. of Quotation"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote),
                                                         "Purchase Proposal" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60018; "Demand Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "Demand Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60020; Remarks; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Purchase Proposal Line"."Estimated Cost" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60022; "Incoming Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60023; "converted Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Direct,Quotation,GeM,Tender;
        }
        field(60024; "Converted User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
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
        field(60029; Attachment1; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60030; Attachment2; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60031; Attachment3; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60032; "Transfer User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" WHERE("Approval User Group Code" = CONST('PURCHPRO'));
            // "User ID" = FILTER(<> 'USERID'));//EXPDIP

            trigger OnValidate()
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE(UserGroupp."User ID", "Transfer User Id");
                UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'PURCHPRO');
                IF UserGroupp.FINDFIRST THEN
                    "Transfer User Name" := UserGroupp."User Full Name"
                ELSE
                    "Transfer User Name" := '';
            end;
        }
        field(60033; "Transfer User Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(60036; "Pending From User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60037; "Pending From User Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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

        PurchPraposalLine.RESET;
        PurchPraposalLine.SETRANGE("Document No.", "No.");
        IF PurchPraposalLine.FINDFIRST THEN
            REPEAT
                PurchPraposalLine.DELETE;
            UNTIL PurchPraposalLine.NEXT = 0;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PurchSetup.GET;

            PurchSetup.TESTFIELD(PurchSetup."Purchase Proposal Nos.");
            NoSeriesMgt.InitSeries(PurchSetup."Purchase Proposal Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        VALIDATE("Posting Date", WORKDATE);
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
        NoSeriesCode: Code[20];
        InvtComnt: Record 5748;
        DimMgt: Codeunit "DimensionManagement Ext";
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
        UserSetup_gRec: Record 91;
        DimValue: Record 349;
        NoSeries: Record 308;
        LocTab: Record 14;
        PurchSetup: Record 312;
        PurchPraposalLine: Record 50097;
        FilePath: Text[100];
        UserGroupp: Record 50082;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="OldProposalHeader">Record 50179.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(OldProposalHeader: Record 50096): Boolean
    begin
        UserSetup.GET(USERID);
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Purchase Proposal Nos.");
        IF NoSeriesMgt.SelectSeries(PurchSetup."Purchase Proposal Nos.", OldProposalHeader."No. Series", "No. Series") THEN BEGIN

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
    end;

    /// <summary>
    /// SendForApproval.
    /// </summary>
    procedure SendForApproval()
    var
        // SMTP: Codeunit 400;
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
    /// <param name="Rec">Record 50172.</param>
    procedure FillfromReq(Rec: Record 50089)
    var
        Text000: Label 'Indent Line already exist do you want to regenerate Indent Line?';
    begin
        /*
        TESTFIELD("Requisition No.");
        IndentLine2.RESET;
        IndentLine2.SETRANGE(IndentLine2."Document No.","No.");
        IF IndentLine2.FINDFIRST THEN
          IF NOT CONFIRM(Text000,FALSE) THEN
            EXIT;
        
          IndentLine2.DELETEALL(TRUE);
        ReqLine.RESET;
        ReqLine.SETRANGE(ReqLine."Requisition No.","Requisition No.");
        IF ReqLine.FINDFIRST THEN BEGIN REPEAT
          IndentLine."Requisition No." := ReqLine."Requisition No.";
          IndentLine."Requisition Line No." :=  ReqLine."Line No.";
          IndentLine."Document No." := "No.";
          IndentLine."Line No." := ReqLine."Line No.";
          IndentLine.Type := ReqLine.Type;
          IndentLine.VALIDATE("No.",ReqLine."No.");
          IndentLine.Description  := ReqLine.Description;
          IndentLine."Unit Of Measure Code" := ReqLine."Unit of Measure Code";
          IndentLine.Quantity := ReqLine."Remaining Qty";
          IndentLine."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
          IndentLine."Shortcut Dimension 2 Code" := ReqLine."Shortcut Dimension 2 Code";
          IndentLine.VALIDATE("Location Code","Location Code");
          IndentLine."Due Date" := ReqLine."Required By Date";
          IndentLine.INSERT;
        UNTIL ReqLine.NEXT = 0;
        
        END;
        */

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

    procedure AssistEdit(): Boolean
    var
        PurchPro: Record "Purchase Proposal Header";
        purchandPaysetup: Record "Purchases & Payables Setup";
    begin
        WITH PurchPro DO BEGIN
            PurchPro := Rec;
            purchandPaysetup.GET;
            purchandPaysetup.TESTFIELD(purchandPaysetup."Purchase Proposal Nos.");
            IF NoSeriesMgt.SelectSeries(purchandPaysetup."Purchase Proposal Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := PurchPro;
                EXIT(TRUE);
            END;
        END;
    end;
    /// <summary>
    /// IndentLinesExist.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IndentLinesExist(): Boolean
    begin

        PurchPraposalLine.RESET;
        PurchPraposalLine.SETRANGE(PurchPraposalLine."Document No.", "No.");
        EXIT(PurchPraposalLine.FINDFIRST);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record 904;
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        PurchPraposalLine.RESET;
        PurchPraposalLine.SETRANGE("Document No.", "No.");
        PurchPraposalLine.LOCKTABLE;
        IF PurchPraposalLine.FINDFIRST THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchPraposalLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF PurchPraposalLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    PurchPraposalLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchPraposalLine."Dimension Set ID", PurchPraposalLine."Shortcut Dimension 1 Code", PurchPraposalLine."Shortcut Dimension 2 Code");
                    PurchPraposalLine.MODIFY;

                END;
            UNTIL PurchPraposalLine.NEXT = 0;
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

    procedure UploadProposalAttachment(DocNo: Integer)
    var
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        FileName: Text;
    begin
        //IF Attachment <> '' THEN
        //  IF NOT CONFIRM('Purchase Proposal is already uploaded. Do you want to replace it?',FALSE,TRUE) THEN EXIT;
        FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchProposal\';
        CASE DocNo OF
            1:
                OldFileName := (FilePath + Attachment1);
            2:
                OldFileName := (FilePath + Attachment2);
            3:
                OldFileName := (FilePath + Attachment3);
        END;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            CASE DocNo OF
                1:
                    Attachment1 := DELCHR("No." + FORMAT(DocNo), '=', '/') + ClientFileName;
                2:
                    Attachment2 := DELCHR("No." + FORMAT(DocNo), '=', '/') + ClientFileName;
                3:
                    Attachment3 := DELCHR("No." + FORMAT(DocNo), '=', '/') + ClientFileName;
            END;
            MODIFY(TRUE);
        END;
        ClientFileName := FilePath + DELCHR("No." + FORMAT(DocNo), '=', '/') + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
            FileManagement.DeleteServerFile(OldFileName);
    end;

    /// <summary>
    /// DownLoadProposalAttachment.
    /// </summary>
    /// <param name="DocNo">Integer.</param>
    procedure DownLoadProposalAttachment(DocNo: Integer)
    var
        OldFileName: Text;
        ServerFileName: Text;
    begin
        FilePath := 'http://115.243.18.40/bseb_ftp/PurchProposal/';
        CASE DocNo OF
            1:
                OldFileName := Attachment1;
            2:
                OldFileName := Attachment2;
            3:
                OldFileName := Attachment3;
        END;
        IF OldFileName <> '' THEN BEGIN
            ServerFileName := FilePath + OldFileName;
            HYPERLINK(ServerFileName);
        END;
    end;

    /// <summary>
    /// SetsecuirityFilter.
    /// </summary>
    procedure SetsecuirityFilter()
    var
        UserSetup: Record 91;
    begin
        UserSetup.GET(USERID);
        FILTERGROUP(2);
        SETRANGE("Location Code", UserSetup."Location Code");
        FILTERGROUP(0);
    end;
}

