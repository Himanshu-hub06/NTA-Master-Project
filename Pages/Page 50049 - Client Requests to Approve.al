#pragma implicitwith disable
page 50049 "Client Requests to Approve"
{
    Caption = 'Requests to Approve';
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 454;
    // SourceTableView = SORTING("Due Date")
    //                   ORDER(Ascending);
    layout
    {
        area(content)
        {
            repeater(XXXX)
            {
                field(ToApprove; Rec.RecordCaption)
                {
                    ApplicationArea = All;
                    Caption = 'To Approve';
                    Visible = false;
                    Width = 30;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Visible = false;
                    HideValue = NOT Rec.Comment;
                }
                // field("Sender ID"; Rec."Sender ID")
                // {
                //     ApplicationArea = All;
                // }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Details; Rec.RecordDetails)
                {
                    ApplicationArea = All;
                    Caption = 'Details';
                    Width = 50;
                }
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group(Show)
            {
                Caption = 'Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = All;
                    Caption = 'Open Record';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    trigger OnAction()
                    begin
                        Rec.ShowRecord;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        ApprovalCommentLine: Record 455;
                    begin
                        ApprovalCommentLine.SETRANGE("Table ID", Rec."Table ID");
                        ApprovalCommentLine.SETRANGE("Record ID to Approve", Rec."Record ID to Approve");
                        PAGE.RUN(PAGE::"Approval Comments", ApprovalCommentLine);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
        //ShowCommentFactbox := CurrPage.ApprovalCommentsFactBox.PAGE.SetRecIDFilter("Record ID to Approve");
    end;

    trigger OnAfterGetRecord()
    begin
        SetDateStyle;
    end;

    trigger OnOpenPage()
    begin
        // Rec.FILTERGROUP(2);
        // Rec.SETRANGE("Approver ID", USERID);
        // Rec.SETRANGE(Status, Rec.Status::Open);
        // Rec.FILTERGROUP(0);
    end;

    var
        DateStyle: Text;
        ShowAllEntries: Boolean;
        ShowChangeFactBox: Boolean;
        ShowCommentFactbox: Boolean;
        Text0001: Label 'Do you want to approve ?';
        Text0002: Label 'Do you want to reject ?';
        Text0003: Label 'Do you want to delegate ?';
        ReqHeader: Record 50087;
    //BudgetPlan: Record 50565;

    local procedure SetDateStyle()
    begin
        DateStyle := '';
        IF Rec.IsOverdue THEN
            DateStyle := 'Attention';
    end;
}

#pragma implicitwith restore

