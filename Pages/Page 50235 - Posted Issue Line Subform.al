/// <summary>
/// Page Posted Issue Line Subform (ID 50235).
/// </summary>
#pragma implicitwith disable
page 50235 "Posted Issue Line Subform"
{
    AutoSplitKey = true;
    DelayedInsert = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = 50094;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    ApplicationArea = All;
                }
                field("Stock in Hand"; Rec."Stock in Hand")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Stock on Hand To Dep"; Rec."Stock on Hand To Dep")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Issue Quantity';
                }
                field("Issue Remarks"; Rec."Issue Remarks")
                {
                    ApplicationArea = All;
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

