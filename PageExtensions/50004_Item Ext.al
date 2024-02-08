pageextension 50004 "Item Ext." extends "Item List"

{



    actions
    {
        addFirst(Creation)
        {
            action(UploadItem) //upload data in Post Code table
            {
                Caption = 'Upload Item';
                Visible = false;//commented by kamlesh date 31-01-2023
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Xmlport.Run(50041, true);
                end;
            }

            // action(Setfilter)
            // {
            //     Caption = 'Set';
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     begin
            //         Rec.SetFilter("No.", '1001,1110,1255');
            //     end;
            // }
            action(SetRenge)
            {

                Caption = 'SetRange';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin
                    Rec.SetRange("No.", '1003', '1255');
                end;
            }



        }

    }

}
