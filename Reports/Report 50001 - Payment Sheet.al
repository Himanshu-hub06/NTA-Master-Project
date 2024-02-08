report 50001 "Payment Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Payment Sheet.rdlc';
    PreviewMode = PrintLayout;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1000000000; "Approved Bills")
        {
            DataItemTableView = SORTING("Bill Type", "Bill ID")
                                ORDER(Ascending)
                                WHERE("Selection For Payment" = CONST(TRUE));
            column(BankNameBranch_ApprovedBills; "Bank Name & Branch")
            {
            }
            column(AccountNo_ApprovedBills; "Account No.")
            {

            }
            column(IFSCCode_ApprovedBills; "IFSC Code")
            {
            }
            column(BillID_ApprovedBills; "Bill ID")
            {
            }
            column(ExamID_ApprovedBills; "Exam ID")
            {
            }
            column(ExamDate_ApprovedBills; "Exam Date")
            {
            }
            column(PayableAmount_ApprovedBills; "Original Payable Amount")
            {
            }
            column(PostingDate_ApprovedBills; "Posting Date")
            {
            }
            column(ExamCode_ApprovedBills; "Exam Code")
            {
            }
            column(ExamName_ApprovedBills; "Exam Name")
            {
            }
            column(ReferenceNo_ApprovedBills; "Reference No.")
            {
            }
            column(BillType_ApprovedBills; "Bill Type")
            {
            }
            column(Name_ApprovedBills; Name)
            {
            }
            column(StateCode_ApprovedBills; "State Code")
            {
            }
            column(EmailID_ApprovedBills; "E-mail ID")
            {
            }
            column(Mobile_ApprovedBills; Mobile)
            {
            }
            column(BalanceAmount_ApprovedBills; "Balance Amount")
            {
            }
            column(CurrentPaymentAmount_ApprovedBills; "Current Payment Amount")
            {
            }
            column(SelectionForPayment_ApprovedBills; "Selection For Payment")
            {
            }
            column(Sr_No_; sn)
            {
            }
            column(Apprv_1; ApprName[1])
            {
            }
            column(Apprv_2; ApprName[2])
            {
            }
            column(Apprv_3; ApprName[3])
            {
            }
            column(Apprv_4; ApprName[4])
            {
            }
            column(Apprv_5; ApprName[5])
            {
            }


            trigger OnAfterGetRecord()
            begin
                sn += 1;
                i := 0;
                IF "Bill Type" = "Bill Type"::"Centre Bill" THEN
                    ApprvTab.SETRANGE(ApprvTab."Table ID", 50002)
                ELSE
                    IF "Bill Type" = "Bill Type"::"TA Bill" THEN
                        ApprvTab.SETRANGE(ApprvTab."Table ID", 50005);
                ApprvTab.SETRANGE("Document No.", "Bill ID");
                IF ApprvTab.FINDFIRST THEN
                    REPEAT
                        i += 1;
                        Approver[i] := ApprvTab."Approver ID";
                        UserTab.RESET;
                        UserTab.SETRANGE("User Name", ApprvTab."Approver ID");
                        IF UserTab.FINDFIRST THEN
                            ApprName[i] := UserTab."Full Name";
                    UNTIL ApprvTab.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        sn: Integer;
        Approver: array[10] of Code[20];
        ApprvTab: Record "Approval Entry";
        i: Integer;
        UserTab: Record "User";
        ApprName: array[10] of Text[50];
}

