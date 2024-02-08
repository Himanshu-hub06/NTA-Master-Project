page 50019 "Approved Centre Bill List"
{
    CardPageID = "Approved Centre Bill Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "Centre Bill Header";
    SourceTableView = SORTING("Reference No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST("Approved"));

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
        area(processing)
        {
            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    ApprovalCommentLine: Record "Approval Comment Line";
                begin
                    ApprovalCommentLine.SETRANGE("Table ID", 50002);
                    ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        rec.SETRANGE(rec.Status, rec.Status::"Approved");
    end;

    var
        DatabaseName: Text;
        DatabaseConnectionString: Text;
}

