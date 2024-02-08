page 50027 "Centre Bill open list"
{
    CardPageID = "Centre Bill open Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "Centre Bill Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; Rec."Reference No.")
                {
                }
                field("Centre No."; Rec."Centre No.")
                {
                }
                field("Centre City"; Rec."Centre City")
                {
                }
                field("Superintendent Name"; Rec."Superintendent Name")
                {
                    Caption = 'Centre Superintendent Name';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    Caption = 'Centre Superintendent Mobile No.';
                }
                field("Exam Name"; Rec."Exam Name")
                {
                }
                field("Exam Date"; Rec."Exam Date")
                {
                }
                field("Submitted Date"; Rec."Created on")
                {
                }
                field("Claimed Amount"; Rec."Claimed Amount")
                {
                }
                field(Status; Rec.Status)
                {
                }

                field(Latitude; Rec.Latitude)
                {
                    Caption = 'Latitude';
                }
                field(Longitude; Rec.Longitude)
                {
                    Caption = 'Longitude';
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

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Rec.Submitted, TRUE);
        Rec.SETRANGE("First Lvel User", USERID);
    end;

    var
        DatabaseName: Text;
        DatabaseConnectionString: Text;
}

