#pragma implicitwith disable
page 50216 "Requisition Store Subform"
{
    AutoSplitKey = true;
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = 50088;

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
                field("Item Category"; Rec."Item Category")
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
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Required Quantity';
                    DecimalPlaces = 0 : 5;
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Stock on Hand To Section"; Rec."Stock on Hand To Section")
                {
                    DecimalPlaces = 0 : 5;
                }
                field("Required By Date"; Rec."Required By Date")
                {
                    Caption = 'Required Date';
                }
                field("Requisition Remarks"; Rec."Requisition Remarks")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TESTFIELD(Status,Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
    end;
}

#pragma implicitwith restore

