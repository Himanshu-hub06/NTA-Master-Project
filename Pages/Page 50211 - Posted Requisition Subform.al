page 50211 "Posted Requisition Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    PageType = ListPart;
    SourceTable = 50088;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = TypeEditable;
                }
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = ItemNoEditable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    //  Editable = UnitofmeasureEditble;
                }
                field("Stock on Hand To Section"; Rec."Stock on Hand To Section")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Required Quantity';
                    Editable = QtyEditable;
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = AppQtyEditable;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = false;
                }
                field("Apply to entry No."; Rec."Apply to entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Issued';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Requisition Remarks"; Rec."Requisition Remarks")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Requsition to Department"; Rec."Requsition to Department")
                {
                    ApplicationArea = All;
                    Editable = DepEditable;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        UserSetup.RESET;
        UserSetup.GET(USERID);
        IF UserSetup."Req Update" THEN BEGIN
            TypeEditable := TRUE;
            QtyEditable := TRUE;
            AppQtyEditable := TRUE;
            ItemNoEditable := TRUE;
            UnitofmeasureEditble := TRUE;
            DepEditable := TRUE;
        END ELSE BEGIN
            TypeEditable := FALSE;
            QtyEditable := FALSE;
            AppQtyEditable := FALSE;
            ItemNoEditable := FALSE;
            UnitofmeasureEditble := FALSE;
            DepEditable := FALSE;
        END;
        //IF ("Issued Quantity" = "Approved Qty") AND  Then
        Rec.SETFILTER("Remaining Qty", '>%1', 0);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.GET(USERID);
        IF NOT UserSetup."Req Update" THEN BEGIN
            ERROR('You donot have permision to insert new Item');
        END;
        Rec."Remaining Qty" := 1;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.GET(USERID);
        IF NOT UserSetup."Req Update" THEN BEGIN
            ERROR('You donot have permision to insert new Item');
        END;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.GET(USERID);
        IF UserSetup."Req Update" THEN BEGIN
            TypeEditable := TRUE;
            QtyEditable := TRUE;
            AppQtyEditable := TRUE;
            ItemNoEditable := TRUE;
            UnitofmeasureEditble := TRUE;
            DepEditable := TRUE;
        END ELSE BEGIN
            TypeEditable := FALSE;
            QtyEditable := FALSE;
            AppQtyEditable := FALSE;
            ItemNoEditable := FALSE;
            UnitofmeasureEditble := FALSE;
            DepEditable := FALSE;
        END;

        Rec.SETFILTER("Remaining Qty", '>%1', 0);
        //END;
        //SETRANGE(Quantity,0);
    end;

    var
        TypeEditable: Boolean;
        QtyEditable: Boolean;
        AppQtyEditable: Boolean;
        ItemNoEditable: Boolean;
        UnitofmeasureEditble: Boolean;
        UserSetup: Record 91;
        DepEditable: Boolean;
}

