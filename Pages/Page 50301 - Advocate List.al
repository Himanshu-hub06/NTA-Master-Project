page 50301 "Advocate List"
{
    CardPageID = "Advocate Card";
    Editable = false;
    PageType = List;
    SourceTable = Advocate;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Advocate Code"; Rec."Advocate Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Registration No."; Rec."Registration No.")
                {
                }
                field("Father Name"; Rec."Father Name")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(City; Rec.City)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Fax No."; Rec."Fax No.")
                {
                }
                field("Email ID"; Rec."Email ID")
                {
                }
                field("Date Of Registratin"; Rec."Date Of Registratin")
                {
                }
                field("Start Date Of Empanelment"; Rec."Start Date Of Empanelment")
                {
                }
                field("End Date Of Empanelment"; Rec."End Date Of Empanelment")
                {
                }
                field("Adv. Type"; Rec."Adv. Type")
                {
                    Caption = 'Advocate Type';
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
}

