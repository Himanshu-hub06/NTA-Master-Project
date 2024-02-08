/// <summary>
/// Table Issue Header (ID 50176).
/// </summary>
table 50093 "Issue Header"
{
    // LookupPageID = 50221;

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
            DataClassification = ToBeClassified;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                TESTFIELD(Release, FALSE);
                "New Branch Code" := "Shortcut Dimension 1 Code";
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
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

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
            DataClassification = ToBeClassified;
            TableRelation = User;

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
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                TESTFIELD(Release, FALSE);
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
        field(50019; "Authorize User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(50020; "Authorize Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Authorize Time"; Time)
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
        field(50031; "New Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                TESTFIELD(Release, FALSE);
            end;
        }
        field(50032; "Issue to Section"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition to Department';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'),
                                                          "Dimension Value Type" = FILTER(<> 'Begin-Total'),
                                                          "Dimension Value Type" = FILTER(<> 'End-Total'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                TESTFIELD(Release, FALSE);
                DimValue.SETRANGE(DimValue."Dimension Code", 'Section');
                DimValue.SETRANGE(DimValue.Code, "Issue to Section");
                IF DimValue.FINDFIRST THEN
                    "Issue To Section Name" := DimValue.Name
                ELSE
                    "Issue To Section Name" := '';
                IF "Shortcut Dimension 2 Code" = "Issue to Section" THEN
                    ERROR('You cannot transfer in same Section');
            end;
        }
        field(50033; "Sent for Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release,Approved,Issued,Closed';
            OptionMembers = Open,Release,Approved,Issued,Closed;
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
        field(50099; "Return Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Doc No Not in use"; Boolean)
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
                ShowDocDim;
            end;
        }
        field(50103; "Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50104; "Issue To Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50105; "Consumption Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Revenue,Capital';
            OptionMembers = " ",Revenue,Capital;

            trigger OnValidate()
            begin
                RequistionLine.SETRANGE(RequistionLine."Document No.", "No.");
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
                IF "Issued Date" < "Posting Date" THEN
                    ERROR('Issue date is greater than Document Date');
            end;
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
        fieldgroup(DropDown; "No.", "Posting Date", "Shortcut Dimension 1 Code", "Location Code", "Section Name", "Issue To Section Name")
        {
        }
    }

    trigger OnDelete()
    begin
        //IF Release = TRUE THEN
        // ERROR('Released Document can not be Delete');


        RequistionLine.RESET;
        RequistionLine.SETRANGE("Document No.", "No.");
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
            InvSetup.TESTFIELD(InvSetup."Issue No. Series");
            NoSeriesMgt.InitSeries(InvSetup."Issue No. Series", xRec."No. Series", 0D, "No.", "No. Series");

        END;
        /*
        "User ID" := USERID;
        UserSetup.SETRANGE("User ID",USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
          //VALIDATE("Shortcut Dimension 1 Code",UserSetup."Branch Code");
          VALIDATE("Shortcut Dimension 2 Code",UserSetup.Department);
          //VALIDATE("Location Code",UserSetup."Location Code");
        END;
         Noseries.RESET;
         Noseries.SETRANGE(Noseries.Code,"No. Series");
         IF Noseries.FINDFIRST THEN BEGIN
           Noseries.TESTFIELD(Noseries."Location Code");
           Noseries.TESTFIELD(Noseries."Shortcut Dimension 1 Code");
           "Location Code" := Noseries."Location Code";
           "Shortcut Dimension 1 Code" := Noseries."Shortcut Dimension 1 Code";
         END;
         *///EXP
        "Posting Date" := WORKDATE;
        "Creation Date" := WORKDATE;
        "Creation Time" := TIME;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "User ID" := USERID;
        //TESTFIELD(Authorized,FALSE);
        //TESTFIELD(Release,FALSE);
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Requistion: Record 50093;
        // DimMgt: Codeunit DimensionManagement;
        DimMgt1: Codeunit "DimensionManagement Ext";
        UserSetup: Record 91;
        RequistionLine: Record 50094;
        UeserSetup: Record 91;
        LocationRec: Record 14;
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        RequistionLine_gRec: Record 50094;
        UserSetup_gRec: Record 91;
        DimValue: Record 349;
        InvSetup: Record 313;
        Noseries: Record 308;
        IssueLine: Record 50094;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(): Boolean
    begin
        WITH Requistion DO BEGIN
            Requistion := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Issue No. Series");
            IF NoSeriesMgt.SelectSeries(InvSetup."Issue No. Series", xRec."No. Series", "No. Series") THEN BEGIN
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
        RequistionLine_gRec.SETRANGE("Document No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine_gRec.TESTFIELD("No.");
                RequistionLine_gRec.TESTFIELD(Quantity);
            UNTIL RequistionLine_gRec.NEXT = 0;
        END
        ELSE
            ERROR('There is nothing to Send for Approval....');

        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Document No.", "No.");
        IF RequistionLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                RequistionLine_gRec.Status := RequistionLine_gRec.Status::Release;
                RequistionLine_gRec.MODIFY;
            UNTIL RequistionLine_gRec.NEXT = 0;
        END;



        TESTFIELD("Requisition Type");
        IF CONFIRM(Text001_gTxt, TRUE) THEN BEGIN
            "Sent for Approval" := TRUE;
            Status := Status::Release;
            MESSAGE(Text002_gTxt, "No.");
            MODIFY;

            RequistionLine_gRec.RESET;
            RequistionLine_gRec.SETRANGE("Document No.", "No.");
            IF RequistionLine_gRec.FINDFIRST THEN BEGIN
                REPEAT
                    RequistionLine_gRec.Status := RequistionLine_gRec.Status::Release;
                    RequistionLine_gRec.MODIFY;
                UNTIL RequistionLine_gRec.NEXT = 0;
            END;
        END;
    end;

    /// <summary>
    /// ApprovedReq_gFnc.
    /// </summary>
    procedure ApprovedReq_gFnc()
    begin
        RequistionLine_gRec.RESET;
        RequistionLine_gRec.SETRANGE("Document No.", "No.");
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
        RequistionLine_gRec.SETRANGE("Document No.", "No.");
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
            IF IssueLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    /// <summary>
    /// IssueLinesExist.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IssueLinesExist(): Boolean
    begin

        IssueLine.RESET;
        IssueLine.SETRANGE("Document No.", "No.");
        EXIT(IssueLine.FINDFIRST);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ATOLink: Record 904;
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        IssueLine.RESET;
        IssueLine.SETRANGE("Document No.", "No.");
        IssueLine.LOCKTABLE;
        IF IssueLine.FINDFIRST THEN
            REPEAT
                NewDimSetID := DimMgt1.GetDeltaDimSetID(IssueLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF IssueLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    IssueLine."Dimension Set ID" := NewDimSetID;
                    DimMgt1.UpdateGlobalDimFromDimSetID(
                      IssueLine."Dimension Set ID", IssueLine."Shortcut Dimension 1 Code", IssueLine."Shortcut Dimension 2 Code");
                    IssueLine.MODIFY;
                END;
            UNTIL IssueLine.NEXT = 0;
    end;
}

