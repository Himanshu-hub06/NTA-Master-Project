page 50350 "Writ/Case List"
{
    CardPageID = "Writ/Case Card";
    Editable = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Status';
    RefreshOnActivate = true;
    SourceTable = "Writ/Case Header";
    SourceTableView = SORTING("File No.")
                      ORDER(Ascending)
                      WHERE(Disposed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; REC."File No.")
                {
                    StyleExpr = RedClr;
                    Width = 15;
                }
                field("Case Type"; REC."Case Type")
                {
                }
                field(Category; REC.Category)
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
                field("Case Filing Date"; REC."Case Filing Date")
                {
                }
                field("BSEB Receiving Date"; REC."BSEB Receiving Date")
                {
                }
                field(Priority; REC.Priority)
                {
                }
                field("SOF Status."; REC."SOF Status")
                {
                }
                field("First Hearing Date"; REC."First Hearing Date")
                {
                }
                field(Status; REC.Status)
                {
                }
                field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
                {
                }
                field("Location Code"; REC."Location Code")
                {
                }
                field(Disposed; Rec.Disposed)
                {

                }
            }
            group("Count Filter")
            {
                Caption = '*';

                Visible = true;
                field(COUNT; REC.COUNT)
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
            part(FileMovementEntry; 50399)
            {
                Caption = 'File Movement Status';
                SubPageLink = "Document No." = FIELD("File No.");
                SubPageView = SORTING("Document Type", "Document No.", "Line No.")
                               ORDER(Ascending);
            }
            part(DocFactBox; 50398)
            {
                Caption = 'Supporting Documents';
                SubPageLink = "Document No." = FIELD("File No.");
            }

            // part("SOF Approval Status"; 50397)
            // {
            //     Caption = 'SOF Approval Status';
            //     SubPageLink = "Sender Examination Code" = FIELD("File No.");
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action("SOF Status")
            {
                ApplicationArea = all;
                Image = Info;
                Promoted = true;
                PromotedCategory = Category4;
                //ApplicationArea=all;

                trigger OnAction()
                begin
                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETRANGE("File No.", REC."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                    IF AdvAssignEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"SOF Status list", AdvAssignEntry);
                end;
            }
            action("File Outward")
            {
                Caption = 'File Movement Status';
                Image = OrderList;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    FileMovEntry.RESET;
                    FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
                    FileMovEntry.SETRANGE("Document No.", REC."File No.");
                    IF FileMovEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry);
                end;
            }
            action("Hearing Details")
            {
                ApplicationArea = all;
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    CaseHearingEntry.RESET;
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE("Document No.", REC."File No.");
                    IF CaseHearingEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Hearing Details List", CaseHearingEntry);
                end;
            }
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
        }
    }

    trigger OnAfterGetRecord()
    begin
        RedClr := '';
        IF REC.Priority = REC.Priority::High THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := '';
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Examination Code" <> '' THEN
            rec.SETRANGE("User Exam Code", UserSetup."Examination Code");
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
}

