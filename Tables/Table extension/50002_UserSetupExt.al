tableextension 50002 "User Setup Ext" extends "User Setup"
{
    fields
    {

        field(50000; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code; //added by kamlesh date 31-01-2023
            DataClassification = ToBeClassified;
        }
        field(50001; "Examination Code"; Code[20])
        {
            Caption = 'Examination Code';
            DataClassification = ToBeClassified;
        }
        field(50002; Section; Code[20])
        {
            Caption = 'Section';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'), "Dimension Value Type" = FILTER(<> "Begin-Total" | "End-Total"));
            DataClassification = ToBeClassified;
        }
        field(50003; "Indent Approval"; Boolean)
        {
            Caption = 'Indent Approval';
            DataClassification = ToBeClassified;
        }
        field(50004; "Requisition Approval"; Boolean)
        {
            Caption = 'Requisition Approval';
            DataClassification = ToBeClassified;
        }
        field(50005; "Budget Approver ID"; Code[50])
        {
            Caption = 'Budget Approver ID';
            DataClassification = ToBeClassified;
        }
        field(50006; "Indent Approver ID"; Code[50])
        {
            Caption = 'Indent Approver ID';
            DataClassification = ToBeClassified;
        }
        field(50007; "Requsition Approver ID"; Code[50])
        {
            Caption = 'Requsition Approver ID';
            DataClassification = ToBeClassified;
        }
        field(50008; Designation; Text[70])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
        }
        field(50009; "Vendor Payment Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Section Approver"; Boolean)
        {

            Caption = 'Section Approver';
            DataClassification = ToBeClassified;
        }
        field(50030; "Store Section"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('Section'), "Dimension Value Type" = FILTER(<> "Begin-Total" | "End-Total"));
            Caption = 'Store Section';
            DataClassification = ToBeClassified;
        }
        field(50031; "Item Creation Allowed"; Boolean)
        {
            Caption = 'Item Creation Allowed';
            DataClassification = ToBeClassified;
        }
        field(50032; "Allow all Location"; Boolean)
        {
            Caption = 'Allow all Location';
            DataClassification = ToBeClassified;
        }
        field(50033; "All Expence Bill Posting"; Boolean)
        {
            Caption = 'All Expence Bill Posting';
            DataClassification = ToBeClassified;
        }
        field(50034; "Pro Head"; Boolean)
        {
            Caption = 'Pro Head';
            DataClassification = ToBeClassified;
        }
        field(50035; "Store Emp"; Boolean)
        {
            Caption = 'Store Emp';
            DataClassification = ToBeClassified;
        }
        field(50036; "Req Update"; Boolean)
        {
            Caption = 'Req Update';
            DataClassification = ToBeClassified;
        }
        field(50037; "Wings Resp. Ctr. Filter"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(50038; "Hold Bill Update"; Boolean)
        {
            Caption = 'Hold Bill Update';
            DataClassification = ToBeClassified;
        }
        field(50040; "CNTB Bill Rollback"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Re-open Disposed Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
}
