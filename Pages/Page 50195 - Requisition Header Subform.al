#pragma implicitwith disable
page 50195 "Requisition Header Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50088;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Type; Rec.Type)

                {
                    ApplicationArea = All;
                    ShowMandatory = true;


                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ReqLine.RESET;
                        ReqLine.SETRANGE(ReqLine."Requisition No.", Rec."Requisition No.");
                        ReqLine.SETRANGE(ReqLine."No.", Rec."No.");
                        IF ReqLine.FINDFIRST THEN BEGIN
                            //Recno := ReqLine.COUNT;
                            //IF Recno > 1 THEN

                            ERROR('Same Item already exist in previous Line');
                        END;
                    end;
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Required Quantity';
                    DecimalPlaces = 0 : 5;
                    ShowMandatory = true;
                }
                field("Required By Date"; Rec."Required By Date")
                {
                    ApplicationArea = All;
                    Caption = 'Required Date';
                }
                field("Requisition Remarks"; Rec."Requisition Remarks")
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

    trigger OnInit()
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TESTFIELD(Status,Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
        ReqLine.RESET;
        ReqLine.SETRANGE(ReqLine."Requisition No.", Rec."Requisition No.");
        ReqLine.SETRANGE(ReqLine."No.", Rec."No.");
        IF ReqLine.FINDFIRST THEN BEGIN
            // Recno := ReqLine.COUNT;
            // IF Recno > 1 THEN

            ERROR('Same Item already exist in previous Line');
        END;
    end;

    var
        ReqLine: Record 50088;
        Recno: Integer;
}

#pragma implicitwith restore

