table 50009 "Exam Master"
{
    Caption = 'Exam Master';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Exam ID"; Integer)
        {
            Caption = 'Exam ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Exam Name"; Text[150])
        {
            Caption = 'Exam Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Exam Code"; Code[100])
        {
            Caption = 'Exam Code';
            DataClassification = ToBeClassified;
        }
        field(4; Occurance; Integer)
        {
            Caption = 'Occurance';
            DataClassification = ToBeClassified;
        }
        field(5; "Last Modified on"; DateTime)
        {
            Caption = 'Last Modified on';
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Total_Candidate"; Integer)
        {
            Caption = 'Total_Candidate';
            DataClassification = ToBeClassified;
        }
        field(9; "Total_City_Coordinator"; Integer)
        {
            Caption = 'Total_City_Coordinator';
            DataClassification = ToBeClassified;
        }
        field(10; "Total_Centre_Superintendent"; Integer)
        {
            Caption = 'Total_Centre_Superintendent';
            DataClassification = ToBeClassified;
        }
        field(11; "Total_Deputy_Superintendent"; Integer)
        {
            Caption = 'Total_Deputy_Superintendent';
            DataClassification = ToBeClassified;
        }
        field(12; "Total_Invigilator"; Integer)
        {
            Caption = 'Total_Invigilator';
            DataClassification = ToBeClassified;
        }
        field(13; "Total_Deputy_Inde_Observer"; Integer)
        {
            Caption = 'Total_Deputy_Inde_Observer';
            DataClassification = ToBeClassified;
        }
        field(14; "Total_flying_Squad"; Integer)
        {
            Caption = 'Total_flying_Squad';
            DataClassification = ToBeClassified;
        }
        field(15; "UploadFile"; text[250])
        {
            Caption = 'UploadFile';
            DataClassification = ToBeClassified;
        }
        field(16; "IsActive"; Boolean)
        {
            Caption = 'IsActive';
            DataClassification = ToBeClassified;
        }
        //ex-ds commented on 28 aug 2023
        // field(17; "CreatedDate"; Date)
        // {
        //     Caption = 'Total_Candidate';
        //     DataClassification = ToBeClassified;
        // }
        field(18; "Total_Centre_D_Superintendent"; Integer)
        {
            Caption = 'Total_Centre_Deputy_Superintendent';
            DataClassification = ToBeClassified;
        }
        field(19; "Exam_Mode"; Option)
        {
            Caption = 'Exam_Mode';
            DataClassification = ToBeClassified;
            OptionMembers = "Online Exam","Offline Exam";
        }


    }
    keys
    {
        key(PK; "Exam ID")
        {
            Clustered = true;
        }
    }
}
