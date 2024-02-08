page 50899 "CentreBill Hdr Tem"
{
    ApplicationArea = All;
    Caption = 'CentreBill Hdr Tem';
    PageType = List;
    SourceTable = "Centre Bill Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Centre ID"; Rec."Centre ID")
                {
                    ToolTip = 'Specifies the value of the Centre ID field.';
                }
                field("Centre No."; Rec."Centre No.")
                {
                    ToolTip = 'Specifies the value of the Centre No. field.';
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ToolTip = 'Specifies the value of the Receiver ID field.';
                }
                field(Rejected_User_Id; Rec.Rejected_User_Id)
                {
                    ToolTip = 'Specifies the value of the Rejected User Id field.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
            }
        }
    }
}
