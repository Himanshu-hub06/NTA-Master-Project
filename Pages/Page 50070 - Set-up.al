page 50070 "Set-up"
{
    //  Editable = false;
    PageType = List;
    SourceTable = "Setup & History";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; rec.Description)
                {
                    ShowCaption = false;

                    trigger OnAssistEdit()
                    begin
                        PAGE.RUN(rec."Page ID");
                    end;
                }
                field("P Code"; rec."P Code")
                {

                }
                field("Page ID"; rec."Page ID")
                {

                }
                field(Department; rec.Department)
                {

                }
                field("Page Type"; rec."Page Type")
                {

                }
            }
        }
    }

    actions
    {
    }
}

