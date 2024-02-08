page 50071 MIS
{
    DeleteAllowed = false;
    // Editable = false;
    //InsertAllowed = false;
    //ModifyAllowed = false;
    PageType = List;
    SourceTable = "Management Report";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; rec.Description)
                {
                    Caption = 'Reports';
                    ShowCaption = false;

                    trigger OnAssistEdit()
                    begin
                        REPORT.RUN(rec."Report ID");
                    end;
                }

                field("R Code"; rec."R Code")
                {


                }
                field("Report ID"; rec."Report ID")
                {


                }
                field(Department; rec.Department)
                {


                }
            }
        }

    }

}