page 50351 "Writ/Case Card"
{
    DelayedInsert = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,SOF';
    SourceTable = "Writ/Case Header";

    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; rec."File No.")
                {
                    //Editable = false;
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    begin
                        IF rec."File No." = '' THEN
                            IF rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                    end;
                }
                field(Court; rec.Court)
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
                            rec."Arising Out Type" := WritCaseHdr."Case Type";
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
                field("NTA Receiving Date"; rec."BSEB Receiving Date")
                {
                    Caption = 'NTA Receiving Date';
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
                    ShowMandatory = true;

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
                    //Editable = DistNameEnable;
                }
                field("e-office File No."; rec."e-office File No.")
                {
                }
                field("First Hearing Date"; rec."First Hearing Date")
                {

                    //Editable = true;


                }
                field("Next Hearing Date"; rec."Next Hearing Date")
                {
                    //Editable = true;
                }
                field("SOF Status"; rec."SOF Status")
                {
                    //Editable = false;
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Attached Writ/Case';
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
                    //Editable = false;
                }

                field(Disposed; Rec.Disposed)
                {

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
            // part(FileMovementEntry; 50399)
            // {
            //     Caption = 'File Movement Status';
            //     SubPageLink = "Document No." = FIELD("File No.");
            //     SubPageView = SORTING("Document Type", "Document No.", "Line No.")
            //                   ORDER(Ascending);
            // }
            part(DocFactBox; 50398)
            {
                Caption = 'Supporting Documents';
                SubPageLink = "Document No." = FIELD("File No.");
            }
            // part("SOF Approval Status"; "SOF Approval status FactBox")
            // {
            //     Caption = 'SOF Approval Status';
            //     SubPageLink = "Document No." = FIELD("File No.");
            // }
        }
    }

    actions
    {
        area(processing)
        {

            action("Send To Section")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SendToSection: Report 50123;
                    Text001: Label 'Document not found.';
                begin
                    rec.TESTFIELD("Name Of Petitioner");
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Global Dimension 1 Code");
                    rec.TESTFIELD("Global Dimension 2 Code");
                    CLEAR(SendToSection);
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", rec."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN

                        SendToSection.SETTABLEVIEW(WritCaseHdr);
                        SendToSection.RUNMODAL;
                    END ELSE
                        ERROR(Text001);
                end;
            }

            action("Assign Advocate")
            {
                Caption = 'Assign Advocate';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.TESTFIELD("Name Of Petitioner");
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Global Dimension 1 Code");
                    rec.TESTFIELD("Global Dimension 2 Code");

                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETRANGE("File No.", rec."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                    PAGE.RUN(PAGE::"Advocate Assigning", AdvAssignEntry);
                end;
            }

            action("Send For Creation")
            {
                Caption = 'Send For Creation';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Process;

                Visible = true;

                trigger OnAction()


                var

                    TheMessage: Codeunit "Email Message";
                    Email: Codeunit Email;
                    Base64: Codeunit "Base64 Convert";
                    Ins: InStream;
                    RecAdvocate: Record Advocate;
                    emailid: Text;


                begin

                    Message('kindly send the Emails Mannualy for the SOF');

                    // if RecAdvocate.Get('AD0015') then
                    //     emailid := RecAdvocate."Email ID";


                    // TheMessage.Create(emailid, 'Hello Friend', 'This is the body');
                    // Email.Send(TheMessage);
                    //Enum::"Email Scenario"::Default);







                end;






            }

            // action("Send For Review")
            // {
            //     Caption = 'Send For Review';
            //     Image = CreditMemo;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     Visible = true;

            //     //trigger OnAction()



            //     //begin

            //     //RefreshOnActivate := true;


            //     //end;
            //     // var
            //     //     AdvErr: Label 'Advocate not assigned for SOF review.';
            //     //     WritCaseHdr: Record "Writ/Case Header";
            //     //     SupportingDoc: Record 50076;
            //     //     InvSetup: Record "Inventory Setup";
            //     //     //UserTab: Record "2000000120";  //DSC
            //     //     FileName: Text;
            //     //     RecepientID: Text;
            //     //     SenderName: Text;
            //     //     //SMTPMail: Codeunit "400";   //DSC
            //     //     //SMTPMailSetup: Record "409";  //DSC
            //     //     //TempBlob: Record "99008535";   //DSC
            //     //     FileMgt: Codeunit "File Management";
            //     //     Subject: Text[150];
            //     //     Body: Text[200];
            //     //     NVInStream: InStream;
            //     //     SendConfirm: Label 'Do you want to send email for SOF review ?';
            //     // begin
            //     //     REC.TESTFIELD("SOF Status", REC."SOF Status"::Created);
            //     //     REC.TESTFIELD("File No.");
            //     //     REC.TESTFIELD("Name Of Petitioner");

            //     //     // IF FileInProcess THEN  /DSC
            //     //     //     ERROR(Text003);

            //     //     IF NOT CONFIRM(SendConfirm) THEN
            //     //         EXIT;

            //     //     AdvAssignEntry.RESET;
            //     //     AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", "File No.");
            //     //     AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //     //     AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //     //     AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Reviewer);
            //     //     AdvAssignEntry.SETRANGE(Active, TRUE);
            //     //     IF NOT AdvAssignEntry.FIND('-') THEN
            //     //         ERROR(AdvErr)
            //     //     ELSE BEGIN
            //     //         RecepientID := '';
            //     //         UserTab.RESET;
            //     //         UserTab.SETRANGE("User Name", USERID);
            //     //         IF UserTab.FIND('-') THEN
            //     //             SenderName := UserTab."Full Name";

            //     //         SMTPMailSetup.GET;
            //     //         Subject := 'Regarding SOF review for case no.-' + "File No.";
            //     //         Body := 'Dear Sir,';
            //     //         SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //     //         SMTPMail.AppendBody('<BR><BR>');
            //     //         SMTPMail.AppendBody('Please find attached documents.');
            //     //         SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //     //         SMTPMail.AppendBody('<BR><BR><BR>');
            //     //         SMTPMail.AppendBody('Thanks & Regards');
            //     //         SMTPMail.AppendBody('<BR><BR>');
            //     //         SMTPMail.AppendBody(SenderName);
            //     //         SMTPMail.AppendBody('<BR>');
            //     //         SMTPMail.AppendBody('Bihar School Examination Board');
            //     //         REPEAT
            //     //             IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //     //                 IF AdvMaster."Email ID" <> '' THEN
            //     //                     SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one reviewer
            //     //         UNTIL AdvAssignEntry.NEXT = 0;
            //     //         InvSetup.GET;
            //     //         WritCaseHdr.RESET;
            //     //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //     //         IF WritCaseHdr.FIND('-') THEN
            //     //             IF rec."File Name" <> '' THEN
            //     //                 SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name", "File Name");

            //     //         AdvAssignEntry2.RESET;                                      //SOF document
            //     //         AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
            //     //         AdvAssignEntry2.SETRANGE("File No.", rec."File No.");
            //     //         AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
            //     //         AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
            //     //         AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Creator);
            //     //         AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
            //     //         AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
            //     //         IF AdvAssignEntry2.FIND('-') THEN BEGIN
            //     //             REPEAT
            //     //                 IF AdvAssignEntry2."SOF File Name" <> '' THEN
            //     //                     SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"), AdvAssignEntry2."SOF File Name");
            //     //             UNTIL AdvAssignEntry2.NEXT = 0;
            //     //         END;

            //     //         SupportingDoc.RESET;
            //     //         SupportingDoc.SETRANGE("Document No.", rec."File No.");
            //     //         IF SupportingDoc.FIND('-') THEN BEGIN

            //     //             REPEAT
            //     //                 IF SupportingDoc."File Name" <> '' THEN
            //     //                     SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
            //     //             UNTIL SupportingDoc.NEXT = 0;
            //     //         END;

            //     //         rec."SOF Status" := rec."SOF Status"::"Under Review";
            //     //         rec.MODIFY(TRUE);
            //     //         REPEAT
            //     //             AdvAssignEntry1.INIT;
            //     //             AdvAssignEntry1."File No." := rec."File No.";
            //     //             AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //     //             AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //     //             AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //     //             AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //     //             AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //     //             AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //     //             AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //     //             AdvAssignEntry1.VALIDATE(Active, TRUE);
            //     //             AdvAssignEntry1.INSERT(TRUE);
            //     //         UNTIL AdvAssignEntry.NEXT = 0;

            //     //         SMTPMail.SendBSEB('LEGAL');
            //     //         MESSAGE(SentSuccessfully);
            //     //     END;
            //     //     LegalCommentLine.RESET;
            //     //     LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //     //     LegalCommentLine.SETRANGE("Document No.", rec."File No.");
            //     //     LegalCommentLine.SETRANGE(Active, FALSE);
            //     //     IF LegalCommentLine.FIND('-') THEN BEGIN
            //     //         REPEAT
            //     //             LegalCommentLine.Active := TRUE;
            //     //             LegalCommentLine.MODIFY;
            //     //         UNTIL LegalCommentLine.NEXT = 0;
            //     //END;

            //     //end;

            // }
            action("Send to Review")
            {


                trigger OnAction()


                var
                    AdvErr: Label 'Advocate not assigned for SOF creation.';
                    WritCaseHdr: Record "Writ/Case Header";
                    SupportingDoc: Record "Supporting Document";
                    InvSetup: Record "Inventory Setup";
                    UserTab: Record "User BOC";
                    RecepientID: Text;
                    SenderName: Text;
                    EMAIL1: Codeunit 8901;
                    EmailMessage1: Codeunit 8904;
                    //TempBlob: Record TempBlob;  //dsc
                    FileMgt: Codeunit "File Management";
                    Subject: Text[150];
                    Body: Text[200];
                    NVInStream: InStream;
                    SendConfirm: Label 'Do you want to send email for SOF creation ?';


                begin

                    //REC.TESTFIELD("SOF Status","SOF Status"::'');
                    rec.TESTFIELD("File No.");
                    rec.TESTFIELD("Name Of Petitioner");
                    FileMovEntry.RESET;
                    FileMovEntry.SETRANGE("Document No.", rec."File No.");
                    IF NOT FileMovEntry.FIND('-') THEN
                        ERROR('SOF data not collected from any section');
                    // IF rFileInProcess THEN  //DSC
                    // ERROR(Text003);

                    IF NOT CONFIRM(SendConfirm) THEN BEGIN
                        CurrPage.CLOSE;
                        EXIT;
                    END;

                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", rec."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                    AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
                    AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
                    AdvAssignEntry.SETRANGE(Active, TRUE);
                    IF NOT AdvAssignEntry.FINDSET THEN
                        ERROR(AdvErr)
                    ELSE BEGIN
                        RecepientID := '';
                        UserTab.RESET;
                        UserTab.SETRANGE("User Name", USERID);
                        IF UserTab.FIND('-') THEN
                            SenderName := UserTab."Full Name";
                        Subject := 'Regarding SOF preparation for case no.-' + rec."File No.";
                        Body := 'Dear Sir,';

                        //Message('%1', Subject);
                        EmailMessage1.Create('', 'Payment Details' + FORMAT(TODAY), Body);






                    end;

                end;






            }




            // action("Send For Creation")
            // {
            //     Caption = 'Send For Creation';
            //     Image = CreditMemo;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     Visible = true;

            //              trigger OnAction()
            //              var
            //              AdvErr: Label 'Advocate not assigned for SOF creation.';
            //              WritCaseHdr: Record "Writ/Case Header";
            //              SupportingDoc: Record "Supporting Document";
            //              InvSetup: Record "Inventory Setup";
            //              UserTab: Record "User BOC";                         FileName: Text;
            //                      RecepientID: Text;
            //                     SenderName: Text;
            //                     //SMTPMail: Codeunit 400; //DSC
            //                     //SMTPMailSetup: Record "409";//DSC
            //                     //TempBlob: Record "99008535";//DSC
            //                     FileMgt: Codeunit "File Management";
            //                      Subject: Text[150];
            //                      Body: Text[200];
            //                     NVInStream: InStream;
            //             SendConfirm: Label 'Do you want to send email for SOF creation ?';
            //              begin
            //           //REC.TESTFIELD("SOF Status","SOF Status"::" ");//DSC
            //                  rec.TESTFIELD("File No.");
            //                  rec.TESTFIELD("Name Of Petitioner");
            //                  FileMovEntry.RESET;
            //                 FileMovEntry.SETRANGE("Document No.", rec."File No.");
            //                 IF NOT FileMovEntry.FIND('-') THEN
            //                   ERROR('SOF data not collected from any section');
            //                 //IF rFileInProcess THEN  //DSC
            //              //             ERROR(Text003);

            //                  IF NOT CONFIRM(SendConfirm) THEN BEGIN
            //                     CurrPage.CLOSE;
            //                     EXIT;
            //                   END;

            //                  AdvAssignEntry.RESET;
            //                  AdvAssignEntry.SETRANGE(AdvAssignEntry."File No.", rec."File No.");
            //                  AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
            //                  AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::Internal);
            //                  AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
            //                  AdvAssignEntry.SETRANGE(Active, TRUE);
            //                  IF NOT AdvAssignEntry.FINDSET THEN
            //                      ERROR(AdvErr)
            //                ELSE BEGIN
            //                 RecepientID := '';
            //                 UserTab.RESET;
            //                 UserTab.SETRANGE("User Name", USERID);
            //                     IF UserTab.FIND('-') THEN
            //                       SenderName := UserTab."Full Name";

            //                     SMTPMailSetup.GET;
            //                      Subject := 'Regarding SOF preparation for case no.-' + "File No.";
            //                      Body := 'Dear Sir,';
            //                      SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
            //                      SMTPMail.AppendBody('<BR><BR>');
            //                      SMTPMail.AppendBody('Please find attached documents.');
            //                      SMTPMail.AppendBody('<BR>');
            //                     SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
            //                      SMTPMail.AppendBody('<BR><BR><BR>');
            //                      SMTPMail.AppendBody('Thanks & Regards');
            //                      SMTPMail.AppendBody('<BR><BR>');
            //                   SMTPMail.AppendBody(SenderName);
            //                      SMTPMail.AppendBody('<BR>');
            //                      SMTPMail.AppendBody('Bihar School Examination Board');
            //                      REPEAT
            //                          IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
            //                              IF AdvMaster."Email ID" <> '' THEN
            //                                  SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
            //                      UNTIL AdvAssignEntry.NEXT = 0;
            //                      InvSetup.GET;
            //                      WritCaseHdr.RESET;
            //                      WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //                      IF WritCaseHdr.FIND('-') THEN
            //                          IF "File Name" <> '' THEN
            //                             SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name", "File Name");
            //                      SupportingDoc.RESET;
            //                      SupportingDoc.SETRANGE("Document No.", "File No.");
            //             //             IF SupportingDoc.FIND('-') THEN BEGIN

            //                         REPEAT
            //                              IF SupportingDoc."File Name" <> '' THEN
            //                                 SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
            //                        UNTIL SupportingDoc.NEXT = 0;
            //                     END;

            //                     "SOF Status" := "SOF Status"::"Under Preparation";
            //                     MODIFY(TRUE);
            //                REPEAT
            //                        AdvAssignEntry1.INIT;
            //                       AdvAssignEntry1."File No." := "File No.";
            //                         AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::SOF;
            //                       AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
            //                       AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
            //                        AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type");
            //                         AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
            //                          AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
            //                         AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
            //                        AdvAssignEntry1.VALIDATE(Active, TRUE);
            //                        AdvAssignEntry1.INSERT(TRUE);
            //                     UNTIL AdvAssignEntry.NEXT = 0;

            //                     SMTPMail.SendBSEB('LEGAL');
            //                      MESSAGE(SentSuccessfully);
            //                 END;

            //                 LegalCommentLine.RESET;
            //                  LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
            //                 LegalCommentLine.SETRANGE("Document No.", "File No.");
            //                  LegalCommentLine.SETRANGE(Active, FALSE);
            //                  IF LegalCommentLine.FIND('-') THEN BEGIN
            //                      REPEAT
            //                          LegalCommentLine.Active := TRUE;
            //                         LegalCommentLine.MODIFY;
            //                      UNTIL LegalCommentLine.NEXT = 0;
            //                  END;

            //            end;

            //}


            action("Send To External Advocate")
            {
                // Image = Email;
                // Promoted = true;
                // PromotedCategory = Process;
                // Visible = true;

                // trigger OnAction()
                // var
                //     AdvErr: Label 'Extrenal Advocate not assigned.';
                //     WritCaseHdr: Record 50203;
                //     SupportingDoc: Record 50076;
                //     InvSetup: Record "Inventory Setup";
                //     UserTab: Record 2000000120;
                //     FileName: Text;
                //     RecepientID: Text;
                //     SenderName: Text;
                //     // SMTPMail: Codeunit "400";
                //     // SMTPMailSetup: Record "409";
                //     // TempBlob: Record "99008535";
                //     FileMgt: Codeunit 419;
                //     Subject: Text[150];
                //     Body: Text[200];
                //     NVInStream: InStream;
                // begin
                //     rec.TESTFIELD("SOF Status", rec."SOF Status"::Approved);
                //     IF Rec.FileInProcess THEN
                //         ERROR(Text003);

                //     IF NOT CONFIRM(Text004) THEN
                //         EXIT;
                //     AdvAssignEntry.RESET;
                //     AdvAssignEntry.SETRANGE("File No.", rec."File No.");
                //     AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                //     AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::External);
                //     AdvAssignEntry.SETRANGE(Active, TRUE);
                //     IF NOT AdvAssignEntry.FIND('-') THEN
                //         ERROR(AdvErr)
                //     ELSE BEGIN
                //         RecepientID := '';
                //         UserTab.RESET;
                //         UserTab.SETRANGE("User Name", USERID);
                //         IF UserTab.FIND('-') THEN
                //             SenderName := UserTab."Full Name";

                //         SMTPMailSetup.GET;
                //         Subject := 'Regarding New case no.-' + rec."File No.";
                //         Body := 'Dear Sir,';
                //         SMTPMail.CreateMessage(FORMAT(USERID), SMTPMailSetup."User ID", RecepientID, Subject, Body, TRUE);
                //         SMTPMail.AppendBody('<BR><BR>');
                //         SMTPMail.AppendBody('Please find attached documents of new case');
                //         SMTPMail.AppendBody('Remarks - ' + AdvAssignEntry.Remarks);
                //         SMTPMail.AppendBody('<BR><BR><BR>');
                //         SMTPMail.AppendBody('Thanks & Regards');
                //         SMTPMail.AppendBody('<BR><BR>');
                //         SMTPMail.AppendBody(SenderName);
                //         SMTPMail.AppendBody('<BR>');
                //         SMTPMail.AppendBody('Bihar School Examination Board');
                //         REPEAT
                //             IF AdvMaster.GET(AdvAssignEntry."Advocate Code") THEN
                //                 IF AdvMaster."Email ID" <> '' THEN
                //                     SMTPMail.AddRecipients(AdvMaster."Email ID");           //For maore than one advocate
                //         UNTIL AdvAssignEntry.NEXT = 0;

                //         InvSetup.GET;
                //         WritCaseHdr.RESET;
                //         WritCaseHdr.SETRANGE("File No.", rec."File No.");
                //         IF WritCaseHdr.FIND('-') THEN
                //             IF rec."File Name" <> '' THEN
                //                 //   SMTPMail.AddAttachment(InvSetup."Writ Case Write Path" + "File Name","File Name");   //19-11-2019

                //                 AdvAssignEntry2.RESET;                                      //SOF document
                //         AdvAssignEntry2.SETCURRENTKEY("File No.", "Line No.");
                //         AdvAssignEntry2.SETRANGE("File No.", rec."File No.");
                //         AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::SOF);
                //         AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::Internal);
                //         AdvAssignEntry2.SETRANGE("Internal Adv. Type", AdvAssignEntry2."Internal Adv. Type"::Reviewer);
                //         AdvAssignEntry2.SETRANGE("SOF Received", TRUE);
                //         AdvAssignEntry2.SETRANGE("Created/Reviewed SOF", TRUE);
                //         IF AdvAssignEntry2.FIND('-') THEN BEGIN
                //             REPEAT
                //                 IF AdvAssignEntry2."SOF File Name" <> '' THEN
                //                     SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + AdvAssignEntry2."SOF File Name"), AdvAssignEntry2."SOF File Name");
                //             UNTIL AdvAssignEntry2.NEXT = 0;
                //         END;

                //         SupportingDoc.RESET;
                //         SupportingDoc.SETRANGE("Document No.", rec."File No.");
                //         SupportingDoc.SETRANGE(SupportingDoc."Legal File Type", SupportingDoc."Legal File Type"::Annexure);
                //         IF SupportingDoc.FIND('-') THEN BEGIN

                //             REPEAT
                //                 IF SupportingDoc."File Name" <> '' THEN
                //                     SMTPMail.AddAttachment((InvSetup."Writ Case Write Path" + SupportingDoc."File Name"), SupportingDoc."File Name");
                //             UNTIL SupportingDoc.NEXT = 0;
                //         END;

                //         rec.Status := rec.Status::Ongoing;
                //         rec.MODIFY(TRUE);
                //         REPEAT
                //             AdvAssignEntry1.INIT;
                //             AdvAssignEntry1."File No." := rec."File No.";
                //             AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::"Sent To External";
                //             AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
                //             AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
                //             AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::" ");
                //             AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
                //             AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
                //             AdvAssignEntry1.VALIDATE("SOF Sending Date", WORKDATE);
                //             AdvAssignEntry1.VALIDATE("Sent To External Adv.", TRUE);
                //             AdvAssignEntry1.VALIDATE("Sent To External Date", WORKDATE);
                //             AdvAssignEntry1.VALIDATE(Active, TRUE);
                //             AdvAssignEntry1.INSERT(TRUE);
                //         UNTIL AdvAssignEntry.NEXT = 0;
                //         SMTPMail.SendBSEB('LEGAL');
                //         MESSAGE(SentSuccessfully);
                //     END;
                //     LegalCommentLine.RESET;
                //     LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
                //     LegalCommentLine.SETRANGE("Document No.", rec."File No.");
                //     LegalCommentLine.SETRANGE(Active, FALSE);
                //     IF LegalCommentLine.FIND('-') THEN BEGIN
                //         REPEAT
                //             LegalCommentLine.Active := TRUE;
                //             LegalCommentLine.MODIFY;
                //         UNTIL LegalCommentLine.NEXT = 0;
                //     END;

                // end;
            }


            action("Hearing Details")
            {
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //rec.TESTFIELD("First Hearing Date");
                    CaseHearingEntry.RESET;
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", rec."File No.");
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
                    rec.TESTFIELD("Case Filing Date");
                    rec.TESTFIELD("BSEB Receiving Date");
                    rec.TESTFIELD("Name Of Petitioner");
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Global Dimension 1 Code");
                    rec.TESTFIELD("Global Dimension 2 Code");
                    rec.TESTFIELD("Disposed Date");
                    rec.TESTFIELD("Verdict Date");
                    rec.TESTFIELD("Disposed Remarks");

                    // IF FileInProcess THEN        //DSC
                    //     ERROR(Text003);
                    // IF NOT CONFIRM(Text007) THEN
                    //     EXIT;

                    rec.Status := rec.Status::Disposed;
                    rec.Disposed := TRUE;
                    rec."Disposed Date" := WORKDATE;
                    rec.MODIFY(TRUE);

                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
                    AdvAssignEntry.SETRANGE("File No.", rec."File No.");
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
                Caption = 'Send For Approval';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FileMovementEntry: Record 50215;
                    AdvAssigmentEntry: Record "Advocate Assigning Entry";
                    SOFApprovalEntry: Record 50214;
                    SeqNo: Integer;
                    RecID: RecordID;
                    UserSetup: Record "User Setup";
                    AppConfirm: Label 'Do you want to send SOF for approval ?';
                    PrevUser: Code[50];
                    SendToSection: Report 50123;
                begin
                    rec.TESTFIELD("SOF Status", rec."SOF Status"::Reviewed);
                    IF NOT CONFIRM(AppConfirm) THEN
                        EXIT;

                    CLEAR(SendToSection);  //DSC
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToSection.SETTABLEVIEW(WritCaseHdr);  //DSC
                        SendToSection.RUNMODAL; //DSC
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

                end;
            }

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
            //         ApprovalCommentLine: Record "Approval Comment Line";
            //     begin
            //         ApprovalCommentLine.SETRANGE("Table ID", 50203);
            //         ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
            //         PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
            //     end;
            // }


            action("Send Order To Section")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                var

                    //SendToSection: Report 50123;
                    SendToSection: Report 50131;   //dscomment
                    Text001: Label 'Document not found.';
                begin
                    rec.TESTFIELD("Name Of Petitioner");
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Global Dimension 1 Code");
                    rec.TESTFIELD("Global Dimension 2 Code");
                    rec.TESTFIELD("Verdict Date");
                    rec.TESTFIELD("Verdict File Name");
                    CLEAR(SendToSection);
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToSection.SETTABLEVIEW(WritCaseHdr);
                        SendToSection.RUNMODAL;
                    END ELSE
                        ERROR(Text001);



                end;
            }

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
                    PAGE.RUN(50385, LegalComment);
                end;
            }
            group(Attachments11)
            {
                Caption = 'Attachments';
                group(Attachments13)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    ToolTip = 'Attachments';
                    action("Attach File")
                    {
                        Caption = 'Attach Writ/Case';
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin
                            InvSetup.GET;
                            filedire.GET;
                            OldFileName := '';
                            //OldFileName := (InvSetup."Writ Case Write Path" + rec."File Name");
                            OldFileName := (filedire."Writ Case Write Path" + rec."File Name");
                            ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                            ClientFileName := FileManagement.GetFileName(ServerFileName);
                            FileExtension := FileManagement.GetExtension(ServerFileName);
                            IF ClientFileName <> '' THEN BEGIN
                                rec."File Name" := DELCHR(rec."File No.", '=', '/') + '_W_' + ClientFileName;
                                rec."File Extension" := FileExtension;
                                rec.MODIFY(TRUE);
                            END ELSE BEGIN
                                rec."File Name" := '';
                                rec."File Extension" := '';
                                rec.MODIFY(TRUE);
                            END;
                            //ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(rec."File No.", '=', '/') + '_W_' + ClientFileName;
                            ClientFileName := filedire."Writ Case Write Path" + DELCHR(rec."File No.", '=', '/') + '_W_' + ClientFileName;
                            FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                            IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
                                FileManagement.DeleteServerFile(OldFileName);
                            IF rec."File Name" <> '' THEN
                                AttachedFile := Text001;
                        end;


                    }
                    action("Supplementary Writ")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin
                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachSupplementary(rec."File No.");

                        end;
                    }
                    action("Attach I.A")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachIA(rec."File No.");

                        end;
                    }
                    action("Attach Rejoinder")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachRejoinder(rec."File No.");

                        end;
                    }
                    action("Attach Note Sheet")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachNoteSheet(rec."File No.");

                        end;
                    }
                    action("Attach Annexure")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachAnnexure(rec."File No.");

                        end;
                    }
                    action("Supporting Document")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin

                            rec.TESTFIELD("File No.");
                            SupportDoc.AttachOther(rec."File No.");


                        end;
                    }
                    action("Verdict Document")
                    {
                        Image = Attach;
                        Promoted = false;

                        trigger OnAction()
                        begin
                            InvSetup.GET;
                            OldFileName := '';
                            OldFileName := (InvSetup."Writ Case Write Path" + rec."Verdict File Name");
                            ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                            ClientFileName := FileManagement.GetFileName(ServerFileName);
                            IF ClientFileName <> '' THEN BEGIN
                                rec."Verdict File Name" := DELCHR(rec."File No.", '=', '/') + '_V_' + ClientFileName;
                                rec.MODIFY(TRUE);
                            END ELSE BEGIN
                                rec."Verdict File Name" := '';
                                rec.MODIFY(TRUE);
                            END;
                            ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(rec."File No.", '=', '/') + '_V_' + ClientFileName;
                            FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                            IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
                                FileManagement.DeleteServerFile(OldFileName);
                            IF rec."Verdict File Name" <> '' THEN
                                VerdictAttachment := 'View';
                        end;
                    }
                }
            }
        }
    }





    trigger OnAfterGetCurrRecord()
    begin
        IF rec.District = 'OTHER' THEN
            DistNameEnable := TRUE
        ELSE
            DistNameEnable := FALSE;

        IF rec."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF rec."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';

        IF rec.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF rec."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF rec."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';

        IF rec.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;

    end;





    trigger OnOpenPage()
    begin
        IF rec."File Name" <> '' THEN
            AttachedFile := Text001
        ELSE
            AttachedFile := '';

        IF rec."Verdict File Name" <> '' THEN
            VerdictAttachment := Text001
        ELSE
            VerdictAttachment := '';




        IF rec."SOF Status" = rec."SOF Status"::Created THEN
            ApproveSOFVisible := FALSE
        ELSE
            ApproveSOFVisible := TRUE;

        IF rec.District = 'OTHER' THEN
            DistNameEnable := TRUE
        ELSE
            DistNameEnable := FALSE;

        IF rec.Description2 <> '' THEN
            ShowCompRemarks := TRUE
        ELSE
            ShowCompRemarks := FALSE;
    end;

    var
        Desc: Text[1000];
        Dscript: BigText;
        ServerFileName: Text;

        filedire: Record 50083;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        //ServerFileHelper: DotNet File;  //DSC
        OldFileName: Text;
        Text001: Label 'View';
        AttachedFile: Text;
        Text002: Label 'Do you want to replace attachment ?';
        AdvAssignEntry: Record "Advocate Assigning Entry";
        AdvAssignEntry1: Record "Advocate Assigning Entry";

        reccaseheadingentry: Record "Case Hearing Entry";
        AdvAssignEntry2: Record 50207;
        AdvMaster: Record Advocate;
        FileMovEntry: Record 50215;
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
        LegalCommentLine: Record "Legal Comment Line";
        email1: Codeunit "Email Message";

    local procedure DuplicateUser(DocNo: Code[20]; UserCode: Code[50]): Boolean
    var
        SOFApprovalEntry1: Record 50214;
    begin
        SOFApprovalEntry1.RESET;
        SOFApprovalEntry1.SETCURRENTKEY("Document No.", "Sequence No.");
        SOFApprovalEntry1.SETRANGE("Document No.", DocNo);
        SOFApprovalEntry1.SETRANGE("Approver ID", UserCode);
        SOFApprovalEntry1.SETFILTER(Status, '%1|%2', SOFApprovalEntry1.Status::Created, SOFApprovalEntry1.Status::Open);
        IF SOFApprovalEntry1.FIND('-') THEN
            EXIT(TRUE)
        //ELSE

    end;

}

