page 50316 "Legal User Activities- Unread"
{
    Caption = 'User Activities - New Arrivals';
    PageType = CardPart;
    SourceTable = "Writ/Case Header";


    layout
    {
        area(content)
        {

            cuegroup(gfg)
            {
                field(CountNewCase; CountNewCase)
                {
                    Caption = 'New';
                    Image = Message;
                    Style = Subordinate;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
                        WritTab.SETRANGE("User Assigned", USERID);
                        WritTab.SETRANGE(Unread, TRUE);
                        WritTab.SETRANGE(Status, WritTab.Status::New);
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50387, WritTab);

                        CurrPage.UPDATE;
                    end;
                }
                field(CountOngoingCase; CountOngoingCase)
                {
                    Caption = 'Ongoing';
                    Image = Message;
                    Style = Favorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
                        WritTab.SETRANGE("User Assigned", USERID);
                        WritTab.SETRANGE(Unread, TRUE);
                        WritTab.SETRANGE(Status, WritTab.Status::Ongoing);
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50387, WritTab);

                        CurrPage.UPDATE;
                    end;
                }
                field(CountDisposedCase; CountDisposedCase)
                {
                    Caption = 'Disposed';
                    Image = Message;
                    Style = Ambiguous;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WritTab.RESET;
                        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
                        WritTab.SETRANGE("User Assigned", USERID);
                        WritTab.SETRANGE(Unread, TRUE);
                        WritTab.SETRANGE(Status, WritTab.Status::Disposed);
                        IF WritTab.FIND('-') THEN
                            PAGE.RUN(50389, WritTab);

                        CurrPage.UPDATE;
                    end;
                }
                field(CountReminder; CountReminder)
                {
                    Caption = 'Reminder';
                    Image = Message;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        RemindEntry.RESET;
                        RemindEntry.SETCURRENTKEY("Reminder No.");
                        RemindEntry.SETRANGE("Receiver ID", USERID);
                        RemindEntry.SETRANGE(Sent, TRUE);
                        RemindEntry.SETRANGE(Unread, TRUE);
                        IF RemindEntry.FIND('-') THEN
                            PAGE.RUN(50398, RemindEntry);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        WritTab: Record "Writ/Case Header";
        RemindEntry: Record "Reminder Entry";

    local procedure CountNewCase(): Integer
    begin
        WritTab.RESET;
        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
        WritTab.SETRANGE("User Assigned", USERID);
        WritTab.SETRANGE(Unread, TRUE);
        WritTab.SETRANGE(Status, WritTab.Status::New);
        EXIT(WritTab.COUNT);
    end;

    local procedure CountOngoingCase(): Integer
    begin
        WritTab.RESET;
        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
        WritTab.SETRANGE("User Assigned", USERID);
        WritTab.SETRANGE(Unread, TRUE);
        WritTab.SETRANGE(Status, WritTab.Status::Ongoing);
        EXIT(WritTab.COUNT);
    end;

    local procedure CountDisposedCase(): Integer
    begin
        WritTab.RESET;
        WritTab.SETCURRENTKEY(Status, "User Assigned", "User Exam Code", Unread);
        WritTab.SETRANGE("User Assigned", USERID);
        WritTab.SETRANGE(Unread, TRUE);
        WritTab.SETRANGE(Status, WritTab.Status::Disposed);
        EXIT(WritTab.COUNT);
    end;

    local procedure CountReminder(): Integer
    begin
        RemindEntry.RESET;
        RemindEntry.SETCURRENTKEY("Reminder No.");
        RemindEntry.SETRANGE(Sent, TRUE);
        RemindEntry.SETRANGE("Receiver ID", USERID);
        RemindEntry.SETRANGE(Unread, TRUE);
        EXIT(RemindEntry.COUNT);
    end;
}

