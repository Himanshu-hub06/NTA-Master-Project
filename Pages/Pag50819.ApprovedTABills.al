page 50819 "Approved TA Bills"
{
    CardPageId = "TA Bill Card";
    ApplicationArea = All;
    Caption = 'Approved TA Bills';
    PageType = List;
    SourceTable = "TA Bill Header";
    UsageCategory = Lists;
    SourceTableView = where("Bill Status" = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Approved_User_ID; Rec.Approved_User_ID)
                {
                    ToolTip = 'Specifies the value of the Approved User ID field.';
                }
                field("Bill Status"; Rec."Bill Status")
                {
                    ToolTip = 'Specifies the value of the Bill Status field.';
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ToolTip = 'Specifies the value of the Receiver ID field.';
                }
            }
        }
    }
}
