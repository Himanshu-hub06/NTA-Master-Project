table 50285 "AV Meeting Header"
{
    DataCaptionFields = "Committee Code";
    fields
    {
        field(1; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Meeting No."; Integer)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     InvtSetup: Record 313;

            // begin
            //     IF "Meeting No." <> xRec."Meeting No." THEN BEGIN
            //         InvtSetup.GET;
            //         NoSeriesMgt.TestManual(InvtSetup."Meeting No.");
            //         "No. Series" := '';

            //     END;
            // end;

        }
        field(3; "Meeting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CommitteeHdr: record "AV Committee Header";
            begin
                //kamlesh dated-15-05-2022
                // IF CommitteeHdr.Get("Committee Type", "Committee Code") then; //rohit
                // if "Meeting Date" <> 0D then begin
                //     if "Meeting Date" < CommitteeHdr."Start Date" then
                //         ERROR('Back Dates are not valid')
                //     else
                //         if "Meeting Date" > CommitteeHdr."End Date" then
                //             Error('Meeting Date is not allowed after Committee End date -%1', CommitteeHdr."End Date");
                // end //rohit
                //kamlesh 15-05-2022

                //below code commented by kamlesh
                // IF "Meeting Date" <> 0D THEN
                //     IF "Meeting Date" < TODAY THEN
                //         ERROR('Back Dates are not valid');
            end;
        }
        field(4; "Meeting Start Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Meeting Start Date Time" <> 0DT) AND ("Meeting End Date Time" <> 0DT) THEN
                    "Meeting Duration" := "Meeting End Date Time" - "Meeting Start Date Time";
            end;
        }
        field(5; "Meeting End Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Meeting Start Date Time" <> 0DT) AND ("Meeting End Date Time" <> 0DT) THEN
                    "Meeting Duration" := "Meeting End Date Time" - "Meeting Start Date Time";
            end;
        }
        field(6; "Meeting Duration"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Approved,Rejected,Mail Sent,Pending for Approval,Recommended To Committee,Closed';
            OptionMembers = Open,Approved,Rejected,"Mail Sent","Pending for Approval","Recommended To Committee",Closed;

            trigger OnValidate()
            begin
                MeetingLineRec.RESET;
                MeetingLineRec.SETRANGE("Committee Code", Rec."Committee Code");
                //MeetingLineRec.SETRANGE("Meeting Type",Rec."Meeting Type");
                MeetingLineRec.SETRANGE("Meeting No.", Rec."Meeting No.");
                IF MeetingLineRec.FINDSET THEN
                    MeetingLineRec.MODIFYALL(Status, Rec.Status);
            end;
        }
        field(9; "MOM Attachment"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Meeting Agenda"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Meeting Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Creater ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sender ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Receiver ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                IF "Document No." = '' THEN BEGIN
                    IF ("Committee Code" <> '') AND ("Meeting No." <> 0) THEN BEGIN
                        "Document No." := "Committee Code" + '/' + FORMAT("Global Dimension 1 Code") + '/' + FORMAT("Meeting No.");
                    END
                    ELSE
                        CLEAR("Document No.");
                END;
            end;
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "All submitted"; Boolean)
        {
            // CalcFormula = Exist("Meeting Header" WHERE("Data Exist" = CONST(true),
            //                                             "Non-Submission Count" = CONST(0),
            //                                             "Committee Code" = FIELD("Committee Code"),
            //                                            "Meeting No." = FIELD("Meeting No.")));
            // FieldClass = FlowField;  //ROHIT
        }
        field(22; "Non-Submission Count"; Integer)
        {
            // CalcFormula = Count("Committee Member App Entry" WHERE(Submitted = CONST(false),
            //                                                         "Committee Code" = FIELD("Committee Code"),
            //                                                         "Meeting No." = FIELD("Meeting No.")));
            // FieldClass = FlowField; //ROHIT
        }
        field(23; "Data Exist"; Boolean)
        {
            // CalcFormula = Exist("Committee Member App Entry" WHERE("Committee Code" = FIELD("Committee Code"),
            //                                                         "Meeting No." = FIELD("Meeting No.")));
            // FieldClass = FlowField; //ROHIT
        }
        field(24; "Meeting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Empanelment,Renewal';
            OptionMembers = " ",Empanelment,Renewal;
            trigger OnValidate()
            begin
                // if Confirm('Do you want to Load Vendor Applications', false) then begin
                //     LoadVendorApplication();
                // end;
            end;
        }
        field(25; "Meeting Venue"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Committee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Print,Outdoor,AV TV,AV Radio,AV Production';
            OptionMembers = " ","Print Media","Out Door","AV TV","AV Radio",Producre;

        }
        field(51; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Approved DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(1100; "Empanelment Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Print,Outdoor,Channel,AV Producer,Website,Community Radio,Pvt. FM,Digital Cinema,Bulk SMS & OBD';
            OptionMembers = Print,Outdoor,Channel,"AV Producer",Website,"Community Radio","Pvt. FM","Digital Cinema","Bulk SMS & OBD";
        }
        field(1101; "Meeting Time"; time)
        {
            DataClassification = ToBeClassified;
        }
        field(1102; "Close Meeting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1103; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Committee Type", "Committee Code", "Meeting No.")
        {
        }
        key(Key2; "Document No.")
        {
        }
        key(Key3; "Meeting Date")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Creater ID" := USERID;
        "Receiver ID" := USERID;

        IF "Document No." = '' THEN BEGIN
            IF ("Committee Code" <> '') AND ("Meeting No." <> 0) THEN BEGIN
                "Document No." := "Committee Code" + '/' + FORMAT("Global Dimension 1 Code") + '/' + FORMAT("Meeting No.");
            END
            ELSE
                CLEAR("Document No.");
        END;

        IF "Meeting Date" = 0D THEN
            "Meeting Date" := TODAY;
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        SelectLatestVersion();
    end;

    var
        MeetingLineRec: Record 50286; //50061;
        ShowPvtFM: Boolean;
        ShowPrint: Boolean;
        ShowOD: Boolean;
        ShowAV: Boolean;
        ShowAVPro: Boolean;
        ShowCRS: Boolean;
        NoSeriesMgt: Codeunit 396;
        MeetingH: Record "AV Meeting Header";
        InvSetup: Record 313;

    procedure ViewMOM()
    var
        FilDnld: Text[250];
        FilePath: Text[80];
        OldFileName: Text;
        ServerFileName: Text;
        Glsetup: Record 98;
        FileDirectory: Record "File Directory Detail";
    begin
        FileDirectory.GET;
        //FilePath := FileDirectory."Committee Attachments Read";
        IF "File Name" <> '' THEN BEGIN
            ServerFileName := FilePath + "File Name";
            HYPERLINK(ServerFileName);
        END
        ELSE
            ERROR('No Document uploaded here');

    end;

    procedure LoadVendorApplication()
    var
        //VendEmpOD: Record 50153;
        //MeetingLine: Record 50061;
        MeetingLine1: Record "AV Meeting Line";
        ODVendorRenewal: Record 50088;
        LastLineNo: Integer;
        MeetingHdr: Record "Meeting Header";
        MeetType: Integer;
    begin
        /*
        LastLineNo := 0;
        CheckStatus;
        MeetingLine.Reset();
        MeetingLine.SETRANGE("Committee Code", rec."Committee Code");
        MeetingLine.SetRange("Meeting No.", rec."Meeting No.");
        IF MeetingLine.FindFirst() then
            if confirm('Do You want to remove applications listed in this meeting', false) then
                MeetingLine.DeleteAll()
            else
                exit;
        IF Rec."Meeting Type" = Rec."Meeting Type"::Empanelment THEN BEGIN               //Empanelment applucation
            VendEmpOD.RESET;
            VendEmpOD.SETCURRENTKEY("OD Category", "OD Media ID");
            VendEmpOD.CalcFields("Selected In Meeting");
            VendEmpOD.SetRange("Selected In Meeting", false);
            VendEmpOD.SETRANGE(Status, VendEmpOD.Status::"Recommended To Committee");
            VendEmpOD.SETRANGE("Recommended To Committee", TRUE);
            IF VendEmpOD.FINDSET THEN BEGIN
                REPEAT
                    MeetingLine.INIT;
                    MeetingLine."Committee Code" := "Committee Code";
                    MeetingLine."Meeting No." := "Meeting No.";
                    MeetingLine."Document No." := "Document No.";
                    MeetingLine."Line No." := MeetingLine."Line No." + 10000;
                    MeetingLine."Newspaper Code" := VendEmpOD."OD Media ID";
                    MeetingLine."Newspaper Name" := VendEmpOD."PM Agency Name";
                    MeetingLine."Bank Account No." := VendEmpOD."Account No.";
                    MeetingLine."Bank Name" := VendEmpOD."Bank Name";
                    //MeetingLine."Account Holder Name":=;
                    //MeetingLine."Account Address":=;
                    MeetingLine."IFSC Code" := VendEmpOD."IFSC Code";
                    MeetingLine.Branch := VendEmpOD."Bank Branch";
                    // MeetingLine."RNI Registration No.":=;
                    MeetingLine."Global Dimension 1 Code" := VendEmpOD."Global Dimension 1 Code";
                    MeetingLine."Meeting Type" := MeetingLine."Meeting Type"::"Fresh Empanelment";
                    MeetingLine."Application Date" := VendEmpOD."Document Date";
                    MeetingLine.INSERT();
                UNTIL VendEmpOD.NEXT = 0;
            END ELSE
                MESSAGE('Application not found to load.');
        END ELSE
            IF Rec."Meeting Type" = Rec."Meeting Type"::Renewal THEN BEGIN          //Renewal Application
                ODVendorRenewal.RESET;
                ODVendorRenewal.SETCURRENTKEY("OD Category", "OD Media ID");
                ODVendorRenewal.SETRANGE(Status, ODVendorRenewal.Status::"Pending For Approval");
                //   ODVendorRenewal.SetRange("Selected In Meeting", false);
                ODVendorRenewal.SETRANGE("Recommended To Committee", TRUE);
                IF ODVendorRenewal.FINDSET THEN BEGIN
                    REPEAT
                        MeetingLine.INIT;
                        MeetingLine."Committee Code" := "Committee Code";
                        MeetingLine."Meeting No." := "Meeting No.";
                        MeetingLine."Document No." := "Document No.";
                        MeetingLine."Line No." := MeetingLine."Line No." + 10000;
                        MeetingLine."Newspaper Code" := ODVendorRenewal."OD Media ID";
                        MeetingLine."Newspaper Name" := ODVendorRenewal."PM Agency Name";
                        MeetingLine."Bank Account No." := ODVendorRenewal."Account No.";
                        MeetingLine."Bank Name" := ODVendorRenewal."Bank Name";
                        //MeetingLine."Account Holder Name":=;
                        //MeetingLine."Account Address":=;
                        MeetingLine."IFSC Code" := ODVendorRenewal."IFSC Code";
                        MeetingLine.Branch := ODVendorRenewal."Bank Branch";
                        // MeetingLine."RNI Registration No.":=;
                        MeetingLine."Global Dimension 1 Code" := ODVendorRenewal."Global Dimension 1 Code";
                        MeetingLine."Meeting Type" := MeetingLine."Meeting Type"::Renewal;
                        MeetingLine.INSERT();
                    UNTIL ODVendorRenewal.NEXT = 0;
                END ELSE
                    MESSAGE('Application not found to load.');
            END;
        // IF rec."Meeting Type" = Rec."Meeting Type"::Empanelment THEN BEGIN               //Empanelment applucation
        //     VendEmpOD.RESET;
        //     VendEmpOD.SETCURRENTKEY("OD Category", "OD Media ID");
        //     VendEmpOD.SETRANGE(Status, VendEmpOD.Status::"Recommended To Committee");
        //     VendEmpOD.SETRANGE("Recommended To Committee", TRUE);
        //     VendEmpOD.CalcFields("Selected In Meeting");
        //     VendEmpOD.SetRange("Selected In Meeting", false);
        //     IF VendEmpOD.FINDSET THEN BEGIN
        //         REPEAT

        //             LastLineNo := GetLastLineNo();
        //             MeetingLine.INIT;
        //             MeetingLine."Committee Code" := Rec."Committee Code";
        //             MeetingLine."Meeting No." := Rec."Meeting No.";
        //             MeetingLine."Document No." := Rec."Document No.";
        //             MeetingLine."Line No." := LastLineNo + 10000;
        //             MeetingLine."Newspaper Code" := VendEmpOD."OD Media ID";
        //             MeetingLine."Newspaper Name" := VendEmpOD."PM Agency Name";
        //             MeetingLine."Bank Account No." := VendEmpOD."Account No.";
        //             MeetingLine."Bank Name" := VendEmpOD."Bank Name";
        //             //MeetingLine."Account Holder Name":=;
        //             //MeetingLine."Account Address":=;
        //             MeetingLine."IFSC Code" := VendEmpOD."IFSC Code";
        //             MeetingLine.Branch := VendEmpOD."Bank Branch";
        //             // MeetingLine."RNI Registration No.":=;
        //             MeetingLine."Global Dimension 1 Code" := VendEmpOD."Global Dimension 1 Code";
        //             MeetingLine."Meeting Type" := MeetingLine."Meeting Type"::"Fresh Empanelment";
        //             MeetingLine."Application Date" := VendEmpOD."Document Date";
        //             MeetingLine.INSERT();
        //         UNTIL VendEmpOD.NEXT = 0;
        //     END
        // end;
        // IF rec."Meeting Type" = Rec."Meeting Type"::Renewal then BEGIN              //Renewal Application
        //     ODVendorRenewal.RESET;
        //     ODVendorRenewal.SETCURRENTKEY("OD Category", "OD Media ID");
        //     ODVendorRenewal.SETRANGE(Status, ODVendorRenewal.Status::"Pending For Approval");
        //     ODVendorRenewal.SETRANGE("Recommended To Committee", TRUE);
        //     //ODVendorRenewal.CalcFields("Selected In Meeting");
        //     //ODVendorRenewal.SetRange("Selected In Meeting", false);
        //     IF ODVendorRenewal.FINDSET THEN BEGIN
        //         REPEAT
        //             LastLineNo := GetLastLineNo();
        //             MeetingLine.INIT;
        //             MeetingLine."Committee Code" := Rec."Committee Code";
        //             MeetingLine."Meeting No." := Rec."Meeting No.";
        //             MeetingLine."Document No." := Rec."Document No.";
        //             MeetingLine."Line No." := LastLineNo + 10000;
        //             MeetingLine."Newspaper Code" := ODVendorRenewal."OD Media ID";
        //             MeetingLine."Newspaper Name" := ODVendorRenewal."PM Agency Name";
        //             MeetingLine."Bank Account No." := ODVendorRenewal."Account No.";
        //             MeetingLine."Bank Name" := ODVendorRenewal."Bank Name";
        //             //MeetingLine."Account Holder Name":=;
        //             //MeetingLine."Account Address":=;
        //             MeetingLine."IFSC Code" := ODVendorRenewal."IFSC Code";
        //             MeetingLine.Branch := ODVendorRenewal."Bank Branch";
        //             // MeetingLine."RNI Registration No.":=;
        //             MeetingLine."Global Dimension 1 Code" := ODVendorRenewal."Global Dimension 1 Code";
        //             MeetingLine."Meeting Type" := MeetingLine."Meeting Type"::Renewal;
        //             MeetingLine.INSERT();
        //         UNTIL ODVendorRenewal.NEXT = 0;
        //     END;

        // end;
        */
    end;

    // procedure GetLandingUID(): Code[50] 
    // var
    //     PMSetup: Record "Media Plan Setup";
    //     AppUserMember: record "Approval User Group Member";
    // begin
    //     PMSetup.Get();
    //     if PMSetup."OP Committee WorkFlow" <> '' then begin
    //         AppUserMember.Reset();
    //         AppUserMember.SetCurrentKey("Approval User Group Code", "Sequence No.");
    //         AppUserMember.SetRange("Approval User Group Code", PMSetup."OP Committee WorkFlow");
    //         AppUserMember.SetRange("Sequence No.", 1);
    //         if AppUserMember.FindFirst() then
    //             exit(AppUserMember."User ID")
    //     end
    //     else
    //         Error('Approval hierarchy not setup');
    // end;

    local procedure CheckStatus()
    var
        MeetingHdr: Record "AV Meeting Header"; // rohit  6/11
    begin
        MeetingHdr.RESET;
        MeetingHdr.SETCURRENTKEY("Committee Code", "Meeting No.");
        MeetingHdr.SETRANGE("Committee Code", "Committee Code");
        MeetingHdr.SETRANGE("Meeting No.", "Meeting No.");
        IF MeetingHdr.FINDFIRST THEN
            IF MeetingHdr.Status <> MeetingHdr.Status::Open THEN
                ERROR('Meeting status should be open.');
    end;

    procedure GetLastLineNo(): Integer
    var
        MeetingLine1: Record "AV Meeting Line";
    begin
        MeetingLine1.Reset();
        MeetingLine1.SetCurrentKey("Committee Code", "Meeting No.", "Meeting Type", "Line No.");
        MeetingLine1.SetRange("Committee Code", Rec."Committee Code");
        MeetingLine1.SetRange("Meeting No.", Rec."Meeting No.");
        if MeetingLine1.FindLast() then
            exit(MeetingLine1."Line No.");
    end;

    // procedure UploadMOM(var MeetingMasterRec: Record 50267; MOMAttacment: Text) modificaton: Boolean
    // var
    //     OldFileName: Text;
    //     FilName: Text;
    //     ServerFileName1: Text;
    //     ClientFileName: Text;
    //     FilePath: Text;
    //     FileMan: Codeunit "File Management";
    //     DialogTitle: Text;
    //     Glsetup: Record "General Ledger Setup";
    //     FileDirectory: Record "File Directory Detail";
    // begin
    //     //Rec.GET(MeetingMasterRec."Committee Code",MeetingMasterRec."Meeting Type",MeetingMasterRec."Committee Code");
    //     FileDirectory.Get();
    //     IF STRLEN("File Name") > 1 THEN
    //         IF NOT CONFIRM('MOM is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN
    //             EXIT;
    //     IF Glsetup.GET THEN;
    //     ServerFileName1 := '';
    //     ClientFileName := '';
    //     FilePath := FileDirectory."Committee Attachments Write";
    //     OldFileName := FilePath + "File Name";
    //     ServerFileName1 := FileMan.UploadFile(DialogTitle, '');

    //     ClientFileName := FileMan.GetFileName(ServerFileName1);
    //     IF ClientFileName <> '' THEN
    //         "File Name" := DELCHR(FORMAT(Rec."Committee Code"), '=', '/') + FORMAT(Rec."Meeting No.") + ClientFileName;
    //     modificaton := MODIFY;
    //     ClientFileName := FilePath + "File Name";
    //     FileMan.CopyServerFile(ServerFileName1, ClientFileName, TRUE);
    //     IF OldFileName <> '' THEN
    //         FileMan.DeleteServerFile(OldFileName);
    //     IF modificaton THEN
    //         IF "File Name" <> '' THEN
    //             MESSAGE('Document Uploaded');
    // end;

    // procedure InsertApprovalEntry(SelctedUser: Text)
    // var
    //     ApproverId: Code[20];
    //     ApprovalEntryRec: Record 454;
    //     EntryNo: Integer;
    // begin
    //     ApprovalEntryRec.RESET;
    //     IF ApprovalEntryRec.FINDLAST THEN
    //         EntryNo := ApprovalEntryRec."Entry No.";
    //     ApprovalEntryRec.RESET;
    //     ApprovalEntryRec."Table ID" := Database::"Meeting Header";
    //     ApprovalEntryRec."Document No." := rec."Committee Code" + '-' + FORMAT(Rec."Meeting No.");
    //     ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Empanelment;
    //     ApprovalEntryRec."Entry No." := EntryNo + 1;
    //     ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
    //     ApprovalEntryRec."Sender ID" := USERID;
    //     ApprovalEntryRec."Approver ID" := SelctedUser;
    //     ApprovalEntryRec."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
    //     ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
    //     ApprovalEntryRec."Last Modified By User ID" := USERID;
    //     ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
    //     ApprovalEntryRec."Record ID to Approve" := Rec.RECORDID;
    //     ApprovalEntryRec.INSERT;
    // end;

    //     procedure ModifyApprovalEntry(EntryStatus: Enum "Approval Status")
    //     var
    //         AppEntInit: Record "Approval Entry";
    //     begin
    //         AppEntInit.RESET;
    //         AppEntInit.SETRANGE("Document No.", rec."Committee Code" + '-' + FORMAT(Rec."Meeting No."));
    //         AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Empanelment);
    //         AppEntInit.SetRange("Approver ID", UserId);
    //         AppEntInit.SetRange(Status, AppEntInit.Status::Open);
    //         IF AppEntInit.FindFirst() THEN BEGIN
    //             AppEntInit.Status := EntryStatus;
    //             AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
    //             AppEntInit."Last Modified By User ID" := USERID;
    //             AppEntInit.MODIFY;
    //         END;
    //     end; 
    procedure AssistEdit(): Boolean
    begin
        WITH MeetingH DO BEGIN
            MeetingH := Rec;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Meeting No.");
            IF NoSeriesMgt.SelectSeries(InvSetup."Meeting No.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Committee Code");
                Rec := MeetingH;
                EXIT(TRUE);
            END;
        END;
    end;
}

