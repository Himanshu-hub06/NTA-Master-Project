page 50345 "Mail sent Details"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Advocate Assigning Entry";
    SourceTableView = SORTING("SOF Sending Date")
                      ORDER(Descending)
                      WHERE("Entry Type" = CONST(SOF));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Advocate Code"; rec."Advocate Code")
                {
                }
                field("Advocate Name"; rec."Advocate Name")
                {
                }
                field("Email id"; rec."Email id")
                {
                }
                field("SOF Sending Date"; rec."SOF Sending Date")
                {
                    Caption = 'Mail Sent Date';
                }
                field("Send Time"; rec."Send Time")
                {
                    Caption = 'Sent Time';
                }
                field("Advocate Type"; rec."Advocate Type")
                {
                }
                field("Internal Adv. Type"; rec."Internal Adv. Type")
                {
                }
                field("File No."; rec."File No.")
                {
                }
                field("Entry Type"; rec."Entry Type")
                {
                }
                field("SOF Sent By"; rec."SOF Sent By")
                {
                    Caption = 'Sender Id';
                }
                field("SOF Sender Name"; rec."SOF Sender Name")
                {
                    Caption = 'Sender Name';
                }
            }
        }
    }

    actions
    {
    }
}

