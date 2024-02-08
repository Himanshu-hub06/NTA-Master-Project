page 50304 "Writ/Case Card- Top Level"
{
    Caption = 'Writ/Case Card';
    DelayedInsert = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,SOF';
    SourceTable = "Writ/Case Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; rec."File No.")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    begin
                        IF rec."File No." = '' THEN
                            IF rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                    end;
                }
                field(Court; rec."Case No.")
                {
                }
                field("Court Name"; rec."Court Name")
                {
                }
                field(Category; rec.Category)
                {

                    trigger OnValidate()
                    begin
                        IF xRec.Category <> rec.Category THEN
                            rec."Case Type" := '';
                    end;
                }
                field("Case Type"; rec."Case Type")
                {
                }
                field("Other Case Type"; rec."Other Case Type")
                {
                }
                field("Arising Out"; rec."Arising Out")
                {
                    TableRelation = "Writ/Case Header"."Case No.";

                    trigger OnValidate()
                    begin
                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE("Case No.", rec."Arising Out");
                        IF WritCaseHdr.FIND('-') THEN
                            REC."Arising Out Type" := WritCaseHdr."Case Type";
                    end;
                }
                field("Arising Out Type"; rec."Arising Out Type")
                {
                    Editable = false;
                }
                field("Case No."; rec."Case No.")
                {
                }
                field(Year; rec.Year)
                {
                    //Numeric = true;
                }
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                    ShowMandatory = true;
                }
                field("Case Filing Date"; rec."Case Filing Date")
                {
                }
                field("BSEB Receiving Date"; rec."BSEB Receiving Date")
                {
                }
                field(Priority; rec.Priority)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                    ShowMandatory = true;
                }
                field("Location Name"; rec."Location Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ShowMandatory = true;
                }
                field("Examination Name"; rec."Examination Name")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ShowMandatory = true;
                }
                field("Section Name"; rec."Section Name")
                {
                    Editable = false;
                }
                field(District; rec.District)
                {

                    trigger OnValidate()
                    begin
                        IF rec.District = 'OTHER' THEN
                            DistNameEnable := TRUE
                        ELSE
                            DistNameEnable := FALSE;
                    end;
                }
                field("District Name"; rec."District Name")
                {
                    Editable = DistNameEnable;
                }
                field("e-office File No."; rec."e-office File No.")
                {
                }
                field("First Hearing Date"; rec."First Hearing Date")
                {
                    Editable = false;
                }
                field("Next Hearing Date"; rec."Next Hearing Date")
                {
                    Editable = false;
                }
                field("SOF Status"; rec."SOF Status")
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
                        IF rec."File Name" <> '' THEN BEGIN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."File Name");

                        END;

                    end;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field(Description1; rec.Description1)
                {
                    Caption = 'Synopsis';
                    Importance = Additional;
                    MultiLine = true;
                }
            }
            group("Dispose Details")
            {
                field("Disposed Date"; rec."Disposed Date")
                {
                    ShowMandatory = true;
                }
                field("Verdict Date"; rec."Verdict Date")
                {
                    ShowMandatory = true;
                }
                field("Verdict Attachment"; VerdictAttachment)
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."Verdict File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."Verdict File Name");
                    end;
                }
                field("In Favour"; rec."In Favour")
                {
                }
                field("Disposed Remark"; rec."Disposed Remarks")
                {
                    Caption = 'Disposed Remark';
                    ShowMandatory = true;
                }
                field("Compliance Remarks"; rec.Description2)
                {
                    Editable = false;
                    MultiLine = true;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(comments; "Legal Comment Factbox")   //DSC
            {
                Caption = 'Comments';
                SubPageLink = "Document No." = FIELD("File No.");
                SubPageView = SORTING("Entry No.")
                              ORDER(Ascending);
            }
            part(FileMovementEntry; "File Movement FactBox")
            {
                Caption = 'File Movement Status';
                SubPageLink = "Document No." = FIELD("File No.");
                SubPageView = SORTING("Document Type", "Document No.", "Line No.")
                              ORDER(Ascending);
            }
            part(DocFactBox; "Supporting Doc Factbox")
            {
                Caption = 'Supporting Documents';
                SubPageLink = "Document No." = FIELD("File No.");
            }
            part("SOF Approval Status"; "SOF Approval status FactBox")
            {
                Caption = 'SOF Approval Status';
                SubPageLink = "Document No." = FIELD("File No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send To Section")
            {
                Caption = 'Send For Fact Collection';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SendToSection: Report 50123;  //DSC
                    Text001: Label 'Document not found.';
                begin
                    REC.TESTFIELD("Name Of Petitioner");
                    REC.TESTFIELD("Location Code");
                    REC.TESTFIELD("Global Dimension 1 Code");
                    REC.TESTFIELD("Global Dimension 2 Code");
                    CLEAR(SendToSection);   //DSC
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");

                    //DSC
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToSection.SETTABLEVIEW(WritCaseHdr);
                        SendToSection.SetSection(REC."Global Dimension 2 Code");
                        SendToSection.RUNMODAL;
                    END ELSE
                        ERROR(Text001);

                    CurrPage.CLOSE;


                end;
            }
            action("Assign Advoate")
            {
                Caption = 'Assign Advocate';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    REC.TESTFIELD("Name Of Petitioner");
                    REC.TESTFIELD("Location Code");
                    REC.TESTFIELD("Global Dimension 1 Code");
                    REC.TESTFIELD("Global Dimension 2 Code");

                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETRANGE("File No.", REC."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                    PAGE.RUN(PAGE::"Advocate Assigning", AdvAssignEntry);


                end;
            }

            //DSC
            // action("Send For Creation")
            // {
            //     Caption = 'Send For Creation';
            //     Image = CreditMemo;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Visible = true;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Advocate not assigned for SOF creation.';
            //         WritCaseHdr: Record "Writ/Case Header";
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         //UserTab: Record "2000000120";  //DSC
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         // SMTPMail: Codeunit "400";  //DSC
            //         // SMTPMailSetup: Record "409";
            //         // TempBlob: Record "99008535";
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF creation ?';
            //     begin
            //         //TESTFIELD("SOF Status","SOF Status"::" ");
            //         REC.TESTFIELD("File No.");
            //         REC.TESTFIELD("Location Code");
            //         REC.TESTFIELD("Global Dimension 1 Code");
            //         REC.TESTFIELD("Global Dimension 2 Code");
            //         REC.TESTFIELD("Name Of Petitioner");
            //         j := 1;
            //         MyUrl := '';
            //         REC.TESTFIELD("File No.");
            //         REC.TESTFIELD("Name Of Petitioner");
            //         FileMovEntry.RESET;
            //         FileMovEntry.SETRANGE("Document No.", REC."File No.");
            //         IF NOT FileMovEntry.FIND('-') THEN
            //             ERROR('SOF data not collected from any section');
            //         IF FileInProcess THEN
            //             ERROR(Text003);

            //         IF NOT CONFIRM(SendConfirm) THEN BEGIN
            //             CurrPage.CLOSE;
            //             EXIT;
            //         END;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", REC."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FINDSET THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             Selection := STRMENU(Text010, 1, Text011);
            //             IF Selection = 0 THEN
            //                 ERROR('Please select SOF type');
            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             SMTPMailSetup.GET;
            //             Subject := 'Regarding SOF preparation for case no.-' + REC."Case No." + ' - ' + REC."Name Of Petitioner";
            //             Body := 'Dear Sir/Madam,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents for preparation of Statement of facts (SOF). Request you to kindly prepare the SOF');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN BEGIN
            //                     MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + "File Name", 'Attachment1');
            //                     SMTPMail.AppendBody(MyUrl);
            //                     //SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");
            //                 END;
            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", REC."File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN

            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         SMTPMail.AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         SMTPMail.AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             j := 0;

            //             LegalCommentLine.RESET;
            //             LegalCommentLine.SETCURRENTKEY("Entry No.", "Document No.");
            //             LegalCommentLine.SETRANGE("Document No.", REC."File No.");
            //             REPORT.SAVEASPDF(50184, InvSetup."Writ Case Write Path" + 'NoteSheet_' + REC."File No." + '.pdf', LegalCommentLine);
            //             SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + 'NoteSheet_' + REC."File No." + '.pdf', 'NoteSheet.pdf');

            //             REC."SOF Status" := REC."SOF Status"::"Under Preparation";
            //             REC.MODIFY(TRUE);
            //             REPEAT
            //                 AdvAssignEntry1.INIT;
            //                 AdvAssignEntry1."File No." := REC."File No.";
            //                 AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //                 AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                 AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                 AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //                 AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                 AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                 AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 IF Selection = 2 THEN
            //                     AdvAssignEntry1.Supplementary := TRUE
            //                 ELSE
            //                     AdvAssignEntry1.Supplementary := FALSE;
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             SMTPMail.SendBSEB('LEGAL');
            //             MESSAGE(SentSuccessfully);
            //         END;

            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", REC."File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
            //         END;

            //     end;
            // }

            //DSC
            // action("Send For Creation(API)")
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
            //         WritCaseHdr: Record "50065";
            //         SupportingDoc: Record "50076";
            //         InvSetup: Record "313";
            //         UserTab: Record "2000000120";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         SMTPMail: Codeunit "400";
            //         SMTPMailSetup: Record "409";
            //         TempBlob: Record "99008535";
            //         FileMgt: Codeunit "419";
            //         Subject: Text[150];
            //         Body: Text;
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF creation ?';
            //     begin
            //         //TESTFIELD("SOF Status","SOF Status"::" ");
            //         TESTFIELD("File No.");
            //         TESTFIELD("Location Code");
            //         TESTFIELD("Global Dimension 1 Code");
            //         TESTFIELD("Global Dimension 2 Code");
            //         TESTFIELD("Name Of Petitioner");
            //         j := 1;
            //         MyUrl := '';
            //         MailBody := '';
            //         TESTFIELD("File No.");
            //         TESTFIELD("Name Of Petitioner");
            //         FileMovEntry.RESET;
            //         FileMovEntry.SETRANGE("Document No.", "File No.");
            //         IF NOT FileMovEntry.FIND('-') THEN
            //             ERROR('SOF data not collected from any section');
            //         IF FileInProcess THEN
            //             ERROR(Text003);

            //         IF NOT CONFIRM(SendConfirm) THEN BEGIN
            //             CurrPage.CLOSE;
            //             EXIT;
            //         END;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", "File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FINDSET THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             Selection := STRMENU(Text010, 1, Text011);
            //             IF Selection = 0 THEN
            //                 ERROR('Please select SOF type');
            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             //SMTPMailSetup.GET;
            //             Subject := 'Regarding SOF preparation for case no.-' + "Case No." + ' - ' + "Name Of Petitioner";
            //             AppendBody('<![CDATA[<!DOCTYPE html><html><head><title></title></head><body>');
            //             AppendBody('Dear Sir/Madam,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody('Please find attached documents for preparation of Statement of Facts (SOF). Request you to kindly prepare the SOF.');
            //             AppendBody('<BR/><BR/>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             AppendBody('<BR/><BR/><BR/>');
            //             AppendBody('Regards,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody(SenderName);
            //             AppendBody('<BR/>');
            //             AppendBody('Bihar School Examination Board');
            //             AppendBody('<BR/><BR/>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         RecepientID := RecepientID + ',' + AdvMaster."Email ID";           //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             RecepientID := COPYSTR(RecepientID, 2, STRLEN(RecepientID));
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN BEGIN
            //                     MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + "File Name", 'Attachment1');
            //                     AppendBody(MyUrl);
            //                     //SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");
            //                 END;
            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         AppendBody('<BR/>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             j := 0;

            //             LegalCommentLine.RESET;
            //             LegalCommentLine.SETCURRENTKEY("Entry No.", "Document No.");
            //             LegalCommentLine.SETRANGE("Document No.", "File No.");
            //             IF LegalCommentLine.FINDFIRST THEN BEGIN
            //                 REPORT.SAVEASPDF(50184, InvSetup."Writ Case Write Path" + 'NoteSheet_' + "File No." + '.pdf', LegalCommentLine);
            //                 MyUrl := '';
            //                 MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + 'NoteSheet_' + "File No." + '.pdf', 'Note Sheet');
            //                 AppendBody('<BR/>');
            //                 AppendBody(MyUrl);
            //             END;
            //             AppendBody('</body></html>]]>');
            //             //SMTPMail.AddAttachment(InvSetup."Writ Case Read Path" + 'NoteSheet_' + "File No." +'.pdf','NoteSheet.pdf');
            //             //ERROR(MailBody);
            //             "SOF Status" := "SOF Status"::"Under Preparation";
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
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 IF Selection = 2 THEN
            //                     AdvAssignEntry1.Supplementary := TRUE
            //                 ELSE
            //                     AdvAssignEntry1.Supplementary := FALSE;
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             //SMTPMail.SendBSEB('LEGAL');
            //             IF CustomEmail.SendEmailWithoutCC(RecepientID, Subject, MailBody) THEN
            //                 MESSAGE('Mail sent successfully')
            //             ELSE
            //                 ERROR(GETLASTERRORTEXT);
            //         END;

            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", "File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
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
            //     Visible = true;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Advocate not assigned for SOF review.';
            //         WritCaseHdr: Record 50203;
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         UserTab: Record "User BOC";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         // SMTPMail: Codeunit "400";  //DSC
            //         // SMTPMailSetup: Record "409";
            //         // TempBlob: Record "99008535";
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF review ?';
            //     begin
            //         j := 1;
            //         MyUrl := '';
            //         Selection := 0;
            //         //TESTFIELD("SOF Status","SOF Status"::Created);
            //         REC.TESTFIELD("File No.");
            //         REC.TESTFIELD("Location Code");
            //         REC.TESTFIELD("Global Dimension 1 Code");
            //         REC.TESTFIELD("Global Dimension 2 Code");
            //         REC.TESTFIELD("Name Of Petitioner");

            //         IF FileInProcess THEN
            //             ERROR(Text003);

            //         IF NOT CONFIRM(SendConfirm) THEN
            //             EXIT;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", "File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Reviewer);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FIND('-') THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             Selection := STRMENU(Text010, 1, Text011);
            //             IF Selection = 0 THEN
            //                 ERROR('Please select SOF type');

            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             SMTPMailSetup.GET;
            //             Subject := 'Regarding vetting of SoF for case no.-' + "Case No." + ' - ' + "Name Of Petitioner";
            //             Body := 'Dear Sir/Madam,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents and Statement of facts (SOF) prepared for this case.');
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Request you to kindly do the vetting of SOF.');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one reviewer
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN BEGIN
            //                     MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + "File Name", 'Attachment1');
            //                     SMTPMail.AppendBody(MyUrl);
            //                     //SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");
            //                 END;
            //             AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", "File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Creator);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN BEGIN
            //                         SMTPMail.AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + AdvAssignEntry2."SOF File Name", 'Attachment' + FORMAT(j));
            //                         SMTPMail.AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"),AdvAssignEntry2."SOF File Name");
            //                     END;
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         SMTPMail.AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         SMTPMail.AppendBody(MyUrl);
            //                         // SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             j := 0;

            //             LegalCommentLine.RESET;
            //             LegalCommentLine.SETCURRENTKEY("Entry No.", "Document No.");
            //             LegalCommentLine.SETRANGE("Document No.", "File No.");
            //             REPORT.SAVEASPDF(50184, InvSetup."Writ Case Write Path" + 'NoteSheet_' + "File No." + '.pdf', LegalCommentLine);
            //             SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + 'NoteSheet_' + "File No." + '.pdf', 'NoteSheet.pdf');

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
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 IF Selection = 2 THEN
            //                     AdvAssignEntry1.Supplementary := TRUE
            //                 ELSE
            //                     AdvAssignEntry1.Supplementary := FALSE;
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             SMTPMail.SendBSEB('LEGAL');
            //             MESSAGE(SentSuccessfully);
            //         END;
            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", "File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
            //         END;
            //     end;
            // }
            // action("Send For Review(API)")
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
            //         UserTab: Record "User BOC";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         // SMTPMail: Codeunit "400";   //DSC
            //         // SMTPMailSetup: Record "409";
            //         // TempBlob: Record "99008535";
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //         SendConfirm: Label 'Do you want to send email for SOF review ?';
            //     begin
            //         j := 1;
            //         MyUrl := '';
            //         MailBody := '';
            //         Subject := '';
            //         Selection := 0;
            //         //TESTFIELD("SOF Status","SOF Status"::Created);
            //         rec.TESTFIELD("File No.");
            //         rec.TESTFIELD("Location Code");
            //         rec.TESTFIELD("Global Dimension 1 Code");
            //         rec.TESTFIELD("Global Dimension 2 Code");
            //         rec.TESTFIELD("Name Of Petitioner");

            //         //DSC
            //         // IF FileInProcess THEN           
            //         //   ERROR(Text003);

            //         // IF NOT CONFIRM(SendConfirm) THEN
            //         //   EXIT;

            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", REC."File No.");
            //         AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //         AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //         AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Reviewer);
            //         AdvAssignEntry.SETRANGE(Active, TRUE);
            //         IF NOT AdvAssignEntry.FIND('-') THEN
            //             ERROR(AdvErr)
            //         ELSE BEGIN
            //             Selection := STRMENU(Text010, 1, Text011);
            //             IF Selection = 0 THEN
            //                 ERROR('Please select SOF type');

            //             RecepientID := '';
            //             UserTab.RESET;
            //             UserTab.SETRANGE("User Name", USERID);
            //             IF UserTab.FIND('-') THEN
            //                 SenderName := UserTab."Full Name";

            //             //SMTPMailSetup.GET;
            //             Subject := 'Regarding vetting of SoF for case no.-' + REC."Case No." + ' - ' + REC."Name Of Petitioner";
            //             AppendBody('<![CDATA[<!DOCTYPE html><html><head><title></title></head><body>');
            //             AppendBody('Dear Sir/Madam,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody('Please find attached documents and Statement of Facts (SOF) prepared for this case.');
            //             AppendBody('<BR/>');
            //             AppendBody('Request you to kindly do the vetting of SOF.');
            //             AppendBody('<BR/><BR/>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             AppendBody('<BR/><BR/><BR/>');
            //             AppendBody('Regards,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody(SenderName);
            //             AppendBody('<BR/>');
            //             AppendBody('Bihar School Examination Board');
            //             AppendBody('<BR/><BR/>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         RecepientID := RecepientID + ',' + AdvMaster."Email ID";           //For maore than one reviewer
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             RecepientID := COPYSTR(RecepientID, 2, STRLEN(RecepientID));
            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF REC."File Name" <> '' THEN BEGIN
            //                     MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + REC."File Name", 'Attachment1');
            //                     AppendBody(MyUrl);
            //                     //SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");
            //                 END;
            //             AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", REC."File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Creator);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN BEGIN
            //                         AppendBody('<BR/>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + AdvAssignEntry2."SOF File Name", 'Attachment' + FORMAT(j));
            //                         AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"),AdvAssignEntry2."SOF File Name");
            //                     END;
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", REC."File No.");
            //             IF SupportingDoc.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         AppendBody('<BR/>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         AppendBody(MyUrl);
            //                         // SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             j := 0;

            //             LegalCommentLine.RESET;
            //             LegalCommentLine.SETCURRENTKEY("Entry No.", "Document No.");
            //             LegalCommentLine.SETRANGE("Document No.", REC."File No.");
            //             IF LegalCommentLine.FINDFIRST THEN BEGIN
            //                 REPORT.SAVEASPDF(50184, InvSetup."Writ Case Write Path" + 'NoteSheet_' + REC."File No." + '.pdf', LegalCommentLine);
            //                 MyUrl := '';
            //                 MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + 'NoteSheet_' + REC."File No." + '.pdf', 'Note Sheet');
            //                 AppendBody('<BR/>');
            //                 AppendBody(MyUrl);
            //             END;
            //             AppendBody('</body></html>]]>');

            //             REC."SOF Status" := REC."SOF Status"::"Under Review";
            //             REC.MODIFY(TRUE);
            //             REPEAT
            //                 AdvAssignEntry1.INIT;
            //                 AdvAssignEntry1."File No." := REC."File No.";
            //                 AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //                 AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                 AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                 AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //                 AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                 AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                 AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 IF Selection = 2 THEN
            //                     AdvAssignEntry1.Supplementary := TRUE
            //                 ELSE
            //                     AdvAssignEntry1.Supplementary := FALSE;
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             IF CustomEmail.SendEmailWithoutCC(RecepientID, Subject, MailBody) THEN
            //                 MESSAGE('Mail sent successfully')
            //             ELSE
            //                 ERROR(GETLASTERRORTEXT);
            //         END;

            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", REC."File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
            //         END;
            //     end;
            // }

            //DSC 
            // action("Send To External Advocate")
            // {
            //     Image = Email;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = true;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Extrenal Advocate not assigned.';
            //         WritCaseHdr: Record "Writ/Case Header";
            //         SupportingDoc: Record "Supporting Document";
            //         InvSetup: Record "Inventory Setup";
            //         UserTab: Record "User BOC";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         // SMTPMail: Codeunit "400";   /DSC
            //         // SMTPMailSetup: Record "409";
            //         // TempBlob: Record "99008535";
            //         FileMgt: Codeunit "File Management";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //     begin
            //         j := 0;
            //         MyUrl := '';
            //         REC.TESTFIELD("File No.");
            //         REC.TESTFIELD("Location Code");
            //         REC.TESTFIELD("Global Dimension 1 Code");
            //         REC.TESTFIELD("Global Dimension 2 Code");
            //         REC.TESTFIELD("Name Of Petitioner");
            //         REC.TESTFIELD("SOF Status", REC."SOF Status"::Approved);
            //         // IF FileInProcess THEN   //DSC
            //         //     ERROR(Text003);

            //         // IF NOT CONFIRM(Text004) THEN
            //         //     EXIT;
            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE("File No.", "File No.");
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
            //             Subject := 'Case no.-' + "Case No." + ' - ' + "Name Of Petitioner";
            //             Body := 'Dear Sir/Madam,';
            //             SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody('Please find attached documents of new case.');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             SMTPMail.AppendBody('<BR><BR><BR>');
            //             SMTPMail.AppendBody('Regards');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             SMTPMail.AppendBody(SenderName);
            //             SMTPMail.AppendBody('<BR>');
            //             SMTPMail.AppendBody('Bihar School Examination Board');
            //             SMTPMail.AppendBody('<BR><BR>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE("File No.", REC."File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF REC."File Name" <> '' THEN
            //                     //   SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");   //19-11-2019

            //                     AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", REC."File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Reviewer);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN BEGIN
            //                         SMTPMail.AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + AdvAssignEntry2."SOF File Name", 'Attachment' + FORMAT(j));
            //                         SMTPMail.AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"),AdvAssignEntry2."SOF File Name");
            //                     END;
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", REC."File No.");
            //             SupportingDoc.SETRANGE(SupportingDoc."Legal File Type", SupportingDoc."Legal File Type"::Annexure);
            //             IF SupportingDoc.FIND('-') THEN BEGIN

            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         SMTPMail.AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         SMTPMail.AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             j := 0;
            //             Status := Status::Ongoing;
            //             "SOF Status" := "SOF Status"::Sent;
            //             "SOF Sent Date" := WORKDATE;
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
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             SMTPMail.SendBSEB('LEGAL');
            //             MESSAGE(SentSuccessfully);
            //         END;
            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", "File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
            //         END;

            //     end;
            // }
            // action("Send To External Advocate(API)")
            // {
            //     Caption = 'Send To External Advocate';
            //     Image = Email;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         AdvErr: Label 'Extrenal Advocate not assigned.';
            //         WritCaseHdr: Record "50065";
            //         SupportingDoc: Record "50076";
            //         InvSetup: Record "313";
            //         UserTab: Record "2000000120";
            //         FileName: Text;
            //         RecepientID: Text;
            //         SenderName: Text;
            //         SMTPMail: Codeunit "400";
            //         SMTPMailSetup: Record "409";
            //         TempBlob: Record "99008535";
            //         FileMgt: Codeunit "419";
            //         Subject: Text[150];
            //         Body: Text[200];
            //         NVInStream: InStream;
            //     begin
            //         j := 0;
            //         MyUrl := '';
            //         Subject := '';
            //         MailBody := '';
            //         TESTFIELD("File No.");
            //         TESTFIELD("Location Code");
            //         TESTFIELD("Global Dimension 1 Code");
            //         TESTFIELD("Global Dimension 2 Code");
            //         TESTFIELD("Name Of Petitioner");
            //         //TESTFIELD("SOF Status","SOF Status"::Approved);
            //         IF FileInProcess THEN
            //             ERROR(Text003);

            //         IF NOT CONFIRM(Text004) THEN
            //             EXIT;
            //         AdvAssignEntry.RESET;
            //         AdvAssignEntry.SETRANGE("File No.", "File No.");
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

            //             //SMTPMailSetup.GET;
            //             Subject := 'Case no.-' + "Case No." + ' - ' + "Name Of Petitioner";
            //             AppendBody('<![CDATA[<!DOCTYPE html><html><head><title></title></head><body>');
            //             AppendBody('Dear Sir/Madam,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody('Please find attached documents of case no.-' + "Case No." + ' - ' + "Name Of Petitioner");
            //             AppendBody('<BR/><BR/>');
            //             IF AdvAssignEntry.Remarks <> '' THEN
            //                 AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //             AppendBody('<BR/><BR/><BR/>');
            //             AppendBody('Regards,');
            //             AppendBody('<BR/><BR/>');
            //             AppendBody(SenderName);
            //             AppendBody('<BR/>');
            //             AppendBody('Bihar School Examination Board');
            //             AppendBody('<BR/><BR/>');
            //             REPEAT
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     IF AdvMaster."Email ID" <> '' THEN
            //                         RecepientID := RecepientID + ',' + AdvMaster."Email ID";          //For maore than one advocate
            //             UNTIL AdvAssignEntry.NEXT = 0;
            //             RecepientID := COPYSTR(RecepientID, 2, STRLEN(RecepientID));

            //             InvSetup.GET;
            //             WritCaseHdr.RESET;
            //             WritCaseHdr.SETRANGE("File No.", "File No.");
            //             IF WritCaseHdr.FIND('-') THEN
            //                 IF "File Name" <> '' THEN
            //                     //   SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");   //19-11-2019

            //                     AdvAssignEntry2.RESET;                                      //SOF document
            //             AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //             AdvAssignEntry2.SETRANGE("File No.", "File No.");
            //             AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //             AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //             AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Reviewer);
            //             AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //             AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
            //             IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF AdvAssignEntry2."SOF File Name" <> '' THEN BEGIN
            //                         AppendBody('<BR/>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + AdvAssignEntry2."SOF File Name", 'Attachment' + FORMAT(j));
            //                         AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"),AdvAssignEntry2."SOF File Name");
            //                     END;
            //                 UNTIL AdvAssignEntry2.NEXT = 0;
            //             END;

            //             SupportingDoc.RESET;
            //             SupportingDoc.SETRANGE("Document No.", "File No.");
            //             SupportingDoc.SETRANGE(SupportingDoc."Legal File Type", SupportingDoc."Legal File Type"::Annexure);
            //             IF SupportingDoc.FIND('-') THEN BEGIN
            //                 REPEAT
            //                     j += 1;
            //                     IF SupportingDoc."File Name" <> '' THEN BEGIN
            //                         AppendBody('<BR>');
            //                         MyUrl := '';
            //                         MyUrl := STRSUBSTNO(AttachmentTxt, InvSetup."Writ Case Read Path" + SupportingDoc."File Name", 'Attachment' + FORMAT(j));
            //                         AppendBody(MyUrl);
            //                         //SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"),SupportingDoc."File Name");
            //                     END;
            //                 UNTIL SupportingDoc.NEXT = 0;
            //             END;
            //             AppendBody('</body></html>]]>');

            //             j := 0;
            //             Status := Status::Ongoing;
            //             "SOF Status" := "SOF Status"::Sent;
            //             "SOF Sent Date" := WORKDATE;
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
            //                 AdvAssignEntry1."SOF Sent By" := USERID;
            //                 AdvAssignEntry1."Send Time" := TIME;
            //                 AdvMaster.RESET;
            //                 IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                     AdvAssignEntry1."Email id" := AdvMaster."Email ID";
            //                 AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                 AdvAssignEntry1.INSERT(TRUE);
            //             UNTIL AdvAssignEntry.NEXT = 0;

            //             IF CustomEmail.SendEmailWithoutCC(RecepientID, Subject, MailBody) THEN
            //                 MESSAGE('Mail sent successfully')
            //             ELSE
            //                 ERROR(GETLASTERRORTEXT);
            //         END;
            //         LegalCommentLine.RESET;
            //         LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //         LegalCommentLine.SETRANGE("Document No.", "File No.");
            //         LegalCommentLine.SETRANGE(Active, FALSE);
            //         IF LegalCommentLine.FIND('-') THEN BEGIN
            //             REPEAT
            //                 LegalCommentLine.Active := TRUE;
            //                 LegalCommentLine.MODIFY;
            //             UNTIL LegalCommentLine.NEXT = 0;
            //         END;
            //     end;
            // }
            action("Hearing Details")
            {
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.","Line No.");
                    AdvAssignEntry.SETRANGE("File No.","File No.");
                    AdvAssignEntry.SETRANGE(Active,TRUE);
                    AdvAssignEntry.SETRANGE("Advocate Type",AdvAssignEntry."Advocate Type"::External);
                    AdvAssignEntry.SETRANGE("Entry Type",AdvAssignEntry."Entry Type"::"Sent To External");
                    AdvAssignEntry.SETRANGE("Sent To External Adv.",TRUE);
                    IF NOT AdvAssignEntry.FINDFIRST THEN
                      ERROR(Text006);
                    */
                    //TESTFIELD("First Hearing Date");
                    CaseHearingEntry.RESET;
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", REC."File No.");
                    PAGE.RUN(50360, CaseHearingEntry);

                end;
            }
            action(Dispose)
            {
                Caption = 'Dispose';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TESTFIELD("Case Filing Date");
                    //TESTFIELD("BSEB Receiving Date");
                    REC.TESTFIELD("Name Of Petitioner");
                    REC.TESTFIELD("Location Code");
                    REC.TESTFIELD("Global Dimension 1 Code");
                    REC.TESTFIELD("Global Dimension 2 Code");
                    REC.TESTFIELD("Disposed Date");
                    REC.TESTFIELD("Verdict Date");
                    REC.TESTFIELD("Disposed Remarks");
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
            action("Send For Approval")
            {
                Caption = 'Send To Section For Approval';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FileMovementEntry: Record "File Movement Entry";
                    AdvAssigmentEntry: Record "Advocate Assigning Entry";
                    SOFApprovalEntry: Record "SOF Approval entry";
                    SeqNo: Integer;
                    RecID: RecordID;
                    UserSetup: Record "User Setup";
                    AppConfirm: Label 'Do you want to send SOF for approval ?';
                    PrevUser: Code[50];
                // SendToSection: Report 50127;
                begin
                    REC.TESTFIELD("SOF Created", TRUE);
                    REC.TESTFIELD("Name Of Petitioner");
                    REC.TESTFIELD("Location Code");
                    REC.TESTFIELD("Global Dimension 1 Code");
                    REC.TESTFIELD("Global Dimension 2 Code");

                    IF NOT CONFIRM(AppConfirm) THEN
                        EXIT;

                    //  CLEAR(SendToSection);
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        // SendToSection.SETTABLEVIEW(WritCaseHdr);
                        //SendToSection.SetSection("Global Dimension 2 Code"); //DSC
                        //SendToSection.RUNMODAL;
                    END ELSE
                        ERROR(Text001);

                    LegalCommentLine.RESET;
                    LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
                    LegalCommentLine.SETRANGE("Document No.", REC."File No.");
                    LegalCommentLine.SETRANGE(Active, FALSE);
                    IF LegalCommentLine.FIND('-') THEN BEGIN
                        REPEAT
                            LegalCommentLine.Active := TRUE;
                        UNTIL LegalCommentLine.NEXT = 0;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action(Comments1)
            {
                Caption = 'SOF Approval Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalCommentLine: Record 455;
                begin
                    ApprovalCommentLine.SETRANGE("Table ID", 50065);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
                end;
            }
            // action("Send Order To Section")
            // {
            //     Image = SelectEntries;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     var
            //         SendToSection: Report "50131";
            //         Text001: Label 'Document not found.';
            //     begin
            //         TESTFIELD("Name Of Petitioner");
            //         TESTFIELD("Location Code");
            //         TESTFIELD("Global Dimension 1 Code");
            //         TESTFIELD("Global Dimension 2 Code");
            //         TESTFIELD("Verdict Date");
            //         TESTFIELD("Verdict File Name");
            //         CLEAR(SendToSection);
            //         WritCaseHdr.RESET;
            //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //         IF WritCaseHdr.FINDFIRST THEN BEGIN
            //             SendToSection.SETTABLEVIEW(WritCaseHdr);
            //             SendToSection.RUNMODAL;
            //         END ELSE
            //             ERROR(Text001);

            //         /*
            //         WritHdr.RESET;
            //         WritHdr.SETRANGE(WritHdr."File No.","File No.");
            //         IF WritHdr.FIND('-') THEN
            //           PAGE.RUNMODAL(50125,WritHdr);
            //         */

            //     end;
            // }
            action(Comment)
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LegalComment: Record "Legal Comment Line";
                begin
                    LegalComment.RESET;
                    LegalComment.SETRANGE("Document No.", REC."File No.");
                    PAGE.RUN(50175, LegalComment);
                end;
            }
            action("Send SOF")
            {
                Caption = 'Send SOF Manually';
                Image = SendAsPDF;
                Promoted = true;

                trigger OnAction()
                var
                    SendToExternalAdv: Report "Send To Extr Advocate Manually";
                begin
                    CLEAR(SendToExternalAdv);
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToExternalAdv.SETTABLEVIEW(WritCaseHdr);
                        SendToExternalAdv.SetFileNo(REC."File No.");
                        SendToExternalAdv.RUNMODAL;
                    END ELSE
                        ERROR('File no. not found');
                end;
            }
            action("Assign To User")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SendToLegal: Report "Send To User-Legal";
                begin
                    IF NOT CONFIRM(Text004) THEN
                        EXIT;
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE("File No.", rec."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToLegal.SETTABLEVIEW(WritCaseHdr);
                        //SendToLegal.SetSection("Global Dimension 2 Code", "User Exam Code");  /DSC
                        SendToLegal.RUNMODAL;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            group(Attachment)
            {
                Caption = 'Attachments';
                group(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    ToolTip = 'Attachments';
                    action("Attach File")
                    {
                        Caption = 'Attach Writ/Case';
                        Image = Attach;

                        trigger OnAction()
                        begin
                            InvSetup.GET;
                            OldFileName := '';
                            OldFileName := (InvSetup."Writ Case Write Path" + REC."File Name");
                            ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                            ClientFileName := FileManagement.GetFileName(ServerFileName);
                            FileExtension := FileManagement.GetExtension(ServerFileName);
                            IF ClientFileName <> '' THEN BEGIN
                                REC."File Name" := DELCHR(REC."File No.", '=', '/') + '_W_' + ClientFileName;
                                REC."File Extension" := FileExtension;
                                REC.MODIFY(TRUE);
                            END ELSE BEGIN
                                REC."File Name" := '';
                                REC."File Extension" := '';
                                REC.MODIFY(TRUE);
                            END;
                            ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(REC."File No.", '=', '/') + '_W_' + ClientFileName;
                            FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                            IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
                                FileManagement.DeleteServerFile(OldFileName);
                            IF REC."File Name" <> '' THEN
                                AttachedFile := Text001;
                        end;
                    }
                    action("Supplementary Writ")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachSupplementary(REC."File No.");
                        end;
                    }
                    action("Attach I.A")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachIA(REC."File No.");
                        end;
                    }
                    action("Attach Rejoinder")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachRejoinder(REC."File No.");
                        end;
                    }
                    action("Attach Note Sheet")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachNoteSheet(REC."File No.");
                        end;
                    }
                    action("Attach Annexure")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachAnnexure(REC."File No.");
                        end;
                    }
                    action("Supporting Document")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            REC.TESTFIELD("File No.");
                            SupportDoc.AttachOther(REC."File No.");
                        end;
                    }
                    action("Verdict Document")
                    {
                        Image = Attach;

                        trigger OnAction()
                        begin
                            InvSetup.GET;
                            OldFileName := '';
                            OldFileName := (InvSetup."Writ Case Write Path" + REC."Verdict File Name");
                            ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                            ClientFileName := FileManagement.GetFileName(ServerFileName);
                            IF ClientFileName <> '' THEN BEGIN
                                REC."Verdict File Name" := DELCHR(REC."File No.", '=', '/') + '_V_' + ClientFileName;
                                REC.MODIFY(TRUE);
                            END ELSE BEGIN
                                REC."Verdict File Name" := '';
                                REC.MODIFY(TRUE);
                            END;
                            ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(REC."File No.", '=', '/') + '_V_' + ClientFileName;
                            FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                            IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
                                FileManagement.DeleteServerFile(OldFileName);
                            IF REC."Verdict File Name" <> '' THEN
                                VerdictAttachment := 'View';
                        end;
                    }
                }
            }
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

        IF REC."SOF Status" = REC."SOF Status"::Created THEN
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
        AttachmentTxt: Label '<a href="%1">%2</a>';
        SentSuccessfully: Label 'Sent successfully.';
        DistNameEnable: Boolean;
        SupportDoc: Record "Supporting Document";
        ShowCompRemarks: Boolean;
        LegalCommentLine: Record "Legal Comment Line";
        j: Integer;
        Text010: Label 'Normal SOF,Supplementary SOF';
        Selection: Integer;
        Text011: Label 'Select SOF type :';
        LegalNoteSheet: Report "Legal Note Sheet";
        //CustomEmail: Codeunit 50761"
        MailBody: Text;

    local procedure DuplicateUser(DocNo: Code[20]; UserCode: Code[50]): Boolean
    var
        SOFApprovalEntry1: Record "SOF Approval entry";
    begin
        SOFApprovalEntry1.RESET;
        SOFApprovalEntry1.SETCURRENTKEY("Document No.", "Sequence No.");
        SOFApprovalEntry1.SETRANGE("Document No.", DocNo);
        SOFApprovalEntry1.SETRANGE("Approver ID", UserCode);
        SOFApprovalEntry1.SETFILTER(Status, '%1|%2', SOFApprovalEntry1.Status::Created, SOFApprovalEntry1.Status::Open);
        IF SOFApprovalEntry1.FIND('-') THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    local procedure AppendBody(Body: Text)
    begin
        MailBody := MailBody + Body;
    end;
}

