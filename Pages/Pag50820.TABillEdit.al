page 50820 "TA Bill Edit"
{
    ApplicationArea = All;
    Caption = 'TA Bill Edit';
    PageType = List;
    SourceTable = "TA Bill Header";
    UsageCategory = Tasks;

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
                field("Bill Status"; Rec."Bill Status")
                {
                    ToolTip = 'Specifies the value of the Bill Status field.';
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {

                }
            }
        }
    }
}
