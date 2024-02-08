page 50333 "Case Hearing List"
{
    Caption = 'Hearing Details';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;

    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    PageType = List;
    SourceTable = "Case Hearing Entry";

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("Document No."; rec."Document No.")
                {
                    Caption = 'File No.';
                }
                field("Case No."; CaseNo)
                {
                }
                field(Year; Year)
                {
                }
                field("Next Hearing Date"; rec."Next Hearing Date")
                {
                    Caption = 'Hearing Date';
                }
                field(Remarks; rec.Remarks)
                {
                }
            }


        }

    }



    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        WritCaseHdr.RESET;
        WritCaseHdr.SETRANGE(WritCaseHdr."File No.", rec."Document No.");
        IF WritCaseHdr.FIND('-') THEN BEGIN
            CaseNo := WritCaseHdr."Case No.";
            Year := WritCaseHdr.Year;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        WritCaseHdr.RESET;
        WritCaseHdr.SETRANGE(WritCaseHdr."File No.", rec."Document No.");
        IF WritCaseHdr.FIND('-') THEN BEGIN
            CaseNo := WritCaseHdr."Case No.";
            Year := WritCaseHdr.Year;
        END;
    end;

    var
        CaseNo: Code[20];
        Year: Integer;
        WritCaseHdr: Record "Writ/Case Header";
}

