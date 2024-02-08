
table 50010 "Posted Centre Bill Header"
{
    //ExternalName = 'BILL_CentreBill_Mst';
    //ExternalSchema = 'dbo';
    //TableType = ExternalSQL;
    Caption = 'Posted Centre Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CentreBill ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'PK_CentreBill_ID';
        }
        field(2; "Centre ID"; Integer)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'FK_CentreId';
        }
        field(3; "Centre No."; Text[30])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Centre_No';
        }
        field(4; "Centre City"; Text[100])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'Centre_City';
        }
        field(5; "Centre Address"; Text[200])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'CentreName_Address';
        }
        field(6; "Superintendent Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'SuperintendentName';
        }
        field(7; "Contact No."; Text[30])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'ContactDetail';
        }
        field(8; "Exam ID"; Integer)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'FK_ExamId';
        }
        field(9; "Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'ExamDate';
        }
        field(10; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'TotalAmount';
        }
        field(11; "Advance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'AdvanceAvailed';
        }
        field(12; "Refund Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'RefundAmount';
        }
        field(13; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'CreatedBy';
        }
        field(14; "Created on"; DateTime)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'CreatedOn';
        }
        field(16; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
            // ExternalName = 'LastModifiedOn';
        }
        field(18; "Net Payble Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'NetAmount_PaidbyNTA';
        }
        field(19; "Net_Approved_Amount"; Decimal)
        {
            //FieldClass = FlowField;
            //CalcFormula = Sum("Centre Bill Line"."Approved Amount" WHERE (Centre Bill ID=FIELD(CentreBill ID)));
            //  ExternalName = 'NetApproved_Amount';

        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = "","Open","Pending Approval","CC Approved","CC Rejected","Posted","RC Approved","RC Rejected";
        }
        field(21; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            //  ExternalName = 'PostingDate_NAV';
        }
        field(22; "Exam Code"; Code[20])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Code" WHERE (Exam ID=FIELD(Exam ID)));
            // FieldClass = FlowField;
        }
        field(23; "Exam Name"; Text[100])
        {
            //CalcFormula = Lookup("Exam Master"."Exam Name" WHERE (Exam ID=FIELD(Exam ID)));
            //FieldClass = FlowField;
        }
        field(24; "File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'File_Path';
        }
        field(25; "Reference No."; Code[100])
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'Reference_No';
        }
        field(26; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
            //ExternalName = 'IsFinalSubmit';
        }
    }

    keys
    {
        key(Key1; "CentreBill ID")
        {
        }
    }

    fieldgroups
    {
    }

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
            "Total Amount" := TotAmt;
            "Refund Amount" := ABS(TotAmt - "Advance Amount");
            "Net Payble Amount" := 0;
        END ELSE BEGIN
            "Total Amount" := TotAmt;
            "Net Payble Amount" := TotAmt - "Advance Amount";
            "Refund Amount" := 0;
        END;
    end;
}

