table 50082 "Approval User Group Member"
{
    Caption = 'Workflow User Group Member';
    LookupPageID = 50134;

    fields
    {
        field(1; "Approval User Group Code"; Code[20])
        {
            Caption = 'Approval User Group Code';
            TableRelation = "Approval User Group".Code;

            trigger OnValidate()
            var
                SequenceNo: Integer;
            begin
                // IF ("User Name" <> '') AND ("Approval User Group Code" <> '' ) THEN BEGIN
                //  UserSetup.GET("User Name");
                //  IF "Sequence No." = 0 THEN BEGIN
                //    SequenceNo := 1;
                //    ApprovalUserGroupMemberRec.SETCURRENTKEY("Approval Permission","Sequence No.");
                //    ApprovalUserGroupMemberRec.SETRANGE("Approval User Group Code","Approval User Group Code");
                //    IF ApprovalUserGroupMemberRec.FINDLAST THEN
                //      SequenceNo := ApprovalUserGroupMemberRec."Sequence No." + 1;
                //    VALIDATE("Sequence No.",SequenceNo);
                //    END;
                //    END;
            end;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            //   TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                UserSetup: Record 91;
                WorkflowUserGroupMember: Record 1541;
                SequenceNo: Integer;
            begin
                // IF UserSetup.GET("User ID") THEN
                //     VALIDATE("User Description", UserSetup.Designation);
                IF ("User ID" <> '') AND ("Approval User Group Code" <> '') THEN BEGIN
                    //  UserSetup.GET("User ID");
                    IF "Sequence No." = 0 THEN BEGIN
                        SequenceNo := 1;
                        ApprovalUserGroupMemberRec.SETCURRENTKEY("Approval Permission", "Sequence No.");
                        ApprovalUserGroupMemberRec.SETRANGE("Approval User Group Code", "Approval User Group Code");
                        IF ApprovalUserGroupMemberRec.FINDLAST THEN
                            SequenceNo := ApprovalUserGroupMemberRec."Sequence No." + 1;
                        VALIDATE("Sequence No.", SequenceNo);
                    END;
                END;
                UserTab.SETRANGE("User Name", "User ID");
                IF UserTab.FINDFIRST THEN
                    VALIDATE("User Full Name", UserTab."Full Name");
            end;
        }
        field(3; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            MinValue = 1;
        }
        field(4; "Media Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                 MediaTypeRec.RESET;
                 MediaTypeRec.SETRANGE(MediaTypeRec."Media Code","Media Code");
                 IF MediaTypeRec.FINDFIRST THEN
                  "Media Name" := MediaTypeRec.Description
                 ELSE
                  "Media Name" := '';
                  */

            end;
        }
        field(5; "Media Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Approval Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "User Description"; Text[80])
        {
            Editable = true;
            FieldClass = Normal;
        }
        field(8; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                IF LocationTab.GET("Location Code") THEN
                    "Location Name" := LocationTab.Name
                ELSE
                    "Location Name" := '';
            end;
        }
        field(9; "Location Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "User Full Name"; Text[80])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            FieldClass = FlowField;
        }
        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Minimum Price For Approval"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Maximum Price For Approval" <> 0) AND ("Minimum Price For Approval" <> 0) THEN
                    IF "Maximum Price For Approval" < "Minimum Price For Approval" THEN
                        ERROR('Maximum amount should be greater than Minimum Amount');
            end;
        }
        field(14; "Maximum Price For Approval"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Maximum Price For Approval" <> 0) AND ("Minimum Price For Approval" <> 0) THEN
                    IF "Maximum Price For Approval" < "Minimum Price For Approval" THEN
                        ERROR('Maximum amount should be greater than Minimum Amount');
            end;
        }
        field(15; "Recommend To Committee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Send For Modification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Section; code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = "Dimension Value".Code where("Dimension Code" = const('SECTION'));
            trigger onvalidate()
            var
                DimValue: Record "Dimension Value";
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'SECTION');
                DimValue.SETRANGE(DimValue.Code, Section);
                IF DimValue.FINDFIRST THEN
                    "Section Name" := DimValue.Name
                ELSE
                    "Section Name" := '';
            end;
        }
        field(18; "Section Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Plan Modification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Agreement Creation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Application User Shift"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Member ID"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Approval User Group Code", "User ID", "Media Code")
        {
            Clustered = true;
        }
        key(Key2; "Approval User Group Code", "Sequence No.", "User ID")
        {
        }
        key(Key3; "Sequence No.")
        {
        }
        key(Key4; "Media Code", "Media Name")
        {
        }
        key(Key5; "User ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", "User Description")
        {

        }
    }


    trigger OnModify()
    begin
        IF Rec."Media Code" <> xRec."Media Code" THEN BEGIN
        END;
    end;

    var
        LocationTab: Record 14;
        WorkflowUserGroupRec: Record 1540;
        WorkflowUserGroupMemberRec: Record 1541;
        ApprovalUserGroupMemberRec: Record 50082;
        UserSetup: Record 91;
        UserTab: Record 2000000120;
}

