table 50081 "Approval User Group"
{
    Caption = 'Approval User Group';
    LookupPageID = 50131;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Media Code"; Code[20])
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
        field(4; "Media Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        WorkflowUserGroupMember: Record 1541;
    begin
        ApprovalUserGroupMemberRec.RESET;
        ApprovalUserGroupMemberRec.SETRANGE("Approval User Group Code", Code);
        ApprovalUserGroupMemberRec.SETRANGE(ApprovalUserGroupMemberRec."Media Code", "Media Code");
        ApprovalUserGroupMemberRec.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        Active := TRUE;
    end;

    trigger OnRename()
    begin
        IF Rec."Media Code" <> xRec."Media Code" THEN BEGIN
            ApprovalUserGroupMemberRec.RESET;
            ApprovalUserGroupMemberRec.SETRANGE("Approval User Group Code", Code);
            ApprovalUserGroupMemberRec.SETRANGE(ApprovalUserGroupMemberRec."Media Code", xRec."Media Code");
            IF ApprovalUserGroupMemberRec.FINDSET THEN
                REPEAT
                    ApprovalUserGroupMemberRec."Media Code" := "Media Code";
                    ApprovalUserGroupMemberRec.RENAME(TRUE);
                UNTIL ApprovalUserGroupMemberRec.NEXT = 0;
        END;
    end;

    var
        WorkflowUserGroupRec: Record 1540;
        WorkflowUserGroupMemberRec: Record 1541;
        ApprovalUserGroupMemberRec: Record 50082;
}

