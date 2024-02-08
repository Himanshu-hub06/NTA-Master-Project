page 50024 "Approved TA Bill Hotel Subform"
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
                }
                field("Room Rent"; rec."Room Rent")
                {
                }
                field("Food Charges"; rec."Food Charges")
                {
                }
                field("Bill No."; rec."Hotel Bill No")
                {
                    Editable = false;
                }
                field("Total Amount"; rec."Total Amount")
                {
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
        InvSetup: Record "Inventory Setup";
}

