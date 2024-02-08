tableextension 50001 "Approval Entry" extends "Approval Entry"
{
    fields
    {
        field(50001; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = ToBeClassified;

        }
        field(50002; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
            DataClassification = ToBeClassified;
        }
        field(50003; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
            DataClassification = ToBeClassified;
        }
        field(50004; "Location Name"; Text[80])
        {
            Caption = 'Location Name';
            DataClassification = ToBeClassified;
        }
        field(50005; "Section Name"; Text[80])
        {
            Caption = 'Section Name';
            DataClassification = ToBeClassified;
        }
        field(50006; "Forwarding Date-Time"; DateTime)
        {
            Caption = 'Forwarding Date-Time';
            DataClassification = ToBeClassified;
        }
        field(50007; "Payment Proposal"; Boolean)
        {
            Caption = 'Payment Proposal';
            DataClassification = ToBeClassified;
        }
        field(50008; "Sender Name"; Text[120])
        {
            Caption = 'Sender Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("Sender ID")));
        }
        field(50009; "Purchase Proposal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(50011; "Exam Name"; Text[150])
        {
            Caption = 'Exam Name';
            DataClassification = ToBeClassified;
        }
        field(50012; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = ToBeClassified;
        }
        field(50013; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(50014; "Requester Name"; Text[150])
        {
            Caption = 'Requester Name';
            DataClassification = ToBeClassified;
        }
        field(50015; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Centre Bill","TA/DA Bill";
        }
    }
}
