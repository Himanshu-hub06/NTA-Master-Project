report 50011 "TABILL"
{
    ApplicationArea = All;
    Caption = 'TA BILL';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/TA BILL.rdl';

    dataset
    {

        dataitem(TABillHeader; "TA Bill Header")
        {
            RequestFilterFields = "Reference No";

            column(ReferenceNo; "Reference No")
            {
            }
            column(BillType; BillType)
            {
            }
            column(ExamName; "Exam Name")
            {
            }
            column(NTAUniqueID; "NTA Unique ID")
            {
            }
            column(Exam_Date; "Exam Date")
            {
            }
            column(Longitude; Longitude)
            {
            }
            column(IP; IP)
            {
            }
            column(RequesterName; "Requester Name")
            {
            }
            column(Designation; Designation)
            {
            }
            column(IFSCCode; "IFSC Code")
            {
            }
            column(ClaimedAmount; "Claimed Amount")
            {
            }
            column(RemunerationDays; "Remuneration Days")
            {
            }
            column(RemunerationRate; "Remuneration Rate")
            {
            }
            column(RemunerationAmount; "Remuneration Amount")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(TDSPercent; "TDS Percent")
            {
            }
            column(TDSAmount; "TDS Amount")
            {
            }
            column(LastModifiedon; "Last Modified on")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
