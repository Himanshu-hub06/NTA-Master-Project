page 50050 "NTA Image Multiple"
{
    ApplicationArea = All;
    Caption = 'Attached Bill Multiple';
    PageType = ListPart;
    SourceTable = BILL_CentreBillParticularsDeta;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Particulars_Name; Rec.Particulars_Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Particulars_Rate; Rec.Particulars_Rate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Attachment; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        //InvSetup.GET;
                        IF rec.UploadBills <> '' THEN
                            //HYPERLINK(InvSetup."FTP Path" + rec."File Path");
                            HYPERLINK('http://20.219.166.69:84/NTA_ERP/backend/web/' + Rec.UploadBills);
                    end;
                }
            }

        }

    }
    trigger OnAfterGetRecord()
    begin
        IF Rec.UploadBills <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';
    end;



    var
        AttachDoc: Text[30];
        Text001: Label 'View';

    // trigger OnAfterGetCurrRecord()
    // begin
    //     IF "Image File Name" <> '' THEN
    //         NearImage := 'View'
    //     ELSE
    //         NearImage := '';

    //     IF "Far Image File Name" <> '' THEN
    //         FarImage := 'View'
    //     ELSE
    //         FarImage := '';
    // end;





}
