pageextension 50118 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted SC Comp. Rcpt. Nos.")
        {
            field("Loa No."; Rec."Loa No.")
            {
                ApplicationArea = All;

            }
            field("Purchase Proposal Nos."; Rec."Purchase Proposal Nos.")
            {
                ApplicationArea = All;

            }
            field("Posted Purchase Proposal Nos."; Rec."Posted Purchase Proposal Nos.")
            {
                ApplicationArea = All;

            }
            field("Loa Attachment No."; Rec."Loa Attachment No.")
            {
                ApplicationArea = All;

            }
            field(Year; Rec.Year)
            {
                ApplicationArea = All;

            }
            field("PFMS No."; Rec."PFMS No.")
            {
                ApplicationArea = All;

            }
            field("PL_NP Fund Entry"; Rec."PL_NP Fund Entry")
            {
                ApplicationArea = All;
                Caption = 'PL/NP Fund Entry';
            }
            field("Bill Payment No."; Rec."Bill Payment No.")
            {
                ApplicationArea = All;

            }
            field("Cheque No. Series"; Rec."Cheque No. Series")
            {
                ApplicationArea = All;

            }
            field("Sanction No. Series"; Rec."Sanction No. Series")
            {
                ApplicationArea = All;

            }
        }
    }

}
