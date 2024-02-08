table 50005 "TA Bill Header"
{
    Caption = 'TA Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bill ID"; Integer)
        {
            Caption = 'Bill ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; BillType; Option)
        {
            Caption = 'BillType';
            DataClassification = ToBeClassified;
            OptionMembers = ,"Local","OutStation";
        }
        // field(3; "Exam ID"; Integer)
        // {
        //     Caption = 'Exam ID';
        //     DataClassification = ToBeClassified;
        // }
        field(4; "Exam Date"; DateTime)
        {
            Caption = 'Exam Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Requester Name"; Text[250])
        {
            Caption = 'Requester Name';
            DataClassification = ToBeClassified;
        }
        field(6; Designation; Text[250])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
        }
        field(7; "Address For Communication"; Text[250])
        {
            Caption = 'Address For Communication';
            DataClassification = ToBeClassified;
        }
        field(8; "Contact No"; Text[30])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
        }
        field(9; Bank_Branch_Name; Text[1000])
        {
            Caption = 'Bank Name & Branch';
            DataClassification = ToBeClassified;
        }
        field(10; "Bank_Account_No"; Text[50])
        {
            Caption = 'Bank_Account_No';
            DataClassification = ToBeClassified;
        }
        field(11; "IFSC Code"; Text[50])
        {
            Caption = 'IFSC Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Claimed Amount"; Decimal)
        {
            Caption = 'Claimed Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Total Amount Local"; Decimal)
        {
            Caption = 'Total Amount Local';
            DataClassification = ToBeClassified;
        }
        field(14; "Total Amount Outstation"; Decimal)
        {
            Caption = 'Total Amount Outstation';
            DataClassification = ToBeClassified;
        }
        field(15; "Total Amount Hotel"; Decimal)
        {
            Caption = 'Total Amount Hotel';
            DataClassification = ToBeClassified;
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;

            OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected",Release,Approved,Rejected,"Send For Modification","Disbursement Pending";
            ;
            //OptionMembers = "","Open","Pending Approval","Approved","Rejected","Posted","Send For Modification";  //Commented by dhananjay Singh ON 17 JULY 2023
            //OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected";
            //OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected",Release,Approved,;
            //OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected",Release,Approved,;
        }

        field(17; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(18; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            DataClassification = ToBeClassified;
        }
        field(19; "Exam Name"; Text[100])
        {
            Caption = 'Exam Name';
            DataClassification = ToBeClassified;
        }
        field(20; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(21; "Reference No"; Code[100])
        {
            Caption = 'Reference No';
            DataClassification = ToBeClassified;
        }
        field(22; "Last Modified on"; DateTime)
        {
            Caption = 'Last Modified on';
            DataClassification = ToBeClassified;
        }
        field(23; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TdsAmt: Decimal;
            begin
                TdsAmt := "Approved Amount" * "TDS Percent" / 100;
                VALIDATE("TDS Amount", TdsAmt)
            end;
        }
        field(24; "First Level User"; Code[50])
        {
            Caption = 'First Level User';
            DataClassification = ToBeClassified;
        }
        field(25; "Role ID"; Integer)
        {
            Caption = 'Role ID';
            DataClassification = ToBeClassified;
        }
        field(26; "TDS Percent"; Decimal)
        {
            Caption = 'TDS (%)';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TdsAmt: Decimal;
            begin
                TdsAmt := "Approved Amount" * "TDS Percent" / 100;
                VALIDATE("TDS Amount", TdsAmt);
            end;
        }
        field(27; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DataClassification = ToBeClassified;
        }
        field(28; "Remuneration Days"; Integer)
        {
            Caption = 'Remuneration Days';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Remuneration Days" < 0 THEN
                    ERROR('Days should be greater than zero');
                VALIDATE("Remuneration Amount", "Remuneration Rate" * "Remuneration Days");
                CALCFIELDS("Total Amount Local", "Total Amount Outstation", "Total Amount Hotel");
            end;
        }
        field(29; "Remuneration Rate"; Decimal)
        {
            Caption = 'Remuneration Rate';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Remuneration Rate" < 0 THEN
                    ERROR('Rate should be greater than zero');
                VALIDATE("Remuneration Amount", "Remuneration Rate" * "Remuneration Days");
                CALCFIELDS("Total Amount Local", "Total Amount Outstation", "Total Amount Hotel");
            end;
        }
        field(30; "Remuneration Amount"; Decimal)
        {
            Caption = 'Remuneration Amount';
            DataClassification = ToBeClassified;
        }
        field(31; "NTA Unique ID"; Text[100])
        {
            Caption = 'NTA Unique ID';
            DataClassification = ToBeClassified;
        }

        field(32; "Exam_ID"; Integer)
        {
            Caption = 'Exam_ID';
            DataClassification = ToBeClassified;
        }
        field(33; "CreatedDate"; DateTime)
        {
            Caption = 'CreatedDate';
            DataClassification = ToBeClassified;
        }

        field(34; "DailyAllowanceTotal"; Decimal)
        {
            Caption = 'DailyAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(35; "OutStationAllowanceTotal"; Decimal)
        {
            Caption = 'OutStationAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(36; "HotelFoodAllowanceTotal"; Decimal)
        {
            Caption = 'HotelFoodAllowanceTotal';
            DataClassification = ToBeClassified;
        }
        field(37; "Exam_Mode"; Integer)
        {
            Caption = 'Exam Mode';
            DataClassification = ToBeClassified;
        }
        field(38; "Remark"; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(39; Receiver_ID; Text[250])
        {
            Caption = 'Receiver ID';
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" where("Approval User Group Code" = const('TALOCAL'));
            trigger OnValidate()
            var
                UserGroupp: Record 50082;
            begin
                UserGroupp.RESET;
                UserGroupp.SETRANGE("User ID", "Receiver_ID");
                UserGroupp.SETRANGE("Approval User Group Code", 'TALOCAL');
                IF UserGroupp.FINDFIRST THEN
                    "Receiver User Name" := UserGroupp."User Description"
                ELSE
                    "Receiver User Name" := '';
            end;
        }
        field(40; Sender_ID; Text[250])
        {
            Caption = 'Sender ID';
            DataClassification = ToBeClassified;
        }

        //* New Added Filed as suggeted by Dipenra Sir
        field(41; Sender_User_ID; CODE[50])

        {
            Caption = 'Sender User ID';
            DataClassification = ToBeClassified;
        }

        field(42; Sending_User_Name; Text[250])
        {
            Caption = 'Sending User Name';
            DataClassification = ToBeClassified;
        }

        field(43; Sending_Date; Date)
        {
            Caption = 'Sending Date';
            DataClassification = ToBeClassified;
        }

        field(44; Sending_Time; DateTime)
        {
            Caption = 'Sending Time';
            DataClassification = ToBeClassified;
        }
        field(45; Pending_User_Id; Code[40])
        {
            Caption = 'Pending User Id';
            DataClassification = ToBeClassified;
        }

        field(46; Pending_User_Name; Text[50])
        {
            Caption = 'Pending User Name';
            DataClassification = ToBeClassified;
        }

        field(47; Approved_User_ID; Code[40])
        {
            Caption = 'Approved User ID';
            DataClassification = ToBeClassified;
        }

        field(48; Approved_User_Name; Text[50])
        {
            Caption = 'Approved User Name';
            DataClassification = ToBeClassified;
        }

        field(49; Approved_Date; Date)
        {
            Caption = 'Approved Date';
            DataClassification = ToBeClassified;
        }
        field(50; Approved_Time; Time)
        {
            Caption = 'Approved Time';
            DataClassification = ToBeClassified;
        }

        field(51; Rejected_User_Id; Code[20])
        {
            Caption = 'Rejected User Id';
            DataClassification = ToBeClassified;
        }
        field(52; Rejected_user_Name; Text[50])
        {
            Caption = 'Rejected user Name';
            DataClassification = ToBeClassified;
        }

        field(53; Rejected_Date; Date)
        {
            Caption = 'Rejected Date';
            DataClassification = ToBeClassified;
        }

        field(54; Rejected_Time; Time)
        {
            Caption = 'Rejected Time';
            DataClassification = ToBeClassified;
        }
        field(55; "Receiver User Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        // field(56; "Responsibility Centre"; Code[10])//Rashmi19-07-2023
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center";
        // }

        field(57; Modification_Remark; text[500])
        {
            DataClassification = ToBeClassified;
        }

        //new field  PAN No. added after the demo on 26th July 2023 discussion

        field(58; PAN_N0; code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(59; Latitude; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(60; Longitude; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(61; IP; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Bill Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,"Disbursement Pending";
        }
        field(63; "Rejection Remark"; Text[250])//Rk
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Created User"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Created Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Bill ID")
        {
            Clustered = true;
        }

        key(Key2; "NTA Unique ID", Submitted)
        {
            // Clustered = true;
        }
        key(Key3; "Reference No", Exam_Mode, "Exam Date", Submitted)
        {
            // Clustered = true;
        }

    }

    procedure InsertApprovalEntry(TabID: Integer; DocType: Option; DocNo: Code[20]; ApproverID: Code[20]; RecIDToApprove: RecordID)
    var
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
    begin
        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.RESET;
        ApprovalEntryRec."Table ID" := TabID;
        ApprovalEntryRec."Document No." := DocNo;
        ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Quote;
        ApprovalEntryRec."Entry No." := EntryNo + 1;
        ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
        ApprovalEntryRec."Sender ID" := USERID;
        ApprovalEntryRec."Approver ID" := ApproverID;
        ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
        ApprovalEntryRec."Last Modified By User ID" := USERID;
        ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
        ApprovalEntryRec."Record ID to Approve" := RecIDToApprove;
        ApprovalEntryRec.INSERT;
    end;


    procedure ApprovalComment()
    var
        ApprovalCommentLine: Record 455;
    begin
        ApprovalCommentLine.SETRANGE("Table ID", DATABASE::"TA Bill Header");
        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", "Reference No");
        PAGE.RUNMODAL(PAGE::"Approval Comments", ApprovalCommentLine);
    end;



}
