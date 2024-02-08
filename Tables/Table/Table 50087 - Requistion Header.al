table 50087 "Requistion Header"
{
    fields
    {
        field(50001; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InvSetup.GET;
                    NoSeriesMgt.TestManual(InvSetup."Requisition No. Series");
                    "No. Series" := '';
                END;
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50002; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                TESTFIELD(Release, FALSE);
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'Exam');
                DimValue.SETRANGE(DimValue.Code, "Shortcut Dimension 1 Code");
                IF DimValue.FINDFIRST THEN
                    "Exam Name" := DimValue.Name
                ELSE
                    "Exam Name" := '';
            end;
        }
        field(50003; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50004; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50005; "Last Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50006; "User ID"; Code[50])
        {
            TableRelation = User;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50007; Authorized; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50008; "Sent for Authorization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Declined; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Requistion';
            OptionMembers = Requistion;
        }
        field(50012; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                //TESTFIELD(Release,FALSE);
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'Section');
                DimValue.SETRANGE(DimValue.Code, "Shortcut Dimension 2 Code");
                IF DimValue.FINDFIRST THEN
                    "Section Name" := DimValue.Name
                ELSE
                    "Section Name" := '';
            end;
        }
        field(50013; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            begin
                TESTFIELD(Release, FALSE);
                IF LocTab.GET("Location Code") THEN
                    "Location Name" := LocTab.Name
                ELSE
                    "Location Name" := '';
            end;
        }
        field(50014; Authorise; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Authorized := Authorise;
                MODIFY;
            end;
        }
        field(50015; "Location Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Autherise/Decline By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Indent Close"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; Release; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Approving UID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50020; "Approving Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Approving Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Requisition By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Transfer,Consumable';
            OptionMembers = " ",Transfer,Consumable;
        }
        field(50027; "Return To Store"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Return Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; Additional; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Exam Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50031; "Section Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
            Editable = true;
        }
        field(50032; "Requisition to Section"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition to Section';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('Section'),
                                                          "Dimension Value Type" = FILTER(<> "Begin-Total"),
                                                          "Dimension Value Type" = FILTER(<> "End-Total"),
                                                          "Issue Depatment" = CONST(true));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                TESTFIELD(Release, FALSE);
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'Section');
                DimValue.SETRANGE(DimValue.Code, "Requisition to Section");
                IF DimValue.FINDFIRST THEN
                    "Req. To Department Name" := DimValue.Name
                ELSE
                    "Req. To Department Name" := '';
            end;
        }
        field(50033; "Sent for Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending for Approval,Approved,Issued,Closed,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Issued,Closed,Rejected;
        }
        field(50035; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "Approved Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Date Time';
        }
        field(50037; "Rejection Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Issue To"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'As Per Schedule,Urgent';
            OptionMembers = "As Per Schedule",Urgent;
        }
        field(50040; "Issued By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50096; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Section';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('Section'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, Department);
            end;
        }
        field(50098; "Indent Required"; Boolean)
        {
            CalcFormula = Lookup("Requistion Line"."Indent Required" WHERE("Requisition No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50099; "Return Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50103; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Section Name';
            Editable = false;
        }
        field(50104; "Req. To Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Req. To Section';
            Editable = false;
        }
        field(50105; "Consumption Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Revenue,Capital';
            OptionMembers = " ",Revenue,Capital;

            trigger OnValidate()
            begin
                RequistionLine.SETRANGE(RequistionLine."Requisition No.", "No.");
                IF RequistionLine.FINDFIRST THEN BEGIN
                    RequistionLine."Consumption Type" := "Consumption Type";
                    RequistionLine.MODIFY;
                END;
            end;
        }
        field(50106; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                 IF "Issued Date" < "Posting Date" THEN
                   ERROR('Issued date greater than posting Date');
                   */

            end;
        }
        field(50107; Issued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Sending UID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" WHERE("Approval User Group Code" = CONST('REQUISITION'));
            // TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE(UserGroupp."User ID", "Sending UID");
                UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'REQUISITION');
                IF UserGroupp.FINDFIRST THEN begin
                    UserGroupp.CalcFields(UserGroupp."User Full Name");
                    "Transfer User name" := UserGroupp."User Full Name";
                end
                ELSE
                    "Transfer User name" := '';
                // User.RESET; // NITIN 07-09-23
                // User.SETRANGE("User Name", "Sending UID");
                // IF User.FINDFIRST THEN
                //     "Transfer User Name" := User."Full Name";
                /*
                ExtEmpMaster.RESET;
                ExtEmpMaster.SETRANGE(ExtEmpMaster."Notification Id","Sending UID");
                IF ExtEmpMaster.FINDFIRST THEN
                  "Transfer User Name" := ExtEmpMaster."Notification Title"
                ELSE
                  "Transfer User Name" := '';
                */

            end;
        }
        field(50109; "Sending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Sending Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Requisition from Other Section"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Deliver to"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; Attachment; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Rejected Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Rejected Remarks"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "User Name"; Text[80])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50118; "File No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Pending From User Id"; Code[50])
        {
            FieldClass = Normal;
        }
        field(50120; "Pending From User"; Text[100])
        {
            FieldClass = Normal;
        }
        field(50121; "Transfer User Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50122; "Item Name"; Text[180])
        {
            CalcFormula = Lookup("Requistion Line".Description WHERE("Requisition No." = FIELD("No.")));
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
        fieldgroup(DropDown; "No.", "Posting Date", "Shortcut Dimension 1 Code", "Location Code", "Department Name", "Req. To Department Name")
        {
        }
    }

    trigger OnDelete()
    begin

        TESTFIELD(Status, Status::Open);
        IF Release = TRUE THEN
            ERROR('Released Document can not be Delete');


        RequistionLine.RESET;
        RequistionLine.SETRANGE("Requisition No.", "No.");
        IF RequistionLine.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine.DELETE;
            UNTIL RequistionLine.NEXT = 0;
        END;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Requisition No. Series");
            NoSeriesMgt.InitSeries(InvSetup."Requisition No. Series", xRec."No. Series", 0D, "No.", "No. Series");

        END;
        "User ID" := USERID;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            //VALIDATE("Shortcut Dimension 1 Code",UserSetup."Branch Code");
            VALIDATE("Shortcut Dimension 2 Code", UserSetup.Section);
            VALIDATE("Location Code", UserSetup."Location Code");
            VALIDATE("Requisition to Section", UserSetup."Store Section");
        END;

        "Posting Date" := WORKDATE;

        "Creation Date" := WORKDATE;
        "Creation Time" := TIME;

        /*
        DimValue.RESET;
        DimValue.SETRANGE(DimValue."Dimension Code",'Department');
        DimValue.SETRANGE(DimValue."Issue Depatment",TRUE);
        IF DimValue.FINDFIRST THEN
          VALIDATE("Requisition to Section",DimValue.Code)
        ELSE
         "Requisition to Section" :='';
         */

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        //"User ID" := USERID;
        //TESTFIELD(Authorized,FALSE);
        //TESTFIELD(Release,FALSE);
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        UserGroupp: Record 50082;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Requistion: Record 50087;
        // DimMgt: Codeunit DimensionManagement;
        DimMgt1: Codeunit "DimensionManagement Ext";
        // DimMgt: Codeunit 408;
        UserSetup: Record 91;
        RequistionLine: Record 50088;
        UeserSetup: Record 91;
        LocationRec: Record 14;
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        RequistionLine_gRec: Record 50088;
        UserSetup_gRec: Record 91;
        DimValue: Record 349;
        InvSetup: Record 313;
        Noseries: Record 308;
        LocTab: Record 14;
        EditableReq: Boolean;
        User: Record 2000000120;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(): Boolean
    begin
        WITH Requistion DO BEGIN
            Requistion := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Requisition No. Series");
            IF NoSeriesMgt.SelectSeries(InvSetup."Requisition No. Series", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := Requistion;
                EXIT(TRUE);
            END;
        END;
    end;

    /// <summary>
    /// SendforAppReq_gFnc.
    /// </summary>
    procedure SendforAppReq_gFnc()
    begin
        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Requisition No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine_gRec.TESTFIELD("No.");
                RequistionLine_gRec.TESTFIELD(Quantity);
            UNTIL RequistionLine_gRec.NEXT = 0;
        END
        ELSE
            ERROR('There is nothing to Send for Approval....');

        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Requisition No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine_gRec.Status := RequistionLine_gRec.Status::"Pending for Approval";
                RequistionLine_gRec.MODIFY;
            UNTIL RequistionLine_gRec.NEXT = 0;
        END;



        TESTFIELD("Requisition Type");
        IF CONFIRM(Text001_gTxt, TRUE) THEN BEGIN
            "Sent for Approval" := TRUE;
            Status := Status::"Pending for Approval";
            MESSAGE(Text002_gTxt, "No.");
            MODIFY;

            RequistionLine_gRec.RESET;
            RequistionLine_gRec.SETRANGE("Requisition No.", "No.");
            IF RequistionLine_gRec.FINDFIRST THEN BEGIN
                REPEAT
                    RequistionLine_gRec.Status := RequistionLine_gRec.Status::"Pending for Approval";
                    RequistionLine_gRec.MODIFY;
                UNTIL RequistionLine_gRec.NEXT = 0;
            END;
        END;
    end;

    procedure ApprovedReq_gFnc()
    begin
        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Requisition No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN
            RequistionLine_gRec.TESTFIELD(RequistionLine_gRec."Approved Qty");


        IF UserSetup_gRec.GET(USERID) THEN
            UserSetup_gRec.TESTFIELD(UserSetup_gRec."Requisition Approval");
        Status := Status::Approved;
        "Approved Date Time" := CURRENTDATETIME;
        "Approved By" := USERID;
        MESSAGE(Text004_gTxt, "No.");
        MODIFY;

        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Requisition No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine_gRec.Status := RequistionLine_gRec.Status::Approved;
                RequistionLine_gRec.MODIFY;
            UNTIL RequistionLine_gRec.NEXT = 0;
        END;
    end;

    /// <summary>
    /// LookupShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt1.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;

    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt1.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
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
          DimMgt1.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', '', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF ReqLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    /// <summary>
    /// ReqLinesExist.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure ReqLinesExist(): Boolean
    begin

        RequistionLine.RESET;
        RequistionLine.SETRANGE(RequistionLine."Requisition No.", "No.");
        EXIT(RequistionLine.FINDFIRST);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record 904;
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        RequistionLine.RESET;
        RequistionLine.SETRANGE("Requisition No.", "No.");
        RequistionLine.LOCKTABLE;
        IF RequistionLine.FINDFIRST THEN
            REPEAT
                NewDimSetID := DimMgt1.GetDeltaDimSetID(RequistionLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF RequistionLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    RequistionLine."Dimension Set ID" := NewDimSetID;
                    DimMgt1.UpdateGlobalDimFromDimSetID(
                      RequistionLine."Dimension Set ID", RequistionLine."Shortcut Dimension 1 Code", RequistionLine."Shortcut Dimension 2 Code");
                    RequistionLine.MODIFY;

                END;
            UNTIL RequistionLine.NEXT = 0;
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
        if Rec.Status = Status::"Pending for Approval" Then Begin
            IF UserSetup."Store Emp" THEN
                SETFILTER("Requisition to Section", '%1', UserSetup."Store Section")
            ELSE
                SETFILTER("Pending From User Id", '%1', USERID);

        END ELSE begin
            IF UserSetup."Store Emp" THEN
                SETFILTER("Requisition to Section", '%1', UserSetup."Store Section")
            ELSE
                SETFILTER("User ID", '%1', USERID);
        end;
        FILTERGROUP(0);


    end;

    /// <summary>
    /// SetSecurityFilter1.
    /// </summary>
    procedure SetSecurityFilter1()
    var
        UserSetup: Record 91;
    begin
        UserSetup.GET(USERID);
        FILTERGROUP(2);
        SETFILTER("User ID", '%1', USERID);
        FILTERGROUP(0);
    end;
}

