page 50132 "Approval User Group"
{
    Caption = 'Approval User Group';
    DataCaptionExpression = CapVar;
    DataCaptionFields = Description;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = 50081;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Approval Group")
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;

                }
            }
            part("Approval User"; 50133)
            {
                ApplicationArea = all;
                SubPageLink = "Approval User Group Code" = FIELD(Code),
                             "Media Code" = FIELD("Media Code");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CapVar := rec.Description + ' Setup';
    end;

    var
        AppgroupCode: Record 50081;
        CapVar: Text;
}

