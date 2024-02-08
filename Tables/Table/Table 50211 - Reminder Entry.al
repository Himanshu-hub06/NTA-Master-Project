table 50211 "Reminder Entry"
{

    fields
    {
        field(1; "Reminder No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Writ/Case Header"."File No." WHERE("User Section Code" = FIELD("User Section"));

        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Reminder Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Legal';
            OptionMembers = " ",Legal;
        }
        field(6; "Sender ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Sender Section Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Receiver ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Receiver Section Code" = FILTER(<> '')) "User Setup"."User ID" WHERE(Section = FIELD("Receiver Section Code"))
            ELSE
            "User Setup"."User ID";


        }
        field(9; "Receiver Section Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; Attachment; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Unread; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sent Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Read Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Sender Description"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Sender ID")));
            FieldClass = FlowField;
        }
        field(22; "Receiver Description"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Receiver ID")));
            FieldClass = FlowField;
        }
        field(23; "Sender Designation"; Text[150])
        {
            //CalcFormula = Lookup(User."Designation Name" WHERE ("User Name"=FIELD("Receiver ID)));
            CalcFormula = Lookup("User BOC"."Designation Name" WHERE("User Name" = FIELD("Receiver ID")));
            FieldClass = FlowField;
        }

        field(24; "Receiver Designation"; Text[150])
        {
            //CalcFormula = Lookup(User."Designation Name" WHERE (User Name=FIELD(Receiver ID)));
            CalcFormula = Lookup("User BOC"."Designation Name" WHERE("User Name" = FIELD("Receiver ID")));
            FieldClass = FlowField;
        }
        field(25; "User Section"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Reminder No.")
        {
        }
    }

    fieldgroups
    {
    }



    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created On" := CURRENTDATETIME;
        IF UserSetup.GET(USERID) THEN
            "User Section" := UserSetup.Section;
    end;

    trigger OnModify()
    begin
        "Modified By" := USERID;
        "Modified On" := CURRENTDATETIME;
    end;

    var
        ReminderEntry: Record "Reminder Entry";
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

        //FileManagement v: Codeunit ;;
        FileManagement: Codeunit "File Management";
        OldFileName: Text;

        UserSetup: Record "User Setup";

    procedure AssistEdit(): Boolean
    begin
        WITH ReminderEntry DO BEGIN
            ReminderEntry := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Reminder No. Series");
            IF NoSeriesMgt.SelectSeries(InvSetup."Reminder No. Series", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Reminder No.");
                Rec := ReminderEntry;
                EXIT(TRUE);
            END;
        END;
    end;

    local procedure GetLineNo(): Integer
    var
        RemindEntry: Record "Reminder Entry";
    begin


    end;
}

