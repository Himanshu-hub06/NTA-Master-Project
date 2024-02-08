page 50308 "Writ/Case Status - Sec"
{
    PageType = CardPart;
    SourceTable = "Writ/Case Header Cue";


    layout
    {
        area(content)
        {
            cuegroup(Secondary)
            {
                Caption = 'Secondary';
                field("Writ/Case - All (Sec.)"; rec."Writ/Case - All (Sec.)")
                {
                    Caption = 'Total';

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE("User Exam Code", 'EXESEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - New (Sec.)"; rec."Writ/Case - New (Sec.)")
                {
                    Caption = 'New';
                    Style = Subordinate;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::New);
                        WritTab.SETRANGE("User Exam Code", 'EXESEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - Ongoing (Sec.)"; rec."Writ/Case - Ongoing (Sec.)")
                {
                    Caption = 'Ongoing';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::Ongoing);
                        WritTab.SETRANGE("User Exam Code", 'EXESEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - Disposed (Sec.)"; rec."Writ/Case - Disposed (Sec.)")
                {
                    Caption = 'Disposed';
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::Disposed);
                        WritTab.SETRANGE("User Exam Code", 'EXESEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Incoming Reminder"; IncomingReminder)
                {
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.UPDATE;
                    end;
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        Caption = 'New Sales Quote';
                        Image = Quote;
                        RunObject = Page 41;
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        Caption = 'New Sales Order';
                        RunObject = Page 42;
                        RunPageMode = Create;
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        WritTab: Record "Writ/Case Header";

    local procedure IncomingReminder(): Integer
    var
        RemindEntry: Record "Reminder Entry";
        TotalIncRem: Integer;
    begin
        RemindEntry.RESET;
        RemindEntry.SETCURRENTKEY("Reminder No.", "Document No.");
        RemindEntry.SETRANGE("Receiver ID", USERID);
        IF RemindEntry.FINDSET THEN
            EXIT(RemindEntry.COUNT);
    end;
}

