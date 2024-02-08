page 50036 "TA Bill Outstation Sub open"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "TA Bill Outstation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Departure Date"; rec."Departure Date")
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
                    MinValue = 0;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF rec."Approved Amount" > rec.Amount THEN
                            ERROR(Text002);
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

    trigger OnAfterGetRecord()
    begin
        IF rec."File Path" <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';
    end;

    var
        AttachDoc: Text[30];
        Text001: Label 'View';
        Text002: Label 'Approved amount should be less than submitted amount.';
        InvSetup: Record "Inventory Setup";
}

