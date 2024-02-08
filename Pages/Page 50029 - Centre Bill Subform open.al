page 50029 "Centre Bill Subform open"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Centre Bill Line";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Partuculars; rec.Partuculars)
                {
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                }
                field(Rate; rec.Rate)
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
                    Visible = false;
                }
                field("Supporting Document"; AttachDoc)
                {
                    Caption = 'Attachment';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."File Path" <> '' THEN
                            HYPERLINK(InvSetup."FTP Path" + rec."File Path");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CentreBillHdr.SETRANGE(CentreBillHdr."CentreBill ID", rec."Centre Bill ID");
        CentreBillHdr.SETFILTER(CentreBillHdr.Status, '%1|%2', CentreBillHdr.Status::"Approved", CentreBillHdr.Status::"Rejected");
        IF CentreBillHdr.FINDFIRST THEN
            AppAmountEditable := FALSE
        ELSE
            AppAmountEditable := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF rec."File Path" <> '' THEN
            AttachDoc := TxtView
        ELSE
            AttachDoc := '';
    end;

    var
        Text001: Label 'Approved amount should be less than submitted amount.';
        CentreBillHdr: Record "Centre Bill Header";
        AppAmountEditable: Boolean;
        AttachDoc: Text;
        TxtView: Label 'View';
        InvSetup: Record "Inventory Setup";
}

