page 50004 "Centre Bill Subform"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Centre Bill Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Partuculars; Rec.Partuculars)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field(Rate; Rec.Rate)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = AppAmountEditable;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
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
                            HYPERLINK(InvSetup."FTP Path" + rec."File Path");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CentreBillHdr.SETRANGE(CentreBillHdr."CentreBill ID", rec."Centre Bill ID");
    //     CentreBillHdr.SETFILTER(CentreBillHdr.Status, '%1|%2', CentreBillHdr.Status::"CC Approved", CentreBillHdr.Status::"CC Rejected");
    //     IF CentreBillHdr.FINDFIRST THEN
    //         AppAmountEditable := FALSE
    //     ELSE
    //         AppAmountEditable := TRUE;
    // end;

    // trigger OnAfterGetRecord()
    // begin
    //     IF rec."File Path" <> '' THEN
    //         AttachDoc := Text002
    //     ELSE
    //         AttachDoc := '';
    // end;

    var
        Text001: Label 'Approved amount should be less than submitted amount.';
        CentreBillHdr: Record "Centre Bill Header";
        AppAmountEditable: Boolean;
        Rem1Editable: Boolean;
        Rem2Editable: Boolean;
        Rem3Editable: Boolean;
        AttachDoc: Text;
        Text002: Label 'View';
        InvSetup: Record "Inventory setup";
}

