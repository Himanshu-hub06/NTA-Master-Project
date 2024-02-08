/// <summary>
/// Codeunit ItemJnlManagement Ext (ID 50011).
/// </summary>
codeunit 50004 "ItemJnlManagement Ext"
{
    /// <summary>
    /// FillItemJournalFromRequisition1.
    /// </summary>
    /// <param name="RequisitionNo">Code[20].</param>
    procedure FillItemJournalFromRequisition1(RequisitionNo: Code[20])
    var
        ItemJournalLineRec: Record "Item Journal Line";
        ItemJournalLineRec1: Record "Item Journal Line";
        RequisitionHead: Record "Requistion Header";
        RequisitionLine: Record "Requistion Line";
        RequisitionLine1: Record "Requistion Line";
        InvSetup: Record "Inventory Setup";
        PostedReqHead: Record "Posted Requistion Header";
        PostedReqLine: Record "Posted Requistion Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemTab: Record Item;
    begin
        InvSetup.GET;
        LineNo := 0;
        RequisitionHead.RESET;
        RequisitionHead.SETRANGE(RequisitionHead."No.", RequisitionNo);
        IF RequisitionHead.FINDFIRST THEN BEGIN
            //IF RequisitionHead."Requisition Type" = RequisitionHead."Requisition Type"::Consumable THEN BEGIN
            RequisitionLine.RESET;
            RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", RequisitionNo);
            RequisitionLine.SETRANGE(RequisitionLine."Item Type", RequisitionLine."Item Type"::Consumable);
            IF RequisitionLine.FIND('-') THEN BEGIN
                REPEAT
                    IF RequisitionLine."Quantity To Issue" <> 0.0 THEN BEGIN
                        ItemJournalLineRec.INIT;
                        ItemJournalLineRec."Journal Template Name" := InvSetup."Requisition Template";
                        ItemJournalLineRec."Journal Batch Name" := InvSetup."Requisition Batch";
                        ItemJournalLineRec."Requisition No." := RequisitionNo;
                        ItemJournalLineRec."Line No." := RequisitionLine."Line No.";
                        ItemJournalLineRec."Entry Type" := ItemJournalLineRec."Entry Type"::"Negative Adjmt.";
                        ItemJournalLineRec."Source Code" := 'ITEMJNL';
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Item No.", RequisitionLine."No.");

                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Unit of Measure Code", RequisitionLine."Unit of Measure Code");
                        RequisitionLine.CALCFIELDS(RequisitionLine."Stock on Hand To Section");
                        IF RequisitionLine."Quantity To Issue" > RequisitionLine."Stock on Hand To Section" THEN
                            ERROR('You cannot issue more than available quantity');
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec.Quantity, RequisitionLine."Quantity To Issue");

                        ItemJournalLineRec."Posting Date" := RequisitionHead."Issued Date";
                        ItemJournalLineRec."Document Date" := RequisitionHead."Issued Date";

                        ItemJournalLineRec."Document No." := RequisitionLine."Requisition No.";
                        ItemJournalLineRec."Requisition Line" := RequisitionLine."Line No.";
                        ItemJournalLineRec.VALIDATE("Location Code", RequisitionLine."Location Code");

                        ItemJournalLineRec."Applies-to Entry" := RequisitionLine."Apply to entry No.";
                        ItemJournalLineRec.VALIDATE("Shortcut Dimension 2 Code", RequisitionHead."Requisition to Section");
                        //ItemJournalLineRec.VALIDATE("Shortcut Dimension 1 Code",RequisitionHead."Shortcut Dimension 1 Code");

                        //ItemJournalLineRec.INSERT(TRUE);
                        ItemJnlPostLine.RunWithCheck(ItemJournalLineRec);
                        COMMIT;
                    END;
                UNTIL RequisitionLine.NEXT = 0;
            END;
            //END ELSE BEGIN
            RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", RequisitionNo);
            RequisitionLine.SETRANGE(RequisitionLine."Item Type", RequisitionLine."Item Type"::Transferable);
            IF RequisitionLine.FIND('-') THEN BEGIN
                REPEAT
                    IF RequisitionLine."Quantity To Issue" <> 0.0 THEN BEGIN
                        ItemJournalLineRec.INIT;
                        ItemJournalLineRec."Journal Template Name" := InvSetup."Requisition Template";
                        ItemJournalLineRec."Journal Batch Name" := InvSetup."Requisition Batch";
                        ItemJournalLineRec."Requisition No." := RequisitionNo;
                        ItemJournalLineRec."Posting Date" := RequisitionHead."Issued Date";
                        ItemJournalLineRec."Line No." := RequisitionLine."Line No.";
                        ItemJournalLineRec."Entry Type" := ItemJournalLineRec."Entry Type"::"Negative Adjmt.";
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Item No.", RequisitionLine."No.");
                        ItemJournalLineRec."Source Code" := 'ITEMJNL';
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Unit of Measure Code", RequisitionLine."Unit of Measure Code");
                        RequisitionLine.CALCFIELDS(RequisitionLine."Stock on Hand To Section");
                        IF RequisitionLine."Quantity To Issue" > RequisitionLine."Stock on Hand To Section" THEN
                            ERROR('You cannot issue more than available quantity');
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec.Quantity, RequisitionLine."Quantity To Issue");
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Unit Cost", RequisitionLine."Unit Cost");

                        ItemJournalLineRec."Document Date" := RequisitionHead."Issued Date";
                        ItemJournalLineRec."Document No." := RequisitionLine."Requisition No.";
                        ItemJournalLineRec."Requisition Line" := RequisitionLine."Line No.";



                        ItemJournalLineRec.VALIDATE("Location Code", RequisitionLine."Location Code");

                        ItemJournalLineRec.VALIDATE("Shortcut Dimension 2 Code", RequisitionHead."Requisition to Section");
                        //ItemJournalLineRec.VALIDATE("Shortcut Dimension 1 Code",RequisitionHead."Shortcut Dimension 1 Code");


                        //ItemJournalLineRec.INSERT(TRUE);
                        ItemJnlPostLine.RunWithCheck(ItemJournalLineRec);
                        //COMMIT;//EXp
                    END;
                UNTIL RequisitionLine.NEXT = 0;
                //ItemJournalLineRec1.RESET;
                // ItemJournalLineRec1.SETRANGE(ItemJournalLineRec1."Journal Template Name",JournalTemplateName);
                // ItemJournalLineRec1.SETRANGE(ItemJournalLineRec1."Journal Batch Name",JournalBatchName);
                //ItemJournalLineRec1.SETRANGE("Requisition No.",RequisitionNo);
                // IF ItemJournalLineRec1.FINDLAST THEN BEGIN
                // LineNo := ItemJournalLineRec1."Line No." + 10000  ;
                RequisitionLine1.SETRANGE(RequisitionLine1."Requisition No.", RequisitionNo);
                RequisitionLine1.SETRANGE(RequisitionLine1."Item Type", RequisitionLine1."Item Type"::Transferable);
                IF RequisitionLine1.FIND('-') THEN BEGIN
                    REPEAT
                        IF RequisitionLine1."Quantity To Issue" <> 0.0 THEN BEGIN
                            ItemJournalLineRec1.INIT;
                            ItemJournalLineRec1."Journal Template Name" := InvSetup."Requisition Template";
                            ItemJournalLineRec1."Journal Batch Name" := InvSetup."Requisition Batch";
                            ItemJournalLineRec1."Requisition No." := RequisitionNo;
                            ItemJournalLineRec1."Posting Date" := RequisitionHead."Issued Date";
                            ItemJournalLineRec1."Line No." := LineNo;
                            ItemJournalLineRec1."Entry Type" := ItemJournalLineRec1."Entry Type"::"Positive Adjmt.";
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1."Item No.", RequisitionLine1."No.");
                            ItemJournalLineRec1."Source Code" := 'ITEMJNL';
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1."Unit of Measure Code", RequisitionLine1."Unit of Measure Code");
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1.Quantity, RequisitionLine1."Quantity To Issue");

                            ItemJournalLineRec1."Document Date" := RequisitionHead."Issued Date";
                            ItemJournalLineRec1."Document No." := RequisitionLine1."Requisition No.";
                            ItemJournalLineRec1."Requisition Line" := RequisitionLine1."Line No.";

                            ItemJournalLineRec1.VALIDATE("Location Code", RequisitionLine1."Location Code");

                            ItemJournalLineRec1.VALIDATE("Shortcut Dimension 2 Code", RequisitionHead."Shortcut Dimension 2 Code");
                            // ItemJournalLineRec1.VALIDATE("Shortcut Dimension 1 Code",RequisitionHead."Shortcut Dimension 1 Code");

                            // COMMIT;
                            // ItemJournalLineRec1.INSERT(TRUE);
                            ItemJnlPostLine.RunWithCheck(ItemJournalLineRec1);
                            LineNo := LineNo + 10000;
                            // COMMIT;
                        END;
                    UNTIL RequisitionLine1.NEXT = 0;
                END;
                //  END;
            END;
        END;
        //END;
        RequisitionHead.RESET;
        RequisitionHead.SETRANGE(RequisitionHead."No.", RequisitionNo);
        IF RequisitionHead.FINDFIRST THEN BEGIN
            //RequisitionHead.Status := RequisitionHead.Status::Issued;
            //RequisitionHead."Issued By"  := USERID;
            //RequisitionHead."Issued Date" := RequisitionHead."Issued Date";
            //RequisitionHead.MODIFY;
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Posted Requisition No.");
            PostedReqHead.TRANSFERFIELDS(RequisitionHead);
            PostedReqHead."No." := NoSeriesMgt.GetNextNo(InvSetup."Posted Requisition No.", RequisitionHead."Issued Date", TRUE);
            PostedReqHead."Requisition No." := RequisitionNo;
            PostedReqHead.Status := PostedReqHead.Status::Issued;
            PostedReqHead.INSERT;
            RequisitionLine.RESET;
            RequisitionLine.SETCURRENTKEY(RequisitionLine."Requisition No.", RequisitionLine."Quantity To Issue");
            RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", RequisitionNo);
            RequisitionLine.SETFILTER(RequisitionLine."Quantity To Issue", '<>%1', 0);
            IF RequisitionLine.FINDFIRST THEN BEGIN
                REPEAT

                    PostedReqLine.TRANSFERFIELDS(RequisitionLine);
                    PostedReqLine."Requisition No." := PostedReqHead."No.";
                    PostedReqLine."Issued Quantity" := PostedReqLine."Quantity To Issue" + PostedReqLine."Issued Quantity";
                    PostedReqLine."Remaining Qty" := RequisitionLine."Remaining Qty" - RequisitionLine."Quantity To Issue";
                    //PostedReqLine."Quantity To Issue" := 0;
                    PostedReqLine.INSERT;
                    RequisitionLine."Issued Quantity" := RequisitionLine."Quantity To Issue" + RequisitionLine."Issued Quantity";
                    RequisitionLine."Remaining Qty" := RequisitionLine."Remaining Qty" - RequisitionLine."Quantity To Issue";
                    RequisitionLine."Quantity To Issue" := 0;
                    RequisitionLine.MODIFY;
                UNTIL RequisitionLine.NEXT = 0;
            END;

        END;
        MESSAGE('Requisition No. %1 Issued successfuly', RequisitionNo);
    end;

    internal procedure FillPurchasePraposalFromIndent("IndentNo.": Code[20])
    var
        UserSetup: Record "User Setup";
    begin

        UserSetup.GET(USERID);
        IndentHead.RESET;
        IndentHead.SETRANGE(IndentHead."No.", "IndentNo.");
        IF IndentHead.FINDFIRST THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD(PurchSetup."Purchase Proposal Nos.");
            PurchPraposalHead.TRANSFERFIELDS(IndentHead);
            PurchPraposalHead."Purchase Type" := IndentHead."Purchase Type";
            PurchPraposalHead."No." := NoSeriesMgt.GetNextNo(PurchSetup."Purchase Proposal Nos.", IndentHead."Posting Date", TRUE);
            PurchPraposalHead."Indent No." := "IndentNo.";
            PurchPraposalHead.Status := PurchPraposalHead.Status::Open;
            PurchPraposalHead."Posting Date" := IndentHead."Proposal Created Date";
            PurchPraposalHead.VALIDATE("Shortcut Dimension 2 Code", UserSetup.Section);
            PurchPraposalHead."User ID" := USERID;
            PurchPraposalHead."Transfer User Id" := '';
            PurchPraposalHead."Transfer User Name" := '';
            PurchPraposalHead.INSERT;
            IndentLine.RESET;
            IndentLine.SETRANGE(IndentLine."Document No.", "IndentNo.");
            IndentLine.SETRANGE(IndentLine."Select Item For Proposal", TRUE);
            IF IndentLine.FINDFIRST THEN BEGIN
                REPEAT
                    PurchPraposalLine.TRANSFERFIELDS(IndentLine);
                    PurchPraposalLine."Document No." := PurchPraposalHead."No.";
                    PurchPraposalLine."Purchase Type" := PurchPraposalHead."Purchase Type";
                    IndentLine."Select Item For Proposal" := FALSE;
                    IndentLine."Purchase Proposal Created" := TRUE;
                    IndentLine."Purchase Proposal No." := PurchPraposalHead."No.";
                    IndentLine."Purchase Proposal Line No." := PurchPraposalLine."Line No.";
                    PurchPraposalLine.INSERT;
                    IndentLine.MODIFY;
                UNTIL IndentLine.NEXT = 0;

            END;
            IndentLine1.RESET;
            IndentLine1.SETRANGE(IndentLine1."Document No.", "IndentNo.");
            IndentLine1.SETRANGE(IndentLine1."Purchase Proposal Created", FALSE);
            IF NOT IndentLine1.FINDFIRST THEN BEGIN
                IndentHead."Converted Date" := WORKDATE;
                IndentHead."Purchase Proposal Created" := TRUE;
                IndentHead."Proposal Created Date" := PurchPraposalHead."Creation Date";
                IndentHead.MODIFY;
            END;

        END;

    end;

    /// <summary>
    /// FillItemJournalFromRequisition2.
    /// </summary>
    /// <param name="RequisitionNo">Code[20].</param>
    procedure FillItemJournalFromRequisition2(RequisitionNo: Code[20])
    var
        ItemJournalLineRec,
ItemJournalLineRec1 : Record "Item Journal Line";
        IssueHead: Record "Issue Header";
        IssueLine,
IssueLine1 : Record "Issue Line";
    begin
        InvSetup.GET;
        LineNo := 0;
        IssueHead.RESET;
        IssueHead.SETRANGE(IssueHead."No.", RequisitionNo);
        IF IssueHead.FINDFIRST THEN BEGIN
            IssueLine.SETRANGE(IssueLine."Document No.", RequisitionNo);
            IF IssueLine.FIND('-') THEN BEGIN
                REPEAT
                    IF IssueLine.Quantity <> 0.0 THEN BEGIN
                        // IssueLine.TESTFIELD(IssueLine."Unit Cost");//For Discussion
                        ItemJournalLineRec.INIT;
                        ItemJournalLineRec."Journal Template Name" := InvSetup."Requisition Template";
                        ItemJournalLineRec."Journal Batch Name" := InvSetup."Requisition Batch";
                        ItemJournalLineRec."Requisition No." := RequisitionNo;
                        ItemJournalLineRec."Line No." := IssueLine."Line No.";
                        ItemJournalLineRec."Posting Date" := IssueHead."Issued Date";

                        ItemJournalLineRec."Entry Type" := ItemJournalLineRec."Entry Type"::"Negative Adjmt.";
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Item No.", IssueLine."No.");
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Unit of Measure Code", IssueLine."Unit of Measure Code");
                        IssueLine.CALCFIELDS(IssueLine."Stock in Hand");
                        IF IssueLine.Quantity > IssueLine."Stock in Hand" THEN
                            ERROR('You cannot issue more than available quantity for Item %1', IssueLine."No.");
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec.Quantity, IssueLine.Quantity);
                        ItemJournalLineRec.VALIDATE(ItemJournalLineRec."Unit Cost", IssueLine."Unit Cost");
                        ItemJournalLineRec."Document Date" := IssueHead."Posting Date";
                        ItemJournalLineRec."Document No." := IssueLine."Document No.";
                        ItemJournalLineRec.VALIDATE("Location Code", IssueLine."Location Code");
                        ItemJournalLineRec.VALIDATE("Shortcut Dimension 2 Code", IssueHead."Shortcut Dimension 2 Code");
                        ItemJournalLineRec.VALIDATE("Shortcut Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");
                        ItemJournalLineRec."Dimension Set ID" := IssueHead."Dimension Set ID";
                        ItemJournalLineRec."Applies-to Entry" := IssueLine."Apply to Entry No.";

                        ItemJnlPostLine.RunWithCheck(ItemJournalLineRec);
                        // COMMIT;
                    END;
                UNTIL IssueLine.NEXT = 0;
                //ItemJournalLineRec1.RESET;
                // ItemJournalLineRec1.SETRANGE(ItemJournalLineRec1."Journal Template Name",JournalTemplateName);
                // ItemJournalLineRec1.SETRANGE(ItemJournalLineRec1."Journal Batch Name",JournalBatchName);
                //ItemJournalLineRec1.SETRANGE("Requisition No.",RequisitionNo);
                // IF ItemJournalLineRec1.FINDLAST THEN BEGIN
                // LineNo := ItemJournalLineRec1."Line No." + 10000  ;
                IssueLine1.SETRANGE(IssueLine1."Document No.", RequisitionNo);
                IF IssueLine1.FIND('-') THEN BEGIN
                    REPEAT
                        IF IssueLine1.Quantity <> 0.0 THEN BEGIN
                            ItemJournalLineRec1.INIT;
                            ItemJournalLineRec1."Journal Template Name" := InvSetup."Requisition Template";
                            ItemJournalLineRec1."Journal Batch Name" := InvSetup."Requisition Batch";
                            ItemJournalLineRec1."Requisition No." := RequisitionNo;
                            ItemJournalLineRec1."Line No." := LineNo;
                            ItemJournalLineRec1."Posting Date" := IssueHead."Issued Date";

                            ItemJournalLineRec1."Entry Type" := ItemJournalLineRec1."Entry Type"::"Positive Adjmt.";
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1."Item No.", IssueLine1."No.");
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1."Unit of Measure Code", IssueLine1."Unit of Measure Code");

                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1.Quantity, IssueLine1.Quantity);
                            ItemJournalLineRec1.VALIDATE(ItemJournalLineRec1."Unit Cost", IssueLine."Unit Cost");
                            ItemJournalLineRec1."Document Date" := IssueHead."Posting Date";
                            ItemJournalLineRec1."Document No." := IssueLine1."Document No.";
                            ItemJournalLineRec1."Requisition Line" := IssueLine1."Line No.";
                            ItemJournalLineRec1.VALIDATE("Location Code", IssueLine1."Location Code");
                            ItemJournalLineRec1.VALIDATE("Shortcut Dimension 2 Code", IssueHead."Issue to Section");
                            ItemJournalLineRec1.VALIDATE("Shortcut Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");

                            ItemJnlPostLine.RunWithCheck(ItemJournalLineRec1);
                            LineNo := LineNo + 10000;
                            // COMMIT;
                        END;
                    UNTIL IssueLine1.NEXT = 0;
                END;
                //  END;
            END;
            // END;
        END;
        IssueHead.RESET;
        IssueHead.SETRANGE(IssueHead."No.", RequisitionNo);
        IF IssueHead.FINDFIRST THEN BEGIN
            IssueHead.Status := IssueHead.Status::Issued;
            IssueHead.Posted := TRUE;
            IssueHead."Issued By" := USERID;
            IssueHead."Issued Date" := IssueHead."Issued Date";
            IssueHead.MODIFY;
            IssueLine.RESET;
            IssueLine.SETRANGE(IssueLine."Document No.", RequisitionNo);
            IF IssueLine.FINDFIRST THEN BEGIN
                REPEAT
                    IssueLine.Status := IssueLine.Status::Issued;
                    IssueLine.MODIFY;
                UNTIL IssueLine.NEXT = 0;
            END;
        END;
        MESSAGE('Issue No. %1 Issued successfuly', RequisitionNo);
    end;

    var
        JournalTemplateName: Text[30];
        JournalBatchName: Text[30];
        LineNo: Integer;
        InvSetup: Record "Inventory Setup";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPraposalHead: Record "Purchase Proposal Header";
        PurchPraposalLine: Record "Purchase Proposal Line";
        IndentLine, IndentLine1 : Record "Indent Line";
        IndentHead: Record "Indent Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
