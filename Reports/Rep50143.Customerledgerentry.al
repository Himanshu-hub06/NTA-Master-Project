report 50143 "Customer ledger entry"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    Caption = 'Customer ledger entry';
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = './Reports/Customer ledger entry.rdl';
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.";
            column(Entry_No_; "Entry No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(No__Series; "No. Series")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Document_Type; "Document Type")
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Amount__LCY_; "Amount (LCY)")
            {

            }

            column(CustomerGSTNo; CustomerGSTNo)
            {

            }

            trigger OnAfterGetRecord()




            begin

                // reccustomer.Reset();
                // reccustomer.SetRange("No.", "Customer No.");
                // if reccustomer.FindFirst() then
                //     CustomerGSTNo := reccustomer.Contact;

                if reccustomer.get("Customer No.") then
                    if reccustomer.FindFirst() then
                        CustomerGSTNo := reccustomer.Contact
                    else
                        CustomerGSTNo := '';





            end;
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
    var
        reccustomer: Record Customer;

        CustomerGSTNo: Code[30];
}
