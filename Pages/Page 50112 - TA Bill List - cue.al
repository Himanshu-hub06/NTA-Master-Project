page 50112 "TA Bill List - cue"

{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "TA Bill Header";
    ApplicationArea = all;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; Rec."Reference No")
                {
                    Editable = false;
                    Width = 25;
                }
                field("Exam Name"; Rec."Exam Name")
                {
                    Editable = false;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                }
                field("NTA Unique ID"; Rec."NTA Unique ID")
                {
                }
                field("Requester Name"; Rec."Requester Name")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Claimed Amount"; Rec."Claimed Amount")
                {
                }
                field("Hotel Amount"; Rec."Total Amount Hotel")
                {
                    Visible = false;
                }
                field("Local Amount"; Rec."Total Amount Local")
                {
                    Visible = false;
                }
                field("Oustation Amount"; Rec."Total Amount Outstation")
                {
                    Visible = false;
                }
                field("Net Payable Amount"; Rec."Total Amount Hotel" + Rec."Total Amount Outstation" + Rec."Total Amount Local" + Rec."Remuneration Amount" - Rec."TDS Amount")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; Rec.COUNT)
                {
                    Caption = 'Total No. Of Records';
                    ColumnSpan = 3;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    var
        sn: Integer;
}

