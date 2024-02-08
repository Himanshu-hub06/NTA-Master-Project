table 50287 Member
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(3; "Member Id"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Member."Member Id";
            trigger OnValidate()
            var

            begin
                If "Member Id" <> xRec."Member Id" then begin
                    Invent.Get;
                    NoSeriesMgt.TestManual(Invent."Member Id");
                    "No. Series" := '';
                end;
            end;

        }
        field(4; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Email-Id"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Designation; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Contact No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

        key(Key1; "Member Id", "Line No.", "Committee Code")
        {
            Clustered = true;
        }
    }
    //HYC following commented by me

    //HYC

    var

        MemID: Record Member;
        Invent: Record 313;
        NoSeriesMgt: Codeunit 396;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(): Boolean
    begin
        WITH MemID DO BEGIN
            MemID := Rec;
            Invent.GET;
            Invent.TESTFIELD(Invent."Member Id");
            IF NoSeriesMgt.SelectSeries(Invent."Member Id", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Member Id");
                Rec := MemID;
                EXIT(TRUE);
            END;
        END;
    end;

}