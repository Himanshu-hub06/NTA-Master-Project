table 50201 Advocate
{
    LookupPageID = 50302;

    fields
    {
        field(1; "Advocate Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Advocate Code" <> xRec."Advocate Code" THEN BEGIN
                    NoSeriesMgt.TestManual('ADVOCATE');
                    "No. series" := ''
                END;
            end;
        }
        field(2; Name; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Father Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Mobile No."; Code[15])
        {
            DataClassification = ToBeClassified;
            Numeric = true;

            trigger OnValidate()
            begin
                IF "Mobile No." <> '' THEN
                    IF STRLEN("Mobile No.") < 10 THEN
                        ERROR('Mobile no. not valid');
            end;
        }
        field(8; "Phone No."; Code[15])
        {
            DataClassification = ToBeClassified;
            Numeric = true;
        }
        field(9; "Fax No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Email ID"; Text[50])
        {
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // begin
            //     IF "Email ID" <> '' THEN
            //       SMTPMail.CheckValidEmailAddresses("Email ID");
            // end;
        }
        field(11; "Date Of Registratin"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Start Date Of Empanelment"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Start Date Of Empanelment" <> 0D THEN
                    IF "End Date Of Empanelment" <> 0D THEN
                        IF "Start Date Of Empanelment" >= "End Date Of Empanelment" THEN
                            ERROR('Start date of empnaelment should be less than end date of empanelment');

                IF "Start Date Of Empanelment" <> 0D THEN
                    Active := TRUE
                ELSE
                    Active := FALSE;
            end;
        }
        field(13; "End Date Of Empanelment"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "End Date Of Empanelment" <> 0D THEN
                    IF "Start Date Of Empanelment" <> 0D THEN
                        IF "End Date Of Empanelment" <= "Start Date Of Empanelment" THEN
                            ERROR('End date of empnaelment should be greater than start date of empanelment');

                IF "End Date Of Empanelment" <> 0D THEN
                    Active := FALSE
                ELSE
                    Active := TRUE;
            end;
        }
        field(14; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Adv. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(16; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            begin
                PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code, "Post Code");
                IF PostCode.FIND('-') THEN
                    VALIDATE(City, PostCode.City)
                ELSE
                    VALIDATE(City, '');
            end;

        }
        field(18; "Bank A/c No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bank Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Branch; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "IFSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Advocate Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "Advocate Code" <> '' THEN
            ERROR('Advocate cannot be delete');

    end;

    trigger OnModify()
    begin


    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        // SMTPMail: Codeunit "400";//DSC
        PostCode: Record "Post Code";
        AdvAssignEntry: Record "Advocate Assigning Entry";

    procedure AssistEdit(OldAdv: Record Advocate): Boolean
    var
        AdvTab: Record Advocate;
    begin
        WITH AdvTab DO BEGIN
            AdvTab := Rec;
            IF NoSeriesMgt.SelectSeries('ADVOCATE', OldAdv."No. series", "No. series") THEN BEGIN
                NoSeriesMgt.SetSeries("Advocate Code");
                Rec := AdvTab;
                EXIT(TRUE);
            END;
        END;
    end;
}


