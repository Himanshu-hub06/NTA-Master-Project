#pragma implicitwith disable
page 50268 "Transport/Fleet Log List"
{
    CardPageID = "Transport/Fleet Log Card";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 50108;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TF Code"; Rec."TF Code")
                {
                    ApplicationArea = all;
                }
                field("TF Date"; Rec."TF Date")
                {
                    ApplicationArea = all;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    Visible = EnableBtn;
                    ApplicationArea = all;
                }
                field("Vehicle Code"; Rec."Vehicle Code")
                {
                    Visible = EnableBtn;
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Receiver ID"; Rec."Receiver ID")
                {
                    ApplicationArea = all;
                }
                field("Place to Visit"; Rec."Place to Visit")
                {
                    ApplicationArea = all;
                }
                field("Journey Type"; Rec."Journey Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        EnableBtn := FALSE;
    end;

    trigger OnOpenPage()
    begin
        IF (Rec.Status = Rec.Status::"Under GA Secton") OR (Rec.Status = Rec.Status::Approved) THEN
            EnableBtn := TRUE;
        // CurrPage.Update();
    end;

    // trigger OnAfterGetRecord()
    // var
    //     myInt: Integer;
    // begin
    //     CurrPage.Update();
    // end;

    var
        EnableBtn: Boolean;
}

#pragma implicitwith restore

