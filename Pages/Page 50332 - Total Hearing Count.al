page 50332 "Total Hearing Count"
{
    Caption = 'Hearing Date';
    PageType = CardPart;
    SourceTable = "Case Hearing Entry";

    layout
    {
        area(content)
        {

            cuegroup(casehearing1)
            {
                field("Next Hearing Date"; Rec."Next Hearing Date")
                {
                    Caption = 'Hearing Date';
                    Image = Funnel;
                    Style = Subordinate;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        UserSetup.GET(USERID);
                        CaseHearingEntry.RESET;
                        CaseHearingEntry.FILTERGROUP(2);
                        CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                        CaseHearingEntry.SETRANGE("Next Hearing Date", StartDate, EndDate);

                        CaseHearingEntry.FILTERGROUP(0);
                        IF CaseHearingEntry.FINDFIRST THEN
                            PAGE.RUN(50332, CaseHearingEntry);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        WritTab: Record "Writ/Case Header";
        RemindEntry: Record "Reminder Entry";
        CaseHearingEntry: Record "Case Hearing Entry";
        StartDate: Date;
        EndDate: Date;
        UserSetup: Record "User Setup";

    local procedure CountTotalHearing(): Integer
    begin
        UserSetup.GET(USERID);
        StartDate := CALCDATE('<-CM>', TODAY);
        EndDate := CALCDATE('<CM>', TODAY);
        CaseHearingEntry.RESET;
        CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
        CaseHearingEntry.SETRANGE("Next Hearing Date", StartDate, EndDate);
        //CaseHearingEntry.SETRANGE("User Exam Code",UserSetup."Examination Code");
        EXIT(CaseHearingEntry.COUNT);
    end;
}

