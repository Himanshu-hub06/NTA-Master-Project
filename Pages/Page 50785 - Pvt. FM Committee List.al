page 50285 "Committee List"
{
    Caption = 'Committee List';
    CardPageID = "Committee Header"; //ROHIT
    PageType = List;
    // SourceTable = 50062;
    SourceTable = 50283;
    // Editable = false;
    // DeleteAllowed = false;
    SourceTableView = sorting("Committee Code") order(descending);
    ApplicationArea = all;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                    Caption = 'Committee Code';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Committee No."; rec."Committee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    Caption = 'Committee Name';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Media Description"; Rec."Media Description")
                {
                    Visible = false;
                    Caption = 'Description';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Meeting No. Series"; Rec."Meeting No. Series")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // SETRANGE("Global Dimension 1 Code", 'M002');
        // SETRANGE("Empanelment Category", "Empanelment Category"::"Pvt. FM"); //ROHIT

    end;

    trigger OnAfterGetRecord()
    begin
        if (Rec."End Date" <> 0D) and (Rec."End Date" < Today) then begin
            Rec.Status := Rec.Status::InActive;
            Rec.Modify();
        end;
    end;
}

