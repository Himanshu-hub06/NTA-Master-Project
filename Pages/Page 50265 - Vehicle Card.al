#pragma implicitwith disable
page 50265 "Vehicle Card"
{
    Caption = 'Vehicle';
    PageType = Card;
    SourceTable = 50106;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                field("Vehicle Code"; Rec."Vehicle Code")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Color"; Rec."Vehicle Color")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration Date"; Rec."Vehicle Registration Date")
                {
                    ApplicationArea = all;
                }
                field("RC Validity Date"; Rec."RC Validity Date")
                {
                    ApplicationArea = all;
                }
                field(Availability; Rec.Availability)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

