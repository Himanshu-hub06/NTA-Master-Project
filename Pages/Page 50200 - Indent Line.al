#pragma implicitwith disable
page 50200 "Indent Line"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = 50090;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Actual Requisition Qty"; Rec."Actual Requisition Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
    end;

    var
        RequisitiontLine: Record 50088;
        RequisitiontLinesPage: Page 50205;

    procedure GetPurchReqLines()
    var
        IndentLineRec: Record 50090;
        RequisitiontLine: Record 50088;
    begin
        /*PostdIndentLine.FILTERGROUP(2);
        PostdIndentLine.SETFILTER(PostdIndentLine."Remaining Qty",'<>%1',0);
        //PostdIndentLine.SETFILTER(PostdIndentLine."Indent No.",'<>%1','');
        PostdIndentLinesFom.SETTABLEVIEW(PostdIndentLine);
        PostdIndentLine.FILTERGROUP(0);
        
        IndentLineRec.RESET;
        IndentLineRec.SETRANGE("Document No.",DocNo);
        IF IndentLineRec.FIND('+') THEN
        //  PostdIndentLinesFom.Initialize(IndentLineRec)
        //ELSE
        //  PostdIndentLinesFom.Initialize(Rec);
        
        //PostdIndentLinesFom.LOOKUPMODE(TRUE);
        PostdIndentLinesFom.RUNMODAL;
        IndentLine.RESET;
        IndentLine.SETRANGE(IndentLine."Location Code",Loc);
        IndentLine.SETRANGE(IndentLine."PO Select",FALSE);
        IndentLinesPoFom.SETTABLEVIEW(IndentLine);
        IndentLinesPoFom.GetDocument("Document No.");
        IndentLinesPoFom.RUN;
        */

        RequisitiontLine.RESET;
        RequisitiontLinesPage.SETTABLEVIEW(RequisitiontLine);
        RequisitiontLinesPage.GetDocument(Rec."Document No.");
        RequisitiontLinesPage.RUN;


    end;

    /// <summary>
    /// GetPurchReqSlipLines.
    /// </summary>
    procedure GetPurchReqSlipLines()
    var
        IndentLineRec: Record 50090;
        PostdIndentLinesFom: Page 50196;
    begin
        IndentLineRec.SETRANGE("Document No.", Rec."Document No.");
    end;
}

#pragma implicitwith restore

