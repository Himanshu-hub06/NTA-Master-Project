#pragma implicitwith disable
page 50267 "Driver Card"
{
    PageType = Card;
    SourceTable = 50107;
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            grid(Group)
            {
                Caption = 'General';
                group(Driver_Detail)
                {
                    ShowCaption = false;
                    field("Driver Code"; Rec."Driver Code")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        trigger OnAssistEdit()
                        begin
                            IF Rec.AssistEdit THEN
                                CurrPage.UPDATE;
                        end;
                    }
                    field("Driver Name"; Rec."Driver Name")
                    {
                        ApplicationArea = all;
                    }
                    field("ID No."; Rec."Aadhar No.")
                    {
                        Caption = 'ID No.';
                        ApplicationArea = all;
                    }
                    field("Contact No."; Rec."Contact No.")
                    {
                        ApplicationArea = all;
                    }
                    field(Email; Rec.Email)
                    {
                        ApplicationArea = all;
                    }
                }
                group(DR_Address)
                {
                    ShowCaption = false;

                    field(City; Rec.City)
                    {
                        ApplicationArea = all;
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            Rec.CalcFields("State Name");
                            SelectLatestVersion();
                            //CurrPage.Activate(true);
                        end;
                    }
                    field("State Name"; Rec."State Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(AddressCptn; 'Address')
                    {
                        ShowCaption = false;
                        ApplicationArea = all;
                        Style = Strong;
                        Editable = false;
                    }
                    field(Address; Rec.Address)
                    {
                        ShowCaption = false;
                        ApplicationArea = all;
                        MultiLine = true;
                    }
                    field("Pin Code"; Rec."Pin Code")
                    {
                        ApplicationArea = all;
                    }
                }
                group(DRImage)
                {
                    ShowCaption = false;
                    part(Image; "Driver Image")
                    {
                        Caption = 'Picture';
                        ApplicationArea = Basic, Suite;
                        SubPageLink = "Driver Code" = field("Driver Code");
                    }
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("State Name");
    end;
}

#pragma implicitwith restore

