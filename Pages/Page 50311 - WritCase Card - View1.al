page 50311 "Writ/Case Card - View1"
{
    Caption = 'Writ/Case Card';
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
                field("File No"; rec."File No.")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    begin
                        IF rec."File No." = '' THEN
                            IF REC.AssistEdit(xRec) THEN
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

                    trigger OnValidate()
                    begin
                        IF xRec.Category <> rec.Category THEN
                            rec."Case Type" := '';
                    end;
                }
                field("Case Type"; rec."Case Type")
                {
                    Editable = false;
                }
                field("Other Case Type"; rec."Other Case Type")
                {
                    Editable = false;
                }
                field("Arising Out"; rec."Arising Out")
                {
                    TableRelation = "Writ/Case Header"."Case No.";

                    trigger OnValidate()
                    begin
                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE("Case No.", REC."Arising Out");
                        IF WritCaseHdr.FIND('-') THEN
                            REC."Arising Out Type" := WritCaseHdr."Case Type";
                    end;
                }
                field("Arising Out Type"; REC."Arising Out Type")
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
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Case Filing Date"; rec."Case Filing Date")
                {
                    Editable = false;
                }
                field("BSEB Receiving Date"; rec."BSEB Receiving Date")
                {
                    Editable = false;
                }
                field(Priority; rec.Priority)
                {
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Location Name"; rec."Location Name")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Examination Name"; rec."Examination Name")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Section Name"; rec."Section Name")
                {
                    Editable = false;
                }
                field(District; rec.District)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("District Name"; rec."District Name")
                {
                    Editable = false;
                }
                field("e-office File No."; rec."e-office File No.")
                {
                    Editable = false;
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





                group("Dispose Details")
                {
                    field("Disposed Date"; rec."Disposed Date")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    field("Verdict Date"; rec."Verdict Date")
                    {
                        Editable = false;
                        ShowMandatory = true;
                    }
                    //DSC
                    field("Verdict Attachment"; VerdictAttachment)
                    {
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            InvSetup.GET;
                            IF REC."Verdict File Name" <> '' THEN
                                HYPERLINK(InvSetup."Writ Case Read Path" + REC."Verdict File Name");
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
                    field("Compliance Remarks"; REC.Description2)
                    {
                        Editable = false;
                        MultiLine = true;
                        Visible = false;
                    }
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
            part(FileMovementEntry; 50399)
            {
                Caption = 'File Movement Status';
                SubPageLink = "Document No." = FIELD("File No.");
                SubPageView = SORTING("Document Type", "Document No.", "Line No.")
                              ORDER(Ascending);
            }


            // HYC 190923
            // part(DocFactBox; 50354)
            // {
            //     Caption = 'Supporting Documents';
            //     SubPageLink = "Document No."=FIELD("File No.");
            // }
            part("SOF Approval Status"; 50373)
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
            //HYC
            action("Reminder List")
            {
                Image = Reminder;
                Promoted = true;

                trigger OnAction()
                begin

                    RemindEntry.RESET;
                    //RemindEntry.SETCURRENTKEY("Reminder No.");   HYC190923
                    RemindEntry.FILTERGROUP(2);
                    RemindEntry.SETRANGE(RemindEntry."Document No.", rec."File No.");
                    RemindEntry.SETRANGE(Sent, TRUE);
                    IF RemindEntry.FIND('-') THEN
                        PAGE.RUNMODAL(50412, RemindEntry);

                end;
            }
            action(Comment)
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50175;
                RunPageLink = "Document No." = FIELD("File No.");
                RunPageMode = View;
                Visible = false;

                trigger OnAction()
                var
                    LegalComment: Record "Legal Comment Line";
                begin
                    // CLEAR(LegalCommentsPage);
                    // LegalCommentsPage.ACTIVATE(FALSE);
                    // LegalCommentsPage.EDITABLE(FALSE);
                    // LegalCommentsPage.LOOKUPMODE(TRUE);
                    // LegalComment.RESET;
                    // LegalComment.SETRANGE("Document No.","File No.");
                    // LegalCommentsPage.SETTABLEVIEW(LegalComment);
                    // LegalCommentsPage.RUN;
                    //
                    // //PAGE.RUN(50175,LegalComment);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF REC."File Name" <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnAfterGetRecord()
    begin
        IF REC."File Name" <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Section Approver" THEN
            SendToUserEnable := TRUE
        ELSE
            SendToUserEnable := FALSE;

        IF REC."File Name" <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';

        IF REC."Verdict File Name" <> '' THEN
            VerdictAttachment := 'View'
        ELSE
            VerdictAttachment := '';
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
        UserSetup: Record 91;
        SendToID: Code[50];
        TempUserSetup: Record "User Settings";
        UserSetup1: Record 91;
        InvSetup: Record 313;
        UserSection: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        AttachedFile: Text;
        OldFileName: Text;
        ServerFileName: Text;
        CaseHearingEntry: Record 50078;
        VerdictAttachment: Text;
        RemindEntry: Record "Reminder Entry";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LegalCommentsPage: Page 50385;
}

