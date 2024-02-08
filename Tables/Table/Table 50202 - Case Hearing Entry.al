table 50202 "Case Hearing Entry"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Writ/Case Header"."File No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

            AutoIncrement = true;
        }
        field(3; "Next Hearing Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                MaxDate := 0D;
                CaseHearingEntry.RESET;
                CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                CaseHearingEntry.SETRANGE("Document No.", "Document No.");
                IF CaseHearingEntry.FIND('-') THEN
                    REPEAT
                        IF MaxDate < CaseHearingEntry."Next Hearing Date" THEN
                            MaxDate := CaseHearingEntry."Next Hearing Date";
                    UNTIL CaseHearingEntry.NEXT = 0;
                IF "Next Hearing Date" <= MaxDate THEN
                    ERROR('Next hearing date should be greater than previous hearing date');
            end;
        }
        field(4; "Hearing Details"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Oath No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "SOF Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Last Modified On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "User Exam Code"; Code[20])
        {
            CalcFormula = Lookup("Writ/Case Header"."User Exam Code" WHERE("File No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(13; "Oath Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created On" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := USERID;
        "Last Modified On" := CURRENTDATETIME;
    end;

    var
        WritCaseHdr: Record "Writ/Case Header";
        CaseHearingEntry: Record "Case Hearing Entry";
        MaxDate: Date;
        FileMovEntry: Record "File Movement Entry";

    local procedure GetLineNo(): Integer
    var
        CaseHearingEntry: Record "Case Hearing Entry";
    begin
        CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
        CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", "Document No.");
        IF CaseHearingEntry.FIND('+') THEN
            EXIT(CaseHearingEntry."Line No." + 10000);

        EXIT(10000);
    end;
}

