page 50309 "Writ/Case Status -S  Sec"
{
    PageType = CardPart;
    SourceTable = "Writ/Case Header Cue";


    layout
    {
        area(content)
        {
            cuegroup("'")
            {
                Caption = '==';
                field("Writ/Case - All (S Sec.)"; rec."Writ/Case - All (S Sec.)")
                {
                    Caption = 'Total';

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE("User Exam Code", 'EXESSEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - New (S Sec.)"; rec."Writ/Case - New (S Sec.)")
                {
                    Caption = 'New';
                    Style = Subordinate;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::New);
                        WritTab.SETRANGE("User Exam Code", 'EXESSEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - Ongoing (S Sec.)"; rec."Writ/Case - Ongoing (S Sec.)")
                {
                    Caption = 'Ongoing';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::Ongoing);
                        WritTab.SETRANGE("User Exam Code", 'EXESSEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
                    end;
                }
                field("Writ/Case - Disposed (S Sec.)"; rec."Writ/Case - Disposed (S Sec.)")
                {
                    Caption = 'Disposed';
                    Style = Ambiguous;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETRANGE(Status, WritTab.Status::Disposed);
                        WritTab.SETRANGE("User Exam Code", 'EXESSEC');
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50305, WritTab);
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
}

