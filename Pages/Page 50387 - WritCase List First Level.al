page 50387 "Writ/Case List First Level"
{
    Caption = 'Writ/Case';
    //CardPageID = "Writ/Case Card First Level";   //HYC
    Editable = false;
    PageType = List;
    ApplicationArea = ALL;
    PromotedActionCategories = 'New,Process,Report,Status';
    RefreshOnActivate = true;
    SourceTable = 50203;
    SourceTableView = SORTING("Origin Date", "File No.")
                      ORDER(Descending);
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
                field(Priority; rec.Priority)
                {
                }
                field("SOF Status"; rec."SOF Status")
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
                    Editable = false;
                }
                field("Assigned User Name"; rec."Assigned User Name")
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

            //HYC 190923
            // part(FileMovementEntry; 50355)
            // {
            //     Caption = 'File Movement Status';
            //      SubPageLink = "Document No." = FIELD("File No.");
            //      SubPageView = SORTING("Document Type","Document No.","Line No.")     HYC
            //       ORDER(Ascending);                                          HYC
            // }
            part(DocFactBox; 50398)
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
            action("SOF Status1")
            {
                Caption = 'SOF Status';
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
                    FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
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

                    rec.TESTFIELD("File No.");
                    SupportDoc.AttachNoteSheet(rec."File No.");

                end;
            }
            action("Attach Annexure")
            {
                Image = Attach;
                Promoted = true;

                trigger OnAction()
                begin
                    rec.TESTFIELD("File No.");
                    SupportDoc.AttachAnnexure(rec."File No.");

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

        UpdateStyle;
        rec.CALCFIELDS("Next Hearing Date");
        IF rec."Origin Date" <> 0DT THEN
            DateTime := (rec."Origin Date" - ((1000 * 60) * 330))
        ELSE
            DateTime := 0DT
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        rec.FILTERGROUP(2);
        rec.SETRANGE("User Assigned", USERID);
        rec.CALCFIELDS("Next Hearing Date");
        IF rec.FINDFIRST THEN;
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

    local procedure UpdateStyle()
    begin
        RedClr := '';
        IF rec.Priority = rec.Priority::High THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := '';
    end;
}

