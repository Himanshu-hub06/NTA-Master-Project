/// <summary>
/// Page Indent Proposal Create Subform (ID 50782).
/// </summary>
#pragma implicitwith disable
page 50230 "Indent Proposal Create Subform"
{
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
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Approved Quantity"; Rec."Approved Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Actual Requisition Qty"; Rec."Actual Requisition Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Per Unit';
                    Visible = false;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                    ApplicationArea = All;
                    Editable = false;
                    Visible = GstperVisible;
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = GstamountVisible;
                }
                field("Estimated Cost Including GST"; Rec."Estimated Cost Including GST")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ExtimatedAmountVisible;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
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
        GstperVisible: Boolean;
        GstamountVisible: Boolean;
        ExtimatedAmountVisible: Boolean;
}

#pragma implicitwith restore

