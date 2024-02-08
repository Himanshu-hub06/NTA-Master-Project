/// <summary>
/// Page Closed/Issued Subform (ID 50772).
/// </summary>
#pragma implicitwith disable
page 50220 "Closed/Issued Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = 50092;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Stock on Hand To Dep"; Rec."Stock on Hand To Dep")
                {
                    ApplicationArea = All;
                }
                field("Approved Qty"; Rec."Approved Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Quantity';
                    DecimalPlaces = 0 : 3;
                    Editable = false;
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 3;
                    Editable = false;
                    Visible = false;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity  Issued';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Total Quantity Issued';
                    DecimalPlaces = 0 : 3;
                    Editable = false;
                }
                field("Requisition Remarks"; Rec."Requisition Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

