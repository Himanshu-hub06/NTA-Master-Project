page 50307 "Disposed Case Card - Top level"
{
    Caption = 'Disposed Case Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,File';
    SourceTable = "Writ/Case Header";


    layout
    {
        area(content)
        {

            group(General)
            {
                field("File No."; REC."File No.")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    begin
                        IF REC."File No." = '' THEN
                            IF REC.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                    end;
                }
                field(Court; REC.Court)
                {
                    Editable = false;
                }
                field("Court Name"; REC."Court Name")
                {
                    Editable = false;
                }
                field(Category; REC.Category)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        IF xRec.Category <> REC.Category THEN
                            REC."Case Type" := '';
                    end;
                }
                field("Case Type"; REC."Case Type")
                {
                    Editable = false;
                }
                field("Other Case Type"; REC."Other Case Type")
                {
                    Editable = false;
                }
                field("Arising Out"; REC."Arising Out")
                {
                    Editable = false;
                }
                field("Arising Out Type"; REC."Arising Out Type")
                {
                    Editable = false;
                }
                field("Case No."; REC."Case No.")
                {
                    Editable = false;
                }
                field("Name Of Petitioner"; REC."Name Of Petitioner")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Case Filing Date"; REC."Case Filing Date")
                {
                    Editable = false;
                }
                field("BSEB Receiving Date"; REC."BSEB Receiving Date")
                {
                    Editable = false;
                }
                field(Priority; REC.Priority)
                {
                    Editable = false;
                }
                field("Location Code"; REC."Location Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Location Name"; REC."Location Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Examination Name"; REC."Examination Name")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Section Name"; REC."Section Name")
                {
                    Editable = false;
                }
                field(District; REC.District)
                {
                    Editable = false;
                    ShowMandatory = true;

                    // trigger OnValidate()
                    // begin
                    //     IF REC.District = 'OTHER' THEN
                    //         REC.DistNameEnable := TRUE
                    //     ELSE
                    //         DistNameEnable := FALSE;
                    // end;
                }
                field("District Name"; REC."District Name")
                {
                    Editable = false;
                }
                field("e-office File No."; REC."e-office File No.")
                {
                    Editable = false;
                }
                field("First Hearing Date"; REC."First Hearing Date")
                {
                    Editable = false;
                }
                field("Next Hearing Date"; REC."Next Hearing Date")
                {
                    Editable = false;
                }
                field("SOF Status"; REC."SOF Status")
                {
                    Editable = false;
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Writ/Case Attachment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF REC."File Name" <> '' THEN BEGIN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."File Name");

                        END;

                    end;
                }
                field(Status; REC.Status)
                {
                    Editable = false;
                }
                field(Description1; REC.Description1)
                {
                    Caption = 'Synopsis';
                    Editable = false;
                    Importance = Additional;
                    MultiLine = true;
                }
            }
            group("Dispose Details")
            {
                field("Disposed Date"; REC."Disposed Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Verdict Date"; REC."Verdict Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Verdict Attachment"; VerdictAttachment)
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF REC."Verdict File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."Verdict File Name");
                    end;
                }
                field("In Favour"; REC."In Favour")
                {
                    Editable = false;
                }
                field("Disposed Remark"; REC."Disposed Remarks")
                {
                    Caption = 'Disposed Remark';
                    Editable = false;
                    ShowMandatory = true;
                }
            }
            group("Complaince Action")
            {
                field("Action Followed"; REC."Action Followed")
                {
                    Editable = false;
                }
                field("Not Satisfactory"; REC."Not Satisfactory")
                {
                    Editable = false;
                }
                field("Compliance Status"; REC."Compliance Status")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Comments; 50310)
            {
                Caption = 'Comments';
                SubPageLink = "Document No." = FIELD("File No.");
                SubPageView = SORTING("Entry No.")
                              ORDER(Ascending);
            }
            // part(FileMovementEntry; 50355)
            // {
            //     Caption = 'File Movement Status';
            //     SubPageLink = Document No.=FIELD(File No.);
            //         SubPageView = SORTING(Document Type,Document No.,Line No.)
            //                   ORDER(Ascending);
            // }
            // part(DocFactBox; 50354)
            // {
            //     Caption = 'Supporting Documents';
            //     SubPageLink = Document No.=FIELD(File No.);
            // }
            // part("SOF Approval Status"; 50337)
            // {
            //     Caption = 'SOF Approval Status';
            //     SubPageLink = Document No.=FIELD(File No.);
            // }
        }
    }

    actions
    {
        area(processing)
        {
            // action("Attach File")
            // {
            //     Image = Attach;
            //     Promoted = true;
            //     PromotedCategory = New;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         InvSetup.GET;
            //         OldFileName := '';
            //         OldFileName := (InvSetup."Writ Case Write Path" + rec."File Name");
            //         ServerFileName := FileManagement.UploadFile(DialogTitle, '');
            //         ClientFileName := FileManagement.GetFileName(ServerFileName);
            //         FileExtension := FileManagement.GetExtension(ServerFileName);
            //         IF ClientFileName <> '' THEN BEGIN
            //             rec."File Name" := DELCHR(rec."File No.", '=', '/') + '_W_' + ClientFileName;
            //             rec."File Extension" := FileExtension;
            //             rec.MODIFY(true);
            //         END ELSE BEGIN
            //             rec."File Name" := '';
            //             rec."File Extension" := '';
            //             rec.MODIFY(TRUE);
            //         END;
            //         ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(rec."File No.", '=', '/') + '_W_' + ClientFileName;
            //         FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
            //         IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
            //             FileManagement.DeleteServerFile(OldFileName);
            //         IF rec."File Name" <> '' THEN
            //             AttachedFile := Text001;
            //     end;
            // }
            // action("Send To Section")
            // {
            //     Image = SelectEntries;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         //SendToSection: Report "50123"; //PPC
            //         Text001: Label 'Document not found.';
            //     begin
            //         rec.TESTFIELD(rec."Name Of Petitioner");
            //         rec.TESTFIELD("Location Code");
            //         rec.TESTFIELD("Global Dimension 1 Code");
            //         rec.TESTFIELD("Global Dimension 2 Code");
            //         //CLEAR("SendToSection");
            //         WritCaseHdr.RESET;
            //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.", rec."File No.");
            //         IF WritCaseHdr.FINDFIRST THEN BEGIN
            //             //SendToSection.SETTABLEVIEW(WritCaseHdr);
            //             //SendToSection.RUNMODAL;
            //         END ELSE
            //             ERROR(Text001);



            //     end;
            // }
            // action("Assign Advoate")
            // {
            //     Caption = 'Assign Advocate';
            //     Image = Allocate;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         rec.TESTFIELD("Name Of Petitioner");
            //         rec.TESTFIELD("Location Code");
            //         rec.TESTFIELD("Global Dimension 1 Code");
            //         rec.TESTFIELD("Global Dimension 2 Code");

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE("File No.", rec."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         PAGE.RUN(PAGE::"Advocate Assigning", AdvAssignEntry);


            //     end;
            // }
            // action("Send For Creation")
            // {
            //     Caption = 'Send For Creation';
            //     Image = CreditMemo;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Advocate not assigned for SOF creation.';
            //         WritCaseHdr: Record "Writ/Case Header";
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         UserTab: Record "User BOC";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;

            //         SMTPMail: Codeunit "400";
            //         SMTPMailSetup: Record "409";
            //         TempBlob: Record "99008535";//PPC
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF creation ?';
            //     begin
            //         //rec.TESTFIELD("SOF Status","SOF Status"::" ");
            //         rec.TESTFIELD("File No.");
            //         rec.TESTFIELD("Name Of Petitioner");
            //         FileMovEntry.RESET;
            //         FileMovEntry.SETRANGE("Document No.", rec."File No.");
            //         IF NOT FileMovEntry.FIND('-') THEN
            //             ERROR('SOF data not collected from any section');
            //         // IF FileInProcess THEN
            //         //     ERROR(Text003); //PPC

            //         IF NOT CONFIRM(SendConfirm) THEN BEGIN
            //             CurrPage.CLOSE;
            //             EXIT;
            //         END;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", rec."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FINDSET THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             SMTPMailSetup.GET;
            //             Subject := 'Regarding SOF preparation for case no.-' + "File No.";
            //             Body := 'Dear Sir,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents.');
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Thanks & Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board'); // PPC
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;//PPc
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF rec."File Name" <> '' THEN
            //                     SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name", "File Name");
            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN

            //                 REPEAT
            //                     IF SupportingDoc."File Name" <> '' THEN
            //                         SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;

            //             WritCaseHdr.RESET;
            //             rec."SOF Status" := rec."SOF Status"::"Under Preparation";
            //             rec.MODIFY(TRUE);
            //             REPEAT
            //                 AdvAssignEntry1.INIT;
            //                 AdvAssignEntry1."File No." := rec."File No.";
            //                 AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //                 AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                 AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                 AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //                 AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                 AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                 AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             //SMTPMail.Send();
            //             MESSAGE(SentSuccessfully);
            //         END;

            //     end;
            // }
            // action("Send For Review")
            // {
            //     Caption = 'Send For Review';
            //     Image = Email;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Advocate not assigned for SOF review.';
            //         WritCaseHdr: Record "Writ/Case Header";
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         //UserTab: Record "2000000120";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         //SMTPMail: Codeunit "400";
            //         //SMTPMailSetup: Record "409";
            //         //: Record "99008535"; //PPC
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF review ?';
            //     begin
            //         rec.TESTFIELD("SOF Status", rec."SOF Status"::Created);
            //         rec.TESTFIELD("File No.");
            //         rec.TESTFIELD("Name Of Petitioner");

            //         // IF FileInProcess THEN
            //         //     ERROR(Text003);

            //         // IF NOT CONFIRM(SendConfirm) THEN
            //         //     EXIT;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", rec."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Reviewer);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FIND('-') THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             RecepientID := '';
            //            // UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             SMTPMailSetup.GET;
            //             Subject := 'Regarding SOF review for case no.-' + "File No.";
            //             Body := 'Dear Sir,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents.');
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Thanks & Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one reviewer
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN
            //                     SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name", "File Name");

            //             AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", "File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Creator);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN
            //                         SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"), AdvAssignEntry2."SOF File Name");
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN
            //                 /*
            //                 REPEAT
            //                   SupportingDoc.CALCFIELDS(SupportingDoc.Content);
            //                    FileName:='';
            //                    CLEAR(NVInStream);
            //                    CLEAR(TempBlob);
            //                    IF NOT SupportingDoc.Content.HASVALUE THEN
            //                     EXIT;
            //                    FileName := SupportingDoc."File Name" + '.' + SupportingDoc."File Extension";
            //                    TempBlob.Blob:=SupportingDoc.Content;
            //                    TempBlob.Blob.CREATEINSTREAM(NVInStream);
            //                    SMTPMail.AddAttachmentStream(NVInStream,FileName);
            //                 UNTIL SupportingDoc.NEXT=0;
            //                 */
            //                 REPEAT
            //                     IF SupportingDoc."File Name" <> '' THEN
            //                         SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;

            //             "SOF Status" := "SOF Status"::"Under Review";
            //             MODIFY(TRUE);
            //             REPEAT
            //                 AdvAssignEntry1.INIT;
            //                 AdvAssignEntry1."File No." := "File No.";
            //                 AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //                 AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                 AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                 AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //                 AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                 AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                 AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             SMTPMail.Send();
            //             MESSAGE(SentSuccessfully);
            //         END;

            //     end;
            // }
            // action("Send To External Advocate")
            // {
            //     Image = Email;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Extrenal Advocate not assigned.';
            //         WritCaseHdr: Record "Writ/Case Header";
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         //UserTab: Record "2000000120";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         // SMTPMail: Codeunit "400";
            //         // SMTPMailSetup: Record "409";
            //         //TempBlob: Record "99008535";
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //     begin
            //         rec.TESTFIELD("SOF Status", rec."SOF Status"::Approved);
            //         IF FileInProcess THEN //PPC
            //             ERROR(Text003);

            //         IF NOT CONFIRM(Text004) THEN
            //             EXIT;
            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE("File No.", rec."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::External);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FIND('-') THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             SMTPMailSetup.GET;
            //             Subject := 'Regarding New case no.-' + "File No.";
            //             Body := 'Dear Sir,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents of new case');
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Thanks & Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE("File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN
            //                     SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name", "File Name");

            //             AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", "File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Reviewer);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN
            //                         SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"), AdvAssignEntry2."SOF File Name");
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN

            //                 REPEAT
            //                     IF SupportingDoc."File Name" <> '' THEN
            //                         SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;

            //             Status := Status::Ongoing;
            //             MODIFY(TRUE);
            //             REPEAT
            //                 AdvAssignEntry1.INIT;
            //                 AdvAssignEntry1."File No." := "File No.";
            //                 AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::"Sent To External";
            //                 AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                 AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                 AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::" ");
            //                 AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                 AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                 AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                 AdvAssignEntry1.VALIDATE("Sent To External Adv.", TRUE);
            //                 AdvAssignEntry1.VALIDATE("Sent To External Date", WORKDATE);
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             SMTPMail.Send();
            //             MESSAGE(SentSuccessfully);
            //         END;

            //     end;
            // }
            // action("Hearing Details")
            // {
            //     Image = Timesheet;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         /*AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETCURRENTKEY("File No.","Line No.");
            //         AdvAssignEntry.SETRANGE("File No.","File No.");
            //         AdvAssignEntry.SETRANGE(Active,TRUE);
            //         AdvAssignEntry.SETRANGE("Advocate Type",AdvAssignEntry."Advocate Type"::External);
            //         AdvAssignEntry.SETRANGE("Entry Type",AdvAssignEntry."Entry Type"::"Sent To External");
            //         AdvAssignEntry.SETRANGE("Sent To External Adv.",TRUE);
            //         IF NOT AdvAssignEntry.FINDFIRST THEN
            //           ERROR(Text006);
            //         */
            //         rec.TESTFIELD("First Hearing Date");
            //         CaseHearingEntry.RESET;
            //         CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
            //         CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", "File No.");
            //         PAGE.RUN(50148, CaseHearingEntry);

            //     end;
            // }
            action(Dispose)
            {
                Caption = 'Dispose';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //rec.TESTFIELD("Case Filing Date");
                    rec.TESTFIELD("BSEB Receiving Date");
                    rec.TESTFIELD("Name Of Petitioner");
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Global Dimension 1 Code");
                    rec.TESTFIELD("Global Dimension 2 Code");
                    rec.TESTFIELD("Disposed Date");
                    rec.TESTFIELD("Verdict Date");
                    rec.TESTFIELD("Disposed Remarks");

                    //DSC
                    // IF FileInProcess THEN
                    //     ERROR(Text003);
                    // IF NOT CONFIRM(Text007) THEN
                    //     EXIT;

                    REC.Status := REC.Status::Disposed;
                    REC.Disposed := TRUE;
                    REC."Disposed Date" := WORKDATE;
                    REC.MODIFY(TRUE);

                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
                    AdvAssignEntry.SETRANGE("File No.", REC."File No.");
                    IF AdvAssignEntry.FIND('-') THEN BEGIN
                        REPEAT
                            AdvAssignEntry.Disposed := TRUE;
                            AdvAssignEntry.MODIFY;
                        UNTIL AdvAssignEntry.NEXT = 0;
                    END;

                    CurrPage.CLOSE;
                end;
            }
            // action("Verdict Document")
            // {
            //     Image = Attach;
            //     Promoted = true;
            //     PromotedCategory = New;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         InvSetup.GET;
            //         OldFileName := '';
            //         OldFileName := (InvSetup."Writ Case Write Path" + "Verdict File Name");
            //         ServerFileName := FileManagement.UploadFile(DialogTitle, '');
            //         ClientFileName := FileManagement.GetFileName(ServerFileName);
            //         IF ClientFileName <> '' THEN BEGIN
            //             "Verdict File Name" := DELCHR("File No.", '=', '/') + '_V_' + ClientFileName;
            //             MODIFY(TRUE);
            //         END ELSE BEGIN
            //             "Verdict File Name" := '';
            //             MODIFY(TRUE);
            //         END;
            //         ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("File No.", '=', '/') + '_V_' + ClientFileName;
            //         FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
            //         IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
            //             FileManagement.DeleteServerFile(OldFileName);
            //         IF "Verdict File Name" <> '' THEN
            //             VerdictAttachment := 'View';
            //     end;
            // }
            // action("Send For Approval")
            // {
            //     Caption = 'Send For Approval';
            //     Image = Approval;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         FileMovementEntry: Record "50075";
            //         AdvAssigmentEntry: Record "50077";
            //         SOFApprovalEntry: Record "50080";
            //         SeqNo: Integer;
            //         RecID: RecordID;
            //         UserSetup: Record "91";
            //         AppConfirm: Label 'Do you want to send SOF for approval ?';
            //         PrevUser: Code[50];
            //         SendToSection: Report "50127";
            //     begin
            //         rec.TESTFIELD("SOF Status", "SOF Status"::Reviewed);
            //         IF NOT CONFIRM(AppConfirm) THEN
            //             EXIT;

            //         CLEAR(SendToSection);
            //         WritCaseHdr.RESET;
            //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //         IF WritCaseHdr.FINDFIRST THEN BEGIN
            //             SendToSection.SETTABLEVIEW(WritCaseHdr);
            //             SendToSection.RUNMODAL;
            //         END ELSE
            //             ERROR(Text001);
            //         /*
            //         SeqNo:=1;
            //         SOFApprovalEntry.INIT;
            //         SOFApprovalEntry."Table ID":=RecID.TABLENO;
            //         SOFApprovalEntry."Document No.":="File No.";
            //         SOFApprovalEntry."Sequence No.":=SeqNo;
            //         SOFApprovalEntry."Sender ID":=USERID;
            //         SOFApprovalEntry."Approver ID":= USERID;
            //         SOFApprovalEntry.Status:=SOFApprovalEntry.Status::Approved;
            //         SOFApprovalEntry."Date-Time Sent for Approval":=CREATEDATETIME(TODAY,TIME);
            //         SOFApprovalEntry."Last Date-Time Modified":=CREATEDATETIME(TODAY,TIME);
            //         SOFApprovalEntry."Last Modified By User ID":=USERID;
            //         SOFApprovalEntry."Record ID to Approve":=Rec.RECORDID;
            //         SOFApprovalEntry.INSERT(TRUE);
            //         SeqNo:=SeqNo+1;
            //         */
            //         /*
            //         SeqNo:=1;
            //         FileMovementEntry.RESET;
            //         FileMovementEntry.SETCURRENTKEY("Document No.","Line No.","Sender Section","Sending Date");
            //         FileMovementEntry.SETRANGE("Document No.","File No.");
            //         FileMovementEntry.SETRANGE("Sender Section",'09');
            //         IF FileMovementEntry.FIND('-') THEN BEGIN
            //           RecID:=Rec.RECORDID;
            //             REPEAT
            //               IF NOT DuplicateUser(FileMovementEntry."Document No.",FileMovementEntry."Receiver ID") THEN BEGIN
            //                 SOFApprovalEntry.INIT;
            //                 SOFApprovalEntry."Table ID":=RecID.TABLENO;
            //                 SOFApprovalEntry."Document No.":="File No.";
            //                 SOFApprovalEntry."Sequence No.":=SeqNo;
            //                 SOFApprovalEntry."Sender ID":=USERID;
            //                 UserSetup.GET(FileMovementEntry."Receiver ID");
            //                 SOFApprovalEntry."Approver ID":=FileMovementEntry."Receiver ID";
            //                 IF SeqNo = 1 THEN
            //                   SOFApprovalEntry.Status:=SOFApprovalEntry.Status::Open
            //                 ELSE
            //                   SOFApprovalEntry.Status:=SOFApprovalEntry.Status::Created;
            //                 SOFApprovalEntry."Date-Time Sent for Approval":=CREATEDATETIME(TODAY,TIME);
            //                 SOFApprovalEntry."Last Date-Time Modified":=CREATEDATETIME(TODAY,TIME);
            //                 SOFApprovalEntry."Last Modified By User ID":=USERID;
            //                 SOFApprovalEntry."Record ID to Approve":=Rec.RECORDID;
            //                 SOFApprovalEntry.INSERT(TRUE);
            //                 SeqNo :=SeqNo + 1;
            //               END;
            //             UNTIL FileMovementEntry.NEXT=0;
            //           SOFApprovalEntry.INIT;
            //           SOFApprovalEntry."Table ID":=RecID.TABLENO;
            //           SOFApprovalEntry."Document No.":="File No.";
            //           SOFApprovalEntry."Sequence No.":=SeqNo;
            //           SOFApprovalEntry."Sender ID":=USERID;
            //           SOFApprovalEntry."Approver ID":= 'SECRETARY';
            //             IF SeqNo = 1 THEN
            //             SOFApprovalEntry.Status:=SOFApprovalEntry.Status::Open
            //             ELSE
            //           SOFApprovalEntry.Status:=SOFApprovalEntry.Status::Created;
            //           SOFApprovalEntry."Date-Time Sent for Approval":=CREATEDATETIME(TODAY,TIME);
            //           SOFApprovalEntry."Last Date-Time Modified":=CREATEDATETIME(TODAY,TIME);
            //           SOFApprovalEntry."Last Modified By User ID":=USERID;
            //           SOFApprovalEntry."Record ID to Approve":=Rec.RECORDID;
            //           SOFApprovalEntry.INSERT(TRUE);
            //         END ELSE
            //           ERROR('SOF data not collected from any section');

            //         "SOF Status":="SOF Status"::"Pending for Approval";
            //         MODIFY;
            //         MESSAGE('Sent for approval successfully');
            //         */

            //     end;
            // }
            // action(Comments)
            // {
            //     Caption = 'SOF Approval Comments';
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Scope = Repeater;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         ApprovalCommentLine: Record "455";
            //     begin
            //         ApprovalCommentLine.SETRANGE("Table ID", 50065);
            //         ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
            //         PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
            //     end;
            // }
            // action("Attach Note Sheet")
            // {
            //     Image = Attach;
            //     Promoted = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         //UploadFile();
            //         /*
            //         MyRecordRef.CLOSE;
            //         MyRecordRef.OPEN(DATABASE::"Writ/Case Header");
            //         MyRecordRef.SETRECFILTER;
            //         SupportDoc.Import(MyRecordRef,Rec."File No.");
            //         */
            //         rec.TESTFIELD("File No.");
            //         SupportDoc.AttachNoteSheet("File No.");

            //     end;
            // }
            // action("Attach Annexure")
            // {
            //     Image = Attach;
            //     Promoted = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         //UploadFile();
            //         /*
            //         MyRecordRef.CLOSE;
            //         MyRecordRef.OPEN(DATABASE::"Writ/Case Header");
            //         MyRecordRef.SETRECFILTER;
            //         SupportDoc.Import(MyRecordRef,Rec."File No.");
            //         */
            //         REC.rec.TESTFIELD("File No.");
            //         SupportDoc.AttachAnnexure(REC."File No.");

            //     end;
            // }
            // action("Attach Supporting Document")
            // {
            //     Image = Attach;
            //     Promoted = true;
            //     Visible = true;

            //     trigger OnAction()
            //begin
            //UploadFile();
            /*
            MyRecordRef.CLOSE;
            MyRecordRef.OPEN(DATABASE::"Writ/Case Header");
            MyRecordRef.SETRECFILTER;
            SupportDoc.Import(MyRecordRef,Rec."File No.");
            */
            //         rec.TESTFIELD("File No.");
            //         SupportDoc.AttachOther(REC."File No.");

            //     end;
            // }
            // action("Order Send To Section")
            // {
            //     Image = SelectEntries;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     var
            //         SendToSection: Report "50131";
            //         Text001: Label 'Document not found.';
            //         WritCaseHdr1: Record "50065";
            //     begin
            //         rec.TESTFIELD("Name Of Petitioner");
            //         rec.TESTFIELD("Location Code");
            //         rec.TESTFIELD("Global Dimension 1 Code");
            //         rec.TESTFIELD("Global Dimension 2 Code");
            //         rec.TESTFIELD("Verdict Date");
            //         //rec.TESTFIELD("Verdict File Name");
            //         CLEAR(SendToSection);
            //         WritCaseHdr1.RESET;
            //         WritCaseHdr1.SETRANGE(WritCaseHdr1."File No.", "File No.");
            //         IF WritCaseHdr1.FINDFIRST THEN BEGIN
            //             SendToSection.SETTABLEVIEW(WritCaseHdr1);
            //             SendToSection.SetSection("Global Dimension 2 Code");
            //             SendToSection.RUNMODAL;
            //         END ELSE
            //             ERROR(Text001);

            //         CurrPage.CLOSE;
            //     end;
            // }
            //   action("File Outward")
            // {
            //     Caption = 'File Movement Status';
            //     Image = OrderList;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     begin
            //         FileMovEntry.RESET;
            //         FileMovEntry.FILTERGROUP(2);
            //         FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
            //         FileMovEntry.SETRANGE("Document No.", REC."File No.");
            //         FileMovEntry.FILTERGROUP(0);
            //         IF FileMovEntry.FIND('-') THEN
            //             PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry)
            //         ELSE
            //             MESSAGE('Details not found');
            //     end;
            // }
            // action(Comment)
            // {
            //     Image = Comment;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     var
            //         LegalComment: Record "Legal Comment Line";
            //     begin
            //         LegalComment.RESET;
            //         LegalComment.SETRANGE("Document No.", REC."File No.");
            //         PAGE.RUN(50175, LegalComment);
            //     end;
            //  }
            //     action("Assign To User")
            //     {
            //         Image = SendTo;
            //         Promoted = true;
            //         PromotedCategory = Process;

            //         trigger OnAction()
            //         begin
            //             IF NOT CONFIRM(Text004) THEN
            //                 EXIT;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE("File No.", "File No.");
            //             IF WritCaseHdr.FINDFIRST THEN BEGIN
            //                 SendToLegal.SETTABLEVIEW(WritCaseHdr);
            //                 SendToLegal.SetSection("Global Dimension 2 Code", "User Exam Code");
            //                 SendToLegal.RUNMODAL;
            //             END;

            //             CurrPage.CLOSE;
            //         end;
            //     }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF REC.District = 'OTHER' THEN
            DistNameEnable := TRUE
        ELSE
            DistNameEnable := FALSE;

        IF REC."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF REC."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';

        IF REC.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF REC."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF REC."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';

        IF REC.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;
    end;

    trigger OnClosePage()
    begin
        WritCaseHdr.RESET;
        WritCaseHdr.SETRANGE("File No.", REC."File No.");
        WritCaseHdr.SETRANGE("User Assigned", USERID);
        IF WritCaseHdr.FIND('-') THEN BEGIN
            IF WritCaseHdr.Unread THEN BEGIN
                WritCaseHdr.Unread := FALSE;
                WritCaseHdr."Read Date Time" := CURRENTDATETIME;
                WritCaseHdr.MODIFY;
            END;
        END;


    end;

    trigger OnOpenPage()
    begin
        IF REC."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF REC."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';

        IF REC."SOF Status" = rec."SOF Status"::Created THEN
            ApproveSOFVisible := FALSE
        ELSE
            ApproveSOFVisible := TRUE;

        IF REC.District = 'OTHER' THEN
            DistNameEnable := TRUE
        ELSE
            DistNameEnable := FALSE;

        IF REC.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;
    end;

    var
        Desc: Text[1000];
        Dscript: BigText;
        ServerFileName: Text;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        //ServerFileHelper: DotNet File;  //DSC
        OldFileName: Text;
        Text001: Label 'View';
        AttachedFile: Text;
        Text002: Label 'Do you want to replace attachment ?';
        AdvAssignEntry: Record "Advocate Assigning Entry";
        AdvAssignEntry1: Record "Advocate Assigning Entry";
        AdvAssignEntry2: Record "Advocate Assigning Entry";
        AdvMaster: Record Advocate;
        FileMovEntry: Record "File Movement Entry";
        Text003: Label 'File process not completed.';
        CaseHearingEntry: Record "Case Hearing Entry";
        WritCaseHdr: Record "Writ/Case Header";
        ApproveSOFVisible: Boolean;
        MyUrl: Text;
        Text004: Label 'Do you want to send ?';
        Text005: Label 'Do you want to approve ?';
        Text006: Label 'File not sent to external advocate.';
        Text007: Label 'Do you want to close the Case ?';
        VerdictAttachment: Text;
        AdvType: Integer;
        Text008: Label 'Internal,External';
        Text009: Label 'File in process, you cannot assign advocate.';
        SentSuccessfully: Label 'Sent successfully.';
        DistNameEnable: Boolean;
        SupportDoc: Record "Supporting Document";
        ShowCompRemarks: Boolean;
    //SendToLegal: Report "50133";  //DSC

    local procedure DuplicateUser(DocNo: Code[20]; UserCode: Code[50]): Boolean
    var
    //SOFApprovalEntry1: Record "50080";
    begin
        // SOFApprovalEntry1.RESET;
        // SOFApprovalEntry1.SETCURRENTKEY("Document No.", "Sequence No.");
        // SOFApprovalEntry1.SETRANGE(rec."Document No.", DocNo);
        // SOFApprovalEntry1.SETRANGE(rec."Approver ID", UserCode);
        // SOFApprovalEntry1.SETFILTER(rec.Status, '%1|%2', SOFApprovalEntry1.Status::Created, SOFApprovalEntry1.Status::Open);
        // IF SOFApprovalEntry1.FIND('-') THEN
        //     EXIT(TRUE)
        // ELSE
        //     EXIT(FALSE);
    end;
}

