table 50094 "Issue Line"
{

    fields
    {
        field(50001; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "No."; Code[30])
        {
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(false),
            "Account Type" = CONST(Posting), Blocked = CONST(false), "Income/Balance" = FILTER('Income Statement'));
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
                SelectItemEntry1(FIELDNO("No."));
            end;

            trigger OnValidate()
            begin
                TestStatus;

                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    Item.GET("No.");
                    Description := Item.Description;
                    "Unit of Measure Code" := Item."Base Unit of Measure";
                    "Last Rate" := Item."Last Direct Cost";
                    "Description 2" := Item."Description 2";
                    "Description 3" := Item.Sepicification;

                    Rate := Item."Last Direct Cost";

                END;


                IF Type = Type::"Fixed Asset" THEN BEGIN
                    FixedAsset.GET("No.");
                    Description := FixedAsset.Description;
                    PurchInvLine1.RESET;
                    PurchInvLine1.SETCURRENTKEY("Expected Receipt Date");
                    PurchInvLine1.SETRANGE(PurchInvLine1.Type, PurchInvLine1.Type::"Fixed Asset");
                    PurchInvLine1.SETRANGE(PurchInvLine1."No.", "No.");
                    IF PurchInvLine1.FIND('+') THEN BEGIN
                        "Last Quantity" := PurchInvLine1.Quantity;
                        "Supplier's Code" := PurchInvLine1."Buy-from Vendor No.";
                        Rate := PurchInvLine1."Direct Unit Cost";
                        "Last Rate" := PurchInvLine1."Direct Unit Cost";
                    END;
                END;

                IF Type = Type::"G/L Account" THEN BEGIN
                    RecGLAccount.RESET;
                    RecGLAccount.GET("No.");
                    Description := RecGLAccount.Name;
                END;


                IssHeader.RESET;
                IssHeader.SETRANGE("No.", "Document No.");
                IF IssHeader.FIND('-') THEN BEGIN
                    IF IssHeader."Location Code" <> '' THEN BEGIN
                        "Location Code" := IssHeader."Location Code";
                        "Shortcut Dimension 1 Code" := IssHeader."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := IssHeader."Shortcut Dimension 2 Code";
                        "Issue To Section" := IssueHeader."Issue to Section";

                    END ELSE
                        ERROR('Issue location should not be blank in Issue Header');
                END;


                PurchInvLine.RESET;
                PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                PurchInvLine.SETRANGE("No.", "No.");
                PurchInvLine.SETRANGE("Document No.");
                IF PurchInvLine.FIND('-') THEN
                    REPEAT
                        "Last Quantity" := PurchInvLine.Quantity;
                        "Supplier's Code" := PurchInvLine."Buy-from Vendor No.";
                    UNTIL PurchInvLine.NEXT = 0;
                VALIDATE("Supplier's Code");
                GetReqHeader;
                IssLine.RESET;
                IssLine.SETRANGE(IssLine."Document No.", "Document No.");
                IssLine.SETRANGE(IssLine."No.", "No.");
                IF IssLine.FINDFIRST THEN BEGIN
                    Recno := IssLine.COUNT;
                    IF Recno > 1 THEN
                        ERROR('Same Item already exist in previous Line');
                END;
            end;
        }
        field(50004; Description; Text[50])
        {
            Description = 'CS Abhishek';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50005; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50006; Quantity; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 3;
            MinValue = 0;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
                Qty1 := 0;
                Amt1 := 0;
                sig := FALSE;
                Rt := 0;
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETRANGE("Item No.", "No.");
                ItemLedgEntry.SETRANGE(Positive, TRUE);
                ItemLedgEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                IssueHead.RESET;
                IssueHead.SETRANGE("No.", "Document No.");
                IF IssueHead.FINDFIRST THEN BEGIN
                    ItemLedgEntry.SETRANGE("Global Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");
                    ItemLedgEntry.SETRANGE("Global Dimension 2 Code", IssueHead."Shortcut Dimension 2 Code");
                END;
                //IF "Lot No" <> '' THEN
                // ItemLedgEntry.SETFILTER("Lot No",'%1',"Lot No");
                //ItemLedgEntry.SETCURRENTKEY();
                IF ItemLedgEntry.FINDFIRST THEN
                    REPEAT
                        Qty2 := Qty1;
                        Qty1 += ItemLedgEntry."Remaining Quantity";
                        IF Qty1 <= Quantity THEN
                            Amt1 += ItemLedgEntry.Rate * ItemLedgEntry."Remaining Quantity"
                        ELSE BEGIN
                            Amt1 += ItemLedgEntry.Rate * (Quantity - Qty2);
                            sig := TRUE;
                        END;
                    UNTIL (ItemLedgEntry.NEXT = 0) OR sig;
                IF Quantity > Qty1 THEN
                    ERROR('Requested Qty is more than available Qty - %1...%2', Quantity, Qty1);
                IF Quantity <> 0 THEN
                    Rt := Amt1 / Quantity;
                VALIDATE("Unit Cost", Rt);
            end;
        }
        field(50009; "Last Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Last Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Supplier's Code"; Code[10])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF Vendor.GET("Supplier's Code") THEN;
                "Supplier's Name" := Vendor.Name;
            end;
        }
        field(50012; "Supplier's Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Stock in Hand"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));

            // DataClassification=ToBeClassified;
        }
        field(50014; "Document Type"; Option)
        {
            OptionCaption = 'Indent';
            OptionMembers = Indent;
            DataClassification = ToBeClassified;
        }
        field(50015; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Value := Quantity * Rate;
                //MODIFY;
            end;
        }
        field(50016; Value; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Value := Quantity * Rate;
            end;
        }
        field(50017; "Description 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(False));
            DataClassification = ToBeClassified;
        }
        field(50019; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
                IF Type <> xRec.Type THEN BEGIN
                    "No." := '';
                    Description := '';
                    "Unit of Measure Code" := '';
                END;
            end;
        }
        field(50021; "Remaining Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Center Type"; Option)
        {
            Caption = 'Center Type';
            OptionCaption = 'Work Center,Machine Center, ';
            OptionMembers = "Work Center","Machine Center"," ";
            DataClassification = ToBeClassified;
        }
        field(50026; "Issue Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50028; "Issued Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50029; "Quantity to be Issued"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Quantity to be Issued" > "Approved Qty" THEN
                    MESSAGE('Quantity to be Issue is greater than Approved Quantity');
            end;
        }
        field(50030; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Quantity To Issue"; Decimal)
        {
            BlankZero = true;
            MinValue = 0;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CALCFIELDS("Stock in Hand");
                /*
                IssHeader.RESET;
                IssHeader.SETRANGE(IssHeader."No.","Document No.");
                IF IssHeader.FINDFIRST THEN BEGIN
                
                    IF "Quantity To Issue" > "Approved Qty" THEN
                      ERROR('Quantity to Issue greater than Approved Qty');
                
                END;
                */
                //IF "Quantity To Issue" > "Stock in Hand" THEN
                //  ERROR('You cannot issue the Quantity more then the Quantity in Stock');

                /*
                IF "Stock in Hand" <  "Quantity To Issue" THEN
                  ERROR('There is no Quantity in Stock kindly create indent');
                
                "Balance Return Quantity" := "Quantity To Issue" - "Original Quantity";
                IF "Balance Return Quantity" < 0 THEN
                  "Balance Return Quantity" := 0;
                
                IF "Quantity To Issue" > "Approved Qty" THEN
                  ERROR('Quantity to Issue cannot be greater than Approved Qty');
                
                IF "Quantity To Issue" > "Remaining Qty" THEN
                  ERROR('Quantity to Issue cannot be greater than Remaining Qty');
                
                IF "Stock in Hand" = 0 THEN
                  ERROR('There is no Quantity in Stock kindly create indent');
                
                IF "Quantity To Issue" > "Stock in Hand" THEN
                  ERROR('You cannot issue the Quantity more then the Quantity in Stock');
                */

            end;
        }
        field(50033; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(50034; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = ToBeClassified;
        }
        field(50038; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Balance Return Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Return Store"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Approved Qty"; Decimal)
        {
            BlankZero = true;
            MinValue = 0;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Approved Qty" > Quantity THEN
                    ERROR(' Approved Qty cannot be greater then Required Quantity');

                //"Quantity To Issue" := "Approved Qty";
                "Remaining Qty" := "Approved Qty";
            end;
        }
        field(50044; Status; Option)
        {
            OptionCaption = 'Open,Release,Approved,Issued,Closed';
            OptionMembers = Open,Release,Approved,Issued,Closed;
            DataClassification = ToBeClassified;
        }
        field(50046; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Requisition Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Description 3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Sub Categories Code"; Code[10])
        {
            Editable = true;
            DataClassification = ToBeClassified;
        }
        field(50096; "Issue To Section"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");
            end;
        }
        field(50100; "Consumption Type"; Option)
        {
            OptionCaption = ' ,Revenue,Capital';
            OptionMembers = " ",Revenue,Capital;
            DataClassification = ToBeClassified;
        }
        field(50102; "Issued Qty"; Decimal)
        {
            Editable = false;
        }
        field(50103; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50106; "Stock on Hand To Dep"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              "Global Dimension 2 Code" = FIELD("Issue To Section")));
            FieldClass = FlowField;
        }
        field(50107; "Lot No"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
                SelectItemEntry(FIELDNO("Lot No"));
            end;
        }
        field(50108; "Apply to Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // GetReqHeader;
        Type := Type::Item;
    end;

    trigger OnModify()
    begin
        TESTFIELD("Document No.");
        GetReqHeader;
    end;

    var
        IssHeader: Record 50093;
        Item: Record 27;
        PurchInvLine: Record 123;
        Vendor: Record 23;
        IssueLine: Record 50094;
        FixedAsset: Record 5600;
        PurchInvLine1: Record 123;
        MachineCenter: Record 99000758;
        IssueHeader: Record 50093;
        RecGLAccount: Record 15;
        // DimMgt: Codeunit DimensionManagement;
        DimMgt1: Codeunit "DimensionManagement Ext";
        IssLine: Record 50094;
        Recno: Integer;
        ItemLedgEntry: Record 32;
        IssueHead: Record 50093;
        ItemTab: Record 27;
        Qty1,
        Amt1,
        Qty2,
        Rt : Decimal;
        sig: Boolean;

    procedure GetReqHeader()
    begin
        IssHeader.SETRANGE(IssHeader."No.", "Document No.");
        IF IssHeader.FINDFIRST THEN BEGIN
            "Location Code" := IssHeader."Location Code";
            VALIDATE("Shortcut Dimension 1 Code", IssHeader."Shortcut Dimension 1 Code");
            VALIDATE("Shortcut Dimension 2 Code", IssHeader."Shortcut Dimension 2 Code");
            //ReqHeader."Branch Code"

            "Consumption Type" := IssHeader."Consumption Type";
            VALIDATE("Issue To Section", IssHeader."Issue to Section");
            MODIFY;

        END;
    end;

    /// <summary>
    /// TestStatus.
    /// </summary>
    procedure TestStatus()
    begin
        IssueHeader.SETRANGE("No.", "Document No.");
        IssueHeader.SETRANGE(Release, TRUE);
        IF IssueHeader.FINDFIRST THEN
            ERROR('Document Must be Open');
    end;


    /// <summary>
    /// LookupShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt1.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt1.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
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
    /// SelectItemEntry.
    /// </summary>
    /// <param name="CurrentFieldNo">Integer.</param>
    procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record 32;
    begin
        IssueHead.RESET;
        IssueHead.SETRANGE(IssueHead."No.", "Document No.");
        IF IssueHead.FINDFIRST THEN BEGIN

            ItemLedgEntry.RESET;
            ItemLedgEntry.SETRANGE(ItemLedgEntry."Location Code", IssueHead."Location Code");
            ItemLedgEntry.SETRANGE(ItemLedgEntry.Open, TRUE);
            ItemLedgEntry.SETFILTER("Remaining Quantity", '>%1', 0);

            ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", IssueHead."Shortcut Dimension 2 Code");

            IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN

                "Location Code" := IssueHead."Location Code";
                VALIDATE("No.", ItemLedgEntry."Item No.");
                VALIDATE("Shortcut Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code", IssueHead."Shortcut Dimension 2 Code");
                VALIDATE("Issue To Section", IssueHead."Issue to Section");
                "Apply to Entry No." := ItemLedgEntry."Entry No.";
                Quantity := ItemLedgEntry."Remaining Quantity";

            END;

        END;
    end;


    procedure SelectItemEntry1(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record 32;
    begin
        IssueHead.RESET;
        IssueHead.SETRANGE(IssueHead."No.", "Document No.");
        IF IssueHead.FINDFIRST THEN BEGIN

            ItemLedgEntry.RESET;
            ItemLedgEntry.SETRANGE(ItemLedgEntry."Location Code", IssueHead."Location Code");
            ItemLedgEntry.SETRANGE(ItemLedgEntry.Open, TRUE);
            ItemLedgEntry.SETFILTER("Remaining Quantity", '>%1', 0);
            ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", IssueHead."Shortcut Dimension 2 Code");
            IF "Lot No" = '' THEN
                ItemLedgEntry.SETFILTER("Item No.", '<>%1', 'FG*');
            IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
                "No." := ItemLedgEntry."Item No.";
                VALIDATE("No.");
            END;
        END;
    end;
}

