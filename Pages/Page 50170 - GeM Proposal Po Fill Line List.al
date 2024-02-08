page 50170 "GeM Proposal Po Fill Line List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Proposal Po Fill Line List';
    PageType = List;
    SourceTable = "Purchase Proposal Line";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            "PO Selected" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Quantity"; Rec."Approved Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Fill PO From Proposal")
            {
                Image = Indent;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    FromProposalLine: Record "Purchase Proposal Line";

                    TotalQty: Decimal;
                    PurchaseLine2: Record 39;
                    PurchaseLine: Record "Purchase Line";
                begin
                    PurchHdrNew.RESET;
                    PurchHdrNew.SETRANGE(PurchHdrNew."No.", NewDocNo);
                    IF PurchHdrNew.FINDFIRST THEN BEGIN
                        DocumentType := PurchHdrNew."Document Type";
                    END;
                    PurchLineRec.RESET;
                    PurchLineRec.SETRANGE(PurchLineRec."Document No.", NewDocNo);
                    IF PurchLineRec.FIND('+') THEN
                        NextLineNo := PurchLineRec."Line No.";

                    FromProposalLine.RESET;
                    FromProposalLine.SETRANGE(FromProposalLine.Selected, TRUE);
                    FromProposalLine.SETRANGE(FromProposalLine."PO Selected", FALSE);
                    IF FromProposalLine.FINDSET THEN BEGIN
                        REPEAT
                            NextLineNo := NextLineNo + 10000;
                            PurchaseLine2.INIT;
                            IF DocumentType = DocumentType::Order THEN
                                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Order;
                            IF DocumentType = DocumentType::Quote THEN
                                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Quote;

                            PurchaseLine2."Document No." := NewDocNo;
                            PurchaseLine2."Line No." := NextLineNo;
                            PurchaseLine2."Shortcut Dimension 1 Code" := FromProposalLine."Shortcut Dimension 1 Code";
                            PurchaseLine2."Shortcut Dimension 2 Code" := FromProposalLine."Shortcut Dimension 2 Code";
                            //PurchaseLine2."Shortcut Dimension 2 Code" := FromIndentLine.Department;
                            //      PurchaseLine2."Cost Centre Dimension" := FromIndentLine."Cost Centre Dimension";//EXP
                            IF FromProposalLine.Type = FromProposalLine.Type::" " THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::Item;
                            IF FromProposalLine.Type = FromProposalLine.Type::"G/L Account" THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::"G/L Account";
                            // Added by DS FOR FA START
                            IF FromProposalLine.Type = FromProposalLine.Type::"Fixed Asset" then
                                PurchaseLine2.Type := PurchaseLine2.Type::"Fixed Asset";
                            //END--DS
                            IF FromProposalLine.Type = FromProposalLine.Type::Item THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::Item;


                            //PurchaseLine2.VALIDATE("No.", FromProposalLine."No.");

                            PurchaseLine2."No." := FromProposalLine."No.";


                            // PurchaseLine2."No." := FromIndentLine."No.";
                            PurchaseLine2.Description := FromProposalLine.Description;
                            PurchaseLine2."Description 2" := FromProposalLine."Description 2";
                            //PurchaseLine2."Description 3" := FromIndentLine."Description 3";//EXP

                            PurchaseLine2.VALIDATE("Location Code", Rec."Location Code"); //
                            PurchaseLine2.VALIDATE(Quantity, FromProposalLine."Remaining Quantity"); //

                            PurchaseLine2."Unit of Measure Code" := FromProposalLine."Unit Of Measure Code";
                            PurchaseLine2."Indent No." := FromProposalLine."Document No.";//EXP

                            PurchaseLine2.INSERT;
                            IF FromProposalLine."Purchase Type" = FromProposalLine."Purchase Type"::Direct THEN
                                FromProposalLine."PO Selected" := FALSE
                            ELSE
                                FromProposalLine."PO Selected" := TRUE;


                            FromProposalLine.Selected := FALSE;
                            FromPurchProposalLine."Purchase Order No." := PurchaseLine2."Document No.";
                            FromPurchProposalLine."Purchase Line No" := PurchaseLine2."Line No.";

                            FromProposalLine.MODIFY;
                            PucrhSetup.GET;
                        UNTIL FromProposalLine.NEXT = 0;
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE(PurchaseHeader."No.", PurchaseLine2."Document No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseHeader."Purchase Proposal" := FromProposalLine."Document No.";
                            PurchaseHeader.MODIFY;
                        END;

                        MESSAGE('Document Successfully Filled');
                        FromPurchProposalLine.RESET;
                        FromPurchProposalLine.SETRANGE(FromPurchProposalLine."Document No.", FromProposalLine."Document No.");
                        FromPurchProposalLine.SETRANGE(FromPurchProposalLine."PO Select", TRUE);
                        IF NOT FromPurchProposalLine.FINDFIRST THEN BEGIN
                            PucrhSetup.GET;
                            FromPurchProposalHead.RESET;
                            FromPurchProposalHead.SETRANGE(FromPurchProposalHead."No.", FromProposalLine."Document No.");
                            IF FromPurchProposalHead.FINDFIRST THEN BEGIN
                                PostedProposalHaed.TRANSFERFIELDS(FromPurchProposalHead);
                                PostedProposalHaed.Posted := TRUE;
                                PostedProposalHaed."No." := NoSeriesMgt.GetNextNo(PucrhSetup."Posted Purchase Proposal Nos.", WORKDATE, TRUE);
                                PostedProposalHaed.INSERT;
                                FromPurchProposalLine1.RESET;
                                FromPurchProposalLine1.SETRANGE(FromPurchProposalLine1."Document No.", FromProposalLine."Document No.");
                                IF FromPurchProposalLine1.FINDFIRST THEN BEGIN
                                    REPEAT
                                        FromPurchProposalLine2.TRANSFERFIELDS(FromPurchProposalLine1);
                                        FromPurchProposalLine2."Document No." := PostedProposalHaed."No.";
                                        FromPurchProposalLine2.INSERT;
                                    UNTIL FromPurchProposalLine1.NEXT = 0;
                                END;
                                FromPurchProposalHead.DELETE;
                            END;
                        END;
                        CurrPage.CLOSE;
                    END ELSE
                        EXIT;
                end;
            }
        }
    }

    var
        PurchLineRec, PurchaseLine, PurchaseLine2 : Record 39;
        ProdJnlMgmt: Codeunit 5510;
        TotalLine: Integer;
        NextLineNo: Integer;
        // PurchaseLine: Record "39";
        // PurchaseLine2: Record "39";
        ProposLLine1: Record "Purchase Proposal Line";
        // ProposLLine1: Record "50012";
        PurchHdr: Record 38;
        NewDocNo: Code[20];
        IndentHeaderRec: Record "Indent Header";
        // IndentHeaderRec: Record "50039";
        UserSetup: Record 91;
        PurchLine: Record 39;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        PurchHdrNew: Record 38;
        // PostedProposalHaed: Record "50008";
        PostedProposalHaed: Record "Posted Purchase Proposal Head";
        // PostedProposalLine: Record "50009";
        // PostedProposalLine: Record "50009";
        FromPurchProposalHead: Record "Purchase Proposal Header";
        // FromPurchProposalHead: Record "50011";
        PostedProposalLine: Record "Posted Purchase Proposal Line";
        FromPurchProposalLine: Record "Posted Purchase Proposal Line";
        FromPurchProposalLine1: Record "Posted Purchase Proposal Line";
        FromPurchProposalLine2: Record "Posted Purchase Proposal Line";
        // FromPurchProposalLine1: Record "50009";
        // FromPurchProposalLine2: Record "50009";
        PucrhSetup: Record 312;
        NoSeriesMgt: Codeunit 396;
        PurchaseHeader: Record 38;

    procedure GetDocument(Doc: Code[20])
    begin
        NewDocNo := Doc;
    end;
}

