report 50191 "Amount in Word"
{
    ApplicationArea = All;
    Caption = 'Amount in Word';
    UsageCategory = Documents;
    RDLCLayout = './Reports/AMTINTOWORD.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            RequestFilterFields = "No.";

            column(DocumentType; "Document Type")
            {
            }
            column(No_; "No.")
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }

            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }

            dataitem("Purchase Line"; "Purchase Line")
            {

                DataItemLink = "DOCUMENT TYPE" = field("DOCUMENT TYPE"), "DOCUMENT NO." = field("NO.");

                column(Document_No_; "Document No.")
                {

                }
                column(No1; "No.")
                {

                }
                column(Quantity; Quantity)
                {

                }

                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }

                column(AmtLinewise; AmtLinewise)
                {

                }

                column(AmountInWords; AmountInWords)
                {

                }



                trigger OnAfterGetRecord()

                begin

                    AmtLinewise := "Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost";

                    RepCheck.InitTextVariable;

                    RepCheck.FormatNoText(NoText, AmountVendor, '');

                    AmountInWords := NoText[1]



                end;




            }














        }



        //dataitem
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

        AmtLinewise: Decimal;
        RepCheck: Report Check;
        NoText: array[2] of Text[50];
        AmountInWords: Text[50];
        AmountVendor: Decimal;

}
