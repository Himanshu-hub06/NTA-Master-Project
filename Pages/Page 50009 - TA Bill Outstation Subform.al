page 50009 "TA Bill Outstation Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "TA Bill Outstation";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Departure Date"; Rec."Departure Date")
                {
                    Editable = false;
                }
                field("Departure From"; Rec."Departure From")
                {
                    Editable = false;
                }
                field("Arrival To"; Rec."Arrival To")
                {
                    Editable = false;
                }
                field("Mode Of Journey"; Rec."Mode Of Journey")
                {
                    Editable = false;
                }
                field("Distance Of Journey"; Rec."Distance Of Journey")
                {
                    Editable = false;
                }
                field("Receipt No."; rec."Receipt No")
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
                        IF Rec."File Path" <> '' THEN
                            //HYPERLINK(InvSetup."FTP Path" + Rec."File Path");
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
        IF Rec."File Path" <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';

        TABillHdr.SETRANGE(TABillHdr."Bill ID", Rec."Bill ID");
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

