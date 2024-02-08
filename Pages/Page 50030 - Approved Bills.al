page 50030 "Approved Bills"
{
    PageType = List;
    SourceTable = "Approved Bills";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Selection For Payment"; rec."Selection For Payment")
                {
                }
                field("Bill Type"; rec."Bill Type")
                {
                    Editable = false;
                }
                field("Bill ID"; rec."Bill ID")
                {
                    Visible = false;
                }
                field("Reference No."; rec."Reference No.")
                {
                    Editable = false;
                }
                field("Centre ID"; rec."Centre ID")
                {
                    Editable = false;
                }
                field("Centre No."; rec."Centre No.")
                {
                    Editable = false;
                }
                field("Exam ID"; rec."Exam ID")
                {
                    Editable = false;
                }
                field("Exam Code"; rec."Exam Code")
                {
                    Editable = false;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    Editable = false;
                }
                field("Exam Date"; rec."Exam Date")
                {
                    Editable = false;
                }
                field("E-mail ID"; rec."E-mail ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("State Code"; rec."State Code")
                {
                    Visible = false;
                }
                field(Mobile; rec.Mobile)
                {
                    Editable = false;
                }
                field("Original Payable Amount"; rec."Original Payable Amount")
                {
                    Editable = false;
                }
                field("Balance Payable Amount"; rec."Balance Payable Amount")
                {
                    Editable = false;
                }
                field("Current Payment Amount"; rec."Current Payment Amount")
                {
                }
                field("Balance Amount"; rec."Balance Amount")
                {
                    Editable = false;
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; rec.COUNT)
                {
                    Caption = 'Total No. Of Records';
                    ColumnSpan = 3;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Test Summary Sheet")
            {
                Caption = 'Test Summary Sheet';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AppBillTab.RESET;
                    AppBillTab.SETRANGE("Selection For Payment", TRUE);
                    IF AppBillTab.FINDFIRST THEN
                        REPORT.RUN(50000, TRUE, TRUE, AppBillTab);
                end;
            }
            action("Post & Pay")
            {
                Caption = 'Post & Pay';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AppBillTab.RESET;
                    AppBillTab.SETRANGE("Selection For Payment", TRUE);
                    AppBillTab.SETFILTER("Current Payment Amount", '>%1', 0);
                    IF AppBillTab.FINDFIRST THEN
                        REPORT.RUN(50001, FALSE, FALSE, AppBillTab);
                    /*
                    PstdBillTab1.SETCURRENTKEY("Unique Code");
                    PstdBillTab1.LOCKTABLE;
                    IF PstdBillTab1.FINDLAST THEN
                      UnqCode := INCSTR(PstdBillTab1."Unique Code")
                    ELSE
                      UnqCode := '000001';
                    AppBillTab.RESET;
                    AppBillTab.SETRANGE("Selection For Payment",TRUE);
                    AppBillTab.SETFILTER("Current Payment Amount",'<>%1',0);
                    AppBillTab1.COPY(AppBillTab);
                    IF AppBillTab.FINDFIRST THEN BEGIN
                      IF CONFIRM('Do You Want to make payment for %1 Bills?',TRUE,AppBillTab.COUNT) THEN
                       REPEAT
                        LineNo := 1000;
                        PstdBillTab3.RESET;
                        PstdBillTab3.SETRANGE(PstdBillTab3."Bill Type",AppBillTab."Bill Type");
                        PstdBillTab3.SETRANGE(PstdBillTab3."Bill ID",AppBillTab."Bill ID");
                        IF PstdBillTab3.FINDLAST THEN
                          LineNo := PstdBillTab3."Line No."+1000;
                        PstdBillTab2.INIT;
                        PstdBillTab2."Bill Type" := AppBillTab."Bill Type";
                        PstdBillTab2."Bill ID" := AppBillTab."Bill ID";
                        PstdBillTab2."Line No." := LineNo;
                        PstdBillTab2."Centre ID" := AppBillTab."Centre ID";
                        PstdBillTab2."Centre No." := AppBillTab."Centre No.";
                        PstdBillTab2."Unique Code" := UnqCode;
                        PstdBillTab2."Exam ID" :=  AppBillTab."Exam ID";
                        PstdBillTab2."Exam Date" := AppBillTab."Exam Date";
                        PstdBillTab2."Bank Name & Branch" := AppBillTab."Bank Name & Branch";
                        PstdBillTab2."Account No." := AppBillTab."Account No.";
                        PstdBillTab2."IFSC Code" := AppBillTab."IFSC Code";
                        PstdBillTab2."Posting Date" := TODAY;
                        PstdBillTab2."Reference No." := AppBillTab."Reference No.";
                        PstdBillTab2.Name := AppBillTab.Name;
                        PstdBillTab2."State Code" := AppBillTab."State Code";
                        PstdBillTab2."E-mail ID" := AppBillTab."E-mail ID";
                        PstdBillTab2.Mobile := AppBillTab.Mobile;
                        PstdBillTab2."Exam Code" := AppBillTab."Exam Code";
                        PstdBillTab2."Exam Name" := AppBillTab."Exam Name";
                        PstdBillTab2."Payment Amount" := AppBillTab."Current Payment Amount";
                        PstdBillTab2.INSERT;
                       UNTIL AppBillTab.NEXT=0;
                    END;
                    //For updation in Approved Bill Table
                    IF AppBillTab1.FINDFIRST THEN REPEAT
                      AppBillTab1."Balance Payable Amount" := AppBillTab1."Balance Payable Amount"-AppBillTab1."Current Payment Amount";
                      AppBillTab1."Current Payment Amount" := 0;
                      AppBillTab1."Selection For Payment" := FALSE;
                      AppBillTab1.MODIFY;
                     UNTIL AppBillTab1.NEXT=0;
                    CurrPage.UPDATE;

                    AppBillTab1.RESET;
                    AppBillTab1.SETFILTER("Balance Payable Amount",'%1',0);
                    IF AppBillTab1.FINDFIRST THEN BEGIN
                    //  IF CONFIRM('%1',FALSE,AppBillTab1.COUNT) THEN
                        AppBillTab1.DELETEALL;
                     END;
                    */

                end;
            }
            action("Select All")
            {
                Caption = 'Select All';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    AppBillTab.RESET;
                    IF AppBillTab.FINDFIRST THEN
                        AppBillTab.MODIFYALL("Selection For Payment", TRUE);
                    CurrPage.UPDATE;
                end;
            }
            action("De-Select All")
            {
                Caption = 'De-Select All';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    AppBillTab.RESET;
                    IF AppBillTab.FINDFIRST THEN
                        AppBillTab.MODIFYALL("Selection For Payment", FALSE);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        NetAmt: Decimal;
        AppBillTab: Record "Approved Bills";
        PstdBillTab1: Record "Posted Approved Bills";
        PstdBillTab2: Record "Posted Approved Bills";
        UnqCode: Code[20];
        PstdBillTab3: Record "Posted Approved Bills";
        LineNo: Integer;
        AppBillTab1: Record "Approved Bills";
}

