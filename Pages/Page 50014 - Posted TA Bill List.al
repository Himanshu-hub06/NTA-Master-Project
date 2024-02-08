page 50014 "Posted TA Bill List"
{
    CardPageID = "Posted TA Bill Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted TA Bill Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill ID"; rec."Bill ID")
                {
                }
                field("Exam ID"; rec."Exam ID")
                {
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
}

