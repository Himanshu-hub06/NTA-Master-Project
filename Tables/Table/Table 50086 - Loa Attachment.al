table 50086 "Loa Attachment"
{
    Caption = 'Loa Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit 396;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchPayablesSetup.GET;
                    ;
                    NoSeriesMgt.TestManual(PurchPayablesSetup."Loa Attachment No.");
                    "No. Series" := '';
                END;

            end;
        }
        field(2; "Ministry Code"; Code[20])
        {
            Caption = 'Ministry Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Ministry Name"; Text[120])
        {
            Caption = 'Ministry Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Address; Text[120])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Address 1"; Text[120])
        {
            Caption = 'Address 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Addres 2"; Text[120])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Posted; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loa Media Category"; Option)
        {
            OptionMembers = "Single Media","Multiple Media";
            DataClassification = ToBeClassified;
        }
        field(16; "Loa Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Compaign;
        }
        field(17; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released;
        }
        field(35; "Loa No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "LOA Ledger Detailed"."Loa No."
            // where("Loa Entry" = const(true), "Head Code" = field("Ministry Code"));


        }
        field(40; "Media Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Print Media","Out Door","AV TV","AV Radio";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        PurchPayablesSetup: Record "Purchases & Payables Setup";
        Loaatt: Record "Loa attachment";

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "No." = '' THEN BEGIN
            PurchPayablesSetup.GET;
            ;
            PurchPayablesSetup.TESTFIELD(PurchPayablesSetup."Loa Attachment No.");
            NoSeriesMgt.InitSeries(PurchPayablesSetup."Loa Attachment No.", xRec."No. Series", 0D, "No.", "No. Series");

        END;
        "Created Date" := WorkDate;
        "Posting Date" := WorkDate;
        "User ID" := USERID;
    end;

    procedure AssistEdit(): Boolean
    var
        NoSeriesMgt: Codeunit 396;
    begin
        WITH Loaatt DO BEGIN
            Loaatt := Rec;
            PurchPayablesSetup.GET;
            PurchPayablesSetup.TESTFIELD(PurchPayablesSetup."Loa Attachment No.");
            IF NoSeriesMgt.SelectSeries(PurchPayablesSetup."Loa Attachment No.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := Loaatt;
                EXIT(TRUE);
            END;
        END;
    end;
}
