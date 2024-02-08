/// <summary>
/// Codeunit LOE Management (ID 50015).
/// </summary>
codeunit 50007 "LOA Management"
{
    procedure PendingAmountonApprovedAdmin(LOCNo: Code[20]): Decimal
    var
        PurchHead: Record "Purchase Header";

        PendAmt: Decimal;
    begin

        PurchHead.RESET;
        PurchHead.SetRange("Account Accepted", true);
        PurchHead.SetRange("Sanction No.", '');
        PurchHead.SetFilter(PurchHead."Loc Fund Entry No.", LOCNo);

        if PurchHead.FindFirst() then
            repeat
                PurchHead.CalcFields(Amount);
                PendAmt += PurchHead.Amount;
            UNTIL PurchHead.Next() = 0;
    end;

    procedure AllocateFundsAdmin(var TempPurchHead: Record "Purchase Header" temporary): Boolean

    var
        LoaAttachment: record "Loa Attachment";
        PurchHead: Record "Purchase Header";
        PendingAmt: Decimal;
        RemainingAmtonLOA: Decimal;
        CurrentLOCNO: Code[20];
        AllocateAmtonPurchHead: Decimal;
        AllocateSucessful: Boolean;
        QryLOAFundStatus: Query "Loa Fund Status admin";

    begin


        if TempPurchHead.FindFirst() then;
        QryLOAFundStatus.Open();
        if QryLOAFundStatus.Read() then
            PendingAmt := PendingAmountonApprovedAdmin(QryLOAFundStatus.LoaNo);

        RemainingAmtonLOA := QryLOAFundStatus.AuthorizedAmount - PendingAmt;

        if RemainingAmtonLOA > TempPurchHead.Amount then begin
            if PurchHead.GET(TempPurchHead."Document Type"::Invoice, TempPurchHead."No.") tHEN begin
                PurchHead."Loc Fund Entry No." := QryLOAFundStatus.LoaNo;
                PurchHead.CalcFields(Amount);
                AllocateAmtonPurchHead += PurchHead."Amount";
                PurchHead.Modify();
            ENd;



            //      until (TempPurchHead.NEXT = 0);



            Commit;
        end;
    END;







}


