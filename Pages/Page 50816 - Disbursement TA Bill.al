page 50816 "Status TA Bill"
{
    CardPageID = "TA Bill Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "TA Bill Header";
    SourceTableView = where("Bill Status" = filter("Disbursement Pending"));
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Action';
    Editable = False;
    RefreshOnActivate = true;
    Caption = 'TA Bill Running Status';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill No."; rec."Reference No")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Width = 25;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Bill Status"; Rec."Bill Status")
                {
                    ApplicationArea = ALL;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ApplicationArea = All;
                }

                field("NTA Unique ID"; rec."NTA Unique ID")
                {
                    ApplicationArea = all;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    ApplicationArea = all;
                }
                field(Designation; rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    ApplicationArea = all;
                }
                field("Hotel Amount"; rec."Total Amount Hotel")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Local Amount"; rec."Total Amount Local")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Oustation Amount"; rec."Total Amount Outstation")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Net Payable Amount"; rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount" - rec."TDS Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
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

