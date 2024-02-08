table 50021 "NTA Bill Setup"
{
    Caption = 'NTA Bill Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "TA Bill Landing UID"; Code[20])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = User."User Name";

            trigger OnLookup()
            begin
                CLEAR(BOCUser);
                IF BOCUser.RUNMODAL = ACTION::OK THEN BEGIN
                    BOCUser.GETRECORD(UserTab);
                    "TA Bill Landing UID" := UserTab."User Name";
                    //"User Description" := UserTab.Designation;
                END;
            end;
        }

        field(3; "Workflow Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Workflow for TA Bill Approval';
            TableRelation = "Approval User Group".Code;
        }
        field(4; "Budget Approval code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group".Code;
        }
        field(5; "TA & Centre Bill UID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transport Approval Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group".Code;
        }
        field(8; "Upload Ans User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Workflow Code3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        BOCUser: Page "BOC Users";
        UserTab: Record 2000000120;
}

