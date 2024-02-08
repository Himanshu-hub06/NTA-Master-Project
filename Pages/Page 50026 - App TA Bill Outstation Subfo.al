page 50026 "App TA Bill Outstation Subfo"
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
                }
                field("Departure From"; rec."Departure From")
                {
                }
                field("Arrival To"; rec."Arrival To")
                {
                }
                field("Mode Of Journey"; rec."Mode Of Journey")
                {
                }
                field("Distance Of Journey"; rec."Distance Of Journey")
                {
                }
                field("Receipt No."; rec."Receipt No")
                {
                }
                field(Amount; rec.Amount)
                {
                }
                field(Attachment; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        HYPERLINK('http://104.211.206.19/NTA_ftp/Bill_TravelAllowance_Document/' + rec."File Path");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        AttachDoc := Text001;
    end;

    var
        AttachDoc: Text[30];
        Text001: Label 'View';
}

