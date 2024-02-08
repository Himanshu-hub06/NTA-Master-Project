pageextension 50001 Purchaseo extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
pageextension 50002 purchaelist extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter(Release)
        {


            action("New Relese")
            {
                ApplicationArea = All;
                Caption = 'New Relese"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Receipt;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}