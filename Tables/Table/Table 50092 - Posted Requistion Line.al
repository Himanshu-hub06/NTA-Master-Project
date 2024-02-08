/// <summary>
/// Table Posted Requistion Line (ID 50175).
/// </summary>
table 50092 "Posted Requistion Line"
{

    fields
    {
        field(50001; "Requisition No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Item)) Item WHERE("Item Category Code" = FIELD("Item Category"))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                   "Account Type" = CONST(Posting),
                                                                                   Blocked = CONST(false),
                                                                                   "Income/Balance" = FILTER("Income Statement"));

            trigger OnValidate()
            begin
                TestStatus;

                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    IF Item.GET("No.") THEN BEGIN
                        Description := Item.Description;
                        "Unit of Measure Code" := Item."Base Unit of Measure";
                        "Last Rate" := Item."Last Direct Cost";
                        "Description 2" := Item."Description 2";
                        "Description 3" := Item.Sepicification;
                        Rate := Item."Last Direct Cost";
                    END;
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


                ReqHeader.RESET;
                ReqHeader.SETRANGE("No.", "Requisition No.");
                IF ReqHeader.FIND('-') THEN BEGIN
                    IF ReqHeader."Location Code" <> '' THEN BEGIN
                        "Location Code" := ReqHeader."Location Code";
                        "Shortcut Dimension 1 Code" := ReqHeader."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
                        "Requsition to Department" := ReqHeader.Department;

                        Priority := ReqHeader.Priority;
                    END ELSE
                        ERROR('Requisition location should not be blank in Requisition Header');
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
                //GetReqHeader;
                ReqLine.RESET;
                ReqLine.SETRANGE(ReqLine."Requisition No.", "Requisition No.");
                ReqLine.SETRANGE(ReqLine."No.", "No.");
                IF ReqLine.FINDFIRST THEN BEGIN
                    Recno := ReqLine.COUNT;
                    IF Recno > 1 THEN
                        ERROR('Same Item already exist in previous Line');
                END;
            end;
        }
        field(50004; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CS Abhishek';

            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50005; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50006; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestStatus;

                Value := Quantity * Rate;
                "Approved Qty" := Quantity;
                //"Remaining Qty" := Quantity - "Issued Quantity";
                //"Quantity To Issue" := "Remaining Qty";
                //"PO Outstanding Quantity" := "Remaining Qty";
            end;
        }
        field(50007; "Required By Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CS Abhishek';

            trigger OnValidate()
            begin
                TestStatus;

                RequistionHeader.RESET;
                RequistionHeader.SETRANGE("No.", "Requisition No.");
                IF RequistionHeader.FINDFIRST THEN BEGIN
                    IF RequistionHeader."Posting Date" > "Required By Date" THEN
                        ERROR('You canot enter the Required by date less then Requested Date');
                END;
            end;
        }
        field(50008; "Monthly Consumption"; Text[10])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatus;
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
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

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
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));
            DecimalPlaces = 0 : 3;
            FieldClass = FlowField;
        }
        field(50014; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Indent';
            OptionMembers = Indent;
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
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(50019; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

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
        field(50020; "PO Assigne Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Remaining Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "MRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Indent Line Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Requisition Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(50027; "Machine Center Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Issued Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Quantity to be Issue"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Quantity to be Issue" > "Approved Qty" THEN
                    MESSAGE('Quantity to be Issue is greater than Approved Quantity');
            end;
        }
        field(50030; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Indent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Quantity To Issue"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            MinValue = 0;

            trigger OnValidate()
            begin
                CALCFIELDS("Stock in Hand");
                ReqHeader.RESET;
                ReqHeader.SETRANGE(ReqHeader."No.", "Requisition No.");
                IF ReqHeader.FINDFIRST THEN BEGIN
                    IF ReqHeader."Requisition to Section" = '04' THEN BEGIN
                        IF "Quantity To Issue" > "Approved Qty" THEN
                            ERROR('Quantity to Issue greater than Approved Qty');
                    END;
                END;
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

                Qty1 := 0;
                Amt1 := 0;
                sig := FALSE;
                Rt := 0;
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETRANGE("Item No.", "No.");
                ItemLedgEntry.SETRANGE(Positive, TRUE);
                ItemLedgEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                ReqHead.RESET;
                ReqHead.SETRANGE("No.", "Requisition No.");
                IF ReqHead.FINDFIRST THEN BEGIN
                    ItemLedgEntry.SETRANGE("Global Dimension 1 Code", ReqHead."Shortcut Dimension 1 Code");
                    ItemLedgEntry.SETRANGE("Global Dimension 2 Code", ReqHeader."Requisition to Section");
                END;
                /*
               IF "Lot No" <> '' THEN
                 ItemLedgEntry.SETFILTER("Lot No",'%1',"Lot No");
                 */
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
                IF "Quantity To Issue" > Qty1 THEN
                    ERROR('Requested Qty is more than available Qty - %1...%2', Quantity, Qty1);
                IF Quantity <> 0 THEN
                    Rt := Amt1 / Quantity;
                VALIDATE("Unit Cost", Rt);

            end;
        }
        field(50033; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50034; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,3,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50035; "PO Outstanding Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "PO Recieved Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"));
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
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0 : 3;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Approved Qty" > Quantity THEN
                    ERROR(' Approved Qty cannot be greater then Required Quantity');


                "Remaining Qty" := "Approved Qty";
            end;
        }
        field(50044; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }
        field(50045; "Indent Required"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Remaining Qty" = 0 THEN
                    ERROR('Remaining Qty must have a value');
                IF "Indent Required" THEN
                    "Quantity To Issue" := Quantity
                ELSE
                    "Quantity To Issue" := 0;
            end;
        }
        field(50046; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Requisition Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Indent Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'As Per Schedule,Urgent';
            OptionMembers = "As Per Schedule",Urgent;
        }
        field(50051; "Description 3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Sub Categories Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50096; "Requsition to Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");
            end;
        }
        field(50097; "MFG No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Consumption Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Revenue,Capital';
            OptionMembers = " ",Revenue,Capital;
        }
        field(50102; "Issued Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50103; "Dimension Set ID"; Integer)
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
        field(50106; "Stock on Hand To Dep"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Location Code" = FIELD("Location Code"),
                                                                              "Global Dimension 2 Code" = FIELD("Requsition to Department")));
            DecimalPlaces = 0 : 3;
            FieldClass = FlowField;
        }
        field(50107; "Apply to entry No."; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                SelectItemEntry(FIELDNO("Apply to entry No."));
            end;
        }
        field(50108; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankNumbers = BlankZero;
        }
        field(50109; "Item Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(50110; "Voucher Type Descreiption"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Requisition No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        Type := Type::Item;
    end;

    trigger OnModify()
    begin
        /*
        ReqHeader.RESET;
        ReqHeader.SETRANGE(ReqHeader."No.","Requisition No.");
        //ReqHeader.SETFILTER(ReqHeader."Approving UID",'<>%1',USERID);
        IF ReqHeader.FINDFIRST THEN BEGIN
          IF ((ReqHeader.Status <> ReqHeader.Status::Open) AND (ReqHeader."Approving UID" <> USERID)) THEN
            ERROR('You do not have permission to modify');
        
        END;
        TESTFIELD("Requisition No.");
        */
        GetReqHeader;

    end;

    var
        ReqHeader: Record 50087;
        Item: Record 27;
        PurchInvLine: Record 123;
        Vendor: Record 23;
        IndentLine: Record 50090;
        FixedAsset: Record 5600;
        PurchInvLine1: Record 123;
        MachineCenter: Record 99000758;
        RequistionHeader: Record 50087;
        RecGLAccount: Record 15;
        // DimMgt: Codeunit DimensionManagement;
        DimMgt1: Codeunit "DimensionManagement Ext";
        ReqLine: Record 50088;
        Recno: Integer;
        ReqLine1: Record 246;
        ItemLedgEntry: Record 32;
        ReqHead: Record 50087;
        ItemTab: Record 27;
        Qty1: Decimal;
        Amt1: Decimal;
        sig: Boolean;
        Qty2: Decimal;
        Rt: Decimal;

    /// <summary>
    /// GetReqHeader.
    /// </summary>
    procedure GetReqHeader()
    begin

        ReqHeader.RESET;
        ReqHeader.SETRANGE(ReqHeader."No.", "Requisition No.");
        IF ReqHeader.FINDFIRST THEN BEGIN
            //ReqHeader.TESTFIELD(ReqHeader."Shortcut Dimension 1 Code");
            ReqHeader.TESTFIELD(ReqHeader."Shortcut Dimension 2 Code");
            ReqHeader.TESTFIELD(ReqHeader."Posting Date");
            ReqHeader.TESTFIELD(ReqHeader."Location Code");
            ReqHeader.TESTFIELD(ReqHeader."Requisition to Section");
            //ReqHeader.TESTFIELD(ReqHeader."Requisition Type");
            "Location Code" := ReqHeader."Location Code";
            "Shortcut Dimension 1 Code" := ReqHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
            "Consumption Type" := ReqHeader."Consumption Type";
            "Requsition to Department" := ReqHeader."Requisition to Section";
            MODIFY;

        END;
    end;

    /// <summary>
    /// TestStatus.
    /// </summary>
    procedure TestStatus()
    begin
        RequistionHeader.SETRANGE("No.", "Requisition No.");
        RequistionHeader.SETFILTER(RequistionHeader.Status, '<>%1', RequistionHeader.Status::Open);
        IF RequistionHeader.FINDFIRST THEN
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

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record 32;
        ReqLine2: Record 50090;
    begin
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    var
    //ItemCheckAvail: Codeunit 311;
    begin
    end;
}

