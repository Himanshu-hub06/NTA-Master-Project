page 50791 " Committee Member"
{
    AutoSplitKey = true;
    Caption = 'Member List';
    MultipleNewLines = false;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Documents;
    //SourceTable = 50284;
    SourceTable = 50287;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;
                    Caption = 'PAC Code';
                    //Editable = false;
                    Visible = false;
                }
                // field(Salutation; Rec.Salutation)//kc 23062023
                // {
                //     ApplicationArea = All;
                // }  // ROHIT
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Email-Id"; Rec."Email-Id")
                {
                    Caption = 'E-mail';
                    ApplicationArea = all;
                }
                field("Login ID"; Rec."Member ID")
                {
                    //Editable = false;
                    ApplicationArea = all;

                }
                // field("Committee Chairman"; Rec."Committee Chairman")     HYC
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        // IF ("Minimum Price For Approval" <> 0) AND ("Maximum Price For Approval" = 0) THEN
        //  "Maximum Price For Approval" := 999999999999999.99;
        //
        // IF ("Minimum Price For Approval" = 0) AND ("Maximum Price For Approval" <> 0) THEN
        //  "Maximum Price For Approval" := 0.0;
    end;
}

