table 50076 "Supporting Document"
{

    fields
    {
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "File Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "File Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Image,PDF,Word,Excel,PowerPoint,Email,XML,Other';
            OptionMembers = " ",Image,PDF,Word,Excel,PowerPoint,Email,XML,Other;
        }
        field(6; "File Extension"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CASE LOWERCASE("File Extension") OF
                    'jpg', 'jpeg', 'bmp', 'png', 'tiff', 'tif', 'gif':
                        "File Type" := "File Type"::Image;
                    'pdf':
                        "File Type" := "File Type"::PDF;
                    'docx', 'doc':
                        "File Type" := "File Type"::Word;
                    'xlsx', 'xls':
                        "File Type" := "File Type"::Excel;
                    'pptx', 'ppt':
                        "File Type" := "File Type"::PowerPoint;
                    'msg':
                        "File Type" := "File Type"::Email;
                    'xml':
                        "File Type" := "File Type"::XML;
                    ELSE
                        "File Type" := "File Type"::Other;
                END;
            end;
        }
        field(7; Content; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "File Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Document Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Created Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created By User ID"; Code[50])
        {
            Caption = 'Created By User ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User;
        }
        field(13; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Legal';
            OptionMembers = " ",Legal;
        }
        field(14; "Record ID"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Legal File Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Note Sheet,Annexure,Other,Supplementary Writ,I.A.,Rejoinder,Fact Sheet';
            OptionMembers = "Note Sheet",Annexure,Other,"Supplementary Writ","I.A.",Rejoinder,"Fact Sheet";
        }
        field(17; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Created User Name"; Text[150])
        {
            // CalcFormula = Lookup(User."Full Name" WHERE(User Name=FIELD(Created By User ID)));
            //     FieldClass = FlowField;

            CalcFormula = Lookup("User BOC"."Full Name" WHERE("User Name" = FIELD("Created By User ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        IF "Created By User ID" <> USERID THEN
            ERROR(DeleteErr);
        IF Active THEN
            ERROR('You cannot delete previous document');



        InvSetup.GET;
        OldFileName := InvSetup."Writ Case Write Path" + "File Name";
        IF EXISTS(OldFileName) THEN
            FileManagement.DeleteServerFile(OldFileName);

    end;

    trigger OnInsert()
    begin
        "Created Date-Time" := CURRENTDATETIME();
        "Created By User ID" := USERID;
    end;

    var
        FileName: Text[250];
        ReplaceContentQst: Label 'Do you want to replace the file content?';
        ImportTxt: Label 'Insert File';
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        NotSupportedDocTableErr: Label 'Table no. %1 is not supported.', Comment = '%1 is a number (integer).';
        FileMovEntry: Record "File Movement Entry";
        WritHdr: Record "Writ/Case Header";
        Size: Integer;
        ModifyDate: Date;
        ModifyTime: Time;
        DeleteErr: Label 'You are not allowed to delete other user''s uploaded documents.';
        DocDeleteErr: Label 'Document %1 has been sent back, you are not allowed to delete supporting documents.';
        InvSetup: Record "Inventory Setup";
        ServerFileName: Text;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        DialogTitle: Text;
        //ServerFileHelper: DotNet File;
        OldFileName: Text;

        filedire: Record "File Directory Detail";

    procedure AttachNoteSheet(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        filedire.GET;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::"Note Sheet";
            INSERT(TRUE);
        END;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);

        Message('Document has been Attached Sucessfully');
    end;

    procedure AttachAnnexure(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::Annexure;
            INSERT(TRUE);
        END;
        ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        Message('Document has been Attached Sucessfully');
    end;

    procedure AttachOther(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;

        filedire.GET;

        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::Other;

            "Created By User ID" := UserId;  //cs-ds



            INSERT(TRUE);
        END;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;

        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        Message('Document has been Attached Sucessfully');
    end;
    // need to re-open   //DSC
    // procedure Import(var RecordRef: RecordRef; DocumentNo: Code[20]): Boolean
    // var
    //     TempBlob: Record TempBlob ; //dsc

    //     FileManagement: Codeunit "File Management";
    //     SupportDoc: Record "Supporting Document";
    //     SupportDoc1: Record "Supporting Document";
    //     MaxLineNo: Integer;
    //     LineNo: Integer;
    // // [RunOnClient]  //DSC 
    // // FileInfo: DotNet FileInfo;//DSC
    // begin
    //     Size := 0;
    //     CASE RecordRef.NUMBER OF
    //         DATABASE::"Writ/Case Header":
    //             BEGIN
    //                 RecordRef.SETTABLE(WritHdr);
    //                 SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocumentNo);
    //                 IF SupportDoc1.FIND('-') THEN BEGIN
    //                     REPEAT
    //                         IF MaxLineNo < SupportDoc1."Line No." THEN
    //                             MaxLineNo := SupportDoc1."Line No.";
    //                     UNTIL SupportDoc1.NEXT = 0;
    //                 END;
    //                 FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);

    //                 IF FileName <> '' THEN BEGIN
    //                     SupportDoc.INIT;
    //                     SupportDoc."Document No." := DocumentNo;
    //                     SupportDoc."Document Type" := SupportDoc."Document Type"::Legal;
    //                     SupportDoc."Line No." := MaxLineNo + 1000;
    //                     SupportDoc.Content := TempBlob.Blob;
    //                     SupportDoc."File Extension" := LOWERCASE(COPYSTR(FileManagement.GetExtension(FileName), 1, MAXSTRLEN(SupportDoc."File Extension")));
    //                     SupportDoc.VALIDATE("File Extension");
    //                     SupportDoc."File Name" := COPYSTR(FileManagement.GetFileNameWithoutExtension(FileName), 1, MAXSTRLEN(SupportDoc."File Name"));
    //                     SupportDoc."File Path" := FileName;
    //                     SupportDoc.INSERT(TRUE);
    //                 END;
    //             END;
    //     END;
    // end;

    // procedure Export(DefaultFileName: Text; ShowFileDialog: Boolean): Text
    // var
    //     TempBlob: Record "99008535";
    //     FileMgt: Codeunit "419";
    // begin
    //     //IF "Incoming Document Entry No." = 0 THEN
    //     //  EXIT;
    //     CALCFIELDS(Content);
    //     IF NOT Content.HASVALUE THEN
    //         EXIT;

    //     IF DefaultFileName = '' THEN
    //         DefaultFileName := "File Name" + '.' + "File Extension";

    //     TempBlob.Blob := Content;
    //     EXIT(FileMgt.BLOBExport(TempBlob, DefaultFileName, ShowFileDialog));
    // end;

    // procedure NameDrillDown(SupportDoc: Record "Supporting Document")
    // var
    //     IncomingDocument: Record 130;
    //     IncomingDocumentAttachment: Record 133;
    // begin

    //     SupportDoc.Export('', TRUE);

    // end;

    // procedure UploadFile(var SupportDoc: Record "50076")
    // var
    //     TempBlob: Record TempBlob  //DSC
    //     FileManagement: Codeunit "419";
    // begin
    //     SupportDoc.CALCFIELDS(Content);

    //     FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);
    //     SupportDoc.Content := TempBlob.Blob;
    // end;

    // procedure ImportAttachment(var SupportDoc: Record "50076"): Boolean
    // var
    //     IncomingDocument: Record 130;
    //     TempBlob: Record 99008535;
    //     FileManagement: Codeunit 419;
    // begin
    //     IF FileName = '' THEN
    //         ERROR('');

    //     WITH SupportDoc DO BEGIN


    //         IF NOT Content.HASVALUE THEN BEGIN
    //             IF FileManagement.ServerFileExists(FileName) THEN
    //                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName)
    //             ELSE
    //                 FileManagement.BLOBImportFromServerFile(TempBlob, FileManagement.UploadFileSilent(FileName));
    //             Content := TempBlob.Blob;
    //         END;

    //         VALIDATE("File Extension", LOWERCASE(COPYSTR(FileManagement.GetExtension(FileName), 1, MAXSTRLEN("File Extension"))));

    //         "File Name" := COPYSTR(FileManagement.GetFileNameWithoutExtension(FileName), 1, MAXSTRLEN("File Name"));


    //         "File Path" := FileName;
    //         MODIFY;
    //         // IF Type IN [Type::Image,Type::PDF] THEN
    //         //    OnAttachBinaryFile;
    //     END;
    //     EXIT(TRUE);
    // end;

    procedure AttachSupplementary(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        filedire.GET;

        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::"Supplementary Writ";
            INSERT(TRUE);
        END;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        Message('Document has been Attached Sucessfully');

    end;

    procedure AttachIA(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        filedire.GET;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::"I.A.";
            INSERT(TRUE);
        END;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;

        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);

        Message('Document has been Attached Sucessfully');
    end;

    procedure AttachRejoinder(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        filedire.GET;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::Rejoinder;
            INSERT(TRUE);
        END;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;

        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);

        Message('Document has been Attached Sucessfully');
    end;

    procedure AttachFact(DocNo: Code[20])
    var
        MaxLineNo: Integer;
        SupportDoc1: Record "Supporting Document";
    begin
        InvSetup.GET;
        filedire.Get;
        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
        ClientFileName := FileManagement.GetFileName(ServerFileName);
        FileExtension := FileManagement.GetExtension(ServerFileName);
        IF ClientFileName <> '' THEN BEGIN
            SupportDoc1.SETCURRENTKEY("Document No.", "Line No.");
            SupportDoc1.SETRANGE(SupportDoc1."Document No.", DocNo);
            IF SupportDoc1.FIND('-') THEN BEGIN
                REPEAT
                    IF MaxLineNo < SupportDoc1."Line No." THEN
                        MaxLineNo := SupportDoc1."Line No.";
                UNTIL SupportDoc1.NEXT = 0;
            END;
            INIT;
            "Document No." := DocNo;
            "Document Type" := "Document Type"::Legal;
            "Line No." := MaxLineNo + 1000;
            "File Extension" := FileExtension;
            VALIDATE("File Extension");
            "File Name" := DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
            "Legal File Type" := "Legal File Type"::"Fact Sheet";
            INSERT(TRUE);
        END;
        //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        ClientFileName := filedire."Writ Case Write Path" + DELCHR("Document No.", '=', '/') + '_' + FORMAT("Line No.") + '_S_' + ClientFileName;
        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
        Message('Document has been Attached Sucessfully');
    end;
}

