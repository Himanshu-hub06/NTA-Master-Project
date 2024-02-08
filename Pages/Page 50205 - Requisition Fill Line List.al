#pragma implicitwith disable
page 50205 "Requisition Fill Line List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50088;
    SourceTableView = ORDER(Descending);
    PromotedActionCategories = 'New,Process,Report,Fill Requision Line';

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
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Required By Date"; Rec."Required By Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requsition to Department"; Rec."Requsition to Department")
                {
                    ApplicationArea = All;
                    Caption = 'Requsition to Section';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("FIll Indent From Requisition")
            {
                ApplicationArea = All;
                Image = Indent;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    FromPostdIndentLine: Record 50090;
                    TotalQty: Decimal;
                begin
                    IndentLine.RESET;
                    IndentLine.SETRANGE(IndentLine."Document No.", NewDocNo);

                    IF IndentLine.FIND('+') THEN
                        NextLineNo := IndentLine."Line No.";

                    RequistionLine.RESET;
                    RequistionLine.SETRANGE(RequistionLine.Selected, TRUE);
                    RequistionLine.SETRANGE(RequistionLine."Requisition Selected", FALSE);
                    IF RequistionLine.FINDSET THEN BEGIN
                        REPEAT

                            RequistionLine1.RESET;
                            RequistionLine1.SETRANGE(RequistionLine1."No.", RequistionLine."No.");
                            RequistionLine1.SETRANGE(RequistionLine1.Selected, TRUE);
                            RequistionLine1.SETRANGE(RequistionLine1."Requisition Selected", FALSE);
                            IF RequistionLine1.FINDFIRST THEN BEGIN
                                TotalQty := 0;
                                REPEAT
                                    TotalQty := TotalQty + RequistionLine1."Approved Qty";
                                UNTIL RequistionLine1.NEXT = 0;
                            END;
                            IndentLine2.RESET;
                            IndentLine2.SETRANGE(IndentLine2."No.", RequistionLine."No.");
                            IndentLine2.SETRANGE(IndentLine2."Document No.", NewDocNo);
                            IF NOT IndentLine2.FINDFIRST THEN BEGIN
                                NextLineNo := NextLineNo + 10000;
                                //IndentLine2.INIT;
                                IndentLine2."Document No." := NewDocNo;
                                IndentLine2."Line No." := NextLineNo;
                                IndentLine2."Shortcut Dimension 1 Code" := RequistionLine."Shortcut Dimension 1 Code";

                                //IndentLine2.Type := IndentLine2.Type::Item;  //cs-ds
                                IndentLine2."Item Category" := RequistionLine."Item Category";
                                IndentLine2.VALIDATE("No.", RequistionLine."No.");
                                IndentLine2.Priority := RequistionLine.Priority;
                                IndentLine2.Description := RequistionLine.Description;
                                IndentLine2."Description 2" := RequistionLine."Description 2";
                                IndentLine2."Description 3" := RequistionLine."Description 3";
                                IndentLine2."Item Type" := RequistionLine."Item Type";
                                IndentLine2.VALIDATE("Location Code", RequistionLine."Location Code");
                                //IndentLine2.VALIDATE(Quantity,RequistionLine."Remaining Qty");
                                IndentLine2."Requisition No." := RequistionLine."Requisition No.";

                                IndentLine2."Requisition Line No." := RequistionLine."Line No.";
                                IndentLine2."Unit Of Measure Code" := RequistionLine."Unit of Measure Code";
                                IndentLine2."Due Date" := RequistionLine."Required By Date";
                                IndentLine2.Remarks := RequistionLine."Requisition Remarks";
                                IndentLine2.VALIDATE(Quantity, TotalQty);
                                IndentLine2."Actual Requisition Qty" := TotalQty;
                                IndentLine2.INSERT;

                            END;
                            RequistionLine."Requisition Selected" := TRUE;
                            RequistionLine.Selected := FALSE;
                            RequistionLine."Indent No." := IndentLine2."Document No.";
                            RequistionLine."Indent Line No." := IndentLine2."Line No.";
                            RequistionLine.MODIFY;
                        UNTIL RequistionLine.NEXT = 0;
                        MESSAGE('Document Successfully Filled');
                        CurrPage.CLOSE;
                    END ELSE
                        EXIT;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Corp - for locatione user access - start

        /*IF usersetup.GET(USERID) THEN BEGIN
          FILTERGROUP(2);
          IF usersetup."Indent Approval" <> '' THEN
            SETFILTER("Location Code",usersetup."Indent Approval");
          FILTERGROUP(0);
        END;
        //Corp - for location wise user access - end
        
        */
        Rec.SETRANGE("Requisition Selected", FALSE);
        //IndentLine.SETRANGE(IndentLine."Document No.",

    end;

    var
        IndentLineRec: Record 50090;
        ProdJnlMgmt: Codeunit 5510;
        TotalLine: Integer;
        NextLineNo: Integer;
        NewDocNo: Code[20];
        IndentLine: Record 50090;
        RequistionLine: Record 50088;
        RequistionLine1: Record 50088;
        IndentLine2: Record 50090;
        usersetup: Record 91;
        TotalQty: Decimal;
        ActTotalReqQty: Decimal;

    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="NewIndentLineRec">Record 50173.</param>
    procedure Initialize(NewIndentLineRec: Record 50090)
    begin
        IndentLineRec := NewIndentLineRec;
    end;

    /// <summary>
    /// GetDocument.
    /// </summary>
    /// <param name="Doc">Code[20].</param>
    procedure GetDocument(Doc: Code[20])
    begin
        NewDocNo := Doc;
    end;
}

#pragma implicitwith restore

