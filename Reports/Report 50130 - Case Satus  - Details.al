report 50130 "Case Satus  - Details"
{
    DefaultLayout = RDLC;

    RDLCLayout = './Reports/Case Satus  - Details.rdl';


    dataset
    {
        dataitem(WCHRD; 50203)
        {
            RequestFilterFields = Court, Category, "Case Type", "Case Filing Date", "Global Dimension 2 Code", "Global Dimension 1 Code";
            // column(FileNo_WritCaseHeader;"Writ/Case Header"."File No.")
            // {
            // }

            column(File_No_; "File No.")
            {

            }

            // column(CaseNo_WritCaseHeader;"Writ/Case Header"."Case No.")
            // {
            // }
            column(Case_No_; "Case No.")
            {

            }
            // column(CaseType_WritCaseHeader;"Writ/Case Header"."Case Type")
            // {
            // }

            column(Case_Type; "Case Type")
            {

            }
            // column(NameOfPetitioner_WritCaseHeader;"Writ/Case Header"."Name Of Petitioner")
            // {
            // }
            column(Name_Of_Petitioner; "Name Of Petitioner")
            {

            }
            // column(CaseFilingDate_WritCaseHeader;"Writ/Case Header"."Case Filing Date")
            // {
            // }
            column(Case_Filing_Date; "Case Filing Date")
            {

            }
            // column(BSEBReceivingDate_WritCaseHeader;"Writ/Case Header"."BSEB Receiving Date")
            // {
            // }

            column(BSEB_Receiving_Date; "BSEB Receiving Date")
            {

            }
            // column(LocationCode_WritCaseHeader;"Writ/Case Header"."Location Code")
            // {
            // }

            column(Location_Code; "Location Code")
            {

            }
            // column(LocationName_WritCaseHeader;"Writ/Case Header"."Location Name")
            // {
            // }

            column(Location_Name; "Location Name")
            {

            }
            column(First_Hearing_Date; "First Hearing Date")
            {

            }
            // column(FirstHearingDate_WritCaseHeader;"Writ/Case Header"."First Hearing Date")
            // {
            // }
            // column(NextHearingDate_WritCaseHeader;"Writ/Case Header"."Next Hearing Date")
            // {
            // }

            column(Next_Hearing_Date; "Next Hearing Date")
            {

            }


            // column(Priority_WritCaseHeader;"Writ/Case Header".Priority)
            // {
            // }

            column(Priority; Priority)
            {

            }


            column(SOFStatus_WritCaseHeader; WCHRD."SOF Status")
            {
            }
            column(Description1_WritCaseHeader; WCHRD.Description1)
            {
            }
            column(ReportFilters; ReportFilter)
            {
            }
            column(Sno; Sno)
            {
            }
            column(SOFsent; SOFsent)
            {
            }
            column(SOFSentDate; SOFSentDate)
            {
            }
            column(SectionName; WCHRD."Section Name")
            {
            }
            column(DistrictName; WCHRD."District Name")
            {
            }
            column(CaseYesr; WCHRD.Year)
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(SOFPleaderName; SOFPleaderName)
            {
            }
            column(OathNo; OathNo)
            {
            }
            column(OathDate; OathDate)
            {
            }
            column(UserExamCode; UserExamCode)
            {
            }
            column(ArisingOutNo; WCHRD."Arising Out")
            {
            }
            column(ArisingOutType; WCHRD."Arising Out Type")
            {
            }
            column(ReminderDate; ReminderDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SOFsent := FALSE;
                SOFSentDate := 0D;
                SOFPleaderName := '';
                OathDate := 0D;
                OathNo := '';
                ReminderDate := 0D;
                Sno := Sno + 1;
                AdvocateAssignEntry.RESET;
                AdvocateAssignEntry.SETRANGE("File No.", "File No.");
                AdvocateAssignEntry.SETRANGE("Entry Type", AdvocateAssignEntry."Entry Type"::"Sent To External");
                AdvocateAssignEntry.SETRANGE("SOF Sent", TRUE);
                IF AdvocateAssignEntry.FIND('-') THEN
                    IF AdvocateAssignEntry."Sent To External Adv." THEN BEGIN
                        SOFsent := TRUE;
                        SOFSentDate := AdvocateAssignEntry."Sent To External Date";
                        SOFPleaderName := AdvocateAssignEntry."Advocate Name";
                    END;

                HearingEntry.RESET;
                HearingEntry.SETCURRENTKEY("Document No.", "Line No.");
                HearingEntry.SETRANGE(HearingEntry."Document No.", "File No.");
                IF HearingEntry.FIND('-') THEN BEGIN
                    REPEAT
                        OathNo := HearingEntry."Oath No.";
                        OathDate := HearingEntry."Oath Date";
                    UNTIL HearingEntry.NEXT = 0;
                END;

                ReminderEntry.RESET;
                ReminderEntry.SETRANGE(ReminderEntry."Document No.", "File No.");
                ReminderEntry.SETRANGE(Sent, TRUE);
                IF ReminderEntry.FINDLAST THEN
                    ReminderDate := DT2DATE(ReminderEntry."Sent Date Time");
            end;

            trigger OnPreDataItem()
            begin
                WCHRD.CALCFIELDS(WCHRD."Next Hearing Date", WCHRD."First Hearing Date");
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
        CompanyInfo.CALCFIELDS(Picture);
        ReportFilter := WCHRD.GETFILTERS();
    end;

    var
        CompanyInfo: Record 79;
        AdvocateAssignEntry: Record 50207;
        HearingEntry: Record 50202;
        ReminderEntry: Record "Reminder Entry";
        ReportFilter: Text;
        Sno: Integer;
        SOFsent: Boolean;
        SOFSentDate: Date;
        SOFPleaderName: Text;
        OathNo: Text;
        OathDate: Date;
        UserExamCode: Option " ","Legal Secondary","Legal Senior Secondary";
        UserExCode: Code[20];
        ReminderDate: Date;
}

