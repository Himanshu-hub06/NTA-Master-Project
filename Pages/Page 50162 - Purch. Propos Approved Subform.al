page 50162 "Purch. Propos Approved Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Proposal Line";
    // SourceTable = Table50012;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved Quantity"; Rec."Approved Quantity")
                {
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Caption = 'Rate Per Unit';
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                    Editable = false;
                    Visible = GstperVisible;
                    ApplicationArea = All;
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    Editable = false;
                    Visible = GstamountVisible;
                }
                field("Estimated Cost Including GST"; Rec."Estimated Cost Including GST")
                {
                    Editable = false;
                    Visible = ExtimatedAmountVisible;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
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

