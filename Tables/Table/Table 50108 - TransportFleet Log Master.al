table 50108 "Transport/Fleet Log Master"
{
    Caption = 'Transport/Fleet Log Master';


    fields
    {
        field(1; "TF Code"; Code[10])
        {
            Caption = 'Transport/Fleet Code';
            DataClassification = ToBeClassified;
        }
        field(2; "TF Date"; Date)
        {
            Caption = 'Transport/Fleet Date';
            DataClassification = ToBeClassified;
        }
        field(3; "TF Time"; Time)
        {
            Caption = 'Transport/Fleet Time';
            DataClassification = ToBeClassified;
        }
        field(4; "Place to Visit"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Journey Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Official,Private';
            OptionMembers = " ",Official,Private;
        }
        field(6; "Requirement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,General,Urgent';
            OptionMembers = " ",General,Urgent;
        }
        field(7; "Vehicle Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Driver Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Start KM"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "End KM"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Name; Text[80])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                UserBSEB: Record 50000;
            begin
            end;
        }
        field(14; Designation; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Purpose; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Under Approval","Under GA Secton",Approved,Completed;
        }
        field(18; "Sender ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Receiver ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "To Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "To Date" < "From Date" THEN
                    ERROR('Please Select Valid Date!!');
            end;
        }
        field(22; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "End Trip"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Transfer User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" WHERE("Approval User Group Code" = CONST('TRANSPORT'));

            trigger OnValidate()
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE(UserGroupp."User ID", "Transfer User Id");
                UserGroupp.SETRANGE(UserGroupp."Approval User Group Code", 'TRANSPORT');
                IF UserGroupp.FINDFIRST THEN begin
                    UserGroupp.CalcFields(UserGroupp."User Full Name");
                    "Transfer User name" := UserGroupp."User Full Name";
                end
                ELSE
                    "Transfer User name" := '';
            end;

        }
        field(25; "Transfer User name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "TF Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "TF Time" := TIME;

        IF "TF Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD(GLSetup."Transport Fleet No. Series");
            NSMgt.InitSeries(GLSetup."Transport Fleet No. Series", xRec."No. Series", 0D, "TF Code", Rec."No. Series");
        END;
    end;

    var
        GLSetup: Record 98;
        TFLogMst: Record 50108;
        NSMgt: Codeunit NoSeriesManagement;
        UserGroupp: Record "Approval User Group Member";

    procedure AssistEdit(): Boolean
    begin
        WITH TFLogMst DO BEGIN
            TFLogMst := Rec;
            GLSetup.GET;
            GLSetup.TESTFIELD(GLSetup."Transport Fleet No. Series");
            IF NSMgt.SelectSeries(GLSetup."Transport Fleet No. Series", xRec."No. Series", "No. Series") THEN BEGIN
                NSMgt.SetSeries("TF Code");
                Rec := TFLogMst;
                EXIT(TRUE);
            END;
        END;
    end;
}

