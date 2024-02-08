table 50104 "Vendor Bill Header"
{
    Caption = 'Vendor Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bill No."; Code[20])
        {
            Caption = 'Bill No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Bill No." <> xRec."Bill No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Bill Payment No.");
                    "No. Series" := '';

                END;

                TestStatusOpen()
            end;
        }
        field(2; "Bill Date"; Date)
        {
            Caption = 'Bill Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LocTab: Record Location;
            begin
                If LocTab.Get(Rec."Location Code") then
                    "Location Name" := LocTab.Name
                Else
                    "Location Code" := '';
            end;
        }
        field(4; "Location Name"; Text[120])
        {
            Caption = 'Location Name';
            DataClassification = ToBeClassified;
        }
        field(5; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = ToBeClassified;
        }
        field(6; "User Name"; Text[120])
        {
            Caption = 'User Name';
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(8; Attachment; Text[120])
        {
            Caption = 'Attachment';
            DataClassification = ToBeClassified;
        }
        field(9; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(10; "Transfer File User ID"; Code[50])
        {
            Caption = 'Transfer File User ID';
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" where("Approval User Group Code" = const('BillPay'));
            trigger OnValidate()
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE(UserGroupp."User ID", "Transfer File User Id");
                UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'BillPay');
                IF UserGroupp.FINDFIRST THEN
                    "Transfer File User Name" := UserGroupp."User Description"
                ELSE
                    "Transfer File User Name" := '';
            end;
        }
        field(11; "Transfer File User Name"; Text[120])
        {
            Caption = 'Transfer File User Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(12; "Financial Year"; Code[20])
        {
            Caption = 'Financial Year';
            DataClassification = ToBeClassified;
        }
        field(13; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Created User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                IndentLine: Record "Indent Line";
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            End;

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
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending for Approval,Approved,Closed,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Closed,Rejected;
        }
        field(18; "Pending From User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Pending From User Name"; Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Approved User ID"; Code[50])
        {

            TableRelation = "User Setup";
        }
        field(22; "Approving Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Sending User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Sending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Sending Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Direct,GeM;
        }
        field(28; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Account Section Accepted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Accepted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Accepted User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Sanction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Fund Entry No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Fund Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",LOA,Checque,PL,NP;
        }
        field(34; Amount; Decimal)
        {

            CalcFormula = Sum("Vendor Bill Line"."Amount Gst Included" WHERE("Document No." = FIELD("Bill No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Total Tds Amount"; Decimal)
        {

            CalcFormula = Sum("Vendor Bill Line"."Tds Amount" WHERE("Document No." = FIELD("Bill No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(37; "Total GST Tds Amount"; Decimal)
        {

            CalcFormula = Sum("Vendor Bill Line"."GST TDS/TCS Amount " WHERE("Document No." = FIELD("Bill No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Sanction Pushed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Sanction Pushed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Sanction Pusted User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Sanction Pushed Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Amount to Vendor"; Decimal)
        {
            CalcFormula = Sum("Vendor Bill Line"."Amount To Vendor" WHERE("Document No." = FIELD("Bill No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(266; "CRN Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(267; "CRN Generated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(268; "Bill Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Establisment Claim Master"."Bill Category";
            //TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }

        field(269; "Bill Desc."; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Establisment Claim Master"."Bill Description" WHERE("Bill Category" = field("Bill Category"));
            trigger OnValidate()
            var
                ECN: Record "Establisment Claim Master";
            begin
                ECN.Reset();
                ECN.SetRange("Bill Category", "Bill Category");
                ECN.SetRange("Bill Description", "Bill Desc.");
                IF ECN.FindFirst() then
                    "Bill Type" := ECN."Bill Type";

            end;
        }


        field(270; "Bill Type"; integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Establisment Claim Master"."Bill ID" where("Bill Category" = field("Bill Category"), "Bill Description" = field("Bill Desc."));
        }



    }
    keys
    {
        key(PK; "Bill No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin

        BillLine.RESET;
        BillLine.SETRANGE("Document No.", "Bill No.");
        IF BillLine.FINDFIRST THEN
            REPEAT
                BillLine.DELETE;
            UNTIL BillLine.NEXT = 0;
    end;

    trigger OnInsert()
    begin
        IF "Bill No." = '' THEN BEGIN
            PurchSetup.GET;

            PurchSetup.TESTFIELD(PurchSetup."Bill Payment No.");
            NoSeriesMgt.InitSeries(PurchSetup."Bill Payment No.", xRec."No. Series", "Bill Date", "Bill No.", "No. Series");
        END;
        VALIDATE("Bill Date", WORKDATE);
        "User ID" := USERID;

        //   UserSetup.SETRANGE("User Id", USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            // VALIDATE("Shortcut Dimension 1 Code",UserSetup."Branch Code");
            //   VALIDATE("Shortcut Dimension 2 Code", UserSetup.Section);
            //  VALIDATE("Location Code", UserSetup."Location Code");
        END;
        Genledsetup.get;
        Rec.Validate("Location Code", 'BOC001');
        Rec."Bill Date" := Today;
        Rec."Created Date" := Today;
        Rec."Created User ID" := UserId;

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure TestStatusOpen()
    begin
        IF Status <> Status::Open THEN
            ERROR(Text0001, "bill No.");
    end;

    procedure AssistEdit(OldbillHeader: Record 50104): Boolean
    var
        BillHead: Record 50104;
        purchandPaysetup: Record "Purchases & Payables Setup";
    begin
        WITH BillHead DO BEGIN
            BillHead := Rec;
            purchandPaysetup.GET;
            purchandPaysetup.TESTFIELD(purchandPaysetup."Bill Payment No.");
            IF NoSeriesMgt.SelectSeries(purchandPaysetup."Bill Payment No.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Bill No.");
                Rec := BillHead;
                EXIT(TRUE);
            END;
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BillLine: Record 50105;
        UserSetup: Record "User BOC";
        PurchSetup: Record "Purchases & Payables Setup";
        DimValue: Record "Dimension Value";
        Text0001: Label 'Status must be Open for Indent %1';
        DimMgt: Codeunit DimensionManagement;
        UserGroupp: Record 50082;
        Genledsetup: Record "General Ledger Setup";

}
