page 50353 "Writ/Case Card View"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
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

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Court; REC.Court)
                {
                    Editable = false;
                    OptionCaption = ' ,Supreme Court of India,High Court of Patna,High Court of Jharkhand,Bihar Anudanit Shikshan Sansthan Pradhikar,Civil/Lower Court,Other High Court,State Appellate Authority';
                }
                field("Court Name"; REC."Court Name")
                {
                    Editable = false;
                }
                field(Category; REC.Category)
                {
                    Editable = false;
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

                    trigger OnDrillDown()
                    begin
                        IF REC."Arising Out" <> '' THEN BEGIN
                            WritCaseHdr.RESET;
                            WritCaseHdr.SETRANGE(WritCaseHdr."Case No.", REC."Arising Out");
                            IF WritCaseHdr.FIND('-') THEN
                                PAGE.RUN(50386, WritCaseHdr);
                        END;
                    end;
                }
                field("Arising Out Type"; REC."Arising Out Type")
                {
                    Editable = false;
                }
                field("Case No."; REC."Case No.")
                {
                    Editable = false;
                }
                field(Year; REC.Year)
                {
                    Editable = false;
                }
                field("Name Of Petitioner"; REC."Name Of Petitioner")
                {
                    Editable = false;
                }
                field("Case Filing Date"; REC."Case Filing Date")
                {
                    Editable = false;
                }
                field("BSEB Receiving Date"; REC."BSEB Receiving Date")
                {
                    Editable = false;
                    Visible = true;
                }
                field(Priority; REC.Priority)
                {
                    Editable = false;
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
                        IF REC."File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + REC."File Name");
                    end;
                }
                field("Physical File Received"; REC."Physical File Received")
                {
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

                    SupportDoc.AttachNoteSheet(REC."File No.");

                end;
            }
            action("Attach Annexure")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin

                    SupportDoc.AttachAnnexure(REC."File No.");

                end;
            }
            action("Attach Fact Document")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin

                    SupportDoc.AttachFact(REC."File No.");

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

                    //CLEAR(SendToUser); //DSC
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE(WritCaseHdr."File No.", REC."File No.");

                    //DSC 
                    //AS REPORT IS NOT TAG
                    // IF WritCaseHdr.FINDFIRST THEN BEGIN
                    //   SendToUser.SETTABLEVIEW(WritCaseHdr);
                    //   SendToUser.SetSection("Global Dimension 2 Code");
                    //   SendToUser.RUNMODAL;
                    // END;
                    // CurrPage.CLOSE;

                end;
            }
            action("Send Back To Legal")
            {
                Caption = 'Send Back';
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    UserSetup.GET(USERID);
                    //TESTFIELD("Physical File Received",TRUE);
                    IF NOT CONFIRM(Text002) THEN
                        EXIT;
                    //SendToBack();   //DSC 
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
                    LegalComment: Record "Legal Comment Line";
                begin
                    LegalComment.RESET;
                    LegalComment.SETRANGE("Document No.", REC."File No.");
                    PAGE.RUN(50385, LegalComment);
                end;
            }

            //DSC
            action("Reminder List")
            {
                Image = Reminder;
                Promoted = true;

                //     trigger OnAction()
                //     begin

                //         RemindEntry.RESET;
                //         RemindEntry.SETCURRENTKEY("Reminder No.");
                //         RemindEntry.FILTERGROUP(2);
                //         RemindEntry.SETRANGE("Document No.","File No.");
                //         RemindEntry.SETRANGE(Sent,TRUE);
                //         IF RemindEntry.FIND('-') THEN
                //           PAGE.RUNMODAL(50412,RemindEntry)
                //         ELSE
                //           MESSAGE('No reminder found against this file no.');

                //  end;
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
        ApprovalUserGroup.SETRANGE("User ID", USERID);
        ApprovalUserGroup.SETRANGE("Approval Permission", TRUE);
        IF ApprovalUserGroup.FIND('-') THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;

        IF REC."File Name" <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
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
        // TempUserSetup: Record 50067;
        UserSetup1: Record "User Setup";
        InvSetup: Record "Inventory Setup";
        UserSection: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        AttachedFile: Text;
        OldFileName: Text;
        ServerFileName: Text;
        CaseHearingEntry: Record "Case Hearing Entry";
        RemindEntry: Record "Reminder Entry";
        //SendToUser: Report "50124";  //DSC
        ApprovalUserGroup: Record 50082;
}

