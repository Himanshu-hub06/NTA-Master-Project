table 50215 "File Movement Entry"
{
    Caption = 'File Movement Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Legal,Vigilance,PRO';
            OptionMembers = Legal,Vigilance,PRO;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Sender ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(4; "Sender Examination Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'EXAM');
                DimValue.SETRANGE(DimValue.Code, "Sender Examination Code");
                IF DimValue.FINDFIRST THEN
                    "Sender Examination Name" := DimValue.Name
                ELSE
                    "Sender Examination Name" := '';
            end;
        }
        field(5; "Sender Examination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Sender Section"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'));

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'SECTION');
                DimValue.SETRANGE(DimValue.Code, "Sender Section");
                IF DimValue.FINDFIRST THEN
                    "Sender Section Name" := DimValue.Name
                ELSE
                    "Sender Section Name" := '';
            end;
        }
        field(7; "Sender Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sender Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(9; "Sender location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Receiver ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(12; "Receiver Examination Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'EXAM');
                DimValue.SETRANGE(DimValue.Code, "Receiver Examination Code");
                IF DimValue.FINDFIRST THEN
                    "Receiver Examination Name" := DimValue.Name
                ELSE
                    "Receiver Examination Name" := '';
            end;
        }
        field(13; "Receiver Examination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Receiver Section"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'));

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE("Dimension Code", 'SECTION');
                DimValue.SETRANGE(Code, "Receiver Section");
                IF DimValue.FINDFIRST THEN
                    VALIDATE("Receiver Section Name", DimValue.Name);
            end;
        }
        field(15; "Receiver Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Receiver Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(17; "Receiver Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'At SO,Assigned To Section,In Process At Section,Return To VO,Return To Legal,Sent Back,Open,Forwarded,At VO';
            OptionMembers = "At SO","Assigned To Section","In Process At Section","Return To VO","Return To Legal","Sent Back",Open,Forwarded,"At VO";
        }
        field(20; "Record ID"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Sent For SOF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Received; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Created by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Last Modified by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Sent Back"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Sent For Compliance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Current User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "In Legal Section"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Legal Exam Code"; Code[20])
        {
            CalcFormula = Lookup("Writ/Case Header"."User Exam Code" WHERE("File No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(33; "Sent For SOF Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Sender Description"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Sender ID")));
            FieldClass = FlowField;
        }
        field(35; "Receiver Description"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Receiver ID")));
            FieldClass = FlowField;
        }
        field(36; "SOF Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Created,Open,Canceled,Rejected,Approved,Forwarded';
            OptionMembers = " ",Created,Open,Canceled,Rejected,Approved,Forwarded;
        }
        field(37; "SOF Approve/Reject By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "SOF Approval DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Verification Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'In Process,Clarification Sought,Verified-Ok,Verified-Not Ok,Closed';
            OptionMembers = "In Process","Clarification Sought","Verified-Ok","Verified-Not Ok",Closed;
        }
        field(40; "SOF Approved By"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("SOF Approve/Reject By")));
            FieldClass = FlowField;
        }
        field(41; "Name Of Petitioner"; Text[100])
        {
            CalcFormula = Lookup("Writ/Case Header"."Name Of Petitioner" WHERE("File No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(42; "Current User Name"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Current User")));
            FieldClass = FlowField;
        }
        field(43; "At Concern Section"; Boolean)
        {
            CalcFormula = Lookup("Writ/Case Header"."At Concern Section" WHERE("File No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        // field(44;"Agency Code";Code[20])
        // {
        //     CalcFormula = Lookup("Document Verification Header"."Agency Code" WHERE ("Document Verification No."=FIELD("Document No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(45;"Agency Name";Text[120])
        // {
        //     CalcFormula = Lookup("Document Verification Header"."Agency Name" WHERE (Document Verification No.=FIELD(Document No.)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(46;"Created By New";Code[50])
        // {
        //     CalcFormula = Lookup("Document Verification Header"."Created By" WHERE (Document Verification No.=FIELD(Document No.)));
        //     Caption = 'Created By';
        //     FieldClass = FlowField;
        // }
        // field(47;"Created Name New";Text[120])
        // {
        //     CalcFormula = Lookup(User."Full Name" WHERE (User Name=FIELD(Created By New)));
        //     Caption = 'Created Name ';
        //     FieldClass = FlowField;
        // }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
        key(Key2; "Document No.", "Sender ID", "Sending Date")
        {
        }
        key(Key3; "Document No.", "Line No.", "Sender Section", "Sending Date")
        {
        }
        key(Key4; "Document No.", "Receiver ID")
        {
        }
        // key(Key5; "Document No.", "Line No.", "Sending Date")
        // {
        // }
        key(Key6; "Received Date", "Document No.", "Line No.")
        {
        }
        key(Key7; "Document No.", "Line No.")
        {
        }
        key(Key8; "Sender ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created by" := USERID;
        "Created Date" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Modified by" := USERID;
        "Last Modified Date" := TODAY;
    end;

    var
        NextEntryNo: Integer;
        LegalFileEntry: Record "File Movement Entry";
        UserSetup: Record "User Setup";
        PageManagement: Codeunit "Page Management";
        //TenderHdr: Record
        DimValue: Record "Dimension Value";

    local procedure GetNextEntryNo(): Integer
    begin
        IF LegalFileEntry.FIND('+') THEN
            EXIT((LegalFileEntry."Document Type") + 1)
        ELSE
            EXIT(1);
    end;

    procedure OpenRecord()
    var
        RecRef: RecordRef;
        WritHdr: Record "Writ/Case Header";
    begin

        // WritHdr.RESET;
        // WritHdr.SETRANGE(WritHdr."File No.", "Document No.");
        // IF WritHdr.FIND('-') THEN
        //     IF "Sent For SOF" THEN
        //         PAGE.RUN(50141, WritHdr)
        //     ELSE
        //         IF "Sent For SOF Approval" THEN
        //             PAGE.RUN(50166, WritHdr)
        //         ELSE
        //             PAGE.RUN(50173, WritHdr);

    end;
}

