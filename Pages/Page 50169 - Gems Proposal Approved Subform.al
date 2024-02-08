page 50169 "Gems Proposal Approved Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
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
                    Editable = false;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requisition Line No."; Rec."Requisition Line No.")
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
                    Editable = false;
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
                    Editable = false;
                }
                field("Approved Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Cost';
                    Editable = false;
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
                // field("Revised Rate Per Unit"; "Revised Rate Per Unit")
                // {
                // }
                // field("Revised Estimated Cost"; "Revised Estimated Cost")
                // {
                // }
                // field("Demand Order Rate"; "Demand Order Rate")
                // {
                // }
                field("Demand Order No."; Rec."Demand Order No.")
                {
                    ApplicationArea = All;
                }
                field("Demand Order Date"; Rec."Demand Order Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
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
                // field("Cancel Demand Order No."; "Cancel Demand Order No.")
                // {
                //     Editable = false;
                // }
                // field("Cancel Demand Order Date"; "Cancel Demand Order Date")
                // {
                //     Editable = false;
                // }
                // field("Cancel Rate"; "Cancel Rate")
                // {
                // }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
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

    trigger OnAfterGetRecord()
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
        // ReqTab: Record "50037";
        ReqTab: Record "Requistion Header";
}

