page 50192 "Notification List"
{
    Caption = 'Notification';
    PageType = ListPlus;
    SourceTable = "Notification Tab";

    Editable = false;
    SourceTableView = sorting("Entry No.") order(descending);
    layout
    {

        area(content)
        {
            group(Notification)

            {
                repeater(General)
                {
                    field("Receiving Date"; Rec."Posting Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Received Date';
                        Visible = false;

                    }

                    field("Notification Details"; Rec."Notification Details")
                    {
                        ApplicationArea = All;
                        // Caption = 'Notifications';
                        ShowCaption = false;
                        Editable = false;
                        StyleExpr = RedClr;

                    }


                }


            }
            field("Total No. of Records"; format(Rec.count()))
            {
                ApplicationArea = All;
                Width = 10;
                Style = favorable;
            }
        }
    }
    trigger OnClosePage()
    var
        NotTab: Record "Notification Tab";
    begin
        NotTab.Reset();
        NotTab.SetRange("Receiver ID", UserId);
        if NotTab.FindSet() then begin
            repeat
                NotTab.read := true;
                NotTab.Modify();
            until NotTab.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        nottab: Record "Notification Tab";
        Readcount: Integer;
        Unreadcount: Integer;
    begin
        RedClr := '';
        IF Rec.read = false then
            RedClr := 'favorable'
        ELSE
            RedClr := '';
        Rec.SetRange("Receiver ID", UserId);
        NotTab.Reset();
        NotTab.SetRange("Receiver ID", UserId);
        nottab.SetRange(read, true);
        if NotTab.FindSet() then begin
            Readcount := nottab.count;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        Rec.SetRange("Receiver ID", UserId);
    end;

    var
        RedClr: Text;
}
