table 50213 "Legal Comment Line"
{
    Caption = 'Legal Comment Line';
    DataCaptionFields = "Document No.";
    // LookupPageID = 50175;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            Editable = false;
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order, ';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(6; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
            Editable = false;
        }
        field(7; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(8; "Record ID to Approve"; RecordID)
        {
            Caption = 'Record ID to Approve';
            DataClassification = SystemMetadata;
        }
        field(9; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Note Sheet"; BLOB)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
        }
        field(12; "User Description"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            FieldClass = FlowField;
        }
        field(13; "User Designation"; Text[150])
        {
            CalcFormula = Lookup("User BOC"."Designation Name" WHERE("User Name" = field("User ID")));
            FieldClass = FlowField;
        }
        field(14; "User Section"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "User Section Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No.")
        {
        }
        key(Key2; "Table ID", "Document Type", "Document No.", "Record ID to Approve")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        IF "User ID" <> USERID THEN
            ERROR('You Cannot delete comment of other user');

        IF Active THEN
            ERROR('You cannot delete previous comments');

    end;

    trigger OnInsert()
    begin

        EVALUATE("Document No.", GETFILTER("Document No."));
        "User ID" := USERID;
        IF UserSetup.GET(USERID) THEN BEGIN
            "User Section" := UserSetup.Section;
            "User Section Name" := SectionName(UserSetup.Section);
        END;
        //"Date and Time" := CREATEDATETIME(TODAY,TIME);
        "Date and Time" := CURRENTDATETIME + ((1000 * 60) * 330);   //plus 5.30hrs
        IF "Entry No." = 0 THEN
            "Entry No." := GetNextEntryNo;
    end;

    trigger OnModify()
    begin
        //"Last Modified on" := CREATEDATETIME(TODAY,TIME);
        "Last Modified on" := CURRENTDATETIME + ((1000 * 60) * 330);
        IF "User ID" <> USERID THEN
            ERROR('You Cannot modify comment of other user');
        IF Active THEN
            ERROR('You cannot modify previous comments');
    end;

    var
        UserSetup: Record "User Setup";

    local procedure GetNextEntryNo(): Integer
    var
        LegalCommentLine: Record "Legal Comment Line";
    begin
        LegalCommentLine.SETCURRENTKEY("Entry No.");
        IF LegalCommentLine.FINDLAST THEN
            EXIT(LegalCommentLine."Entry No." + 1);

        EXIT(1);
    end;

    procedure SectionName(SecCode: Code[20]) SecName: Text[100]
    var
        DimValTab: Record "Dimension Value";
    begin
        DimValTab.RESET;
        DimValTab.SETRANGE("Dimension Code", 'SECTION');
        DimValTab.SETRANGE(DimValTab.Code, SecCode);
        IF DimValTab.FINDFIRST THEN
            SecName := DimValTab.Name;
    end;
}

