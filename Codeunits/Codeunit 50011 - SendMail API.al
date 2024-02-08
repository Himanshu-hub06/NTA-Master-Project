codeunit 50011 "Send Mail(API)"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;

    procedure Sendmail(UserName: code[50]; Subject: Text; BodyMessage: Text[500]): Boolean
    var
        FdirdtlTab: Record "File Directory Detail";
        APIURL: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        Email: array[20] of Text[80];
        CBCUserTab, CBCUserTab2 : Record "User BOC";
        UserTab, UserTab2 : Record User;
    begin
        FdirdtlTab.Get();
        UserTab.Reset();
        UserTab.SetRange("User Name", UserName);
        if UserTab.FindFirst() then;

        CBCUserTab.Reset();
        CBCUserTab.SetRange("User Name", UserId);
        if CBCUserTab.FindFirst() then;

        CBCUserTab2.Reset();
        CBCUserTab2.SetRange("User Name", UserName);
        if CBCUserTab2.FindFirst() then;
        Email[1] := UserTab."Contact Email";
        APIURL := FdirdtlTab."Mail API Url";
        BodyMessage := StrSubstNo(BodyMessage, CBCUserTab."Full Name", CBCUserTab.Designation);
        if Email[1] <> '' then begin
            APIURL := APIURL + '&email[]=' + Email[1] + '&subject=' + Subject + '&body=' + BodyMessage;
            if Client.Get(APIURL, Response) then
                if Response.IsSuccessStatusCode() then begin
                    Message('Mail successfully sent to %1 (Designation- %2)!', CBCUserTab2."Full Name", CBCUserTab2.Designation);
                    exit(true);
                end
                else
                    Error('Mail not sent!');
        end
        else
            exit(true);
    end;
}
