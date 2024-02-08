report 50134 "Adv. Wise Case Assign Details"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = './Reports/Adv. Wise Case Assign Details.rdl';

    dataset
    {
        dataitem(ADVENTRY; "Advocate Assigning Entry")
        {
            DataItemTableView = SORTING("File No.", "Line No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Advocate Type", "Advocate Code", "Assigned Date";
            // column(FileNo_AdvocateAssigningEntry; REC."File No.")
            // {
            //     IncludeCaption = true;
            // }

            column(File_No_; "File No.")
            {

            }
            // column(AdvocateCode_AdvocateAssigningEntry;"Advocate Assigning Entry"."Advocate Code")
            // {
            //     IncludeCaption = true;
            // }

            column(Advocate_Code; "Advocate Code")
            {

            }
            // column(AdvocateName_AdvocateAssigningEntry;"Advocate Assigning Entry"."Advocate Name")
            // {
            // }

            column(Advocate_Name; "Advocate Name")
            {

            }
            // column(AdvocateType_AdvocateAssigningEntry;"Advocate Assigning Entry"."Advocate Type")
            // {
            // }
            column(Advocate_Type; "Advocate Type")
            {

            }

            // column(InternalAdvType_AdvocateAssigningEntry;"Advocate Assigning Entry"."Internal Adv. Type")
            // {
            // }
            column(Internal_Adv__Type; "Internal Adv. Type")
            {

            }

            column(PIC; CompanyInfo.Picture)
            { }
            // column(EntryType_AdvocateAssigningEntry;"Advocate Assigning Entry"."Entry Type")
            // {
            // }
            column(ReportFilter; ReportFilter)
            {
            }
            column(Petition_NAme; NameOfPetitioner)
            {
            }
            column(Case_No; "CaseNo.")
            {
            }
            column(Year; Year)
            {
            }
            column(Sr_No; SrNo)
            {
            }
            column(SectionName; SectionName)
            {
            }
            column(DistrictName; DistrictName)
            {
            }
            column(CaseType; CaseType)
            {
            }
            // column(AssignedDate_AdvocateAssigningEntry;"Advocate Assigning Entry"."Assigned Date")
            // {
            // }
            column(Assigned_Date; "Assigned Date")
            {

            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(UserExamCode; UserExamCode)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Writ_CaseHeader.RESET;
                Writ_CaseHeader.SETRANGE("File No.", ADVENTRY."File No.");
                IF Writ_CaseHeader.FINDFIRST THEN BEGIN
                    "CaseNo." := Writ_CaseHeader."Case No.";
                    NameOfPetitioner := Writ_CaseHeader."Name Of Petitioner";
                    Year := Writ_CaseHeader.Year;
                    SectionName := Writ_CaseHeader."Section Name";
                    DistrictName := Writ_CaseHeader."District Name";
                    CaseType := Writ_CaseHeader."Case Type";
                END;
            end;

            trigger OnPreDataItem()
            begin
                ReportFilter := ADVENTRY.GETFILTERS();
                IF UserExamCode = UserExamCode::"Legal Secondary" THEN
                    UserExCode := 'EXESEC'
                ELSE
                    IF UserExamCode = UserExamCode::"Legal Senior Secondary" THEN
                        UserExCode := 'EXESSEC';

                ADVENTRY.SETRANGE(ADVENTRY."Entry Type", ADVENTRY."Entry Type"::"Case Assign");
                IF UserExCode <> '' THEN
                    ADVENTRY.SETFILTER(ADVENTRY."User Exam Code", '=%1', UserExCode);
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
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        Writ_CaseHeader: Record 50203;
        CompanyInfo: Record "Company Information";
        Year: Integer;
        "CaseNo.": Code[20];
        CaseType: Text;
        NameOfPetitioner: Text;
        ReportFilter: Text;
        SrNo: Integer;
        SectionName: Text;
        DistrictName: Text;
        UserExamCode: Option " ","Legal Secondary","Legal Senior Secondary";
        UserExCode: Code[20];
}

