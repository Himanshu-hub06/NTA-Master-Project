table 50079 ERP_BILL_TravellingAllowanceBi
{
    Caption = 'ERP_BILL_TravellingAllowanceBi';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; NTA_Unique_Admin_ID; Text[50])
        {
            Caption = 'NTA_Unique_Admin_ID';
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4; Designation; Text[50])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(6; Contact_No; Text[70])
        {
            Caption = 'Contact_No';
            DataClassification = ToBeClassified;
        }
        field(7; Bank_Branch_Name; Text[70])
        {
            Caption = 'Bank_Branch_Name';
            DataClassification = ToBeClassified;
        }
        field(8; Bank_Account_No; Text[70])
        {
            Caption = 'Bank_Account_No';
            DataClassification = ToBeClassified;
        }
        field(9; IFSC_Code; Text[70])
        {
            Caption = 'IFSC_Code';
            DataClassification = ToBeClassified;
        }
        field(10; Exam_ID; Text[50])
        {
            Caption = 'Exam_ID';
            DataClassification = ToBeClassified;
        }
        field(11; Role_ID; Text[50])
        {
            Caption = 'Role_ID';
            DataClassification = ToBeClassified;
        }
        field(12; Bill_Type; Option)
        {
            Caption = 'Bill_Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","PAID";
        }
        field(13; Remuneration_Days; Text[50])
        {
            Caption = 'Remuneration_Days';
            DataClassification = ToBeClassified;
        }
        field(14; Remuneration_Rate; Decimal)
        {
            Caption = 'Remuneration_Rate';
            DataClassification = ToBeClassified;
        }
        field(15; Remuneration_Total_Amount; Decimal)
        {
            Caption = 'Remuneration_Total_Amount';
            DataClassification = ToBeClassified;
        }
        field(16; IsActive; Boolean)
        {
            Caption = 'IsActive';
            DataClassification = ToBeClassified;
        }
        field(17; CreatedDate; DateTime)
        {
            Caption = 'CreatedDate';
            DataClassification = ToBeClassified;
        }
        field(18; DailyAllowanceTotal; Decimal)
        {
            Caption = 'DailyAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(19; OutStationAllowanceTotal; Decimal)
        {
            Caption = 'OutStationAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(20; HotelFoodAllowanceTotal; Decimal)
        {
            Caption = 'HotelFoodAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(21; Approved_amount; Decimal)
        {
            Caption = 'Approved_Amount';
            DataClassification = ToBeClassified;
        }
        field(22; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected";
        }
        field(23; Exam_Mode; Option)
        {
            Caption = 'Exam_Mode';
            DataClassification = ToBeClassified;
            OptionMembers = "Online Mode","Offline Mode";
        }
        field(24; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;

        }
        field(25; RefrenceNo; Code[20])
        {
            Caption = 'RefrenceNo';
            DataClassification = ToBeClassified;

        }
        field(26; Receiver_ID; Code[20])
        {
            Caption = 'Receiver_ID';
            DataClassification = ToBeClassified;

        }
        field(27; Sender_ID; Code[20])
        {
            Caption = 'Sender_ID';
            DataClassification = ToBeClassified;

        }

    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
