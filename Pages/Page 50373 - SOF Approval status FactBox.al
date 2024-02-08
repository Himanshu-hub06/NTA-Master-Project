page 50373 "SOF Approval status FactBox"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "File Movement Entry";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("SOF Approval Status" = FILTER(Approved | Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SOF Approved By"; Rec."SOF Approved By")
                {
                    Caption = 'SOF Approve/Reject By';
                }
                field("SOF Approval Status"; rec."SOF Approval Status")
                {
                }
                field("SOF Approval DateTime"; rec."SOF Approval DateTime")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        CreatedBy: Text;
}

