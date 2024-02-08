page 50778 "Meeting List"
{
    Caption = 'Meeting List';
    CardPageID = "Meeting Card"; //ROHIT
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50285;
    PromotedActionCategories = 'New,Process,Reports';
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Meeting No."; Rec."Meeting No.")
                {
                    ApplicationArea = all;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = all;
                }
                field(Subject; Rec."Meeting Agenda")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec."Meeting Description")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}

