page 50305 "Writ/Case List - All"
{
    CardPageID = "Writ/Case Card - View1";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Status';
    RefreshOnActivate = true;
    SourceTable = "Writ/Case Header";
    SourceTableView = SORTING("File No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No"; rec."File No.")
                {
                    StyleExpr = RedClr;
                    Width = 15;
                }
                field("Case Type"; rec."Case Type")
                {
                }
                field(Category; rec.Category)
                {
                }
                field("Case No."; rec."Case No.")
                {
                }
                field(Year; rec.Year)
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
                }
                field(Priority; rec.Priority)
                {
                }
                field("First Hearing Date"; rec."First Hearing Date")
                {
                }
                field("Next Hearing Date"; rec."Next Hearing Date")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                }
                field("Section Name"; rec."Section Name")
                {
                    Enabled = false;
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field("Location Name"; rec."Location Name")
                {
                    Enabled = false;
                }
                field("User Assigned"; rec."User Assigned")
                {
                }
                field("Assigned User Name"; rec."Assigned User Name")
                {
                    Enabled = false;
                }
                field("SOF Status."; rec."SOF Status")
                {
                    Enabled = false;
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; rec.COUNT)
                {
                    Caption = 'Total No. Of Records';
                    ColumnSpan = 3;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            // part(FileMovementEntry; 50143)
            // {
            //     Caption = 'File Movement Status';
            //     SubPageLink = "Document No."=FIELD("File No.");
            //         SubPageView = SORTING(Document Type,Document No.,Line No.)
            //                   ORDER(Ascending);
            // }



            //HYC 190923  

            // part(DocFactBox; 50142)
            // {
            //     Caption = 'Supporting Documents';
            //     SubPageLink = Document No.=FIELD("File No.");
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
            action("SOF Status")
            {
                Image = Info;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    AdvAssignEntry.RESET;
                    AdvAssignEntry.FILTERGROUP(2);
                    AdvAssignEntry.SETRANGE("File No.", rec."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
                    AdvAssignEntry.FILTERGROUP(0);
                    IF AdvAssignEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"SOF Status list", AdvAssignEntry);
                end;
            }
            action("File Outward")
            {
                Caption = 'File Movement Status';
                Image = OrderList;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FileMovEntry.RESET;
                    FileMovEntry.FILTERGROUP(2);

                    //  HYC 190923
                    //FileMovEntry.SETRANGE("Document No.",FileMovEntry."Document No."::Legal);
                    FileMovEntry.SETRANGE("Document No.", rec."File No.");
                    FileMovEntry.FILTERGROUP(0);
                    IF FileMovEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry);
                end;
            }
            action("Hearing Details List")
            {
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    CaseHearingEntry.RESET;
                    CaseHearingEntry.FILTERGROUP(2);
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE("Document No.", rec."File No.");
                    CaseHearingEntry.FILTERGROUP(0);
                    IF CaseHearingEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Hearing Details List", CaseHearingEntry);
                end;
            }
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
            action("Reminder List")
            {
                Image = Reminder;
                Promoted = true;

                trigger OnAction()
                begin

                    RemindEntry.RESET;
                    RemindEntry.SETCURRENTKEY("Reminder No.");
                    RemindEntry.SETRANGE("Document No.", rec."File No.");
                    IF RemindEntry.FIND('-') THEN
                        PAGE.RUNMODAL(50412, RemindEntry);

                end;
            }
            action("Hearing Details")
            {
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    CaseHearingEntry.RESET;
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE(CaseHearingEntry."Document No.", rec."File No.");
                    PAGE.RUN(50148, CaseHearingEntry);

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        rec.CALCFIELDS("Next Hearing Date");
    end;

    trigger OnAfterGetRecord()
    begin

        RedClr := '';
        IF rec.Priority = rec.Priority::High THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := '';

        rec.CALCFIELDS("Next Hearing Date");
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        //IF UserSetup."Examination Code" <> '' THEN
        //  SETRANGE("User Exam Code",UserSetup."Examination Code");
        rec.CALCFIELDS("Next Hearing Date");
    end;

    var
        WritHdr: Record "Writ/Case Header";
        UserSetup: Record "User Setup";
        ShowFileMovementFactBox: Boolean;
        ShowSuppDocFactBox: Boolean;
        AdvAssignEntry: Record "Advocate Assigning Entry";
        FileMovEntry: Record "File Movement Entry";
        Text001: Label 'Internal,External';
        CaseHearingEntry: Record "Case Hearing Entry";
        AdvType: Integer;
        RedClr: Text;
        SupportDoc: Record "Supporting Document";
        //LegalReminder: Report "50134";            HYC 190923
        RemindEntry: Record "Reminder Entry";
}

