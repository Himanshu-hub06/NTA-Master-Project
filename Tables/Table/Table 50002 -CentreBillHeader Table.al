
table 50002 "Centre Bill Header"
{
    Caption = 'Centre Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CentreBill ID"; Integer)
        {
            Caption = 'CentreBill ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Centre ID"; Integer)
        {
            Caption = 'Centre ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Centre No."; Text[50])
        {
            Caption = 'Centre No.';
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin

            // end;// rk
        }
        field(4; "Centre City"; Text[100])
        {
            Caption = 'Centre City';
            DataClassification = ToBeClassified;
        }
        field(5; "Centre Address"; Text[250])
        {
            Caption = 'Centre Address';
            DataClassification = ToBeClassified;
        }
        field(6; "Superintendent Name"; Text[100])
        {
            Caption = 'Superintendent Name';
            DataClassification = ToBeClassified;
        }
        field(7; "Contact No."; Text[30])
        {
            Caption = 'Contact No';
            DataClassification = ToBeClassified;
        }
        field(8; "Exam ID"; Integer)
        {
            Caption = 'Exam ID';
            DataClassification = ToBeClassified;
        }
        field(9; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Claimed Amount"; Decimal)
        {
            Caption = 'Claimed Amount';
            DataClassification = ToBeClassified;
        }
        field(11; "Advance Amount"; Decimal)
        {
            Caption = 'Advance Amount';
            DataClassification = ToBeClassified;
        }
        field(12; "Refund Amount"; Decimal)
        {
            Caption = 'Refund Amount';
            DataClassification = ToBeClassified;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(14; "Created on"; DateTime)
        {
            Caption = 'Created on';
            DataClassification = ToBeClassified;
        }
        field(15; "Last Modified on"; DateTime)
        {
            Caption = 'Last Modified on';
            DataClassification = ToBeClassified;
        }
        field(16; "Net Payble Amount"; Decimal)
        {
            Caption = 'Net Payble Amount';
            DataClassification = ToBeClassified;
        }
        field(17; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TdsAmt: Decimal;
            begin
                CALCFIELDS("Approved Amount");
                TdsAmt := "Approved Amount" * "Tds percentage" / 100;
                VALIDATE("TDS Amount", TdsAmt);
                VALIDATE("Net Payble Amount", "Approved Amount" - "Advance Amount" - TdsAmt);
            end;
        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected",Release,Approved,Rejected,"Send For Modification","Disbursement Pending";
            ;

            //OptionMembers = "","Open","Pending Approval","Approved","Rejected","Posted","Send For Modification";  // commented by dhananjay 17 aug 2023
        }
        field(19; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            DataClassification = ToBeClassified;
        }
        field(21; "Exam Name"; Text[150])
        {
            Caption = 'Exam Name';
            //DataClassification = ToBeClassified;
            CalcFormula = Lookup("Exam Master"."Exam Name" WHERE("Exam ID" = FIELD("Exam ID")));
            Editable = false;
            FieldClass = FlowField; //RK

        }
        field(22; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = ToBeClassified;
        }
        field(23; "Reference No."; Code[100])
        {
            Caption = 'Reference No';
            DataClassification = ToBeClassified;
        }
        field(24; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(25; "Total Approved Amount"; Decimal)
        {
            Caption = 'Total Approved Amount';
            DataClassification = ToBeClassified;
        }
        field(26; "First Lvel User"; Code[50])
        {
            Caption = 'First Lvel User';
            DataClassification = ToBeClassified;
        }
        field(27; "Role ID"; Integer)
        {
            Caption = 'Role ID';
            DataClassification = ToBeClassified;
        }
        field(28; "Tds percentage"; Decimal)
        {
            Caption = 'Tds percentage';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TdsAmt: Decimal;
            begin
                CALCFIELDS("Approved Amount");
                TdsAmt := "Approved Amount" * "Tds percentage" / 100;
                VALIDATE("TDS Amount", TdsAmt);
                VALIDATE("Net Payble Amount", "Approved Amount" - "Advance Amount" - TdsAmt);
            end;
        }
        field(29; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DataClassification = ToBeClassified;
        }

        field(30; "NTA_Unique_Admin_ID"; text[50])
        {
            Caption = 'NTA_Unique_Admin_ID';
            DataClassification = ToBeClassified;
        }
        field(31; "Exam_Mode"; Option)
        {
            Caption = 'Exam_Mode';
            DataClassification = ToBeClassified;
            OptionMembers = "Online Mode","Offline Mode";
        }
        field(32; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;

        }
        field(33; Sender_ID; Code[20])
        {
            Caption = 'Sender_ID';
            DataClassification = ToBeClassified;

        }
        field(34; Receiver_ID; Code[20])
        {
            Caption = 'Receiver ID';
            DataClassification = ToBeClassified;
            TableRelation = "Approval User Group Member"."User ID" where("Approval User Group Code" = const('TALOCAL'));


        }
        field(35; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;

        }
        // field(36; "No."; code[20])
        // {
        //     Caption = 'No.';
        //     DataClassification = ToBeClassified;

        // }

        //* Newly Added Field as suggeted by dipenda Ji
        field(36; Sender_User_ID; CODE[50])

        {
            Caption = 'Sender User ID';
            DataClassification = ToBeClassified;
        }

        field(37; Sending_User_Name; Text[250])
        {
            Caption = 'Sending User Name';
            DataClassification = ToBeClassified;
        }

        field(38; Sending_Date; Date)
        {
            Caption = 'Sending Date';
            DataClassification = ToBeClassified;
        }

        field(39; Sending_Time; DateTime)
        {
            Caption = 'Sending Time';
            DataClassification = ToBeClassified;
        }
        field(40; Pending_User_Id; Code[40])
        {
            Caption = 'Pending User Id';
            DataClassification = ToBeClassified;
        }

        field(41; Pending_User_Name; Text[50])
        {
            Caption = 'Pending User Name';
            DataClassification = ToBeClassified;
        }

        field(42; Approved_User_ID; Code[40])
        {
            Caption = 'Approved User ID';
            DataClassification = ToBeClassified;
        }

        field(43; Approved_User_Name; Text[50])
        {
            Caption = 'Approved User Name';
            DataClassification = ToBeClassified;
        }

        field(44; Approved_Date; Date)
        {
            Caption = 'Approved Date';
            DataClassification = ToBeClassified;
        }
        field(45; Approved_Time; DateTime)
        {
            Caption = 'Approved Time';
            DataClassification = ToBeClassified;
        }

        field(46; Rejected_User_Id; Code[20])
        {
            Caption = 'Rejected User Id';
            DataClassification = ToBeClassified;
        }
        field(47; Rejected_user_Name; Text[50])
        {
            Caption = 'Rejected user Name';
            DataClassification = ToBeClassified;
        }
        field(48; Rejected_Date; Date)
        {
            Caption = 'Rejected Date';
            DataClassification = ToBeClassified;
        }

        field(49; Rejected_Time; DateTime)
        {
            Caption = 'Rejected Time';
            DataClassification = ToBeClassified;
        }

        //new field PAN N0. added after the demo on 26th July 2023 discussion

        field(50; PAN_N0; code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(51; Latitude; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(52; Longitude; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53; IP; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Bill Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,"Disbursement Pending";
        }
        field(55; "Rejection Remark"; Text[250])//Rk
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Created User"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Created Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(58; Attachment; Text[150])// nitin 28-08-23
        {
            DataClassification = ToBeClassified;
        }
        field(59; Centre_Name; Text[100])
        {
            DataClassification = ToBeClassified;
            //     CalcFormula = Lookup(ERP_MASTER_Centre.Centre_Name WHERE(Centre_Name = FIELD("CentreBill ID")));
            //     Editable = false;
            //     FieldClass = FlowField;
        }

    }
    keys
    {
        key(Key1; "CentreBill ID", "Centre ID")
        {
        }
        key(Key2; "Reference No.", "Exam ID", "Exam Date", Submitted)
        {
        }
    }

    fieldgroups
    {
    }
    var
        ERPMSTR: Record ERP_MASTER_Centre;

    trigger OnInsert()
    begin
        "Net Payble Amount" := "Claimed Amount" - "Advance Amount";


    end;



    procedure CalculateAmt()
    var
        CentreBillLine: Record "Centre Bill Line";
        TotAmt: Decimal;
        AdvAmt: Decimal;
        RefundAmt: Decimal;
        PaybleAmt: Decimal;
    begin
        TotAmt := 0;
        CentreBillLine.RESET;
        //CentreBillLine.SETRANGE(CentreBillLine."Document No.","Document No.");
        IF CentreBillLine.FIND('-') THEN BEGIN
            REPEAT
                TotAmt := TotAmt + CentreBillLine.Amount;
            UNTIL CentreBillLine.NEXT = 0;
        END;
        IF "Advance Amount" > TotAmt THEN BEGIN
            "Claimed Amount" := TotAmt;
            "Refund Amount" := ABS(TotAmt - "Advance Amount");
            "Net Payble Amount" := 0;
        END ELSE BEGIN
            "Claimed Amount" := TotAmt;
            "Net Payble Amount" := TotAmt - "Advance Amount";
            "Refund Amount" := 0;
        END;
    end;

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
        ApprovalCommentLine.SETRANGE("Table ID", DATABASE::"Centre Bill Header");
        //ApprovalCommentLine.SETRANGE("Record ID to Approve","Record ID to Approve");
        //ApprovalCommentLine.SETRANGE("Document Type",ApprovalCommentLine."Document Type"::Empanelment);
        ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", "Reference No.");
        PAGE.RUNMODAL(PAGE::"Approval Comments", ApprovalCommentLine);
    end;
    // procedure Post(var ContingentBillHeader: Record 50002)
    // var
    //      ContingentBillLines: Record 50002;
    //    // QSheetLines: Record 50121;
    //     //BillsManagement: Codeunit 50004;
    //     NoofLines: Integer;
    //     NOPurPost: Integer;
    // begin
    //     //Tests PFMS Unique Ref. No.
    //     ContingentBillLines.RESET;
    //    // ContingentBillLines.SETRANGE("Document Type", ContingentBillHeader."Document Type");
    //     ContingentBillLines.SETRANGE("Document No.", ContingentBillHeader."No.");
    //     IF ContingentBillLines.FINDFIRST THEN
    //         REPEAT
    //             ContingentBillLines.TESTFIELD("PFMS Unique Ref. No.");
    //         UNTIL ContingentBillLines.NEXT = 0;
}
