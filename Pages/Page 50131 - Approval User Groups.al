page 50131 "Approval User Groups"
{
    Caption = 'Approval User Groups';
    CardPageID = "Approval User Group";
    DataCaptionFields = Description;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = 50081;
    ApplicationArea = all;
    SourceTableView = WHERE(Active = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Media Name"; rec."Media Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

