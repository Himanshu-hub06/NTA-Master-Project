table 50012 "Posted TA Bill Header"
{
    //ExternalName = 'BILL_TA_BILL_MST';
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Posted TA Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PK_BILL_ID';
        }
        field(2; BillType; Option)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'BillType';
            OptionCaption = 'Local,OutStation';
            OptionMembers = "Local",OutStation;
        }
        field(3; "Exam ID"; Integer)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'FK_ExamId';
        }
        field(4; "Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Exam_Date';
        }
        field(5; "NTA Unique ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'NTA_UniqueID';
        }
        field(6; "Requester Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Requester_Name';
        }
        field(7; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Designation';
        }
        field(8; "Address For Communication"; Text[250])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Address_C';
        }
        field(9; "Contact No."; Text[30])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Contact_No';
        }
        field(10; "Bank Name & Branch"; Text[100])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Bank_Branch_Name';
        }
        field(11; "Account No."; Text[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Account_No';
        }
        field(12; "IFSC Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'IFSC_Code';
        }
        field(13; "Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Bill_Amount';
        }
        field(14; "Total Amount Local"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Total_Amount_Local';
        }
        field(15; "Total Amount Outstation"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Total_Amount_OutStation';
        }
        field(16; "Total Amount Hotel"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Total_Amount_Hotel';
        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Bill_Status';
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(18; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PostingDate_NAV';
        }
        field(22; "Exam Code"; Code[20])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Code" WHERE (Exam ID=FIELD(Exam ID)));
            //FieldClass = FlowField;
        }
        field(23; "Exam Name"; Text[100])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Name" WHERE (Exam ID=FIELD(Exam ID)));
            // FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Bill ID")
        {
        }
    }

    fieldgroups
    {
    }
}

