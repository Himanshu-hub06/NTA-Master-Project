page 50011 "Posted Centre Bill List"
{
    CardPageID = "Posted Centre Bill Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Centre Bill Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; rec."Reference No.")
                {
                }
                field("Centre No."; rec."Centre No.")
                {
                }
                field("Centre City"; rec."Centre City")
                {
                }
                field("Superintendent Name"; rec."Superintendent Name")
                {
                    Caption = 'Centre Superintendent Name';
                }
                field("Exam Name"; rec."Exam Name")
                {
                }
                field("Exam Date"; rec."Exam Date")
                {
                }
                field("Submitted Date"; rec."Created on")
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

    var
        DatabaseName: Text;
        DatabaseConnectionString: Text;
}

