page 50383 "Writ/Case Card View-Order"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Writ/Case Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Type"; Rec."Case Type")
                {
                    Editable = false;
                }
                field("File No."; Rec."File No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Case No."; Rec."Case No.")
                {
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    Editable = false;
                }
                field("Name Of Petitioner"; Rec."Name Of Petitioner")
                {
                    Editable = false;
                }
                field("Arising Out"; Rec."Arising Out")
                {
                    Editable = false;
                }
                field("Arising Out Type"; Rec."Arising Out Type")
                {
                    Editable = false;
                }
                field("Case Filing Date"; Rec."Case Filing Date")
                {
                    Editable = false;
                }
                field("BSEB Receiving Date"; Rec."BSEB Receiving Date")
                {
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                    Editable = false;
                }
                field("Examination Name"; Rec."Examination Name")
                {
                    Editable = false;
                }
                field("Section Name"; Rec."Section Name")
                {
                    Editable = false;
                }
                field("District Name"; Rec."District Name")
                {
                    Editable = false;
                }
                field("First Hearing Date"; Rec."First Hearing Date")
                {
                    Editable = false;
                }
                field("Next Hearing Date"; Rec."Next Hearing Date")
                {
                    Editable = false;
                }
                field("SOF Status"; Rec."SOF Status")
                {
                    Editable = false;
                }

                //HYC

                // field(AttachedFile; Rec.AttachedFile)
                // {
                //     Caption = 'Writ/Case Attachment';
                //     Editable = false;

                //     trigger OnDrillDown()
                //     begin
                //         InvSetup.GET;
                //         IF "File Name" <> '' THEN
                //             HYPERLINK(InvSetup."Writ Case Read Path" + "File Name");
                //     end;
                // }
                field("Physical File Received"; Rec."Physical File Received")
                {
                }
                field(Description1; Rec.Description1)
                {
                    Caption = 'Synopsis';
                    Editable = false;
                    Importance = Additional;
                    MultiLine = true;
                }
            }
            group("Disposed Details")
            {
                field("Disposed Date"; Rec."Disposed Date")
                {
                    Editable = false;
                }
                field("Verdict Date"; Rec."Verdict Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("In Favour"; Rec."In Favour")
                {
                    Editable = false;
                }

                //HYC220923
                // field("Verdict Attachment"; rec.VerdictAttachment)
                // {
                //     Editable = false;

                //     trigger OnDrillDown()
                //     begin
                //         InvSetup.GET;
                //         IF "Verdict File Name" <> '' THEN
                //             HYPERLINK(InvSetup."Writ Case Read Path" + "Verdict File Name");
                //     end;
                // }
            }
            group("Complaince Action")
            {
                field("Action Followed"; Rec."Action Followed")
                {
                }
                field("Not Satisfactory"; Rec."Not Satisfactory")
                {
                }
                field("Compliance Remarks"; Rec.Description2)
                {
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            part("Supporting Documents"; 50398)
            {
                Caption = 'Supporting Documents';
                SubPageLink = "Document No." = FIELD("File No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Attach Note Sheet")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin
                    //UploadFile();

                    SupportDoc.AttachNoteSheet(Rec."File No.");

                end;
            }
            action("Attach Annexure")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin
                    //UploadFile();
                    /*
                    MyRecordRef.CLOSE;
                    MyRecordRef.OPEN(DATABASE::"Writ/Case Header");
                    MyRecordRef.SETRECFILTER;
                    SupportDoc.Import(MyRecordRef,Rec."File No.");
                    */
                    SupportDoc.AttachAnnexure(Rec."File No.");

                end;
            }
            action(Forward)
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    UserSetup.GET(USERID);
                    CLEAR(SendToUser);
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", rec."File No.");
                    IF WritCaseHdr.FINDFIRST THEN BEGIN
                        SendToUser.SETTABLEVIEW(WritCaseHdr);
                        SendToUser.SetSection(rec."Global Dimension 2 Code");
                        SendToUser.RUNMODAL;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("Send Back")
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    rec.TESTFIELD("Physical File Received", TRUE);
                    IF rec."Compliance Status" = rec."Compliance Status"::" " THEN
                        ERROR('Please choose complaince action');
                    UserSetup.GET(USERID);
                    IF NOT CONFIRM(Text002) THEN
                        EXIT;

                    //HCY
                    //SendToBack();
                    CurrPage.CLOSE;
                end;
            }
            action(Comment)
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LegalComment: Record 50213;
                begin
                    LegalComment.RESET;
                    LegalComment.SETRANGE("Document No.", rec."File No.");
                    PAGE.RUN(50385, LegalComment);
                end;
            }
            action("Send To Higher Authority")
            {
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Text0001: Label 'Secretary,Chairman';
                    Text0002: Label 'Send To - ';
                    Pos: Integer;
                    RecID: RecordID;
                    SOFApprovalEntry: Record 50214;
                    SOFApprovalEntry2: Record 50214;
                    ApproverID: Code[50];
                begin
                    Pos := STRMENU(Text0001, 1, Text0002);
                    CASE Pos OF
                        1:
                            ApproverID := 'SECRETARY';
                        2:
                            ApproverID := 'CHAIRMAN'
                    END;

                    //HCY

                    IF ApproverID <> '' THEN BEGIN
                        UserSetup.GET(USERID);
                        UserSetup1.GET(ApproverID);
                        FileMovementEntry.RESET;
                        FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                        FileMovementEntry.SETRANGE("Document No.", rec."File No.");
                        IF FileMovementEntry.FIND('+') THEN
                            LineNo := FileMovementEntry."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        FileMovementEntry.INIT;
                        FileMovementEntry."Document Type" := FileMovementEntry."Document Type"::Legal;
                        FileMovementEntry."Line No." := LineNo;
                        FileMovementEntry."Document No." := rec."File No.";
                        FileMovementEntry."Sender ID" := UserSetup."User ID";
                        FileMovementEntry.VALIDATE("Sender Examination Code", UserSetup."Examination Code");
                        FileMovementEntry.VALIDATE("Sender Location Code", UserSetup."Location Code");
                        FileMovementEntry.VALIDATE("Sender Section", UserSetup.Section);
                        FileMovementEntry."Sending Date" := TODAY;
                        FileMovementEntry."Receiver ID" := UserSetup1."User ID";
                        FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup1."Examination Code");
                        FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup1."Location Code");
                        FileMovementEntry.VALIDATE("Receiver Section", UserSetup1.Section);
                        FileMovementEntry."Record ID" := rec.RECORDID;
                        FileMovementEntry.Status := FileMovementEntry.Status::"In Process At Section";
                        FileMovementEntry."Sent For Compliance" := TRUE;
                        FileMovementEntry.INSERT(TRUE);

                        //.Net Notificaion Table Start;
                        ExtNotification.INIT;
                        ExtNotification."Module ID" := 68;
                        ExtNotification."View ID" := 3831;
                        ExtNotification."Action ID" := 14;

                        ExtUserMaster.RESET;
                        ExtUserMaster.SETRANGE("User Name", UserSetup."User ID");
                        IF ExtUserMaster.FIND('-') THEN
                            SenderIDInt := ExtUserMaster."User ID"
                        ELSE
                            ERROR('SenderID not found in UMS_User_Mst');

                        ExtNotification."Sender ID" := SenderIDInt;

                        ExtUserMaster.RESET;
                        ExtUserMaster.SETRANGE("User Name", UserSetup1."User ID");
                        IF ExtUserMaster.FIND('-') THEN
                            ReceiverIDInt := ExtUserMaster."User ID"
                        ELSE
                            ERROR('ReceiverID not found in UMS_User_Mst');

                        ExtNotification."Receiver ID" := ReceiverIDInt;
                        ExtNotification."Notification Type" := 'PROCESS';
                        ExtNotification.Message := 'Legal request pending for response';
                        ExtNotification.Status := 0;
                        ExtNotification."Read Status" := 0;
                        ExtNotification."Last Modified on" := CURRENTDATETIME;
                        ExtNotification."Last Modified by" := SenderIDInt;
                        ExtNotification.IsActive := 1;
                        ExtNotification.INSERT;
                        // .Net Notificaion Table
                    End;
                    FileMovementEntry.RESET;
                    FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                    FileMovementEntry.SETRANGE(FileMovementEntry."Document No.", rec."File No.");
                    IF FileMovementEntry.FIND('-') THEN BEGIN
                        REPEAT
                            FileMovementEntry."Current User" := UserSetup1."User ID";
                            FileMovementEntry.MODIFY;
                        UNTIL FileMovementEntry.NEXT = 0;
                    END;
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE("File No.", rec."File No.");
                    IF WritCaseHdr.FIND('-') THEN BEGIN
                        WritCaseHdr."Previous User" := USERID;
                        WritCaseHdr.Unread := TRUE;
                        WritCaseHdr."User Assigned" := UserSetup1."User ID";
                        WritCaseHdr.MODIFY;
                    END;
                    LegalCommentLine.RESET;
                    LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
                    LegalCommentLine.SETRANGE("Document No.", rec."File No.");
                    LegalCommentLine.SETRANGE(Active, FALSE);
                    IF LegalCommentLine.FIND('-') THEN BEGIN
                        REPEAT
                            LegalCommentLine.Active := TRUE;
                            LegalCommentLine.MODIFY;
                        UNTIL LegalCommentLine.NEXT = 0;
                    END;

                    MESSAGE('Sent successfully');
                    CurrPage.CLOSE;
                END;

            }
        }
    }

    trigger OnAfterGetCurrRecord()

    //HCY
    begin
        ApprovalUserGroup.RESET;
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE("User Id", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;
    end;



    trigger OnAfterGetRecord()
    begin
        //HCY
        //GetRecord();
        //temporary;
        ApprovalUserGroup.RESET;
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE("User Id", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;
    end;

    trigger OnOpenPage()



    begin
        UserSetup.GET(USERID);
        ApprovalUserGroup.RESET;
        //HCY220923
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE("User Id", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;

        IF rec."File Name" <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';

        IF rec."Verdict File Name" <> '' THEN
            VerdictAttachment := Text008
        ELSE
            VerdictAttachment := '';
    end;

    var
        Desc: Text[1000];
        Dscript: BigText;
        SupportDoc: Record 50076;
        MyRecordRef: RecordRef;
        Text001: Label 'Do you want to attach ';
        Text002: Label 'Do you want to send back.?';
        Text003: Label 'Document already send to %1.';
        Text004: Label 'You cannot send to other user. ';
        Text005: Label 'Do you want to send ?';
        Text006: Label 'Send To User cannot be blank.';
        Text007: Label 'Sent successfully.';
        SendToUserEnable: Boolean;
        UserSetup: Record 91;
        SendToID: Code[50];
        //TempUserSetup: Record 50067;
        UserSetup1: Record 91;
        UserSetup2: Record 91;
        InvSetup: Record 313;
        UserSection: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        AttachedFile: Text;
        OldFileName: Text;
        ServerFileName: Text;
        CaseHearingEntry: Record "Case Hearing Entry";
        VerdictAttachment: Text;
        Text008: Label 'View';
        FileMovementEntry: Record "File Movement Entry";
        LineNo: Integer;
        LegalCommentLine: Record "Legal Comment Line";
        ExtNotification: Record "External CSA Notification";
        ExtUserMaster: Record "External UMS User Master";
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        SendToUser: Report 50124;
        ApprovalUserGroup: Record "Approval User Group Member";
}

