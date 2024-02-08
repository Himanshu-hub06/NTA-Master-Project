tableextension 50000 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {

        field(50000; "Committee No. Series"; Code[10])
        {
            TableRelation = "No. Series";

        }

        field(50001; "Notification No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }

        field(50002; "Document Master No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Writ Case Read Path"; text[100])
        {
            TableRelation = "No. Series";
        }
        field(50007; "Indent No. Series"; Code[20])
        {
            Caption = 'Indent No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50009; "FTP Path"; Text[250])
        {

            Caption = 'FTP Path';
            DataClassification = ToBeClassified;
        }
        field(50011; "Requisition No. Series"; Code[20])
        {
            Caption = 'Requisition No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50012; "Issue No. Series"; Code[20])
        {
            Caption = 'Issue No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50013; "Writ Case Write Path"; Text[100])
        {
            Caption = 'Writ Case Write Path';
            DataClassification = ToBeClassified;
            //TableRelation = "No. Series";
        }
        field(50014; "Tender File Path"; Text[100])
        {
            Caption = 'Tender File Path';
            DataClassification = ToBeClassified;
            //TableRelation = "No. Series";
        }

        field(50017; "Session No. Series"; Code[10])
        {
            Caption = 'Session No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(85009; "Requisition Template"; Code[20])
        {
            Caption = 'Requisition Template';
            DataClassification = ToBeClassified;
            trigger onlookup()
            var
                ItemJouTemplate: Record "Item Journal Template";
            begin
                IF PAGE.RUNMODAL(0, ItemJouTemplate) = ACTION::LookupOK THEN BEGIN
                    "Requisition Template" := ItemJouTemplate.Name;
                END;
            end;
        }
        field(85010; "Requisition Batch"; Code[20])
        {
            Caption = 'Requisition Batch';
            DataClassification = ToBeClassified;
            trigger Onlookup()
            var
                ItemJouBatch: Record "Item Journal Batch";
            begin
                ItemJouBatch.SETRANGE(ItemJouBatch."Journal Template Name", "Requisition Template");
                IF PAGE.RUNMODAL(0, ItemJouBatch) = ACTION::LookupOK THEN
                    "Requisition Batch" := ItemJouBatch.Name;
            end;
        }
        field(85011; "Posted Requisition No."; Code[10])
        {
            Caption = 'Posted Requisition No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85012; "Reminder No. Series"; Code[20])
        {
            Caption = 'Reminder No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(85013; "Media Type No."; Code[10])
        {
            Caption = 'Media Type No.';
            DataClassification = ToBeClassified;
        }
        field(85014; "Phys.Invt. Order Nos"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(85015; "Payment Receipt No."; Code[20])
        {
            Caption = 'Payment Receipt No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85016; "Committee Code"; Code[20])
        {
            Caption = 'Committee Code';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85017; "Member Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85018; "Meeting No."; Code[20])
        {
            Caption = 'Meeting No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(85019; "Notification No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }



    }
}
