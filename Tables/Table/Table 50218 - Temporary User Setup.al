table 50067 "Temporary User Setup"
{
    Caption = 'Temporary User Setup';

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;



            //DSC as not Function in BC

            // trigger OnLookup()
            // var
            //     UserMgt: Codeunit 418;
            // begin
            //     UserMgt.LookupUserID("User ID");
            // end;

            // trigger OnValidate()
            // var
            //     UserMgt: Codeunit 418;
            // begin
            //     UserMgt.ValidateUserID("User ID");
            // end;
        }
        field(50022; Section; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'),
                                                          "Dimension Value Type" = FILTER(<> "Begin-Total" | "End-Total"));
            ValidateTableRelation = false;
        }
        field(50028; Designation; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
        key(Key2; Designation)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", Designation)
        {
        }
    }

    trigger OnDelete()
    var
        NotificationSetup: Record 1512;
    begin
    end;

    var
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: Label 'You cannot have both a %1 and %2. ';
        Text005: Label 'You cannot have approval limits less than zero.';
        PrivacyBlockedGenericErr: Label 'Privacy Blocked must not be true for Salesperson / Purchaser %1.', Comment = '%1 = salesperson / purchaser code.';
        UserSetupManagement: Codeunit 5700;
}

