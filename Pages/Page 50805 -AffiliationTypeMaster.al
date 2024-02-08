page 50805 "Affiliation Type Master"
{
    ApplicationArea = All;
    Caption = 'Affiliation Type Master';
    PageType = Card;
    SourceTable = "Affiliation Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Sr. No."; Rec."Sr. No.")
                {

                }


                field("Affiliation Type"; Rec."Affiliation Type")
                {
                    ToolTip = 'Specifies the value of the Affiliation Type field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }



            }
        }
    }
}
