pageextension 50110 General_Ledger_Setup_Ext extends "General Ledger Setup"
{
    layout
    {

        addafter("Print VAT specification in LCY")
        {
            // field("MPP Rate"; Rec."MPP Rtae")
            // {
            //     ApplicationArea = All;
            // }
            // field("Physical Bill Receiving Days"; rec."Physical Bill Receiving Days")
            // {
            //     ApplicationArea = All;
            // }
        }
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
            Editable = true;
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
            Editable = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
            Editable = true;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
            Editable = true;
        }



        addafter("Bank Account Nos.")
        {
            // field("GST Amount"; Rec."GST Amount")
            // {
            //     ApplicationArea = All;
            // }
            // field("client Request No."; rec."client Request No.")
            // {
            //     ApplicationArea = All;
            // }

            // field("Budget Plan No"; REc."Budget Plan No")
            // {
            //     ApplicationArea = All;
            // }
            // field("PRT No."; Rec."PRT No.")
            // {
            //     ApplicationArea = All;
            // }

            // field("Media Plan"; Rec."Media Plan")
            // {
            //     Caption = 'AV Media Plan';
            //     ApplicationArea = All;
            // }
            // field("Print Media Plan"; Rec."Print Media Plan")
            // {
            //     ApplicationArea = All;
            // }
            // field("Cont. Bill No. Series"; rec."Cont. Bill No. Series")
            // {
            //     Caption = 'Cont. Bill No. Series';
            //     ApplicationArea = All;
            // }
            // field("Q Sheet No. Series"; rec."Q Sheet No. Series")
            // {
            //     Caption = 'Q Sheet No. Series';
            //     ApplicationArea = All;
            // }
            // field("Visitor No. Series"; rec."Visitor No. Series")
            // {
            //     ApplicationArea = All;
            // }
            // field("Vehical No. Series"; "Vehicle No. Series")
            // {
            //     ApplicationArea = All;
            // }
            // field("Driver No. Series"; "Driver No. Series")
            // {
            //     ApplicationArea = All;
            // }
            // field("Transport Fleet No. Series"; "Transport Fleet No. Series")
            // {
            //     ApplicationArea = All;
            // }
            // field("Parliament Q  No. Series"; "Parliament Q  No. Series")
            // {
            //     Caption = 'Parliament Questions No. Series';
            //     ApplicationArea = All;
            // }
        }
    }
}