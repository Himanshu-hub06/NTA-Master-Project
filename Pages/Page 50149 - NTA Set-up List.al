#pragma implicitwith disable
page 50149 "NTA Set-up List"
{
    //Editable = true;
    PageType = List;
    SourceTable = "Setup & History";
    DeleteAllowed = false;
    CardPageId = 50090;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowCaption = false;

                    trigger OnAssistEdit()
                    begin
                        PAGE.RUN(Rec."Page ID");
                    end;
                }
                // field("Page ID"; Rec."Page ID")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

