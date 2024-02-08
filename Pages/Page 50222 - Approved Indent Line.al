/// <summary>
/// Page Approved Indent Line (ID 50774).
/// </summary>
#pragma implicitwith disable
page 50222 "Approved Indent Line"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = 50090;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field("Actual Requisition Qty"; Rec."Actual Requisition Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        RequisitiontLine: Record 50088;

    /// <summary>
    /// GetPurchReqLines.
    /// </summary>
    procedure GetPurchReqLines()
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
        PostdIndentLinesFom.RUNMODAL;*/
        /*//SLS
      RequisitiontLine.RESET;
      //RequisitiontLine.SETRANGE(RequisitiontLine."Requisition Selected",FALSE);
      RequisitiontLinesPage.SETTABLEVIEW(RequisitiontLine);
      RequisitiontLinesPage.GetDocument("Document No.");
      RequisitiontLinesPage.RUN;
        *///SLS

    end;

    procedure GetPurchReqSlipLines()
    var
        IndentLineRec: Record 50090;
        PostdIndentLinesFom: Page 50039;
    begin
        //IndentLineRec.SETRANGE("NP Code","Document No.");
    end;
}

#pragma implicitwith restore

