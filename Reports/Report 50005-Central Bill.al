report 50005 "Centre Bill Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Centre Bill.rdl';


    dataset
    {
        dataitem("Centre Bill Header"; 50002)

        {
            RequestFilterFields = "Bill Status";
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {

            }
            column(PIC; Companyinfo.Picture)
            {

            }
            column(Centre_City; "Centre City")
            {

            }
            column(Exam_Name; "Exam Name")
            {

            }
            column(Centre_No_; "Centre No.")
            {

            }
            column(Centre_Name; Centre_Name)
            {

            }
            column(Centre_ID; "Centre ID")
            {

            }
            column(Centre_Address; "Centre Address")
            {

            }
            column(Exam_Date; "Exam Date")
            {

            }
            column(Bill_Status; "Bill Status")
            {

            }
            column(Contact_No_; "Contact No.")
            {

            }
            column(Superintendent_Name; "Superintendent Name")
            {

            }
            column(Claimed_Amount; "Claimed Amount")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }

            //column(Companyinfo;Companyinfo.I)
            dataitem(BILL_CentreBillParticularsDeta; 50077)
            {

            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    var

    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;



    var
        Companyinfo: Record 79;

}