page 50357 "Advocate Assigning List"
{
    Caption = 'Assigning of Internal/External Advocate';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Advocate Assigning Entry";
    SourceTableView = SORTING("File No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Entry Type" = CONST("Case Assign"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; REC."File No.")
                {
                }
                field("Advocate Code"; REC."Advocate Code")
                {

                    trigger OnValidate()
                    begin
                        IF REC."Advocate Type" = REC."Advocate Type"::Internal THEN
                            Enable1 := TRUE
                        ELSE
                            Enable1 := FALSE;
                    end;
                }
                field("Advocate Name"; REC."Advocate Name")
                {
                    Editable = false;
                }
                field("Advocate Type"; REC."Advocate Type")
                {
                    Editable = false;
                }
                field("Internal Adv. Type"; REC."Internal Adv. Type")
                {
                    Enabled = Enable1;
                }
                field("Assigned Date"; REC."Assigned Date")
                {
                }
                field(Remarks; REC.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF REC."Advocate Type" = REC."Advocate Type"::Internal THEN
            Enable1 := TRUE
        ELSE
            Enable1 := FALSE;
    end;

    var
        Text001: Label 'Advocate type should be Internal';
        Enable1: Boolean;
}

