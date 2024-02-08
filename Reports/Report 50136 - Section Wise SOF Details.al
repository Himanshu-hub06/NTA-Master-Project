report 50136 "Section Wise SOF Details"
{
    DefaultLayout = RDLC;


    RDLCLayout = './Reports/Section Wise SOF Details.rdl';

    dataset
    {
        dataitem(WCHRD; 50203)
        {
            RequestFilterFields = "Global Dimension 2 Code", Court, Category, "Case Type", "Case Filing Date", "SOF Status";
            column(ReportFIlters; ReportFIlters)
            {
            }
            // column(CaseType_WritCaseHeader;"Writ/Case Header"."Case Type")
            // {
            // }

            column(Case_Type; "Case Type")
            {

            }
            // column(Status_WritCaseHeader;"Writ/Case Header".Status)
            // {
            // }

            column(Status; Status)
            {

            }


            // column(Year_WritCaseHeader;"Writ/Case Header".Year)
            // {
            // }
            column(Year; Year)
            {

            }
            // column(SectionCode_WritCaseHeader;"Writ/Case Header"."Global Dimension 2 Code")
            // {
            // }
            column(Section_Name; "Section Name")
            {

            }
            // column(SectionName_WritCaseHeader;"Writ/Case Header"."Section Name")
            // {
            // }
            column(CPCount; CPCount)
            {

            }

            column(SOFSCount; SOFSCount)
            {
            }
            column(SWaitingCount; SWaitingCount)
            {
            }
            column(SPUPCount; SPUPCount)
            {
            }
            column(SPUVCount; SPUVCount)
            {
            }
            column(SPUACount; SPUACount)
            {
            }
            column(EndingDate; FORMAT(EndingDate, 0, '<day,2>-<month,2>-<year4>'))
            {
            }
            column(Grand_Total_Caption; Grand_Total_Caption)
            {
            }
            column(First_Hearing_Date; "First Hearing Date")
            {
            }
            column(Case_Filing_Date; "Case Filing Date")
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(UserExamCode; UserExamCode)
            {
            }
            column(CAFileCounter; CAFileCounter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CPCount := 0;
                SOFSCount := 0;
                SPUACount := 0;
                SPUPCount := 0;
                SWaitingCount := 0;
                CAFileCounter := 0;
                IF (WCHRD.Status = WCHRD.Status::Ongoing) THEN
                    CPCount := 1;

                IF WCHRD."SOF Status" = WCHRD."SOF Status"::"Under Preparation" THEN
                    SPUPCount := 1;

                IF WCHRD."SOF Status" = WCHRD."SOF Status"::"Pending for Approval" THEN
                    SPUACount := 1;

                IF WCHRD."SOF Status" = WCHRD."SOF Status"::" " THEN
                    SWaitingCount := 1;

                AdvocateAssigningEntry.RESET;
                AdvocateAssigningEntry.SETRANGE("Advocate Type", AdvocateAssigningEntry."Advocate Type"::External);
                AdvocateAssigningEntry.SETRANGE("File No.", "File No.");
                AdvocateAssigningEntry.SETRANGE("Entry Type", AdvocateAssigningEntry."Entry Type"::"Sent To External");
                AdvocateAssigningEntry.SETRANGE("SOF Sent", TRUE);
                IF AdvocateAssigningEntry.FIND('-') THEN
                    SOFSCount := 1;

                CaseHearingEntry.RESET;
                CaseHearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                CaseHearingEntry.SETRANGE("Document No.", "File No.");
                CaseHearingEntry.SETFILTER("Oath No.", '<>%1', '');
                IF CaseHearingEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CAFileCounter := CAFileCounter + 1;
                    UNTIL CaseHearingEntry.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                WCHRD.CALCFIELDS(WCHRD."First Hearing Date");
                ReportFIlters := WCHRD.GETFILTERS();
                WCHRD.SETFILTER(WCHRD.Status, '<>%1', WCHRD.Status::Disposed);

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
                    Caption = 'Choose';
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'End Date';
                        Visible = false;
                    }
                    field("Legal Section"; UserExamCode)
                    {
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            IF EndingDate = 0D THEN
                EndingDate := TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        ReportFIlters: Text;
        AdvocateAssigningEntry: Record "Advocate Assigning Entry";
        CompanyInfo: Record "Company Information";
        CaseHearingEntry: Record "Case Hearing Entry";
        SOFSCount: Integer;
        CPCount: Integer;
        SWaitingCount: Integer;
        SPUPCount: Integer;
        SPUVCount: Integer;
        SPUACount: Integer;
        SPFACount: Integer;
        EndingDate: Date;
        Grand_Total_Caption: Label 'GRAND TOTAL';
        UserExamCode: Option " ","Legal Secondary","Legal Senior Secondary";
        UserExCode: Code[20];
        CAFileCounter: Integer;
}

