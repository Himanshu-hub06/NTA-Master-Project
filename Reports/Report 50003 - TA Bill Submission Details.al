report 50003 "TA Bill Submission Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TA Bill Submission Details.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1000000000; 50019)
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
            column(SubmittedCount; SubmittedCount)
            {
            }
            column(DraftCount; DraftCount)
            {
            }
            column(NoRecordCount; NoRecordCount)
            {
            }
            column(ReportName; ReportLabel)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SubmittedCount := 0;
                DraftCount := 0;
                NoRecordCount := 0;

                TaBillHdr.RESET;
                TaBillHdr.SETCURRENTKEY("NTA Unique ID", Submitted);
                TaBillHdr.SETRANGE("NTA Unique ID", "Examinar Code");
                IF TaBillHdr.FIND('-') THEN BEGIN
                    REPEAT
                        IF TaBillHdr.Submitted THEN
                            SubmittedCount := SubmittedCount + 1
                        ELSE
                            IF NOT TaBillHdr.Submitted THEN
                                DraftCount := DraftCount + 1
                     UNTIL TaBillHdr.NEXT = 0;
                END ELSE
                    NoRecordCount := NoRecordCount + 1;

                IF OldExamID <> "Exam ID" THEN BEGIN
                    Sno := 0;
                    Sno := Sno + 1;
                    OldExamID := "Exam ID"
                END ELSE BEGIN
                    Sno := Sno + 1;
                END;

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
        SubmittedCount: Integer;
        DraftCount: Integer;
        NoRecordCount: Integer;
        TotalCount: Integer;
        ReportLabel: Label 'TA/DA Bill Status';
}

