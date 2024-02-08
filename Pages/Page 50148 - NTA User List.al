#pragma implicitwith disable
page 50148 "NTA User List"
{
    Caption = 'Users';
    CardPageID = "NTA User Card";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = none;
    PageType = List;
    SourceTable = 2000000120;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    Caption = 'User Name';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ValidateUserName;
                    end;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                    Editable = false;
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field(Designation; Desig)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        WindowsUserName := IdentityManagement.UserName(Rec."Windows Security ID");
        NoUserExists := FALSE;
        Desig := '';
        BOCUser.RESET;
        BOCUser.SETRANGE("User Name", Rec."User Name");
        IF BOCUser.FINDFIRST THEN
            Desig := BOCUser.Designation;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF Rec."User Name" = '' THEN
            ERROR(Text004, Rec.FIELDCAPTION("User Name"));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."User Security ID" := CREATEGUID;
        WindowsUserName := '';
    end;

    trigger OnOpenPage()
    begin
        NoUserExists := Rec.ISEMPTY;
    end;

    var
        IdentityManagement: Codeunit 9801;
        WindowsUserName: Text[208];
        Text001: Label 'The account %1 is not a valid Windows account.';
        Text002: Label 'The account %1 already exists.';
        Text003: Label 'The account %1 is not allowed.';
        Text004: Label '%1 cannot be empty.';
        NoUserExists: Boolean;
        CreateQst: Label 'Do you want to create %1 as super user?', Comment = '%1=user name, e.g. europe\myaccountname';
        Desig: Text;
        BOCUser: Record 50000;

    local procedure ValidateSid()
    var
        User: Record 2000000120;
    begin
        IF Rec."Windows Security ID" = '' THEN
            ERROR(Text001, Rec."User Name");

        IF (Rec."Windows Security ID" = 'S-1-1-0') OR (Rec."Windows Security ID" = 'S-1-5-7') THEN
            ERROR(Text003, Rec."User Name");

        User.SETCURRENTKEY("Windows Security ID");
        User.SETFILTER("Windows Security ID", Rec."Windows Security ID");
        User.SETFILTER("User Security ID", '<>%1', Rec."User Security ID");
        IF User.FINDFIRST THEN
            ERROR(Text002, WindowsUserName);
    end;

    local procedure ValidateUserName()
    var
        UserMgt: Codeunit 418;
    begin
        //  UserMgt.ValidateUserName(Rec, xRec, WindowsUserName);
        CurrPage.UPDATE;
    end;

    local procedure SetUserName()
    begin
        Rec."User Name" := WindowsUserName;
        ValidateUserName;
    end;

    procedure GetSelectionFilter(var User: Record 2000000120)
    begin
        CurrPage.SETSELECTIONFILTER(User);
    end;
}

#pragma implicitwith restore

