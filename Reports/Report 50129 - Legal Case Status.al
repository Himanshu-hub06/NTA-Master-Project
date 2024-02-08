report 50129 "Legal Case Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Legal Case Status1.rdl';


    dataset
    {
        dataitem(WCHRD; 50203)
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);
            RequestFilterFields = "Case Filing Date", Court, Category, "Case Type", "Location Code";
            column(Year; WCHRD.Year)
            {
            }
            column(counter; Counter)
            {
            }
            column(CaseType_WritCaseHeader; WCHRD."Case Type")
            {
            }
            column(DispCounter; DisposeCounter)
            {
            }
            column(OngoingCounter; OngoingCounter)
            {
            }
            column(EndingDate; EndingDate)
            {
            }
            column(LocationCode_WritCaseHeader; WCHRD."Location Code")
            {
            }
            column(LocationName_WritCaseHeader; WCHRD."Location Name")
            {
            }
            column(NewCounter; NewCounter)
            {
            }
            column(ReportFilter; ReportFilter)
            {
            }
            column(SOFSentCounter; SOFSentCounter)
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(UserExamCode; UserExamCode)
            {
            }
            column(SOFPendingCounter; SOFPendingCounter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Counter := 1;

                IF WCHRD.Status = WCHRD.Status::Disposed THEN
                    DisposeCounter := 1
                ELSE
                    DisposeCounter := 0;

                IF WCHRD.Status = WCHRD.Status::Ongoing THEN
                    OngoingCounter := 1
                ELSE
                    OngoingCounter := 0;

                IF WCHRD.Status = WCHRD.Status::New THEN
                    NewCounter := 1
                ELSE
                    NewCounter := 0;

                IF WCHRD."SOF Status" = WCHRD."SOF Status"::"Under Preparation" THEN
                    SOFPendingCounter := 1
                ELSE
                    SOFPendingCounter := 0;

                AdvocateAssigningEntry.RESET;
                AdvocateAssigningEntry.SETRANGE("Advocate Type", AdvocateAssigningEntry."Advocate Type"::External);
                AdvocateAssigningEntry.SETRANGE("File No.", "File No.");
                AdvocateAssigningEntry.SETRANGE("Entry Type", AdvocateAssigningEntry."Entry Type"::"Sent To External");
                AdvocateAssigningEntry.SETRANGE("SOF Sent", TRUE);
                IF AdvocateAssigningEntry.FIND('-') THEN
                    SOFSentCounter := 1
                ELSE
                    SOFSentCounter := 0;
            end;

            trigger OnPreDataItem()
            begin
                ReportFilter := WCHRD.GETFILTERS();
                IF UserExamCode = UserExamCode::"Legal Secondary" THEN
                    UserExCode := 'EXESEC'
                ELSE
                    IF UserExamCode = UserExamCode::"Legal Senior Secondary" THEN
                        UserExCode := 'EXESSEC';
                IF UserExCode <> '' THEN
                    WCHRD.SETRANGE(WCHRD."User Exam Code", UserExCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Choose)
                {
                    field("Legal Section"; UserExamCode)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record 79;
        EndingDate: Date;
        Counter: Integer;
        DisposeCounter: Integer;
        OngoingCounter: Integer;
        NewCounter: Integer;
        Year: Integer;
        ReportFilter: Text;
        SOFSentCounter: Integer;
        AdvocateAssigningEntry: Record "Advocate Assigning Entry";
        UserExamCode: Option " ","Legal Secondary","Legal Senior Secondary";
        UserExCode: Code[20];
        SOFPendingCounter: Integer;
}

