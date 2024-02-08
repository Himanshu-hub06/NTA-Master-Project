table 50214 "SOF Approval entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order, ';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
            DataClassification = ToBeClassified;
        }
        field(7; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";


            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Sender ID");

            // end;
        }
        field(8; "Approver ID"; Code[50])
        {
            Caption = 'Approver ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";


            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Approver ID");
            // end;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;

            trigger OnValidate()
            begin
                IF (xRec.Status = Status::Created) AND (Status = Status::Open) THEN
                    "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            end;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
            DataClassification = ToBeClassified;
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
            DataClassification = ToBeClassified;
        }
        field(12; "Last Modified By User ID"; Code[50])
        {
            Caption = 'Last Modified By User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";


            // trigger OnLookup()
            // begin
            //     UserMgt.LookupUserID("Last Modified By User ID");

            // end;
        }
        field(13; Comment; Boolean)
        {
            // CalcFormula = Exist("Legal Comment Line" WHERE (Document No.=FIELD(Document No.)));
            // Caption = 'Comment';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(15; "Pending Approvals"; Integer)
        {
            // CalcFormula = Count("SOF Approval entry" WHERE (Record ID to Approve=FIELD(Record ID to Approve),
            //                                                 Status=FILTER(Created|Open)));
            Caption = 'Pending Approvals';
            // FieldClass = FlowField;
        }
        field(16; "Record ID to Approve"; RecordID)
        {
            Caption = 'Record ID to Approve';
            DataClassification = ToBeClassified;
        }
        field(17; "Delegation Date Formula"; DateFormula)
        {
            Caption = 'Delegation Date Formula';
            DataClassification = ToBeClassified;
        }
        field(18; "Number of Approved Requests"; Integer)
        {
            // CalcFormula = Count("SOF Approval entry" WHERE (Record ID to Approve=FIELD(Record ID to Approve),
            //                                                 Status=FILTER(Approved)));
            Caption = 'Number of Approved Requests';
            //  FieldClass = FlowField;
        }
        field(19; "Number of Rejected Requests"; Integer)
        {
            // CalcFormula = Count("SOF Approval entry" WHERE (Record ID to Approve=FIELD(Record ID to Approve),
            //                                                 Status=FILTER(Rejected)));
            Caption = 'Number of Rejected Requests';
            //FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Entry No." := GetNextEntryNo();
    end;

    trigger OnModify()
    begin
        "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
        "Last Modified By User ID" := USERID;
    end;

    var
        UserMgt: Codeunit "User Management";
        PageManagement: Codeunit "Page Management";
        SOFAppEntry: Record "SOF Approval entry";

    local procedure GetNextEntryNo(): Integer
    begin
        IF SOFAppEntry.FIND('+') THEN
            EXIT((SOFAppEntry."Entry No.") + 1)
        ELSE
            EXIT(1);
    end;

    procedure OpenRecord()
    var
        RecRef: RecordRef;
        WritHdr: Record "Writ/Case Header";
    begin
        WritHdr.RESET;
        WritHdr.SETRANGE(WritHdr."File No.", "Document No.");
        IF WritHdr.FIND('-') THEN;
        // PAGE.RUN(50166, WritHdr);
    end;

    procedure GetNextSeqNo(DocNo: Code[20]): Integer
    var
        SOFApprovalEntry: Record "SOF Approval entry";
    begin
        SOFApprovalEntry.RESET;
        SOFApprovalEntry.SETCURRENTKEY("Document No.", "Sequence No.");
        SOFApprovalEntry.SETRANGE("Document No.", DocNo);
        SOFApprovalEntry.SETRANGE(Status, SOFApprovalEntry.Status::Created);
        IF SOFApprovalEntry.FINDLAST THEN
            EXIT(SOFApprovalEntry."Sequence No." + 1)
        ELSE
            EXIT(1);
    end;
}

