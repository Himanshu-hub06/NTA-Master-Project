table 50283 "AV Committee Header"
{
    DataCaptionFields = "Committee Code";
    fields
    {
        field(1; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                InvtSetup: Record 313;

            begin
                IF "Committee Code" <> xRec."Committee Code" THEN BEGIN
                    InvtSetup.GET;
                    NoSeriesMgt.TestManual(InvtSetup."Committee Code");
                    "No. Series" := '';

                END;
            end;
        }


        field(2; "Committee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Committee Header";
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;


            trigger OnValidate()
            begin
                IF "Start Date" <> xRec."Start Date" THEN
                    //UpdateLine; //ROHIT
                IF "Start Date" <> 0D THEN
                        IF "Start Date" < TODAY THEN
                            ERROR('Back Dates are not valid');
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "End Date" <> xRec."End Date" THEN
                    //UpdateLine; //ROHIT
                    IF "End Date" < "Start Date" THEN
                        ERROR('End Date can not be less than from Start Date %1', "Start Date");
            end;
        }
        field(6; "Media Description"; Text[80])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code")));
            FieldClass = FlowField;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fresh,Renewal,Job Allocation';
            OptionMembers = " ",Fresh,Renewal,"Job Allocation";

            trigger OnValidate()
            begin
                IF Type <> xRec.Type THEN BEGIN
                    ComLine.RESET;
                    ComLine.SetRange("Committee Type", "Committee Type");  // HYC
                    ComLine.SETRANGE(ComLine."Committee Code", "Committee Code");
                    IF ComLine.FINDSET THEN
                        REPEAT
                            //ComLine.Type := Type; HYC
                            ComLine."Committee Code" := "Committee Code"; //HYC New
                            ComLine.MODIFY;
                        UNTIL ComLine.NEXT = 0;
                END
            end;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Draft,Active,InActive';
            OptionMembers = Draft,Active,InActive;
        }
        field(18; "Login Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1100; "Empanelment Category"; Option)
        {
            Caption = 'Media Category';
            DataClassification = ToBeClassified;
            OptionCaption = 'Print,Outdoor,Channel,AV Production,Website,Community Radio,Pvt. FM,Digital Cinema,Bulk SMS & OBD';
            OptionMembers = Print,Outdoor,Channel,"AV Producer",Website,"Community Radio","Pvt. FM","Digital Cinema","Bulk SMS & OBD";
        }
        field(50; "Committee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Print,Outdoor,AV TV,Radio,Production,Production Job Allocation';
            OptionMembers = " ","Print Media","Out Door","AV TV","Radio",Producer,"PR Job Allocation";

            // OptionCaption = ' ,Print,Outdoor,AV TV,AV Radio';
            // OptionMembers = " ","Print Media","Out Door","AV TV","AV Radio";

        }
        field(55; "Responsibility Centre"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(56; "Meeting No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(57; "Committee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Committee Header";
            trigger OnValidate()
            var
                commmint: Record "Committee Header";
            begin
                if "Committee No." <> xRec."Committee No." then begin
                    commmint.Reset();
                    if commmint.Get("Committee No.") then begin
                        "Committee Name" := commmint."committee Name";

                    end
                end;
            end;
        }

    }

    keys
    {
        key(Key1; "Committee Type", "Committee Code", "Committee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ComLine.RESET;
        ComLine.SetRange(ComLine."Committee Type", "Committee Type");    // HYC
        ComLine.SETRANGE(ComLine."Committee Code", "Committee Code");
        IF ComLine.FINDSET THEN
            ComLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        /*//kc 28042023
        IF "Committee Code" = '' THEN BEGIN
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."AV PAC No. Series");
            NoSeriesMgt.InitSeries(InvSetup."AV PAC No. Series", xRec."No. Series", 0D, "Committee Code", "No. Series");

        END;
        */
        "Created By" := USERID;
        "Created Date" := TODAY;
    end;

    trigger OnModify()
    begin
        "Modified By" := USERID;
        "Last Modified Date" := TODAY;
    end;

    var

        ComHdr: Record 50283;
        InvSetup: Record 313;
        NoSeriesMgt: Codeunit 396;
        ComLine: Record 50284; //HYC Table No.

    // procedure AssistEdit(): Boolean
    // procedure AssistEdit(CMType: option ,Emp,MP): Boolean
    // var
    //     InvSetup: Record 313;
    //     NoSeriesMgt: Codeunit 396;
    //     MPStup: Record "Media Plan Setup";
    // begin
    //     WITH ComHdr DO BEGIN
    //         ComHdr := Rec;
    //         InvSetup.GET;
    //         InvSetup.TESTFIELD(InvSetup."AV PAC No. Series");
    //         MPStup.Get();
    //         MPStup.TestField("Producer JAC No. Series");
    //         if CMType = CMType::Emp then
    //             Rec."Committee Code" := NoSeriesMgt.GetNextNo(InvSetup."AV PAC No. Series", Today, true);
    //         if CMType = CMType::MP then
    //             Rec."Committee Code" := NoSeriesMgt.GetNextNo(MPStup."Producer JAC No. Series", Today, true);
    //         if rec."Committee Code" <> '' THEN
    //             EXIT(TRUE);
    //         // IF NoSeriesMgt.SelectSeries(InvSetup."AV PAC No. Series", xRec."No. Series", "No. Series") THEN BEGIN
    //         //     // IF NoSeriesMgt.SelectSeries(GetNoSeries(), xRec."No. Series", "No. Series") THEN BEGIN //commented by kamlesh date 21-02-2023
    //         //     NoSeriesMgt.SetSeries("Committee Code");
    //         //     Rec := ComHdr;
    //         //     EXIT(TRUE);
    //         // END;


    //     END;
    // end;

    // procedure OPAssistEdit(): Boolean
    // var
    //     InvSetup: Record 313;
    //     NoSeriesMgt: Codeunit 396;
    // begin
    //     WITH ComHdr DO BEGIN
    //         ComHdr := Rec;
    //         // InvSetup.GET;
    //         // InvSetup.TESTFIELD(InvSetup."OP Committee No. Series");
    //         IF NoSeriesMgt.SelectSeries(GetNoSeries(), xRec."No. Series", "No. Series") THEN BEGIN
    //             NoSeriesMgt.SetSeries("Committee Code");
    //             Rec := ComHdr;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;

    // procedure UpdateLine()
    // var
    //     ComLine: Record 50063;
    // begin
    //     /*
    //     ComLine.RESET;
    //     ComLine.SETRANGE(ComLine."Committee Code","Committee Code");
    //     IF ComLine.FIND('-') THEN
    //       REPEAT
    //         ComLine."Start Date":="Start Date";
    //         ComLine."End Date":="End Date";
    //         ComLine.MODIFY(TRUE);
    //       UNTIL ComLine.NEXT = 0;
    //     */

    // end;

    // local procedure GetNoSeries(): Code[10]
    // var
    //     RespCentre: Record "Responsibility Center";
    // begin
    //     RespCentre.RESET;
    //     RespCentre.SetRange("Document Type", Rec."Committee Type");
    //     IF RespCentre.FindFirst() then begin
    //         EXIT(RespCentre."Committee No. Series")
    //     end Else begin
    //         InvSetup.GET;
    //         EXIT(InvSetup."Committee No. Series");
    //     end;
    // end;

    // // procedure ProducerLoginCreation(var LoginEnbl: Boolean)
    // procedure ProducerLoginCreation(var LoginEnbl: Boolean; CmType: option ,Emp,MP) //kc 04-09-2023
    // var
    //     CommLine: Record 50266;
    //     UserTab: Record 2000000120;
    //     BSEBUser: Record 50000;
    //     AccessTab: Record 2000000053;
    //     UserPerTab: Record 2000000073;
    //     TempPass: Text;
    //     UserCode: Code[50];
    //     AllProfile: record "All Profile";
    // MPSetup: Record "Media Plan Setup";  //ROHIT
    //     NosrsemgtCU: Codeunit NoSeriesManagement;
    // begin
    //     IF NOT CONFIRM('Do you want to create Login ID for committee members?') THEN
    //         EXIT;
    //     CommLine.Reset();
    //     CommLine.SETRANGE("Committee Code", "Committee Code");
    //     IF CommLine.FINDFIRST THEN BEGIN
    //         REPEAT
    //             TempPass := 'Boc@1234';
    //             UserTab.INIT;
    //             UserTab."User Security ID" := CREATEGUID;
    //             MPSetup.Reset();
    //             MPSetup.Get();
    //             if CmType = CmType::Emp then begin
    //                 MPSetup.TestField("AVPro Comm Member No. Series");
    //                 UserCode := NosrsemgtCU.GetNextNo(MPSetup."AVPro Comm Member No. Series", Today, true);
    //             end;
    //             if CmType = CmType::MP then begin
    //                 MPSetup.TestField("Producer JAC Member No. Series");
    //                 UserCode := NosrsemgtCU.GetNextNo(MPSetup."Producer JAC Member No. Series", Today, true);
    //             end;
    //             UserTab."User Name" := UserCode;
    //             UserTab."Full Name" := CommLine."Member Name";
    //             UserTab."Contact Email" := CommLine."E-mail ID";
    //             UserTab."Change Password" := FALSE;
    //             IF UserTab.INSERT THEN BEGIN
    //                 SETUSERPASSWORD(UserTab."User Security ID", TempPass);
    //                 AccessTab.INIT;
    //                 AccessTab."User Security ID" := UserTab."User Security ID";
    //                 // AccessTab."Role ID" := 'SUPER';
    //                 AccessTab.Validate("Role ID", 'SUPER');
    //                 AccessTab.Scope := AccessTab.Scope::System;// nitin 050723// If permission set is user defined then scope will be tenant else scope will be system.
    //                 AccessTab."User Name" := UserTab."User Name";
    //                 AccessTab.INSERT;
    //                 UserPerTab.INIT;
    //                 UserPerTab."User SID" := UserTab."User Security ID";
    //                 AllProfile.Reset();
    //                 AllProfile.SetRange("Profile ID", 'PRODUCTION COMMITTEE MEMBER');
    //                 AllProfile.SetRange(Scope, AllProfile.Scope::Tenant);
    //                 if AllProfile.FindFirst() then begin
    //                     UserPerTab."Profile ID" := AllProfile."Profile ID";
    //                     UserPerTab.Scope := AllProfile.Scope;
    //                 end;
    //                 UserPerTab.INSERT;
    //                 CommLine."Member ID" := UserCode;
    //                 CommLine.MODIFY;
    //             END;
    //         UNTIL CommLine.NEXT = 0;
    //         rec."Login Created" := true;
    //         rec.Status := rec.Status::Active;
    //         LoginEnbl := false;
    //         if Rec.Modify() then
    //             MESSAGE('User login successfully created');
    //     END;
    // end;


    // procedure GetUserDocType(): Integer
    // var
    //     RespCenter: Record 5714;
    // begin
    //     IF "Responsibility Centre" <> '' THEN BEGIN
    //         RespCenter.GET("Responsibility Centre");
    //         RespCenter.TESTFIELD("Document Type");
    //         EXIT(RespCenter."Document Type");
    //     END;
    // end;
    procedure AssistEdit(): Boolean
    begin
        WITH ComHdr DO BEGIN
            ComHdr := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Committee Code");
            IF NoSeriesMgt.SelectSeries(InvSetup."Committee Code", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Committee Code");
                Rec := ComHdr;
                EXIT(TRUE);
            END;
        END;
    end;
    //  procedure AssistEdit(): Boolean
    // begin
    //     WITH MemID DO BEGIN
    //         MemID := Rec;
    //         Invent.GET;
    //         Invent.TESTFIELD(Invent."Member Id");
    //         IF NoSeriesMgt.SelectSeries(Invent."Member Id", xRec."No. Series", "No. Series") THEN BEGIN
    //             NoSeriesMgt.SetSeries("Member Id");
    //             Rec := MemID;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;


    var
        RespCentre: Record "Responsibility Center";
}

