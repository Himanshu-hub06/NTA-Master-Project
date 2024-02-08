pageextension 50111 Inventory_Setup_PageExt extends "Inventory Setup"
{

    layout
    {
        addafter("Item Nos.")
        {
            field("Committee No. Series"; REc."Committee No. Series")
            {
                ApplicationArea = all;

            }
            field("Document Master No."; rec."Document Master No.")
            {
                ApplicationArea = all;

            }
            field("Notification No. Series"; Rec."Notification No. Series")
            {
                ApplicationArea = all;

            }
            field("Indent No. Series"; Rec."Indent No. Series")
            {
                ApplicationArea = All;
                // FieldPropertyName = FieldPropertyValue;
            }
            field("Requisition No. Series"; Rec."Requisition No. Series")
            {
                ApplicationArea = All;
                // FieldPropertyName = FieldPropertyValue;
            }
            field("Issue No. Series"; Rec."Issue No. Series")
            {
                ApplicationArea = All;
                // FieldPropertyName = FieldPropertyValue;
            }
            field("Posted Requisition No."; Rec."Posted Requisition No.")
            {
                ApplicationArea = All;
            }
            field("Requisition Batch"; Rec."Requisition Batch")
            {
                ApplicationArea = All;
            }
            field("Requisition Template"; Rec."Requisition Template")
            {
                ApplicationArea = All;
            }
            field("Payment Receipt No."; Rec."Payment Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Committee Code"; Rec."Committee Code")
            {
                ApplicationArea = ALL;
            }
            field("Member Id"; Rec."Member Id")
            {
                ApplicationArea = all;
            }
            field("Meeting No."; Rec."Meeting No.")
            {
                ApplicationArea = All;
            }
            field("Notification No."; Rec."Notification No.")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter("Journal Templates")
        {
            action(ExlRun)
            {
                ApplicationArea = all;
                Caption = 'ExlRun';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Excel;
                trigger OnAction()
                var
                    TempFile: File;
                    Name: Text[250];
                    NewStrem: InStream;
                    TOfile: Text[250];
                    Returnvalue: Boolean;
                    LoaTab: Record "LOA Ledger Detailed";

                begin
                    TempFile.TextMode(False);
                    Name := 'C:\Temp\TempReport.xls';
                    TempFile.Create(Name);
                    TempFile.Close;
                    Report.SaveAsExcel(50006, Name);
                end;
            }
        }
    }
}
