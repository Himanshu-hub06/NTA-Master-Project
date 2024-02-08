/// <summary>
/// Page Store Activities (ID 50799).
/// </summary>
page 50246 "Store Activities"
{
    Caption = 'No. Of Documents';
    PageType = CardPart;
    SourceTable = "Store Cue";

    layout
    {
        area(content)
        {
            grid(Control1000000002)
            {
                group(Control1000000003)
                {
                    cuegroup(Requisition)
                    {
                        Caption = ' Requisition';
                        field(Today; Rec."Open Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                            // Image = Stack;
                            Importance = Promoted;
                        }
                        field("Current Month"; Rec."Monthly Open Requisition Docs")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                        field("Current Year"; Rec."Yearly Open Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                        field("Today pending"; Rec."Today Pending Requisition Docs")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            Caption = 'Today Pending';
                            DrillDown = true;
                            // Image = Stack;
                            Importance = Promoted;
                        }
                        field("Current Month Pending"; Rec."Monthly Pending Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                        field("Current Year Pending"; Rec."Yearly Pending Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                        field("Today Approved"; Rec."Today Approved Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                            // Image = Stack;
                            Importance = Promoted;
                        }
                        field("Current Month Approved"; Rec."Monthly Approved Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                        field("Current Year Approved"; Rec."Yearly Approved Requisition")
                        {
                            ApplicationArea = All;
                            AccessByPermission = TableData 50087 = R;
                            DrillDown = true;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.User := USERID;
        UserSetup.GET(USERID);
        Rec."Section Filter" := UserSetup.Section;
        Rec.MODIFY;
        StDt := CALCDATE('-CM', WORKDATE);
        StDt1 := CALCDATE('-CY', WORKDATE);
        Rec.SETRANGE("Date Filter", WORKDATE);
        Rec.SETRANGE("Date Filter1", StDt, WORKDATE);
        Rec.SETRANGE("Date Filter2", StDt1, WORKDATE);
    end;

    var
        StDt: Date;
        StDt1: Date;
        UserSetup: Record 91;
}

