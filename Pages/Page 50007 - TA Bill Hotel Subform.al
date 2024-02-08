page 50007 "TA Bill Hotel Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "TA Bill Hotel";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hotel Name & Address"; rec."Hotel Name & Address")
                {
                    Editable = false;
                }
                field("Room Rent"; rec."Room Rent")
                {
                    Editable = false;
                }
                field("Food Charges"; rec."Food Charges")
                {
                    Editable = false;
                }
                field("Bill No."; rec."Hotel Bill No")
                {
                    Editable = false;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    Editable = false;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    Editable = AppAmountEditable;
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        //IF "Approved Amount" > "Total Amount" THEN
                        //  ERROR(Text002);
                    end;
                }
                field(Attachment; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."File Path" <> '' THEN
                            //HYPERLINK(InvSetup."FTP Path" + rec."File Path");
                            HYPERLINK('http://20.219.166.69:84/NTA_ERP/backend/web/' + Rec."File Path");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF rec."File Path" <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';

        TaBillHdr.SETRANGE(TaBillHdr."Bill ID", rec."Bill ID");
        TaBillHdr.SETFILTER(TaBillHdr.Status, '%1|%2', TaBillHdr.Status::Approved, TaBillHdr.Status::Rejected);
        IF TaBillHdr.FINDFIRST THEN
            AppAmountEditable := FALSE
        ELSE
            AppAmountEditable := TRUE;
    end;

    var
        AttachDoc: Text[15];
        Text001: Label 'View';
        Text002: Label 'Approved amount should be less than submitted amount.';
        TaBillHdr: Record "TA Bill Header";
        AppAmountEditable: Boolean;
        InvSetup: Record "Inventory Setup";
}

