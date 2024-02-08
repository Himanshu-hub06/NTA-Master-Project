table 50203 "Writ/Case Header"
{
    LookupPageID = 50305;

    fields
    {
        field(1; "File No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "File No." <> xRec."File No." THEN BEGIN
                    NoSeriesMgt.TestManual('NFLA');
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Case Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Writ/Case Type".Code WHERE(Type=field()),
            // Court = FIELD(Court));
            TableRelation = "Writ/Case Type".Code;

        }
        field(3; "Case No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Name Of Petitioner"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Case Filing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "BSEB Receiving Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE("Date Of Writ", "BSEB Receiving Date");
            end;
        }
        field(7; "Date Of Writ"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Medium,High';
            OptionMembers = Normal,Medium,High;
        }
        field(10; "First Hearing Date"; Date)
        {
            CalcFormula = Min("Case Hearing Entry"."Next Hearing Date" WHERE("Document No." = FIELD("File No.")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CaseHearingEntry.RESET;
                CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                CaseHearingEntry.SETRANGE("Document No.", "File No.");
                IF CaseHearingEntry.FIND('-') THEN
                    ERROR('Next hearing detail exist, you cannot change first hearing date');
            end;
        }
        field(11; Description1; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Synopsis';
        }
        field(12; Description2; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'compliance remark';
        }
        field(13; Description3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Description4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Ongoing,Disposed';
            OptionMembers = New,Ongoing,Disposed;
        }
        field(16; Summary; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Districts."District Name";

            trigger OnValidate()
            begin
                Dist.RESET;
                Dist.SETRANGE("District Name", District);
                IF Dist.FIND('-') THEN
                    "District Name" := Dist."District Name"
                ELSE
                    "District Name" := '';
            end;
        }
        field(19; "SOF Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Under Preparation,Created,Under Review,Reviewed,Pending for Approval,Approved,Sent,Rejected';
            OptionMembers = " ","Under Preparation",Created,"Under Review",Reviewed,"Pending for Approval",Approved,Sent,Rejected;
        }
        field(20; "Advocate For SOF Preparartion"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Advocate;
        }
        field(21; "Advocate For SOF Review"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Advocate;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('exam'));

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'EXAM');
                //DimValue.SETRANGE(DimValue."Dimension Code", 'EXAM');
                DimValue.SETRANGE(DimValue.Code, "Global Dimension 1 Code");

                if DimValue.FindFirst() then
                    Message('%1', DimValue.Name);
                "Examination Name" := DimValue.Name;
                "Examination Name" := DimValue.Name;

                // IF DimValue.Get(rec."Global Dimension 1 Code") then
                //     "Examination Name" := DimValue.Name;
                // Message('%1', "Examination Name");

            end;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            //DecimalPlaces =
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimValue.RESET;
                DimValue.SETRANGE(DimValue."Dimension Code", 'SECTION');
                DimValue.SETRANGE(DimValue.Code, "Global Dimension 2 Code");
                IF DimValue.FINDFIRST THEN
                    "Section Name" := DimValue.Name
                ELSE
                    "Section Name" := '';
            end;


        }
        field(25; "Next Hearing Date"; Date)
        {
            CalcFormula = Max("Case Hearing Entry"."Next Hearing Date" WHERE("Document No." = FIELD("File No.")));
            FieldClass = FlowField;
        }
        field(26; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Created on"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "File Extension"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Examination Name"; Text[50])
        {
            FieldClass = Normal;
        }
        field(33; "Section Name"; Text[80])
        {
            FieldClass = Normal;
        }
        field(34; "Disposed Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Disposed Date" <> 0D THEN BEGIN
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", "File No.");
                    IF CaseHearingEntry.FIND('+') THEN
                        MaxHearingDate := CaseHearingEntry."Next Hearing Date"
                    ELSE
                        MaxHearingDate := "First Hearing Date";

                    IF "Disposed Date" < MaxHearingDate THEN
                        ERROR('Disposed date should be greater than Next hearing date');
                END;
            end;
        }
        field(35; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Verdict Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD("Disposed Date");
                IF "Verdict Date" <> 0D THEN
                    IF "Verdict Date" < "Disposed Date" THEN
                        ERROR('Verdict Date should be greater than or equals to Disposed date');
            end;
        }
        field(37; "Verdict File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "In Favour"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Disposed Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "District Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Civil,Criminal,Other';
            OptionMembers = Civil,Criminal,Other;
        }
        field(42; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                // DimValue.RESET;
                // DimValue.SETRANGE(DimValue."Dimension Code", 'BRANCH');
                // DimValue.SETRANGE(DimValue.Code, "Location Code");
                // IF DimValue.FINDFIRST THEN
                //     "Location Name" := DimValue.Name
                // ELSE
                //     "Location Name" := '';

                //recLocation

                IF recLocation.Get("Location Code") THEN
                    "Location Name" := recLocation.Name
                else
                    "Location Name" := '';



            end;
        }
        field(43; "Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "User Exam Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(45; "User Section Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(46; "SOF Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Action Followed"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Action Followed" THEN BEGIN
                    VALIDATE("Not Satisfactory", FALSE);
                    VALIDATE("Compliance Status", "Compliance Status"::"Action Followed");
                END ELSE
                    VALIDATE("Compliance Status", "Compliance Status"::" ");
            end;
        }
        field(49; "Not Satisfactory"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Not Satisfactory" THEN BEGIN
                    VALIDATE("Action Followed", FALSE);
                    VALIDATE("Compliance Status", "Compliance Status"::"Not Satisfactory");
                END ELSE
                    VALIDATE("Compliance Status", "Compliance Status"::" ");
            end;
        }
        field(50; "Compliance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Action Followed,Not Satisfactory';
            OptionMembers = " ","Action Followed","Not Satisfactory";
        }
        field(51; "Arising Out"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Court Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; Court; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Supreme Court of India,High Court of Patna,High Court of Jharkhand,Bihar Anudanit Shikshan Sansthan Pradhikar,Civil/Lower Court,Other High Court,State Appellate Authority';
            OptionMembers = " ","Supreme Court of India","High Court of Patna","High Court of Jharkhand","Bihar Anudanit Shikshan Sansthan Pradhikar","Civil/Lower Court","Other High Court","State Appellate Authority";
        }
        field(54; "Other Case Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Arising Out Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Previous User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "User Assigned"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Physical File Received"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(59; Unread; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Read Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "SOF Sent Date"; Date)
        {
            FieldClass = Normal;
        }
        field(62; "Origin Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "e-office File No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Assigned User Name"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User Assigned")));
            FieldClass = FlowField;
        }
        field(65; "At Concern Section"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Sent By At Concern Section"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Sent User Name"; Text[150])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Sent By At Concern Section")));
            FieldClass = FlowField;
        }
        field(68; "Sent Date To Concern Sec"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Deletion Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Re-open Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Re-open UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Previous Disposed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Previous Disposed User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Previous Disposed Remarks"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Assign Advocate Name"; Text[120])
        {
            CalcFormula = Lookup("Advocate Assigning Entry"."Advocate Name" WHERE("File No." = FIELD("File No."), "Internal Adv. Type" = CONST(Creator), "Advocate Type" = CONST(Internal)));



            FieldClass = FlowField;
        }
        field(76; "Reviewer Advocate Name"; Text[120])
        {
            CalcFormula = Lookup("Advocate Assigning Entry"."Advocate Name" WHERE("File No." = FIELD("File No."),
                                                                                   "Internal Adv. Type" = CONST(Reviewer),
                                                                                   "Advocate Type" = CONST(Internal)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "External Advocate Name"; Text[120])
        {
            CalcFormula = Lookup("Advocate Assigning Entry"."Advocate Name" WHERE("File No." = FIELD("File No."),
                                                                                   "Internal Adv. Type" = CONST(" "),
                                                                                   "Advocate Type" = CONST(External)));
            Editable = false;
            FieldClass = FlowField;
        }


    }

    keys
    {
        key(Key1; "File No.")
        {
        }
        key(Key2; "Case No.")
        {
        }
        key(Key3; "Case Type")
        {
        }
        // key(Key4; Status, "User Assigned", "User Exam Code", Unread)
        // {
        // }
        key(Key5; "Origin Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "File No.", "Case Type", "Case No.")
        {
        }
    }

    trigger OnDelete()
    begin
        IF NOT CONFIRM('Do you want to delete?') THEN
            EXIT;
        IF "Deletion Remarks" = '' THEN
            ERROR('Please enter deletion remarks first');
    end;

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created on" := TODAY;
        UserSetup.GET(USERID);

        "User Section Code" := UserSetup.Section;

        "Origin Date" := CURRENTDATETIME + ((1000 * 60) * 330);   //plus 5.30hrs
    end;

    trigger OnModify()
    begin
        "Last Modified By" := USERID;
        "Last Modified on" := CURRENTDATETIME;
    end;

    var

        WritTab: Record "Writ/Case Header";
        CaseHearingEntry: Record "Case Hearing Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;

        recLocation: Record Location;


        FileName: Text[250];
        Size: Integer;
        ModifyDate: Date;
        ModifyTime: Time;
        ImportTxt: Label 'Insert File';
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        UserSetup: Record "User Setup";


        UserSec: Code[10];
        //SendToUserReport: Report "50124";
        FileMovementEntry: Record 50215;
        DimValue: Record "Dimension Value";
        NextLineNo: Integer;
        UserSTab: Record "User Setup";
        ReceiverID: Code[50];
        //LineNo: Integer;
        Text002: Label 'Do you want to send back.?';
        Text003: Label 'Document already send to %1.';
        Text004: Label 'You cannot send to other user. ';
        Text005: Label 'Do you want to send ?';
        Text006: Label 'Send To User cannot be blank.';
        Text007: Label 'Sent successfully.';
        Text008: Label 'File process not completed in your section.';
        Text009: Label 'File process not completed.';
        Dist: Record Districts;
        MaxHearingDate: Date;
        LegalCommentLine: Record "Legal Comment Line";
        FileMovTab: Record "File Movement Entry";
        SupportDoc: Record 50076;


    //procedure AssistEdit(OldWrit: Record 50203): Boolean
    //var
    //     SupportDoc: Record "Supporting Document";
    // begin
    //     WITH WritTab DO BEGIN
    //         COPY(Rec);
    //         UserSetup.GET(USERID);
    //         IF UserSetup."Examination Code" = 'EXESEC' THEN BEGIN
    //             IF NoSeriesMgt.SelectSeries('WRIT-S', OldWrit."No. Series", "No. Series") THEN BEGIN
    //                 NoSeriesMgt.SetSeries("File No.");
    //                 Rec := WritTab;
    //                 EXIT(TRUE);
    //             END;
    //         END;
    //         IF UserSetup."Examination Code" = 'EXESSEC' THEN BEGIN
    //             IF NoSeriesMgt.SelectSeries('WRIT-SS', OldWrit."No. Series", "No. Series") THEN BEGIN
    //                 NoSeriesMgt.SetSeries("File No.");
    //                 Rec := WritTab;
    //                 EXIT(TRUE);
    //             END;
    //         END;
    //     END;
    // end;

    // var
    //     AdvTab: Record "Writ/Case Header";
    // begin
    //     WITH AdvTab DO BEGIN
    //         AdvTab := Rec ;
    //         IF NoSeriesMgt.SelectSeries('ADVOCATE', OldWrit."No. series", "No. series") THEN BEGIN
    //             NoSeriesMgt.SetSeries("");
    //             Rec := AdvTab;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;


    // procedure UploadFile()
    // var
    //     TempBlob: Record "99008535";
    //     FileManagement: Codeunit "419"
    //     SupportDoc: Record "50076";
    //     SupportDoc1: Record "50076";
    //     MaxLineNo: Integer;
    //     LineNo: Integer;
    // begin
    //     Size:=0;
    //     SupportDoc1.RESET;
    //     SupportDoc1.SETRANGE(SupportDoc1."Document No.","File No.");
    //     IF SupportDoc1.FIND('-') THEN BEGIN
    //       REPEAT
    //         IF MaxLineNo < SupportDoc1."Line No." THEN
    //           MaxLineNo:=SupportDoc1."Line No.";
    //       UNTIL SupportDoc1.NEXT=0;
    //     END;
    //       FileName := FileManagement.BLOBImportWithFilter(TempBlob,ImportTxt,FileName,STRSUBSTNO(FileDialogTxt,FilterTxt),FilterTxt);

    //      IF  FileName <> '' THEN BEGIN
    //       SupportDoc.INIT;
    //       SupportDoc."Document No.":="File No.";
    //       SupportDoc."Document Type":=SupportDoc."Document Type"::Legal;
    //       SupportDoc."Record ID":=Rec.RECORDID;
    //       SupportDoc."Line No.":= MaxLineNo + 1000;
    //       SupportDoc.Content :=  TempBlob.Blob;
    //       SupportDoc."File Extension":=LOWERCASE(COPYSTR(FileManagement.GetExtension(FileName),1,MAXSTRLEN(SupportDoc."File Extension")));
    //       SupportDoc.VALIDATE("File Extension");
    //       SupportDoc."File Name" := COPYSTR(FileManagement.GetFileNameWithoutExtension(FileName),1,MAXSTRLEN(SupportDoc."File Name"));
    //       SupportDoc."File Path":=FileName;
    //       SupportDoc.INSERT(TRUE);
    //       END;
    // end;

    procedure SendToBack()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Section Approver" THEN BEGIN
            FileMovementEntry.RESET;
            FileMovementEntry.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
            FileMovementEntry.SETRANGE("Document No.", "File No.");
            FileMovementEntry.SETRANGE("Receiver Section", UserSetup.Section);
            FileMovementEntry.SETRANGE(FileMovementEntry.Status, FileMovementEntry.Status::"In Process At Section");
            FileMovementEntry.SETRANGE("Sender ID", USERID);
            IF FileMovementEntry.FIND('-') THEN
                ERROR(Text008)
            ELSE BEGIN
                FileMovementEntry.RESET;
                FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                FileMovementEntry.SETRANGE("Document No.", "File No.");
                FileMovementEntry.SETRANGE("Receiver ID", USERID);
                FileMovementEntry.SETRANGE(FileMovementEntry.Status, FileMovementEntry.Status::"Assigned To Section");
                IF FileMovementEntry.FIND('-') THEN BEGIN
                    ReceiverID := FileMovementEntry."Sender ID";
                    FileMovementEntry.Status := FileMovementEntry.Status::"Return To Legal";
                    FileMovementEntry."Sent Back" := TRUE;
                    FileMovementEntry.MODIFY(TRUE);

                    WritTab.RESET;
                    WritTab.SETRANGE("File No.", "File No.");
                    IF WritTab.FIND('-') THEN BEGIN
                        WritTab."Previous User" := USERID;
                        WritTab.Unread := TRUE;
                        WritTab."User Assigned" := FileMovementEntry."Sender ID";
                        WritTab.MODIFY;
                    END;

                    FileMovTab.RESET;
                    FileMovTab.SETRANGE("Document Type", FileMovTab."Document Type"::Legal);
                    FileMovTab.SETRANGE("Document No.", "File No.");
                    IF FileMovTab.FIND('-') THEN BEGIN
                        REPEAT
                            FileMovTab."Current User" := FileMovementEntry."Sender ID";
                            FileMovTab.MODIFY;
                        UNTIL FileMovTab.NEXT = 0;
                    END;
                END ELSE
                    MESSAGE('Already sent');
            END;
        END ELSE BEGIN          //other than section officer
            FileMovementEntry.RESET;
            FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
            FileMovementEntry.SETRANGE("Document No.", "File No.");
            FileMovementEntry.SETRANGE("Receiver ID", USERID);
            FileMovementEntry.SETRANGE(FileMovementEntry.Status, FileMovementEntry.Status::"In Process At Section");
            IF FileMovementEntry.FIND('-') THEN BEGIN
                ReceiverID := FileMovementEntry."Sender ID";
                FileMovementEntry.Status := FileMovementEntry.Status::"Sent Back";
                FileMovementEntry."Sent Back" := TRUE;
                FileMovementEntry.MODIFY(TRUE);

                WritTab.RESET;
                WritTab.SETRANGE("File No.", "File No.");
                IF WritTab.FIND('-') THEN BEGIN
                    WritTab."Previous User" := USERID;
                    WritTab.Unread := TRUE;
                    WritTab."User Assigned" := FileMovementEntry."Sender ID";
                    WritTab.MODIFY;
                END;

                FileMovTab.RESET;
                FileMovTab.SETRANGE("Document Type", FileMovTab."Document Type"::Legal);
                FileMovTab.SETRANGE("Document No.", "File No.");
                IF FileMovTab.FIND('-') THEN BEGIN
                    REPEAT
                        FileMovTab."Current User" := FileMovementEntry."Sender ID";
                        FileMovTab.MODIFY;
                    UNTIL FileMovTab.NEXT = 0;
                END;
            END ELSE
                MESSAGE('Already sent');
        END;

        LegalCommentLine.RESET;
        LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
        LegalCommentLine.SETRANGE("Document No.", "File No.");
        LegalCommentLine.SETRANGE(Active, FALSE);
        IF LegalCommentLine.FIND('-') THEN BEGIN
            REPEAT
                LegalCommentLine.Active := TRUE;
                LegalCommentLine.MODIFY;
            UNTIL LegalCommentLine.NEXT = 0;
        END;

        SupportDoc.RESET;
        SupportDoc.SETRANGE("Document Type", SupportDoc."Document Type"::Legal);
        SupportDoc.SETRANGE("Document No.", "File No.");
        SupportDoc.SETRANGE(Active, FALSE);
        IF SupportDoc.FIND('-') THEN BEGIN
            REPEAT
                SupportDoc.Active := TRUE;
                SupportDoc.MODIFY;
            UNTIL SupportDoc.NEXT = 0;
        END;
        MESSAGE('Sent Seccessfully');
    end;


    procedure AssistEdit(OldAdv: Record "Writ/Case Header"): Boolean
    var
        AdvTab: Record "Writ/Case Header";
    begin
        WITH AdvTab DO BEGIN
            AdvTab := Rec;
            IF NoSeriesMgt.SelectSeries('NFLA', OldAdv."No. series", "No. series") THEN BEGIN
                NoSeriesMgt.SetSeries("File No.");
                Rec := AdvTab;
                EXIT(TRUE);
            END;
        END;
    end;




    procedure FileInProcess(): Boolean
    var
        Flag: Boolean;
    begin
        Flag := FALSE;
        FileMovementEntry.RESET;
        FileMovementEntry.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
        FileMovementEntry.SETRANGE("Document No.", "File No.");
        IF FileMovementEntry.FINDSET THEN BEGIN
            REPEAT
                IF FileMovementEntry.Status IN [FileMovementEntry.Status::"Assigned To Section", FileMovementEntry.Status::"In Process At Section"] THEN
                    Flag := TRUE;
            UNTIL FileMovementEntry.NEXT = 0;
        END;
        EXIT(Flag);
    end;
}

