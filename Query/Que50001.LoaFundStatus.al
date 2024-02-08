query 50001 "Loa Fund Status"
{
    Caption = 'Loa Fund Status';
    QueryType = Normal;
    OrderBy = descending(AuthorizedAmount);
    elements
    {
        dataitem(LOALedgerDetailed;
        "LOA Ledger Detailed")

        {
            DataItemTableFilter = Cancel = const(false);

            filter(FundType; "Fund Type")
            {

            }
            column(MediaType; "Media Type")
            {
            }
            column(HeadCode; "Head Code")
            {
            }

            column(LoaNo; "Loa No.")
            {
            }
            column(Fund_Category; "Fund Category")
            {

            }
            column(Campaign_Code; "Campaign Code")
            {

            }

            column(AuthorizedAmount; "Authorized Amount")
            {
                Method = Sum;

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
