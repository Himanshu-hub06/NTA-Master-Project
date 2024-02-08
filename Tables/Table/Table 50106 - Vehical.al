table 50106 Vehicle
{

    fields
    {
        field(1; "Vehicle Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; "Vehicle Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vehicle No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vehicle Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' , 5 Seater, 7 Seater';
            OptionMembers = " ","5 Seater","7 Seater";
        }
        field(5; "Vehicle Color"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vehicle Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Vehicle Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "RC Validity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Availability; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total (KM)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Vehicle Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Availability := TRUE;
        IF "Vehicle Code" = '' THEN BEGIN
            GLSetup.GET;
            GLSetup.TESTFIELD("Vehicle No. Series");
            NsMan.InitSeries(GLSetup."Vehicle No. Series", xRec."No. Series", 0D, "Vehicle Code", "No. Series");
        END;
    end;

    var
        GLSetup: Record 98;
        VRec: Record 50106;
        NsMan: Codeunit NoSeriesManagement;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(): Boolean
    begin
        WITH VRec DO BEGIN
            VRec := Rec;
            GLSetup.GET;
            GLSetup.TESTFIELD("Vehicle No. Series");
            IF NsMan.SelectSeries(GLSetup."Vehicle No. Series", xRec."No. Series", "No. Series") THEN BEGIN
                NsMan.SetSeries("Vehicle Code");
                Rec := VRec;
                EXIT(TRUE);
            END;
        END;
    end;
}

