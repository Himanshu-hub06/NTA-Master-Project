page 50303 "Writ/Case List -Top Level"
{
    Caption = 'Writ/Case List';
    //CardPageID = "Writ/Case Card- Top Level"; //PPC
    CardPageId = "Writ/Case List -Top Level";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Status';
    RefreshOnActivate = true;
    SourceTable = "Writ/Case Header";
    SourceTableView = SORTING("Origin Date")
                      ORDER(Descending)
                      WHERE(Disposed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
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
                field("Assign Advocate Name"; rec."Assign Advocate Name")
                {
                }
                field("Reviewer Advocate Name"; rec."Reviewer Advocate Name")
                {
                }
                field("External Advocate Name"; rec."External Advocate Name")
                {
                }
                field(Priority; rec.Priority)
                {
                }
                //  field(REC."SOF Status"; rec."SOF Status")
                //  {
                //  }
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
                field("Date Filter"; DateTime)
                {
                    Caption = 'DateTime Filter';
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
            part("Legal Comments"; 50310)
            {
                Caption = 'Legal Comments';
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
                        PAGE.RUN(PAGE::"SOF Status list", AdvAssignEntry)
                    ELSE
                        MESSAGE('Details not found');
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
                    //FileMovEntry.SETRANGE('Document Type',FileMovEntry,'Document Type'::Legal);
                    FileMovEntry.SETRANGE("Document No.", rec."File No.");

                    FileMovEntry.FILTERGROUP(0);
                    IF FileMovEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry)
                    ELSE
                        MESSAGE('Details not found');
                end;
            }
            action("Hearing Details")
            {
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    CaseHearingEntry.RESET;
                    CaseHearingEntry.FILTERGROUP(2);
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE("Document No.", rec."File No.");
                    CaseHearingEntry.FILTERGROUP(0);
                    IF CaseHearingEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Hearing Details List", CaseHearingEntry)
                    ELSE
                        MESSAGE('Details not found');
                end;
            }
            action("Attach Note Sheet")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin

                    SupportDoc.AttachNoteSheet(rec."File No.");

                end;
            }
            action("Attach Annexure")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin

                    SupportDoc.AttachAnnexure(rec."File No.");

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        rec.CALCFIELDS(rec."Next Hearing Date");
    end;

    trigger OnAfterGetRecord()
    begin

        RedClr := '';
        IF rec.Priority = rec.Priority::High THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := '';

        rec.CALCFIELDS("Next Hearing Date");//ppp
        IF rec."Origin Date" <> 0DT THEN//ppc
            DateTime := (rec."Origin Date" - ((1000 * 60) * 330))//ppp
        ELSE
            DateTime := 0DT
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        // FILTERGROUP(2);
        // SETRANGE("User Assigned",USERID);
        //IF UserSetup."Examination Code" <> '' THEN
        // SETRANGE("User Exam Code",UserSetup."Examination Code");
        rec.CALCFIELDS("Next Hearing Date");

        // IF FINDFIRST THEN;
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
        DateTime: DateTime;
}

