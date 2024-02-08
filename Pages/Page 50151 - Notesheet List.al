/// <summary>
/// Page Notesheet List (ID 50620).
/// </summary>
page 50151 "Notesheet List"
{
    CardPageID = "NoteSheet Card";
    Editable = false;
    PageType = List;
    SourceTable = 50084;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Creator Section Code"; Rec."Creator Section Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Creator UID"; Rec."Creator UID")
                {
                    ApplicationArea = All;
                }
                field("Creator User Name"; Rec."Creator User Name")
                {
                    ApplicationArea = All;
                }
                field("Current UID"; Rec."Current UID")
                {
                    ApplicationArea = All;
                }
                field("Current User Name"; Rec."Current User Name")
                {
                    ApplicationArea = All;
                }
                field("Creator Section Name"; Rec."Creator Section Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date Time"; Rec."Creation Date Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

