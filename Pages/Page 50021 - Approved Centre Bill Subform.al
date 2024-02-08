page 50021 "Approved Centre Bill Subform"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "Centre Bill Line";

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
                    Editable = false;

                    trigger OnValidate()
                    begin
                        IF rec."Approved Amount" > rec.Amount THEN
                            ERROR(Text001);
                    end;
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

    trigger OnAfterGetRecord()
    begin
        IF rec."File Path" <> '' THEN
            AttachDoc := TxtView
        ELSE
            AttachDoc := '';
    end;

    var
        Text001: Label 'Approved amount should be less than submitted amount.';
        AttachDoc: Text;
        TxtView: Label 'View';
        InvSetup: Record "Inventory Setup";
}

