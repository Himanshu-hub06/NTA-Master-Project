page 50025 "Approved TA Bill Loacl Subform"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ApplicationArea = all;
    SourceTable = "TA Bill Local";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journey Date"; Rec."Journey Date")
                {
                }
                field("Journey Remarks"; Rec."Journey Remarks")
                {
                }
                field("Departure From"; Rec."Departure From")
                {
                }
                field("Arrival To"; Rec."Arrival To")
                {
                }
                field("Mode Of Journey"; Rec."Mode Of Journey")
                {
                }
                field("Distance Of Journey"; Rec."Distance Of Journey")
                {
                }
                field("Receipt No."; Rec."Receipt No")
                {
                }
                field(Amount; Rec.Amount)
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
                        IF Rec."File Path" <> '' THEN
                            HYPERLINK(InvSetup."FTP Path" + Rec."File Path");
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
    end;

    var
        AttachDoc: Text[30];
        Text001: Label 'View';
        InvSetup: Record "Inventory Setup";
}

