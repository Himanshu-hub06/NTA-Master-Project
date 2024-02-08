page 50022 "Approved TA Bill List"
{
    CardPageID = "Approved TA Bill Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "TA Bill Header";
    ApplicationArea = all;
    SourceTableView = SORTING("Bill ID")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; rec."Reference No")
                {
                    Editable = false;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    Editable = false;
                }
                field("Exam Date"; rec."Exam Date")
                {
                }
                field("NTA Unique ID"; rec."NTA Unique ID")
                {
                }
                field("Requester Name"; rec."Requester Name")
                {
                }
                field(Designation; rec.Designation)
                {
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                }
                field(Status; rec.Status)
                {
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; rec.COUNT)
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

    trigger OnOpenPage()
    begin
        rec.FILTERGROUP(2);
        rec.SETRANGE(Submitted, TRUE);
    end;
}

