page 50376 "SOF Approval Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Writ/Case Header";
    ApplicationArea = ALL;



    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; REC."File No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Court; REC.Court)
                {
                }
                field("Court Name"; REC."Court Name")
                {
                }
                field(Category; REC.Category)
                {
                }
                field("Case Type"; REC."Case Type")
                {
                }
                field("Case No."; REC."Case No.")
                {
                }
                field(Year; REC.Year)
                {
                }
                field("Name Of Petitioner"; REC."Name Of Petitioner")
                {
                }
                field("Arising Out"; REC."Arising Out")
                {
                    Editable = false;
                }
                field("Arising Out Type"; REC."Arising Out Type")
                {
                    Editable = false;
                }
                field("Case Filing Date"; REC."Case Filing Date")
                {
                }
                field("BSEB Receiving Date"; REC."BSEB Receiving Date")
                {
                    Visible = true;
                }
                field(Priority; REC.Priority)
                {
                }
                field("Location Name"; REC."Location Name")
                {
                    Editable = false;
                }
                field("Examination Name"; REC."Examination Name")
                {
                    Editable = false;
                }
                field("Section Name"; REC."Section Name")
                {
                    Editable = false;
                }
                field("District Name"; REC."District Name")
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
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Attachment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF REC."File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + REC."File Name");
                    end;
                }
                field(Description1; REC.Description1)
                {
                    Caption = 'Synopsis';
                    Editable = false;
                    Importance = Additional;
                    MultiLine = true;
                }
            }
        }

        // area(factboxes)
        // {
        //     part("Supporting Documents"; 50354)
        //     {
        //         Caption = 'Supporting Documents';
        //         SubPageLink = "Document No."=FIELD("File No.");
        //             Visible = true;
        //     }
        // }
    }

    actions
    {
        area(processing)
        {
            action("Reminder List")
            {
                Image = Reminder;
                Promoted = true;

                trigger OnAction()
                var
                    RemindEntry: Record "Reminder Entry";
                begin

                    RemindEntry.RESET;
                    RemindEntry.SETCURRENTKEY("Reminder No.");
                    RemindEntry.FILTERGROUP(2);
                    RemindEntry.SETRANGE("Document No.", REC."File No.");
                    RemindEntry.SETRANGE(Sent, TRUE);
                    IF RemindEntry.FIND('-') THEN
                        PAGE.RUNMODAL(50412, RemindEntry)
                    ELSE
                        MESSAGE('No reminder found against this file no.');

                end;
            }
            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalCommentLine: Record "Approval Comment Line";
                begin
                    ApprovalCommentLine.SETRANGE("Table ID", 50203);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"SOF Approval Comments", ApprovalCommentLine);
                end;
            }
            action("Download SOF")
            {
                Caption = 'SOF Document';
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
                    AdvAssignEntry.SETRANGE("File No.", REC."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
                    AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
                    AdvAssignEntry.SETRANGE("SOF Received", TRUE);
                    IF AdvAssignEntry.FIND('-') THEN BEGIN
                        IF AdvAssignEntry."SOF File Name" <> '' THEN BEGIN
                            InvSetup.GET;
                            OldFileName := AdvAssignEntry."SOF File Name";
                            ServerFileName := InvSetup."Writ Case Write Path" + AdvAssignEntry."SOF File Name";
                            DOWNLOAD(ServerFileName, '', '', '', OldFileName);
                        END;
                    END ELSE
                        ERROR('SOF document not found');
                end;
            }
            // action(Forward)
            // {
            //     Image = SendMail;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         UserSetup.GET(USERID);
            //         /*
            //         ApprovalUserGroup.RESET;
            //         ApprovalUserGroup.SETRANGE("Approval User Group Code",'LEGAL');
            //         ApprovalUserGroup.SETRANGE("User Name",USERID);
            //         ApprovalUserGroup.SETRANGE("Approval Permission",TRUE);
            //         IF NOT ApprovalUserGroup.FIND('-') THEN
            //           ERROR(Text004);
            //         */
            //         CLEAR(SendToUser);
            //         WritCaseHdr.RESET;
            //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.", "File No.");
            //         IF WritCaseHdr.FINDFIRST THEN BEGIN
            //             SendToUser.SETTABLEVIEW(WritCaseHdr);
            //             SendToUser.SetSection("Global Dimension 2 Code");
            //             SendToUser.RUNMODAL;
            //         END;
            //         CurrPage.CLOSE;

            //     end;
            // }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approval Mgmt";
                begin
                    REC.TESTFIELD("SOF Status", REC."SOF Status"::"Pending for Approval");
                    UserSetup.GET(USERID);
                    ApprovalUserGroup.RESET;
                    ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
                    ApprovalUserGroup.SETRANGE(Section, REC."Global Dimension 2 Code");
                    ApprovalUserGroup.SETRANGE(ApprovalUserGroup."User ID", USERID);
                    ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
                    IF NOT ApprovalUserGroup.FIND('-') THEN
                        ERROR('You do not have permision to approve SOF');

                    IF NOT CONFIRM(AppTxt) THEN
                        EXIT;

                    FileMovementEntry1.RESET;
                    FileMovementEntry1.SETRANGE("Document Type", FileMovementEntry1."Document Type"::Legal);
                    FileMovementEntry1.SETRANGE("Document No.", REC."File No.");
                    FileMovementEntry1.SETRANGE(Status, FileMovementEntry1.Status::Open);
                    FileMovementEntry1.SETRANGE("Sent For SOF Approval", TRUE);
                    FileMovementEntry1.SETRANGE("Receiver ID", USERID);
                    IF FileMovementEntry1.FINDFIRST THEN BEGIN
                        FileMovementEntry1."SOF Approval Status" := FileMovementEntry1."SOF Approval Status"::Approved;
                        FileMovementEntry1."SOF Approve/Reject By" := USERID;
                        FileMovementEntry1."SOF Approval DateTime" := CURRENTDATETIME;
                        FileMovementEntry1.MODIFY;
                    END;

                    REC."SOF Status" := REC."SOF Status"::Approved;
                    REC.MODIFY;
                    MESSAGE('Approved successfully');

                end;
            }
            action("Send Back")
            {
                Caption = 'Send Back';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    SOFAppEntry: Record "SOF Approval entry";
                    Text0003: Label 'Do you want to send back ?';
                    SendBackOnlyOpenRequestsErr: Label 'You can send back only open entry. ';
                    NotApproverUserErr: Label 'You are not authoeize person.';
                    SOFAppEntry1: Record 50214;

                begin
                    //IF NOT CONFIRM(Text0003) THEN  //DSC

                end;
            }


            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approval Mgmt";
                begin
                    REC.TESTFIELD("SOF Status", REC."SOF Status"::"Pending for Approval");
                    UserSetup.GET(USERID);
                    ApprovalUserGroup.RESET;
                    ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
                    ApprovalUserGroup.SETRANGE(Section, REC."Global Dimension 2 Code");
                    ApprovalUserGroup.SETRANGE(ApprovalUserGroup."User ID", USERID);
                    ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
                    IF NOT ApprovalUserGroup.FIND('-') THEN
                        ERROR('You do not have permision to approve or reject SOF');

                    IF NOT CONFIRM(Text008) THEN
                        EXIT;

                    FileMovementEntry1.RESET;
                    FileMovementEntry1.SETRANGE("Document Type", FileMovementEntry1."Document Type"::Legal);
                    FileMovementEntry1.SETRANGE("Document No.", REC."File No.");
                    FileMovementEntry1.SETRANGE(Status, FileMovementEntry1.Status::Open);
                    FileMovementEntry1.SETRANGE("Sent For SOF Approval", TRUE);
                    FileMovementEntry1.SETRANGE("Receiver ID", USERID);
                    IF FileMovementEntry1.FINDFIRST THEN BEGIN
                        FileMovementEntry1."SOF Approval Status" := FileMovementEntry1."SOF Approval Status"::Rejected;
                        FileMovementEntry1."SOF Approve/Reject By" := USERID;
                        FileMovementEntry1."SOF Approval DateTime" := CURRENTDATETIME;
                        FileMovementEntry1.MODIFY;
                    END;

                    REC."SOF Status" := REC."SOF Status"::Rejected;
                    REC.MODIFY;
                    MESSAGE('Rejected successfully');
                end;
            }
            // action("Send To User")
            // {
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         UserSetup.GET(USERID);
            //         ApprovalUserGroup.RESET;
            //         ApprovalUserGroup.SETRANGE("Approval User Group Code",'LEGAL');
            //         ApprovalUserGroup.SETRANGE(ApprovalUserGroup."User ID",USERID);
            //         ApprovalUserGroup.SETRANGE("Approval Permission",TRUE);
            //         IF NOT ApprovalUserGroup.FIND('-') THEN
            //           ERROR(Text004);
            //         IF NOT CONFIRM(Text005) THEN
            //           EXIT;

            //         CLEAR(SendToUser);
            //         WritCaseHdr.RESET;
            //         WritCaseHdr.SETRANGE(WritCaseHdr."File No.",REC."File No.");
            //         IF WritCaseHdr.FINDFIRST THEN BEGIN
            //           SendToUser.SETTABLEVIEW(WritCaseHdr);
            //           IF UserSetup.Section <> '' THEN
            //             SendToUser.SetSection(UserSetup.Section)
            //           ELSE
            //             SendToUser.SetSection("Global Dimension 2 Code");
            //            SendToUser.RUNMODAL;
            //         END;
            //         CurrPage.CLOSE;
            //     end;
            // }

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
                    SOFApprovalEntry: Record "SOF Approval entry";
                    SOFApprovalEntry2: Record "SOF Approval entry";
                    ApproverID: Code[50];
                begin
                    Pos := STRMENU(Text0001, 1, Text0002);
                    CASE Pos OF
                        1:
                            ApproverID := 'SECRETARY';
                        2:
                            ApproverID := 'CHAIRMAN'
                    END;
                    IF ApproverID <> '' THEN BEGIN
                        RecID := Rec.RECORDID;
                        SOFApprovalEntry2.RESET;
                        SOFApprovalEntry2.SETCURRENTKEY("Document No.", "Sequence No.");
                        SOFApprovalEntry2.SETRANGE("Document No.", REC."File No.");
                        SOFApprovalEntry2.SETRANGE("Approver ID", USERID);
                        SOFApprovalEntry2.SETRANGE(Status, SOFApprovalEntry2.Status::Open);
                        IF SOFApprovalEntry2.FIND('-') THEN BEGIN
                            //SeqNo:=SOFApprovalEntry2."Sequence No." + 1;
                            SOFApprovalEntry2.Status := SOFApprovalEntry2.Status::Created;
                            SOFApprovalEntry2.MODIFY(TRUE);
                        END;

                        SOFApprovalEntry.INIT;
                        SOFApprovalEntry."Table ID" := RecID.TABLENO;
                        SOFApprovalEntry."Document No." := REC."File No.";
                        SOFApprovalEntry."Sequence No." := SOFApprovalEntry.GetNextSeqNo(REC."File No.");
                        SOFApprovalEntry."Sender ID" := USERID;
                        SOFApprovalEntry."Approver ID" := ApproverID;
                        SOFApprovalEntry.Status := SOFApprovalEntry.Status::Open;
                        SOFApprovalEntry."Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
                        SOFApprovalEntry."Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
                        SOFApprovalEntry."Last Modified By User ID" := USERID;
                        SOFApprovalEntry."Record ID to Approve" := RecID;
                        SOFApprovalEntry.INSERT(TRUE);

                        UserSetup.GET(USERID);
                        UserSetup1.GET(ApproverID);
                        FileMovementEntry.RESET;
                        FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                        FileMovementEntry.SETRANGE("Document No.", REC."File No.");
                        IF FileMovementEntry.FIND('+') THEN
                            LineNo := FileMovementEntry."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        FileMovementEntry.INIT;
                        FileMovementEntry."Document Type" := FileMovementEntry."Document Type"::Legal;
                        FileMovementEntry."Line No." := LineNo;
                        FileMovementEntry."Document No." := REC."File No.";
                        FileMovementEntry."Sender ID" := UserSetup."User ID";
                        FileMovementEntry.VALIDATE("Sender Examination Code", UserSetup."Examination Code");
                        FileMovementEntry.VALIDATE("Sender Location Code", UserSetup."Location Code");
                        FileMovementEntry.VALIDATE("Sender Section", UserSetup.Section);
                        FileMovementEntry."Sending Date" := TODAY;
                        FileMovementEntry."Receiver ID" := UserSetup1."User ID";
                        FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup1."Examination Code");
                        FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup1."Location Code");
                        FileMovementEntry.VALIDATE("Receiver Section", UserSetup1.Section);
                        FileMovementEntry."Record ID" := REC.RECORDID;
                        FileMovementEntry.Status := FileMovementEntry.Status::"In Process At Section";
                        FileMovementEntry."Sent For SOF Approval" := TRUE;
                        FileMovementEntry.INSERT(TRUE);

                        //.Net Notificaion Table Start
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
                        //.Net Notificaion Table End
                        FileMovementEntry.RESET;
                        FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                        FileMovementEntry.SETRANGE(FileMovementEntry."Document No.", REC."File No.");
                        IF FileMovementEntry.FIND('-') THEN BEGIN
                            REPEAT
                                FileMovementEntry."Current User" := UserSetup1."User ID";
                                FileMovementEntry.MODIFY;
                            UNTIL FileMovementEntry.NEXT = 0;
                        END;
                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");
                        IF WritCaseHdr.FIND('-') THEN BEGIN
                            WritCaseHdr."Previous User" := USERID;
                            WritCaseHdr.Unread := TRUE;
                            WritCaseHdr."User Assigned" := UserSetup1."User ID";
                            WritCaseHdr.MODIFY;
                        END;
                        LegalCommentLine.RESET;
                        LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
                        LegalCommentLine.SETRANGE("Document No.", REC."File No.");
                        LegalCommentLine.SETRANGE(Active, FALSE);
                        IF LegalCommentLine.FIND('-') THEN BEGIN
                            REPEAT
                                LegalCommentLine.Active := TRUE;
                                LegalCommentLine.MODIFY;
                            UNTIL LegalCommentLine.NEXT = 0;
                        END;

                        MESSAGE('Sent successfully');
                        CurrPage.CLOSE;
                    END
                end;
            }
            action(Comment)
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LegalComment: Record "Legal Comment Line";
                begin
                    LegalComment.RESET;
                    LegalComment.SETRANGE("Document No.", REC."File No.");
                    PAGE.RUN(50385, LegalComment);
                end;
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    begin
        ApprovalUserGroup.RESET;
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE("User ID", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin
        ApprovalUserGroup.RESET;
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE("User ID", USERID);
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
        ApprovalUserGroup.SETRANGE("Approval User Group Code", 'LEGAL');
        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."User ID", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;

        IF rec."File Name" <> '' THEN
            AttachedFile := 'View';
    end;

    var
        Desc: Text[1000];
        Dscript: BigText;
        SupportDoc: Record "Supporting Document";
        MyRecordRef: RecordRef;
        Text001: Label 'Do you want to attach ';
        Text002: Label 'Do you want to send back.?';
        Text003: Label 'Document already send to %1.';
        Text004: Label 'You cannot send to other user. ';
        Text005: Label 'Do you want to send ?';
        Text006: Label 'Send To User cannot be blank.';
        Text007: Label 'Sent successfully.';
        SendToUserEnable: Boolean;
        UserSetup: Record "User Setup";
        SendToID: Code[50];
        //TempUserSetup: Record "50067";  //DSC
        UserSetup1: Record "User Setup";
        InvSetup: Record "Inventory Setup";
        UserSection: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        AttachedFile: Text;
        OldFileName: Text;
        ServerFileName: Text;
        CaseHearingEntry: Record "Case Hearing Entry";
        AdvAssignEntry: Record "Advocate Assigning Entry";
        AppTxt: Label 'Do you want to approve ?';
        SOFApprovalEntry: Record 50214;
        SOFApprovalEntr2: Record 50214;
        Text008: Label 'Do you want to reject ?';
        FileMovTab: Record "File Movement Entry";
        FileMovementEntry: Record "File Movement Entry";
        LineNo: Integer;
        ExtNotification: Record "External CSA Notification";
        ExtUserMaster: Record "External UMS User Master";
        LegalCommentLine: Record "Legal Comment Line";
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        //SendToUser: Report "50128";   //DSC
        ApprovalUserGroup: Record "Approval User Group Member";
        FileMovementEntry1: Record "File Movement Entry";
}

