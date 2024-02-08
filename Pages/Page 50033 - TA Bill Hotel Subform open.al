page 50033 "TA Bill Hotel Subform open"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "TA Bill Hotel";

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
                    MinValue = 0;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF rec."Approved Amount" > rec."Total Amount" THEN
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
        AttachDoc: Text[15];
        Text001: Label 'View';
        Text002: Label 'Approved amount should be less than submitted amount.';
        InvSetup: Record "Inventory Setup";
}

