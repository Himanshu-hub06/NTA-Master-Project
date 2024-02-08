report 50038 "Batch Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("Item Category Code" = filter(= 'S01'));
            trigger OnAfterGetRecord()
            begin
                Item.Validate("GST Group Code", '0988');
                Validate("GST Credit", Item."GST Credit"::Availment);
                Validate("HSN/SAC Code", '0988001');
                Item.Modify(true);

            end;

        }


    }








    var

}