page 50386 "Writ/Case Card Arising out"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 50203;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; rec."File No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Court; rec.Court)
                {
                    Editable = false;
                }
                field("Court Name"; rec."Court Name")
                {
                    Editable = false;
                }
                field(Category; rec.Category)
                {
                    Editable = false;
                }
                field("Case Type"; rec."Case Type")
                {
                }
                field("Other Case Type"; rec."Other Case Type")
                {
                    Editable = false;
                }
                field("Case No."; rec."Case No.")
                {
                }
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                }
                field("Case Filing Date"; rec."Case Filing Date")
                {
                }
                field("BSEB Receiving Date"; rec."BSEB Receiving Date")
                {
                    Visible = true;
                }
                field(Priority; rec.Priority)
                {
                }
                field("Location Name"; rec."Location Name")
                {
                    Editable = false;
                }
                field("Examination Name"; rec."Examination Name")
                {
                    Editable = false;
                }
                field("Section Name"; rec."Section Name")
                {
                    Editable = false;
                }
                field("District Name"; rec."District Name")
                {
                    Editable = false;
                }
                field("First Hearing Date"; rec."First Hearing Date")
                {
                    Editable = false;
                }
                field("Next Hearing Date"; rec."Next Hearing Date")
                {
                }
                field("SOF Status"; rec."SOF Status")
                {
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Writ/Case Attachment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."File Name");
                    end;
                }
                field(Description1; rec.Description1)
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
            part("Supporting Documents"; "Supporting Doc Factbox")
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
                Visible = false;

                trigger OnAction()
                begin

                    SupportDoc.AttachNoteSheet(rec."File No.");

                end;
            }
            action("Attach Annexure")
            {
                Image = Attach;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin

                    SupportDoc.AttachAnnexure(rec."File No.");

                end;
            }
            action("Send To User")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    UserSetup.GET(USERID);
                    IF NOT UserSetup."Section Approver" THEN
                        ERROR(Text004);
                    IF NOT CONFIRM(Text005) THEN
                        EXIT;
                    WritCaseHdr.RESET;
                    WritCaseHdr.SETRANGE("File No.", rec."File No.");
                    IF WritCaseHdr.FINDFIRST THEN
                        REPORT.RUN(50124, TRUE, FALSE, WritCaseHdr);
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
                    UserSetup.GET(USERID);
                    IF NOT CONFIRM(Text002) THEN
                        EXIT;
                    //SendToBack();             HYc
                    CurrPage.CLOSE;
                end;
            }
            action(Comment)
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    LegalComment: Record 50213;
                begin
                    LegalComment.RESET;
                    LegalComment.SETRANGE("Document No.", rec."File No.");
                    PAGE.RUN(50175, LegalComment);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Section Approver" THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;

        IF rec."File Name" <> '' THEN
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
        //TempUserSetup: Record "50067";  HYC 190923
        UserSetup1: Record "User Setup";
        InvSetup: Record "Inventory Setup";
        UserSection: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        AttachedFile: Text;
        OldFileName: Text;
        ServerFileName: Text;
        CaseHearingEntry: Record "Case Hearing Entry";
}

