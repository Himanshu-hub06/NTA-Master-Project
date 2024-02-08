table 50107 Driver
{

    fields
    {
        field(1; "Driver Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; "Driver Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Aadhar No."; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Contact No."; Code[10])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(5; Email; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(6; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; State; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code;
        }
        field(9; "Pin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Availability; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "State Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(state.Description where(Code = field(State)));
        }
        field(13; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Driver Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Availability := TRUE;
        IF "Driver Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Driver No. Series");
            NsMan.InitSeries(GLSetup."Driver No. Series", xRec."No. Series", 0D, "Driver Code", "No. Series");
        END;
    end;

    var
        PictureUpdated: Boolean;
        GLSetup: Record 98;
        Drec: Record 50107;
        NsMan: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean
    begin
        WITH Drec DO BEGIN
            Drec := Rec;
            GLSetup.GET;
            GLSetup.TESTFIELD("Driver No. Series");
            IF NsMan.SelectSeries(GLSetup."Driver No. Series", xRec."No. Series", "No. Series") THEN BEGIN
                NsMan.SetSeries("Driver Code");
                Rec := Drec;
                EXIT(TRUE);
            END;
        END;
    end;
}

