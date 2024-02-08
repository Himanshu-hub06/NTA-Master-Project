#pragma implicitwith disable
page 50294 "File Directory List"
{
    ApplicationArea = All;
    Caption = 'File Directory List';
    PageType = List;
    SourceTable = "File Directory Detail";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("SQL Connection"; rec.ConnectionString)
                {
                    ApplicationArea = All;
                }
                field("Mail API Url"; Rec."Mail API Url")
                {
                    ApplicationArea = All;
                }
                field("Message API URL"; Rec."Message API URL")
                {
                    ApplicationArea = All;
                }
                field("Requisition Read"; rec."Requisition Read")
                {
                    ApplicationArea = All;
                }
                field("Requisition Write"; rec."Requisition Write")
                {
                    ApplicationArea = All;
                }
                field("Indent Read"; rec."Indent Read")
                {
                    ApplicationArea = All;
                }
                field("Indent Write"; rec."Indent Write")
                {
                    ApplicationArea = All;
                }
                field("Purchase Proposal Read"; rec."Purchase Proposal Read")
                {
                    ApplicationArea = All;
                }
                field("Purchase Proposal write"; rec."Purchase Proposal write")
                {
                    ApplicationArea = All;
                }
                field("Pfms Read"; rec."Pfms Read")
                {
                    ApplicationArea = All;
                }
                field("Pfms Write"; Rec."Pfms Write")
                {
                    ApplicationArea = All;
                }
                field("PFMS Sanction Status File Path"; Rec."PFMS Sanction Status")
                {
                    ApplicationArea = All;
                }
                field("PFMS Push Status File Path"; Rec."PFMS Push Status")
                {
                    ApplicationArea = All;
                }
                field("PFMS Payment Status File Path"; Rec."PFMS Payment Status")
                {
                    ApplicationArea = All;
                }

                field("Writ Case Read Path"; Rec."Writ Case Read Path")
                {
                    ApplicationArea = All;
                }

                field("Writ Case Write Path"; Rec."Writ Case Write Path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

#pragma implicitwith restore
