page 50369 "Writ/Case Type List"
{
    CardPageID = "Writ/Case Type Card";
    PageType = List;
    SourceTable = "Writ/Case Type";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; REC.Code)
                {
                }
                field(Description; REC.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

