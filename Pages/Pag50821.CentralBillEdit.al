page 50821 "Central Bill Edit"
{
    ApplicationArea = All;
    Caption = 'Central Bill Edit';
    PageType = List;
    SourceTable = "Centre Bill Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No."; Rec."Reference No.")
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
