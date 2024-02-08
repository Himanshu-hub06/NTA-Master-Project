page 50164 "Gems Purchase Proposal Line"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = ListPart;
    InsertAllowed = true;

    SourceTable = "Purchase Proposal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Requisition Line No."; Rec."Requisition Line No.")
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
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Approved Quantity"; Rec."Approved Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Per Unit';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("GST Include"; Rec."GST Include")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Rec."GST Include" THEN BEGIN
                            GstperVisible := TRUE;
                            GstamountVisible := TRUE;
                            ExtimatedAmountVisible := TRUE;
                        END ELSE BEGIN
                            GstperVisible := FALSE;
                            GstamountVisible := FALSE;
                            ExtimatedAmountVisible := FALSE;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("GST %"; Rec."GST %")
                {
                    Editable = true;
                    Visible = GstperVisible;
                    ApplicationArea = All;
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    Editable = true;
                    Visible = GstamountVisible;
                    ApplicationArea = All;
                }
                field("Estimated Cost Including GST"; Rec."Estimated Cost Including GST")
                {
                    Editable = false;
                    Visible = ExtimatedAmountVisible;
                    ApplicationArea = All;
                }
                field("Demand Order No."; Rec."Demand Order No.")
                {
                    ApplicationArea = All;
                }
                field("Demand Order Date"; Rec."Demand Order Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = true;
                    ApplicationArea = All;
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
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(Requisition)
                {
                    Caption = 'Requisition';
                    Image = ExplodeBOM;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //ExplodeBOM;
                        ReqTab.RESET;
                        ReqTab.SETRANGE(ReqTab."No.", Rec."Requisition No.");
                        IF ReqTab.FINDFIRST THEN BEGIN
                            PAGE.RUN(50685, ReqTab);
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Type := Rec.Type::Item;
        IF Rec."GST Include" THEN BEGIN
            GstperVisible := TRUE;
            GstamountVisible := TRUE;
            ExtimatedAmountVisible := TRUE;
        END ELSE BEGIN
            GstperVisible := FALSE;
            GstamountVisible := FALSE;
            ExtimatedAmountVisible := FALSE;
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Purchase Type" := Rec."Purchase Type"::GeM;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Purchase Type" := Rec."Purchase Type"::GeM;
    end;

    trigger OnOpenPage()
    begin
        IF Rec."GST Include" THEN BEGIN
            GstperVisible := TRUE;
            GstamountVisible := TRUE;
            ExtimatedAmountVisible := TRUE;
        END ELSE BEGIN
            GstperVisible := FALSE;
            GstamountVisible := FALSE;
            ExtimatedAmountVisible := FALSE;
        END;
    end;

    var
        // RequisitiontLine: Record "50038";
        RequisitiontLine: Record "Requistion Line";
        // RequisitiontLinesPage: Page "50018";
        RequisitiontLinesPage: Page 50194;
        GstperVisible: Boolean;
        GstamountVisible: Boolean;
        ExtimatedAmountVisible: Boolean;
        // ReqTab: Record "50037";
        ReqTab: Record "Requistion Header";

    procedure GetPurchReqLines()
    var
        // IndentLineRec: Record "50040";
        IndentLineRec: Record "Indent Line";
        // RequisitiontLine: Record "50038";
        RequisitiontLine: Record "Requistion Line";
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
        // RequisitiontLinesPage.GetDocument("Document No."); //kamlesh date 31-01-2023
        RequisitiontLinesPage.RUN;


    end;

    procedure GetPurchReqSlipLines()
    var
        // IndentLineRec: Record "50040";
        IndentLineRec: Record "Indent Line";
        // PostdIndentLinesFom: Page "50039";
        PostdIndentLinesFom: Page "Posted Indent Line";
    begin
        IndentLineRec.SETRANGE("Document No.", Rec."Document No.");
    end;
}

