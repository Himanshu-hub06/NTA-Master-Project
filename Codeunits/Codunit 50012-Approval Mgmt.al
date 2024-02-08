codeunit 50012 "Approval Mgmt"
{
    SingleInstance = true;
    procedure setstatus(Satus: Text)
    var

    begin
        staus := Satus;
    end;

    procedure Getstatus() Rstatus: Text
    var

    begin
        Exit(staus);
    end;

    var
        staus: Text;
}
