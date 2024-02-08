reportextension 50001 Orderext extends Order
{

    dataset
    {

        Add("Purchase Line")
        {
            Column(GSTGroupCode; "Purchase Line"."GST Group Code")
            {

            }
            column(GSTCredit; "Purchase Line"."GST Credit")
            {

            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Order.rdl';
        }
    }

}



