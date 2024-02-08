page 50002 "Centre Bill List"
{
    CardPageID = "Centre Bill Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Centre Bill Header";

    // Permissions =
    //     tabledata "Centre Bill Header" = RD;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; rec."Reference No.")
                {
                    ApplicationArea = all;
                }
                field(Centre_Name; Rec.Centre_Name)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Bill Status"; Rec."Bill Status")
                {
                    ApplicationArea = ALL;
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ApplicationArea = all;
                }
                field("Centre City"; rec."Centre City")
                {
                    ApplicationArea = all;
                }
                field("Centre No."; Rec."Centre No.")
                {
                    ApplicationArea = All;
                }
                field("Centre Address"; Rec."Centre Address")
                {
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                }

                field("Exam Name"; rec."Exam Name")
                {
                    ApplicationArea = all;
                }

                field(Longitude; Rec.Longitude)
                {
                    ApplicationArea = All;
                }
                field(Latitude; Rec.Latitude)
                {
                    ApplicationArea = All;
                }
                field(IP; Rec.IP)
                {
                    ApplicationArea = All;
                }
                field(PAN_N0; Rec.PAN_N0)
                {
                    ApplicationArea = all;
                }
                field("Superintendent Name"; rec."Superintendent Name")
                {
                    ApplicationArea = all;
                    Caption = 'Centre Superintendent Name';
                }
                field("Submitted Date"; rec."Created on")
                {
                    ApplicationArea = all;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    ApplicationArea = all;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    ApplicationArea = all;
                }
                field(Sender_ID; rec.Sender_ID)
                {
                    ApplicationArea = all;
                }

            }
            // group("Count Filter")
            // {
            //     Caption = '*';
            //     //The GridLayout property is only supported on controls of type Grid
            //     //GridLayout = Rows;
            //     Visible = true;
            //     field(COUNT; rec.COUNT)
            //     {
            //         Caption = 'Total No. Of Records';
            //         ColumnSpan = 3;
            //         Style = Attention;
            //         StyleExpr = TRUE;
            //     }

            // }
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
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table ID", 50002);
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Record ID to Approve", Rec.RECORDID);
                    PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
                end;

            }



        }

    }
    trigger OnOpenPage()
    var

    begin
        // rec.FilterGroup(0);
        // rec.setrange(Rec.Receiver_ID, UserId);
        // rec.FilterGroup(2);
    end;


    var
        DatabaseName: Text;
        DatabaseConnectionString: Text;
        user: Record User;
}

