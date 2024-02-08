/// <summary>
/// Table NoteSheet (ID 50116).
/// </summary>
table 50084 NoteSheet
{
    //  LookupPageID = 50615;
    DataCaptionFields = "Document No.";
    fields
    {
        field(1; "Table Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Creator Section Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Creator Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Receiving Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Creation Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Running Note"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(9; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Open,Closed';
            OptionMembers = New,Open,Closed;
        }
        field(10; "Current Note"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Current UID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Current Section"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sender UID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sender Section"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Creator User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Current User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sender User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Creator UID"; Code[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserTab: Record "User BOC";
            begin
                UserTab.RESET;
                UserTab.SETRANGE(UserTab."User Name", USERID);
                IF UserTab.FINDFIRST THEN
                    Rec."Creator User Name" := UserTab."Full Name";
            end;
        }
        field(20; "Last Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Table Id", "Document No.", "Document Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        NSheet: Record 50084;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(): Boolean
    begin
        /*
        WITH NSheet DO BEGIN
          NSheet := Rec;
          IF NoSeriesMgt.SelectSeries('Note sheet',xRec."No. Series","No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("Document No.");
            Rec := NSheet;
            EXIT(TRUE);
          END;
        END;
        */

    end;
}

