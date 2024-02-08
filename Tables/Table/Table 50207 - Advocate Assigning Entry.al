table 50207 "Advocate Assigning Entry"
{

    fields
    {
        field(1; "File No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Writ/Case Header"."File No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Advocate Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Advocate."Advocate Code" WHERE("Adv. Type" = FIELD("Advocate Type"),
                                                            Active = CONST(true));

            trigger OnValidate()
            begin
                AdvMaster.RESET;
                AdvMaster.SETRANGE("Advocate Code", "Advocate Code");
                IF AdvMaster.FIND('-') THEN
                    "Advocate Name" := AdvMaster.Name
                ELSE
                    "Advocate Name" := '';
            end;
        }
        field(4; "Advocate Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Advocate Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(6; "Internal Adv. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Creator,Reviewer';
            OptionMembers = " ",Creator,Reviewer;
        }
        field(7; "Assigned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Case Assign,SOF,Sent To External';
            OptionMembers = "Case Assign",SOF,"Sent To External";
        }
        field(14; "SOF Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "SOF Sending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "SOF Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "SOF Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "SOF Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Sent To External Adv."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sent To External Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "SOF Received"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "SOF Received Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "SOF Received Date" <> 0D THEN
                    IF "SOF Received Date" < "SOF Sending Date" THEN
                        ERROR('RecDateErr');  //DSC
            end;
        }
        field(23; "SOF File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Inactive Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "User Exam Code"; Code[20])
        {
            CalcFormula = Lookup("Writ/Case Header"."User Exam Code" WHERE("File No." = FIELD("File No.")));
            FieldClass = FlowField;
        }

        field(28; "User Section Code"; Code[20])
        {
            CalcFormula = Lookup("Writ/Case Header"."User Section Code" WHERE("File No." = FIELD("File No.")));
            FieldClass = FlowField;
        }
        field(29; "Created/Reviewed SOF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Revised SOF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Manual Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Supplementary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "SOF Sent By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "SOF Sender Name"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("SOF Sent By")));
            FieldClass = FlowField;
        }
        field(35; "SOF Received By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "SOF Receiver Name"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("SOF Received By")));
            FieldClass = FlowField;
        }
        field(37; "Case No."; Code[20])
        {
            CalcFormula = Lookup("Writ/Case Header"."Case No." WHERE("File No." = FIELD("File No.")));
            FieldClass = FlowField;
        }
        field(38; "Name Of Petitioner"; Text[100])
        {
            CalcFormula = Lookup("Writ/Case Header"."Name Of Petitioner" WHERE("File No." = FIELD("File No.")));
            FieldClass = FlowField;
        }

        field(39; Year; Integer)
        {
            CalcFormula = Lookup("Writ/Case Header".Year WHERE("File No." = FIELD("File No.")));
            FieldClass = FlowField;
        }
        field(40; "Send Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Email id"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "File No.", "Line No.")
        {
        }
        key(Key2; "SOF Sending Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Active THEN
            ERROR('Active entry cannot be deleted.');

        AdvAssignEntry.RESET;
        AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
        AdvAssignEntry.SETRANGE("File No.", "File No.");
        AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
        AdvAssignEntry.SETRANGE("Advocate Code", "Advocate Code");
        AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
        IF AdvAssignEntry.FIND('-') THEN
            IF AdvAssignEntry."SOF Received" THEN
                ERROR(CreatedErr, "Advocate Code");
    end;

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created On" := TODAY();

        "Line No." := GetNextLineNo;
        Active := TRUE;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := USERID;
        "Last Modified on" := CURRENTDATETIME;
    end;

    var
        AdvMaster: Record Advocate;
        AdvAssignEntry: Record "Advocate Assigning Entry";
        WritCaseHdr: Record "Writ/Case Header";
        RecDateErr: Label 'SOF received date should be greater than sent date.';
        ServerFileName: Text;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        // ServerFileHelper: DotNet File; 
        OldFileName: Text;
        AttachedFile: Text;
        CreatedErr: Label 'SOF received from %1, you cannot cancel advocate assign entry.';

    local procedure GetNextLineNo(): Integer
    begin
        AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
        AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", "File No.");
        IF AdvAssignEntry.FIND('+') THEN
            EXIT(AdvAssignEntry."Line No." + 10000);

        EXIT(10000);
    end;

    //DSC

    procedure AttachSOFDoc()
    begin
        InvSetup.GET;
        OldFileName := '';
        OldFileName := (InvSetup."Writ Case Write Path" + "SOF File Name");
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            "SOF File Name" := ClientFileName;
            MODIFY(TRUE);
        END ELSE BEGIN
            "SOF File Name" := '';
            MODIFY(TRUE);
        END;
        ClientFileName := InvSetup."Writ Case Write Path" + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, FALSE);
        IF OldFileName <> '' THEN
            FileManagement.DeleteServerFile(OldFileName);
    end;
}

