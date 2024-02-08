tableextension 50100 General_Ledger_Setup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "client Request No."; Code[20])
        {
            TableRelation = "No. Series";

            DataClassification = ToBeClassified;
        }
        field(50001; "MPP Rtae"; Decimal)
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50002; "Budget Plan No"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50003; "FOB No"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50004; "PRT No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50005; "Media Plan"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(50006; "Print Media Plan"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50007; "BOC FTP Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Q Sheet No. Series"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Description = 'QSheet';
        }
        field(50009; "Cont. Bill No. Series"; code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            Description = 'QSheet';
        }
        field(50010; "Advisiory No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50011; "Parliament Q  No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50012; "Vehicle No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50013; "Driver No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50014; "Transport Fleet No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50015; "Validate User with Wings"; Boolean)
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50020; "Physical Bill Receiving Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "GST Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Visitor No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50031; "Payment Receipt No."; Code[50])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

    }

}