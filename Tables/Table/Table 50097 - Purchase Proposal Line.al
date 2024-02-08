/// <summary>
/// Table Purchase Proposal Line (ID 50180).
/// </summary>
table 50097 "Purchase Proposal Line"
{
    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                TestStatusOpen();
                /*
                TempIndentLine.COPY(Rec);
                INIT;
                "Document No." := TempIndentLine."Document No.";
                "Line No." := TempIndentLine."Line No.";
                Type := TempIndentLine.Type;
                "Due Date" := xRec."Due Date";
                */

            end;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Item)) Item."No." WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                   "Account Type" = CONST(Posting),
                                                                                   Blocked = CONST(false),
                                                                                   "Income/Balance" = FILTER("Income Statement"));

            trigger OnValidate()
            begin
                //TestStatusOpen();
                //ds
                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    Item.GET("No.");
                    Description := Item.Description;
                    "Unit Of Measure Code" := Item."Base Unit of Measure";
                    "Description 2" := Item."Description 2";
                    "Description 3" := Item.Sepicification;

                END;


                IF Type = Type::"Fixed Asset" THEN BEGIN
                    FixedAsset.GET("No.");
                    Description := FixedAsset.Description;
                END;

                IF Type = Type::"G/L Account" THEN BEGIN
                    RecGLAccount.RESET;
                    RecGLAccount.GET("No.");
                    Description := RecGLAccount.Name;
                END;
                GetindentHead;
                PraposalHeader.RESET;
                PraposalHeader.SETRANGE("No.", "Document No.");
                IF PraposalHeader.FIND('-') THEN BEGIN
                    IF PraposalHeader."Location Code" <> '' THEN BEGIN
                        "Location Code" := PraposalHeader."Location Code";
                        "Shortcut Dimension 1 Code" := PraposalHeader."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := PraposalHeader."Shortcut Dimension 2 Code";
                        "Purchase Type" := PraposalHeader."Purchase Type";
                        "Posting Date" := PraposalHeader."Posting Date";
                        Priority := PraposalHeader.Priority;
                    END ELSE
                        ERROR('Purchase Praposal location should not be blank in Purchase Praposal Header');
                END;
            end;
        }
        field(6; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Description 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = true;

            trigger OnValidate()
            begin
                TestStatusOpen();

                "Remaining Quantity" := Quantity;
                IF Type = Type::Item THEN BEGIN
                    "Quantity (Base)" := CalcBaseQty(Quantity);
                    VALIDATE("Approved Quantity", Quantity);//ARV_REL
                    "PO Outstanding Quantity" := Quantity;
                END;
                //VALIDATE("Direct Unit Cost");
                IF "Direct Unit Cost" <> 0 THEN BEGIN
                    "Estimated Cost" := "Approved Quantity" * "Direct Unit Cost";
                END;


                IF "GST %" <> 0 THEN BEGIN
                    "GST Amount" := ("Estimated Cost" * "GST %") / 100;
                    "Estimated Cost Including GST" := "Direct Unit Cost" * Quantity + "GST Amount";
                END;
            end;
        }
        field(9; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TestStatusOpen();
                IF "Direct Unit Cost" <> 0 THEN BEGIN
                    "Estimated Cost" := "Approved Quantity" * "Direct Unit Cost";
                END;

                IF "GST %" <> 0 THEN BEGIN
                    "GST Amount" := ("Estimated Cost" * "GST %") / 100;
                    "Estimated Cost Including GST" := "Direct Unit Cost" * Quantity + "GST Amount";
                END;
            end;
        }
        field(12; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
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
            end;
        }
        field(17; "Approved Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                Text50000: Label '%1 is not authorised to approve the Indent Quantity.';
            begin
                //Code Commented approve quantity is not required to be fill in Indent ----ARV
                /*
                UserSetup.GET(USERID);
                IF UserSetup."Indent Approval" = FALSE THEN
                  ERROR(Text50000,USERID);
                TestStatusReleased();
                //Code Commented approve quantity is not required to be fill in Indent ----ARV
                */

                IF Type = Type::Item THEN
                    "Approved Quantity (Base)" := CalcBaseQty("Approved Quantity");
                IF "Approved Quantity" > Quantity THEN
                    ERROR('Approved Quantity Cannot not be more then Actual');
                IF "Approved Quantity (Base)" > "Quantity (Base)" THEN
                    ERROR('Approved Quantity Cannot not be more then Actual');
                /*
          IF "Approved Quantity" > 0 THEN BEGIN
           IndentHeader.GET("Document No.");
           IndentHeader."Approved By" := USERID;
           IndentHeader.MODIFY;
          END; */

            end;
        }
        field(18; "Approved Quantity (Base)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            begin

                //vij izhar
                BINCONT.SETRANGE(BINCONT."Location Code", "Location Code");
                BINCONT.SETRANGE(BINCONT."Item No.", "No.");
                IF BINCONT.FINDFIRST THEN
                    "Bin Code" := BINCONT."Bin Code";
                //vij
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5402; "Variant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code;

            trigger OnValidate()
            begin
                TestStatusOpen()

            end;
        }
        field(5404; "Qty. per Unit Of Measure"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5407; "Unit Of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5701; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5705; "Product Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Product Group"; // "Product Group" table removed in BC

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50001; "Indent Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50002; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen();
                "Direct Unit Cost" := "Estimated Cost" / "Approved Quantity";
            end;
        }
        field(50003; "Inventory Main Store"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50004; "Capital Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50007; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Transfer form Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(50010; "Stock In Hand"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 2 Code" = CONST('04')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Order Quantity"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Qty On Component Line"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50051; "Production Order Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50052; "Units Per Parcel"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Act. Rem. Indent Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Remaining Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Pending Indent QTY';
        }
        field(50059; "Sale Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'As Per Schedule,Urgent';
            OptionMembers = "As Per Schedule",Urgent;
        }
        field(50063; "Sub Categories Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
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
                 */

            end;
        }
        field(54001; "Shelf No."; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table0;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(55050; "Quantity-Base unit of Measure"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                //HMD
                IF "Quantity-Base unit of Measure" <> 0 THEN BEGIN
                    IF ItemRec.GET("No.") THEN BEGIN
                        ItemUnitOfMeasureRec.SETRANGE("Item No.", "No.");
                        ItemUnitOfMeasureRec.SETRANGE(Code, ItemRec."Purch. Unit of Measure");
                        IF ItemUnitOfMeasureRec.FIND('-') THEN
                            VALIDATE(Quantity, ItemUnitOfMeasureRec."Qty. per Unit of Measure" * "Quantity-Base unit of Measure");
                    END;
                END ELSE
                    VALIDATE(Quantity, 0);
                //HMD
            end;
        }
        field(55053; "Excise Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55058; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }
        field(55059; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Selected';
        }
        field(55060; "PO Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PO Select';
        }
        field(55061; "Description 3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55062; "PO No."; Code[20])
        {
            CalcFormula = Lookup("Purchase Line"."Document No." WHERE("Indent No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "GST %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("GST %" <> 0) AND ("Estimated Cost" <> 0) THEN BEGIN

                    "GST Amount" := ("Estimated Cost" * "GST %") / 100;
                    "Estimated Cost Including GST" := "Estimated Cost" + "GST Amount";
                END ELSE BEGIN
                    "GST Amount" := 0;
                    "Estimated Cost Including GST" := "Estimated Cost";
                END;
            end;
        }
        field(60001; "GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Estimated Cost Including GST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "GST Include"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60011; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Direct,Quotation,GeM,Tender;
        }
        field(60012; "Select Item For Praposal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60018; "Demand Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "Demand Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(85515; "Description 2 New"; Text[30])
        {
        }
        field(85519; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // GetindentHead;
            end;
        }
        field(85520; "Requisition Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Requistion Line"."Line No.";

            trigger OnLookup()
            begin
                mrequi1.SETRANGE(mrequi1."Requisition No.", "Requisition No.");
                IF PAGE.RUNMODAL(PAGE::"Requisition Line List", mrequi1) = ACTION::LookupOK THEN BEGIN
                    "Requisition Line No." := mrequi1."Line No.";
                    Type := Type::Item;
                    VALIDATE("No.", mrequi1."No.");
                    Description := mrequi1.Description;
                    VALIDATE("Unit Of Measure Code", mrequi1."Unit of Measure Code");
                    VALIDATE(Quantity, mrequi1.Quantity);
                    "Due Date" := mrequi1."Required By Date";
                    Remarks := mrequi1."Requisition Remarks";
                    // GetindentHead;
                    ReqLine.SETRANGE(ReqLine."Requisition No.", "Requisition No.");
                    ReqLine.SETRANGE(ReqLine."Line No.", "Requisition Line No.");
                    IF ReqLine.FINDFIRST THEN BEGIN
                        ReqLine.CALCFIELDS(ReqLine."Stock in Hand");
                        IF ReqLine."Stock in Hand" > Quantity THEN
                            MESSAGE('No. %1 allready available in stock in Location %2', "No.", "Location Code");
                    END;
                END;
                /*
                  SETRANGE("Document No.");
                  IF FIND ('-') THEN
                  REPEAT
                    IF mrequi1."Requisition No." = "Requisition No." THEN BEGIN
                      IF mrequi1."Line No." = "Requisition Line No." THEN BEGIN
                      "Requisition Line No.":= 0;
                      "No.":= '';
                      Description:='';
                      "Unit Of Measure Code" := '';
                      Quantity:=0;
                
                      ERROR('Duplicate Line No.is not Allowed')
                      END ELSE
                      "Requisition Line No.":=mrequi1."Line No.";
                      "No.":=mrequi1."No.";
                      Description:=mrequi1.Description;
                      "Unit Of Measure Code" := mrequi1."Unit of Measure Code";
                      Quantity:=mrequi1.Quantity;
                      //"Required Date" := mrequi1."Required Date";
                      "Shortcut Dimension 1 Code" := mrequi1."Shortcut Dimension 1 Code";
                      "Shortcut Dimension 2 Code" := mrequi1."Shortcut Dimension 2 Code";
                      "Requisition No." := mrequi1."Requisition No.";
                      "Requisition Line No." := mrequi1."Line No.";
                      VALIDATE("Requisition Line No.");
                    END
                  UNTIL  NEXT = 0
                //END;
                */

            end;
        }
        field(85521; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85522; "Purchase Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85523; "PO Outstanding Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85524; "PO Received Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85525; "PO Completed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(99000882; "Gen.Prod.Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; Type, "No.", "Variant Code", "Location Code", "Indent Date")
        {
        }
        key(Key3; "No.", "Location Code", "Indent Date")
        {
        }
        key(Key4; "No.", "Location Code", "Bin Code", "Shortcut Dimension 1 Code", "Indent Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF PraposalHeader.GET("Document No.") THEN
            PraposalHeader.TESTFIELD(PraposalHeader.Status, PraposalHeader.Status::Open);

        /*
       RequisitionLine.RESET;
       RequisitionLine.SETRANGE(RequisitionLine."Requisition No.","Requisition No.");
       RequisitionLine.SETRANGE(RequisitionLine."Line No.","Requisition Line No.");
       //RequisitionLine.SETRANGE(RequisitionLine.Selected,TRUE);
       IF RequisitionLine.FINDFIRST THEN BEGIN
         REPEAT
           RequisitionLine.Selected := FALSE;
           RequisitionLine."Requisition Selected" := FALSE;
           RequisitionLine.MODIFY(TRUE);
         UNTIL RequisitionLine.NEXT = 0;
       END;
       */

    end;

    trigger OnInsert()
    begin
        GetindentHead;
    end;

    trigger OnModify()
    begin
        GetindentHead;
    end;

    var
        Item: Record 27;
        ItemUnitMeasure: Record 5404;
        StandardText: Record 7;
        // DimMgt: Codeunit DimensionManagement;
        // DimMgt1: Codeunit DimensionManagement;
        PraposalHeader1: Record 50096;
        TempIndentLine: Record 50090 temporary;
        FixedAsset: Record 5600;
        UserSetup: Record 91;
        "---HMD---": Integer;
        ItemRec: Record 27;
        ItemUnitOfMeasureRec: Record 5404;
        BINCONT: Record 7302;
        Text001: Label 'Status must be open for Purchase Praposal %1';
        Text002: Label 'You cannot rename a %1.';
        Text003: Label 'Status must be Released for Purchase Praposal %1';
        RequisitionLine: Record 50088;
        RecGLAccount: Record 15;
        ItemTab: Record 7;
        PurchInvLine: Record 123;
        Vendor: Record 23;
        mitemline: Record 32;
        mremqty: Decimal;
        mrequi1: Record 50088;
        ReqLine: Record 50088;
        mreqno: Code[20];
        mreqlineno: Integer;
        PraposalHeader: Record 50096;
        IndentLine: Record 50090;

    /// <summary>
    /// TestStatusOpen.
    /// </summary>
    procedure TestStatusOpen()
    var
        IndentHeader: Record 50089;
    begin
        PraposalHeader.GET("Document No.");
        IF PraposalHeader.Status <> PraposalHeader.Status::Open THEN
            ERROR(Text001, "Document No.");

    end;

    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*
DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
IF "Line No." <> 0 THEN
 DimMgt.SaveDocDim(
   DATABASE::"Indent Line", 6 {"Document Type"},"Document No.",
   "Line No.",FieldNumber,ShortcutDimCode)
ELSE
 DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
         */

    end;

    /// <summary>
    /// CreateDim.
    /// </summary>
    /// <param name="Type1">Integer.</param>
    /// <param name="No1">Code[20].</param>
    /// <param name="Type2">Integer.</param>
    /// <param name="No2">Code[20].</param>
    /// <param name="Type3">Integer.</param>
    /// <param name="No3">Code[20].</param>
    /// <param name="Type4">Integer.</param>
    /// <param name="No4">Code[20].</param>
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record 242;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        /*
 SourceCodeSetup.GET;
 TableID[1] := Type1;
 No[1] := No1;
 TableID[2] := Type2;
 No[2] := No2;
 TableID[3] := Type3;
 No[3] := No3;
 TableID[4] := Type4;
 No[4] := No4;
 //"Shortcut Dimension 1 Code" := '';
 //"Shortcut Dimension 2 Code" := '';
 DimMgt.GetPreviousDocDefaultDim(
   DATABASE::"Indent Header",6{"Document Type"},"Document No.",0,
   DATABASE::Vendor,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
 DimMgt.GetDefaultDim(
   TableID,No,SourceCodeSetup.Purchases,
   "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
 IF "Line No." <> 0 THEN
   DimMgt.UpdateDocDefaultDim(
     DATABASE::"Indent Line",6{"Document Type"},"Document No.","Line No.",
     "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
         */

    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        /*TESTFIELD("Qty. per Unit Of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit Of Measure",0.00001));
         */

    end;

    /// <summary>
    /// TestStatusReleased.
    /// </summary>
    procedure TestStatusReleased()
    var
        IndentHeader: Record 50089;
    begin
        /*IndentHeader.GET("Document No.");
        IF IndentHeader.Status <> IndentHeader.Status::Released THEN
         ERROR(Text003, "Document No.");
         */

    end;

    /// <summary>
    /// ------------SLS.
    /// </summary>
    procedure "------------SLS"()
    begin
    end;

    /// <summary>
    /// SetSecurityFilter.
    /// </summary>
    procedure SetSecurityFilter()
    var
        UserSetup: Record 91;
    begin
        /*
        UserSetup.GET(USERID);
        IF NOT UserSetup."All Location" THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Location Code",'%1|%2|%3|%4|%5|%6|%7|%8|%9',UserSetup."Baddi Loaction",UserSetup."Guna Location",
                    UserSetup."Delhi Location",UserSetup."AMT Location",UserSetup."BIL Location",UserSetup."Meerut Location-MY",UserSetup."MUM Location",
                    UserSetup."PANIPAT Location",UserSetup."LUDH Location");
          FILTERGROUP(0);
         END;
        *///EXP

    end;

    /// <summary>
    /// GetindentHead.
    /// </summary>
    procedure GetindentHead()
    begin

        PraposalHeader1.RESET;

        PraposalHeader1.SETRANGE(PraposalHeader1."No.", "Document No.");
        IF PraposalHeader1.FINDFIRST THEN BEGIN
            "Shortcut Dimension 1 Code" := PraposalHeader1."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := PraposalHeader1."Shortcut Dimension 2 Code";
            "Dimension Set ID" := PraposalHeader1."Dimension Set ID";
            "Location Code" := PraposalHeader1."Location Code";
            "Indent Date" := PraposalHeader1."Indent Date";
            "Consumption Type" := PraposalHeader1."Consumption Type";
            "Purchase Type" := PraposalHeader."Purchase Type";
        END;
    end;
}

