page 50008 "TA Bill Loacl Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "TA Bill Local";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journey Date"; rec."Journey Date")
                {
                    Editable = false;
                }
                field("Journey Remarks"; rec."Journey Remarks")
                {
                    Editable = false;
                }
                field("Departure From"; rec."Departure From")
                {
                    Editable = false;
                }
                field("Arrival To"; rec."Arrival To")
                {
                    Editable = false;
                }
                field("Mode Of Journey"; rec."Mode Of Journey")
                {
                    Editable = false;
                }
                field("Distance Of Journey"; rec."Distance Of Journey")
                {
                    Editable = false;
                }
                field("Receipt No."; rec."Receipt No")
                {
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    Editable = false;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    Editable = AppAmountEditable;
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        //IF "Approved Amount" > Amount THEN
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

        TABillHdr.SETRANGE(TABillHdr."Bill ID", rec."Bill ID");
        TABillHdr.SETFILTER(TABillHdr.Status, '%1|%2', TABillHdr.Status::Approved, TABillHdr.Status::Rejected);
        IF TABillHdr.FINDFIRST THEN
            AppAmountEditable := FALSE
        ELSE
            AppAmountEditable := TRUE;
    end;

    var
        AttachDoc: Text[30];
        Text001: Label 'View';
        Text002: Label 'Approved amount should be less than submitted amount.';
        TABillHdr: Record "TA Bill Header";
        AppAmountEditable: Boolean;
        InvSetup: Record "Inventory Setup";
}

