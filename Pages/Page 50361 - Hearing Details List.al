page 50361 "Hearing Details List"
{
    Caption = 'Hearing Details';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Case Hearing Entry";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; REC."Document No.")
                {
                    Caption = 'File No.';
                    Editable = false;
                }
                field("Next Hearing Date"; REC."Next Hearing Date")
                {
                }
                field("Hearing Details"; REC."Hearing Details")
                {
                }
                field("Oath No."; REC."Oath No.")
                {
                }
                field("Oath Date"; REC."Oath Date")
                {
                }
                field(Remarks; REC.Remarks)
                {
                }
                field("SOF Required"; REC."SOF Required")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

