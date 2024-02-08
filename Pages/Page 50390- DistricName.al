page 50390 "Distric Name"
{
    ApplicationArea = All;
    Caption = 'Distric Name';
    PageType = List;
    SourceTable = Districts;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("District Name"; Rec."District Name")
                {

                }

                field(Commissionerate; Rec.Commissionerate)
                {

                }

                field("State Code"; Rec."State Code")
                {

                }

            }
        }
    }
}
