page 50043 "TA/DA Bill List Current Status"
{
    Caption = 'TA/DA Bill Approval Status';
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 50005;
    // ApplicationArea = all;
    // SourceTableView = SORTING("Reference No", "Exam Mode", "Exam Date", Submitted)
    //                   ORDER(Ascending)
    //                   WHERE(Submitted = CONST(true),
    //                         Status = FILTER(<> Approved));
    ApplicationArea = all;
    SourceTableView = SORTING("Reference No", Exam_Mode, "Exam Date", Submitted)
                       ORDER(Ascending)
                       WHERE(Submitted = CONST(true),
                             Status = FILTER(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Gen)
            {
                field("Bill No."; Rec."Reference No")
                {
                    Width = 20;
                }

                field(Receiver_ID; Rec.Receiver_ID)
                {
                    //Width = 20;
                }




                field("NTA Unique ID"; Rec."NTA Unique ID")
                {
                }
                field("Requester Name"; Rec."Requester Name")
                {
                }
                field(Exam_Mode; Rec.Exam_Mode)
                {
                }
                field("Exam Name"; Rec."Exam Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Claimed Amount"; Rec."Claimed Amount")
                {
                }
                field("User ID"; ApproverID)
                {
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; Rec.COUNT)
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
    }

    trigger OnAfterGetCurrRecord()
    begin
        ApproverID := '';
        IF Rec.Status = Rec.Status::Open THEN
            ApproverID := Rec."First Level User";
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            ApprvalEnt.RESET;
            ApprvalEnt.SETRANGE("Bill Type", ApprvalEnt."Bill Type"::"TA/DA Bill");
            ApprvalEnt.SETRANGE("Reference No.", Rec."Reference No");
            ApprvalEnt.SETRANGE(Status, ApprvalEnt.Status::Open);
            ApprvalEnt.SETFILTER("Document No.", FORMAT(Rec."Bill ID"));
            IF ApprvalEnt.FIND('-') THEN
                ApproverID := ApprvalEnt."Approver ID";
        END;
        IF Rec.Status = Rec.Status::"Rejected" THEN BEGIN
            ApprvalEnt.RESET;
            ApprvalEnt.SETRANGE("Bill Type", ApprvalEnt."Bill Type"::"TA/DA Bill");
            ApprvalEnt.SETRANGE("Reference No.", Rec."Reference No");
            ApprvalEnt.SETRANGE(Status, ApprvalEnt.Status::Rejected);
            ApprvalEnt.SETRANGE("Sequence No.", 1);
            ApprvalEnt.SETFILTER("Document No.", FORMAT(Rec."Bill ID"));
            IF ApprvalEnt.FIND('-') THEN
                ApproverID := ApprvalEnt."Last Modified By User ID";
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        ClaimedAmt := 0;
        ApprovedAmt := 0;
        NTAUniqueID := '';
        ApproverID := '';

        IF Rec.Status = Rec.Status::Open THEN
            ApproverID := Rec."First Level User";
        IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
            ApprvalEnt.RESET;
            ApprvalEnt.SETRANGE("Bill Type", ApprvalEnt."Bill Type"::"TA/DA Bill");
            ApprvalEnt.SETRANGE("Reference No.", Rec."Reference No");
            ApprvalEnt.SETRANGE(Status, ApprvalEnt.Status::Open);
            ApprvalEnt.SETFILTER("Document No.", FORMAT(Rec."Bill ID"));
            IF ApprvalEnt.FIND('-') THEN
                ApproverID := ApprvalEnt."Approver ID";
        END;
        IF Rec.Status = Rec.Status::"Rejected" THEN BEGIN
            ApprvalEnt.RESET;
            ApprvalEnt.SETRANGE("Bill Type", ApprvalEnt."Bill Type"::"TA/DA Bill");
            ApprvalEnt.SETRANGE("Reference No.", Rec."Reference No");
            ApprvalEnt.SETRANGE(Status, ApprvalEnt.Status::Rejected);
            ApprvalEnt.SETRANGE("Sequence No.", 1);
            ApprvalEnt.SETFILTER("Document No.", FORMAT(Rec."Bill ID"));
            IF ApprvalEnt.FIND('-') THEN
                ApproverID := ApprvalEnt."Last Modified By User ID";
        END;
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Rec.Submitted, TRUE);
    end;

    var
        DateStyle: Text;
        ShowAllEntries: Boolean;
        ShowChangeFactBox: Boolean;
        ShowCommentFactbox: Boolean;
        ApprBillTab: Record 50017;
        ApprBillTab11: Record 50017;
        CentreBillTab: Record 50002;
        TABillTab: Record 50005;
        ClaimedAmt: Decimal;
        ApprovedAmt: Decimal;
        ApprovalEntry1: Record 454;
        Text001: Label 'Do you want to send back ?';
        Text002: Label 'Sent successfully.';
        //Editable: Boolean;
        ApprvalEnt: Record 454;
        SeqNo: Integer;
        ApprvalEnt2: Record 454;
        UserSetup: Record 91;
        NTAUniqueID: Code[100];
        ApproverID: Code[50];
}

