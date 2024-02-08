page 50302 "Advocate Card"
{
    DataCaptionExpression = Rec."Advocate Code";

    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = Card;
    SourceTable = 50201;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Advocate Code"; rec."Advocate Code")
                {
                    ShowMandatory = true;

                    trigger OnAssistEdit()
                    begin
                        IF rec."Advocate Code" = '' THEN
                            IF rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                    end;
                }
                field(Name; rec.Name)
                {
                    ShowMandatory = true;
                }
                field("Registration No."; rec."Registration No.")
                {
                }
                field("Father Name"; rec."Father Name")
                {
                }
                field(Address; rec.Address)
                {
                    ShowMandatory = true;
                }
                field("Post Code"; rec."Post Code")
                {
                }
                field(City; rec.City)
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Mobile No."; rec."Mobile No.")
                {
                    ShowMandatory = true;
                }
                field("Phone No."; rec."Phone No.")
                {
                }
                field("Fax No."; rec."Fax No.")
                {
                }
                field("Email ID"; rec."Email ID")
                {
                    ShowMandatory = true;
                }
                field("Date Of Registratin"; rec."Date Of Registratin")
                {
                }
                field("Start Date Of Empanelment"; rec."Start Date Of Empanelment")
                {
                    ShowMandatory = true;
                }
                field("End Date Of Empanelment"; rec."End Date Of Empanelment")
                {
                }
                field("Adv. Type"; rec."Adv. Type")
                {
                    Caption = 'Advocate Type';
                }
                field(Active; rec.Active)
                {
                    //Editable = false;
                }
            }
            group("Bank Details")
            {
                field("Bank A/c No."; rec."Bank A/c No.")
                {
                }
                field("Bank Name"; rec."Bank Name")
                {
                }
                field(Branch; rec.Branch)
                {
                }
                field("IFSC Code"; rec."IFSC Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

