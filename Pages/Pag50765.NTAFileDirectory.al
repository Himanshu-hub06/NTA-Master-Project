page 50765 "NTA File Directory"
{
    ApplicationArea = All;
    Caption = 'NTA File Directory';
    PageType = List;
    SourceTable = "File Directory Detail";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bill File Path"; Rec."Bill File Path")
                {
                    ToolTip = 'Specifies the value of the Bill File Path field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(ConnectionString; Rec.ConnectionString)
                {
                    ToolTip = 'Specifies the value of the ConnectionString field.';
                }
                field(DatabaseName; Rec.DatabaseName)
                {
                    ToolTip = 'Specifies the value of the DatabaseName field.';
                }
                field("Indent Read"; Rec."Indent Read")
                {
                    ToolTip = 'Specifies the value of the Indent Read field.';
                }
                field("Indent Write"; Rec."Indent Write")
                {
                    ToolTip = 'Specifies the value of the Indent Write field.';
                }
                field("Location Image URL"; Rec."Location Image URL")
                {
                    ToolTip = 'Specifies the value of the Location Image URL field.';
                }
                field("Mail API Url"; Rec."Mail API Url")
                {
                    ToolTip = 'Specifies the value of the Mail API Url field.';
                }
                field("Message API URL"; Rec."Message API URL")
                {
                    ToolTip = 'Specifies the value of the Message API URL field.';
                }

                field("PFMS Payment Status"; Rec."PFMS Payment Status")
                {
                    ToolTip = 'Specifies the value of the PFMS Payment Status field.';
                }
                field("PFMS Push Status"; Rec."PFMS Push Status")
                {
                    ToolTip = 'Specifies the value of the PFMS Push Status field.';
                }
                field("PFMS Sanction Status"; Rec."PFMS Sanction Status")
                {
                    ToolTip = 'Specifies the value of the PFMS Sanction Status field.';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field("Pfms Read"; Rec."Pfms Read")
                {
                    ToolTip = 'Specifies the value of the Pfms Read field.';
                }
                field("Pfms Write"; Rec."Pfms Write")
                {
                    ToolTip = 'Specifies the value of the Pfms Write field.';
                }

                field("Purchase Proposal Read"; Rec."Purchase Proposal Read")
                {
                    ToolTip = 'Specifies the value of the Purchase Proposal Read field.';
                }
                field("Purchase Proposal Write"; Rec."Purchase Proposal Write")
                {
                    ToolTip = 'Specifies the value of the Purchase Proposal Write field.';
                }
                field("Requisition Read"; Rec."Requisition Read")
                {
                    ToolTip = 'Specifies the value of the Requisition Read field.';
                }
                field("Requisition Write"; Rec."Requisition Write")
                {
                    ToolTip = 'Specifies the value of the Requisition Write field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }

                field("Writ Case Write Path"; Rec."Writ Case Write Path")
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
