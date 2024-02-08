page 50394 "Writ/Case - Ongoing"
{
    CardPageID = "Writ/Case Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Status';
    RefreshOnActivate = true;
    SourceTable = "Writ/Case Header";
    SourceTableView = SORTING("File No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Ongoing));
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; rec."File No.")
                {
                    StyleExpr = RedClr;
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
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                }
                field("Case Filing Date"; rec."Case Filing Date")
                {
                }
                field("Date Of Writ"; rec."Date Of Writ")
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
                field(Status; rec.Status)
                {
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                }
                field("Location Code"; rec."Location Code")
                {
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
                    AdvAssignEntry.SETRANGE("File No.", rec."File No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
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
                    FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
                    FileMovEntry.SETRANGE("Document No.", rec."File No.");
                    IF FileMovEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry);
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
                    CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                    CaseHearingEntry.SETRANGE("Document No.", rec."File No.");
                    IF CaseHearingEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Hearing Details List", CaseHearingEntry);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //ShowFileMovementFactBox := CurrPage.ApprovalCommentsFactBox.PAGE.SetRecIDFilter("Record ID to Approve");
        //ShowFileMovementFactBox:=CurrPage.FileMovementEntry.PAGE.FileMovementEntryExist("File No.");
        //ShowSuppDocFactBox:=CurrPage.DocFactBox.PAGE.SuppDocExist("File No.");
        RedClr := '';
        IF rec.Priority = rec.Priority::High THEN
            RedClr := 'Unfavorable'
        ELSE
            RedClr := '';
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
}

