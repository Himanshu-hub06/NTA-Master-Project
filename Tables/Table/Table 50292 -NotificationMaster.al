table 50292 "Notification Master"
{
    Caption = 'Notification Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Notification No."; Code[10])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                InvtSetup: Record 313;

            begin
                If "Notification No." <> xRec."Notification No." Then Begin
                    InvtSetup.Get;
                    NoSeriesMgt.ManualNoAllowed(InvtSetup."Notification No.");
                    "No. Sereis" := '';
                End
            end;



        }
        field(2; "Notification"; Text[150])
        {
            Caption = 'Notification';
        }
        field(3; "Active From"; Date)
        {
            Caption = 'Active From';
        }
        field(4; "Active to"; Date)
        {
            Caption = 'Active to';
        }
        field(5; "Document Title"; Text[70])
        {
            Caption = 'Document Title';
        }
        field(6; "No. Sereis"; Code[10])
        {
            Caption = 'Notification No.';
        }
    }
    keys
    {
        key(PK; "Notification No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin


        IF "Notification No." = '' THEN BEGIN
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Notification No.");
            NoSeriesMgt.InitSeries(InvSetup."Notification No.", xRec."No. Sereis", 0D, "Notification No.", Rec."No. Sereis");
        END;
    end;

    var
        InvSetup: Record 313;
        NotMstr: Record 50292;
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(): Boolean
    begin
        WITH NotMstr DO BEGIN
            NotMstr := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Committee Code");
            IF NoSeriesMgt.SelectSeries(InvSetup."Notification No.", xRec."No. Sereis", "No. Sereis") THEN BEGIN
                NoSeriesMgt.SetSeries("Notification No.");
                Rec := NotMstr;
                EXIT(TRUE);
            END;
        END;
    end;
    // procedure AssistEdit(OldAdv: Record "Writ/Case Header"): Boolean
    // var
    //     AdvTab: Record "Writ/Case Header";
    // begin
    //     WITH AdvTab DO BEGIN
    //         AdvTab := Rec;
    //         IF NoSeriesMgt.SelectSeries('NFLA', OldAdv."No. series", "No. series") THEN BEGIN
    //             NoSeriesMgt.SetSeries("File No.");
    //             Rec := AdvTab;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;



}
