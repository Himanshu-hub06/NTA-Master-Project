pageextension 50119 SALESTest extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {

            field("Additional Remark"; Rec."Additional Remark")
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