report 50002 "TA/DA Bill Submission Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TADA Bill Submission Details.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1000000000; "Examiner Details")
        {
            DataItemTableView = SORTING("Exam ID", "Exam Date")
                                ORDER(Ascending);
            RequestFilterFields = "Exam ID", "Exam Date", "Role ID";
            column(ExamID_ExaminerDetails; "Exam ID")
            {
            }
            column(NTA_Unique_ID; "Examinar Code")
            {
            }
            column(Exam_Date; "Exam Date")
            {
            }
            column(Exam_Name; "Exam Name")
            {
            }
            column(EmailAddress_ExaminerDetails; "Email Address")
            {
            }
            column(MobileNo_ExaminerDetails; "Mobile No.")
            {
            }
            column(SerialNo; Sno)
            {
            }
            column(ReportText; ReportTxt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Submitted THEN BEGIN
                    TaBillHdr.SETCURRENTKEY("NTA Unique ID", Submitted);
                    TaBillHdr.SETRANGE(Submitted, TRUE);
                    TaBillHdr.SETRANGE("NTA Unique ID", "Examinar Code");
                    IF NOT TaBillHdr.FIND('-') THEN
                        CurrReport.SKIP;
                END;
                IF NotSubmitted THEN BEGIN
                    TaBillHdr.SETCURRENTKEY("NTA Unique ID", Submitted);
                    TaBillHdr.SETRANGE(Submitted, FALSE);
                    TaBillHdr.SETRANGE("NTA Unique ID", "Examinar Code");
                    IF NOT TaBillHdr.FIND('-') THEN
                        CurrReport.SKIP;
                END;
                IF NoRecord THEN BEGIN
                    TaBillHdr.SETCURRENTKEY("NTA Unique ID", Submitted);
                    TaBillHdr.SETRANGE("NTA Unique ID", "Examinar Code");
                    IF TaBillHdr.FIND('-') THEN
                        CurrReport.SKIP;
                END;
                IF OldExamID <> "Exam ID" THEN BEGIN
                    Sno := 0;
                    Sno := Sno + 1;
                    OldExamID := "Exam ID"
                END ELSE BEGIN
                    Sno := Sno + 1;
                END
            end;

            trigger OnPreDataItem()
            begin
                OldExamID := 0;
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
                    Caption = 'Select one option';
                    field(Submitted; Submitted)
                    {
                    }
                    field(Draft; NotSubmitted)
                    {
                    }
                    field("No Record"; NoRecord)
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
        Sno := 0;
        IF Submitted THEN
            ReportTxt := 'Soft copy send to NTA'
        ELSE
            IF NotSubmitted THEN
                ReportTxt := 'Soft copy not send to NTA'
            ELSE
                IF NoRecord THEN
                    ReportTxt := 'Not Fill'
                ELSE
                    ReportTxt := 'Overall'
    end;

    var
        TaBillHdr: Record 50005;
        Submitted: Boolean;
        NotSubmitted: Boolean;
        NoRecord: Boolean;
        Sno: Integer;
        ReportTxt: Text;
        OldExamID: Integer;
}

