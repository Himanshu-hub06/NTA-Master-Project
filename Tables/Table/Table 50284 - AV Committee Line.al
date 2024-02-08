table 50284 "AV Committee Line"
{
    DataCaptionFields = "Committee Code";


    fields
    {
        field(1; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "AV Committee Header"."Committee Code";
            //Caption = 'Document No.';

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(3; "Member ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = User."User Name";
            ValidateTableRelation = false;
            TableRelation = Member."Member Name";

            trigger OnValidate()
            var
                Recmember: Record Member;

            begin

                // UserTab.RESET;
                // UserTab.SETRANGE("User Name", "Member ID");
                // IF UserTab.FIND('-') THEN begin
                //     "Member Name" := UserTab."Full Name";
                //     "E-mail ID" := UserTab."Contact Email";

                // end
                // ELSE
                //     "Member Name" := '';
                Recmember.Reset();
                Recmember.SetRange("Member Name", "Member ID");
                if Recmember.Find('-') then begin
                    "Member Name" := Recmember."Member Name";
                    "E-mail ID" := Recmember."Email-Id";
                    Designation := Recmember.Designation;

                end
                else
                    "Member Name" := ''; //rk

            end;

        }
        field(4; "Member Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = Member;

        }
        field(5; "Member Role"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Media Description"; Text[80])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code")));
            FieldClass = FlowField;
        }
        field(17; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fresh,Renewal,Job Allocation';
            OptionMembers = " ",Fresh,Renewal,"Job Allocation";
        }
        field(18; "Approval Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Minimum Price For Approval"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Maximum Price For Approval" <> 0) AND ("Minimum Price For Approval" <> 0) THEN
                    IF "Maximum Price For Approval" < "Minimum Price For Approval" THEN
                        ERROR('Maximum amount should be greater than Minimum Amount');
            end;
        }
        field(20; "Maximum Price For Approval"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Maximum Price For Approval" <> 0) AND ("Minimum Price For Approval" <> 0) THEN
                    IF "Maximum Price For Approval" < "Minimum Price For Approval" THEN
                        ERROR('Maximum amount should be greater than Minimum Amount');
            end;
        }
        field(21; "E-mail ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(22; Designation; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "No. Of Pendancy"; Integer)
        {
            // DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = count("Committee Member App Entry" where("User ID" = field("Member ID"), "Committee Code" = field("Committee Code"), Submitted = const(false))); //ROHIT
        }
        field(50; "Committee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Print Media,Out Door,AV TV,AV Radio,Production,Production Job Allocation';
            OptionMembers = " ","Print Media","Out Door","AV TV","AV Radio",Producer,"PR Job Allocation";
        }
        field(51; "Salutation"; Enum Salutation)
        {
            DataClassification = ToBeClassified;
        }  //ROHIT

        field(52; "Committee Chairman"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Member Secretary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Committee Type", "Committee Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    // trigger OnInsert()
    // var
    //     CommLine: Record "AV Committee Line";
    // begin
    //     Clear(CommLine);
    //     CommLine.Reset();
    //     CommLine.SetRange("Member ID", "Member ID");
    //     CommLine.SetCurrentKey("Line No.");
    //     if CommLine.FindLast() then begin
    //         Rec."Line No." := CommLine."Line No." + 1;
    //     end
    //     else
    //         rec."Line No." := 1;
    // end; /// rohit

    var
        UserTab: Record 2000000120;
        TxtUserError: Label 'E-mail ID %1 not found in user master, Please create User ID for this committee member.';

    procedure GetCommitteeHeader()
    var
        ComHdr: Record "AV Committee Header";
    begin
        ComHdr.RESET;
        ComHdr.SETRANGE(ComHdr."Committee Code", "Committee Code");
        IF ComHdr.FIND('-') THEN BEGIN
            "Global Dimension 1 Code" := ComHdr."Global Dimension 1 Code";
            "Media Description" := ComHdr."Media Description";
            Type := ComHdr.Type;
            "Committee Type" := ComHdr."Committee Type";
        END
    end;

    local procedure CheckDupliacteMember(): Boolean
    var
        CommitteeLine11Rec: Record "AV Committee Line";
    begin
        CommitteeLine11Rec.RESET;
        CommitteeLine11Rec.SETRANGE("Committee Code", Rec."Committee Code");
        CommitteeLine11Rec.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
        CommitteeLine11Rec.SETRANGE("Member ID", Rec."Member ID");
        EXIT(CommitteeLine11Rec.FINDFIRST);
    end;
}

