#pragma implicitwith disable
page 50223 "Indent Po Fill Line List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50090;
    SourceTableView = WHERE(Status = FILTER(Approved),
                            "PO Select" = FILTER(false),
                            "Remaining Quantity" = FILTER(> 0));

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
            action("Fill PO From Indent")
            {
                Image = Indent;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FromIndentLine: Record 50090;
                    TotalQty: Decimal;
                    PurchaseLine2: Record 39;
                    PurchaseLine: Record 39;
                begin
                    PurchHdrNew.RESET;
                    PurchHdrNew.SETRANGE(PurchHdrNew."No.", NewDocNo);
                    IF PurchHdrNew.FINDFIRST THEN BEGIN
#pragma warning disable AL0603
                        DocumentType := PurchHdrNew."Document Type";
#pragma warning restore AL0603
                    END;
                    PurchLineRec.RESET;
                    PurchLineRec.SETRANGE(PurchLineRec."Document No.", NewDocNo);
                    IF PurchLineRec.FIND('+') THEN
                        NextLineNo := PurchLineRec."Line No.";

                    FromIndentLine.RESET;
                    FromIndentLine.SETRANGE(FromIndentLine.Selected, TRUE);
                    FromIndentLine.SETRANGE(FromIndentLine."PO Select", FALSE);
                    IF FromIndentLine.FINDSET THEN BEGIN
                        REPEAT
                            NextLineNo := NextLineNo + 10000;
                            PurchaseLine2.INIT;
                            IF DocumentType = DocumentType::Order THEN
                                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Order;
                            IF DocumentType = DocumentType::Quote THEN
                                PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Quote;

                            PurchaseLine2."Document No." := NewDocNo;
                            PurchaseLine2."Line No." := NextLineNo;
                            PurchaseLine2."Shortcut Dimension 1 Code" := FromIndentLine."Shortcut Dimension 1 Code";
                            PurchaseLine2."Shortcut Dimension 2 Code" := FromIndentLine."Shortcut Dimension 2 Code";
                            //PurchaseLine2."Shortcut Dimension 2 Code" := FromIndentLine.Department;
                            //      PurchaseLine2."Cost Centre Dimension" := FromIndentLine."Cost Centre Dimension";//EXP
                            IF FromIndentLine.Type = FromIndentLine.Type::" " THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::Item;
                            IF FromIndentLine.Type = FromIndentLine.Type::"G/L Account" THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::"G/L Account";
                            IF FromIndentLine.Type = FromIndentLine.Type::Item THEN
                                PurchaseLine2.Type := PurchaseLine2.Type::Item;
                            PurchaseLine2.VALIDATE("No.", FromIndentLine."No.");
                            // PurchaseLine2."No." := FromIndentLine."No.";
                            PurchaseLine2.Description := FromIndentLine.Description;
                            PurchaseLine2."Description 2" := FromIndentLine."Description 2";
                            //PurchaseLine2."Description 3" := FromIndentLine."Description 3";//EXP
                            PurchaseLine2.VALIDATE("Location Code", Rec."Location Code"); //
                            PurchaseLine2.VALIDATE(Quantity, FromIndentLine."Remaining Quantity"); //
                                                                                                   //PurchaseLine2."Location Code" := FromIndentLine."Location Code";
                                                                                                   //PurchaseLine2.Quantity := FromIndentLine.Quantity;
                            PurchaseLine2."Unit of Measure Code" := FromIndentLine."Unit Of Measure Code";
                            PurchaseLine2."Indent No." := FromIndentLine."Document No.";//EXP
                                                                                        //PurchaseLine2."Indent Line No." := FromIndentLine."Line No.";//EXP
                            PurchaseLine2.INSERT;

                            //FromIndentLine."PO Select":=TRUE;
                            FromIndentLine.Selected := FALSE;
                            FromIndentLine.MODIFY;
                        UNTIL FromIndentLine.NEXT = 0;
                        MESSAGE('Document Successfully Filled');
                        CurrPage.CLOSE;
                    END ELSE
                        EXIT;
                end;
            }
        }
    }

    var
        PurchLineRec: Record 39;
        ProdJnlMgmt: Codeunit 5510;
        TotalLine: Integer;
        NextLineNo: Integer;
        PurchaseLine: Record 39;
        PurchaseLine2: Record 39;
        IndentLine1: Record 50090;
        PurchHdr: Record 38;
        NewDocNo: Code[20];
        IndentHeaderRec: Record 50089;
        UserSetup: Record 91;
        PurchLine: Record 39;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        PurchHdrNew: Record 38;

    procedure GetDocument(Doc: Code[20])
    begin
        NewDocNo := Doc;
    end;
}

#pragma implicitwith restore

