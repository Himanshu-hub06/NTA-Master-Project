page 50034 "Paid Bill List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Posted Approved Bills";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill Type"; rec."Bill Type")
                {
                }
                field("Bill ID"; rec."Bill ID")
                {
                }
                field("Reference No."; rec."Reference No.")
                {
                }
                field("Line No."; rec."Line No.")
                {
                }
                field("Unique Code"; rec."Unique Code")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("Exam ID"; rec."Exam ID")
                {
                }
                field("Exam Date"; rec."Exam Date")
                {
                }
                field("Exam Code"; rec."Exam Code")
                {
                }
                field("Exam Name"; rec."Exam Name")
                {
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("State Code"; rec."State Code")
                {
                    Visible = false;
                }
                field("E-mail ID"; rec."E-mail ID")
                {
                    Visible = false;
                }
                field(Mobile; rec.Mobile)
                {
                    Visible = false;
                }
                field("Payment Amount"; rec."Payment Amount")
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

