query 50004 "Loa Fund Status Admin"
{
    Caption = 'Loa Fund Status Admin';
    QueryType = Normal;

    elements
    {
        dataitem(LOALedgerDetailed; "LOA Ledger Detailed")

        {
            DataItemTableFilter = Cancel = const(false), "Fund Type" = const(Establishment);

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
