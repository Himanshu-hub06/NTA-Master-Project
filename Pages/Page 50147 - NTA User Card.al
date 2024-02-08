#pragma implicitwith disable
page 50147 "NTA User Card"
{
    Caption = 'User Card';
    DataCaptionExpression = Rec."Full Name";
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 2000000120;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = All;
                    Caption = 'User Security ID';
                    Visible = false;
                    Editable = false;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        IF xRec."User Name" <> Rec."User Name" THEN begin
                            ValidateUserName;
                            UserBOC.Reset();
                            UserBOC.SetRange("User Security ID", Rec."User Security ID");
                            if UserBOC.FindFirst() then begin
                                UserBOC."User Name" := Rec."User Name";
                                UserBOC.MODIFY(TRUE);
                            end;
                        end;
                    end;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Designation';
                }
                field(Level; Level)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Level';
                }
                field("Media Type"; MedName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        DimPg: page "Dimension Values";
                    begin

                        //   DimPg.Run();
                        // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    end;
                }
                //   field(Rec.Glo)
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnValidate()
                    var
                        BocUser: Record "User BOC";
                    begin
                        BocUser.Reset();
                        BocUser.SetCurrentKey("User Security ID");
                        BocUser.SetRange("User Security ID", Rec."User Security ID");
                        if BocUser.FindFirst() then begin
                            BocUser.State := rec.State;
                            BocUser.Modify();
                        end;
                    end;
                }
            }
            group("NAV Password Authentication")
            {
                Caption = 'Microsoft Dynamics NAV Password Authentication';
                field(Password; Password)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Caption = 'Password';
                    Editable = false;
                    ExtendedDatatype = Masked;
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        EditNavPassword;
                    end;
                }
                field("Change Password"; Rec."Change Password")
                {
                    ApplicationArea = All;
                    Caption = 'User must change password at next login';
                }
            }
            part(Permissions; 9801)
            {
                ApplicationArea = All;
                Caption = 'User Permission Sets';
                SubPageLink = "User Security ID" = FIELD("User Security ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnAfterGetRecord()
    begin
        WindowsUserName := IdentityManagement.UserName(Rec."Windows Security ID");

        Rec.TESTFIELD("User Name");

        //  Password := IdentityManagement.GetMaskedNavPassword("User Security ID");
        if IdentityManagement.IsUserPasswordSet(Rec."User Security ID") then
            Password := '********';
        WebServiceID := IdentityManagement.GetWebServicesKey(Rec."User Security ID");
        ACSStatus := IdentityManagement.GetACSStatus(Rec."User Security ID");
        WebServiceExpiryDate := IdentityManagement.GetWebServiceExpiryDate(Rec."User Security ID");
        AuthenticationStatus := IdentityManagement.GetAuthenticationStatus(Rec."User Security ID");
        BOCUser.RESET;
        BOCUser.SETRANGE("User Name", Rec."User Name");
        IF BOCUser.FINDFIRST THEN BEGIN
            Level := BOCUser.Level;
            Designation := BOCUser.Designation;
            MedName := BOCUser."Global Dimension 1 Code";
        END;
    end;

    trigger OnClosePage()
    begin
        IF Rec."User Name" <> '' THEN BEGIN
            UserBOC.SETRANGE(UserBOC."User Name", Rec."User Name");
            IF NOT UserBOC.FINDFIRST THEN BEGIN
                UserBOC.TRANSFERFIELDS(Rec);
                UserBOC."WS Call" := 0;
                UserBOC.Designation := Designation;
                UserBOC.Level := Level;
                UserBOC."Global Dimension 1 Code" := MedName;
                UserBOC."Exp Pass" := BocPassword;
                UserBOC.INSERT(TRUE);
            END
            ELSE BEGIN
                UserBOC.TRANSFERFIELDS(Rec);
                UserBOC."WS Call" := 0;
                UserBOC.Designation := Designation;
                UserBOC.Level := Level;
                UserBOC."Global Dimension 1 Code" := MedName;
                UserBOC."Exp Pass" := BocPassword;
                UserBOC.MODIFY(TRUE);
            END;
        END;
    end;
    //kamlesh
    trigger OnOpenPage()
    var
        bocuser: Record 50000;
    begin
        bocuser.Reset();
        // bocuser.SetRange(User, Rec."User Name");raj
        if bocuser.FindFirst() then begin
            Designation := bocuser.Designation;
            Level := bocuser.Level;
            MedName := bocuser."Global Dimension 1 Code";
        end;
    end;
    //kamlesh

    trigger OnInit()
    begin
        DeployedToAzure := IdentityManagement.IsAzure();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Security ID" := CREATEGUID;
        Rec.TESTFIELD("User Name");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD("User Name");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        WindowsUserName := '';
        Password := '';
        Rec."Change Password" := FALSE;
        WebServiceID := '';
        CLEAR(WebServiceExpiryDate);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF Rec."User Name" <> '' THEN
            EXIT(ValidateAuthentication);
    end;

    var
        UserSecID: Record 2000000120;
        IdentityManagement: Codeunit 9801;
        WindowsUserName: Text[208];
        Text001: Label 'The account %1 is not a valid Windows account.';
        Text002: Label 'The account %1 already exists.';
        Text003: Label 'The account %1 is not allowed.';
        Password: Text[80];
        ACSStatus: Option Disabled,Pending,Registered,Unknown;
        WebServiceID: Text[80];
        Confirm001Qst: Label 'The current Web Service Access Key will not be valid after editing. All clients that use it have to be updated. Do you want to continue?';
        WebServiceExpiryDate: DateTime;
        Confirm002Qst: Label 'You have not completed all necessary fields for the Credential Type that this client is currently using. The user will not be able to log in unless you provide a value in the %1 field. Are you sure that you want to close the window?';
        [InDataSet]
        DeployedToAzure: Boolean;
        Confirm003Qst: Label 'The user will not be able to sign in unless you change the state to Enabled. Are you sure that you want to close the page?';
        AuthenticationStatus: Option Disabled,Inactive,Active;
        Confirm004Qst: Label 'The user will not be able to sign in because no authentication data was provided. Are you sure that you want to close the page?';
        UserBOC: Record 50000;
        Designation: Text[80];
        Level: Integer;
        BOCUser: Record 50000;
        BocPassword: Text;
        MedName: code[10];

    local procedure ValidateSid()
    var
        User: Record 2000000120;
    begin
        IF Rec."Windows Security ID" = '' THEN
            ERROR(Text001, Rec."User Name");

        IF (Rec."Windows Security ID" = 'S-1-1-0') OR (Rec."Windows Security ID" = 'S-1-5-7') OR (Rec."Windows Security ID" = 'S-1-5-32-544') THEN
            ERROR(Text003, IdentityManagement.UserName(Rec."Windows Security ID"));

        User.SETCURRENTKEY("Windows Security ID");
        User.SETFILTER("Windows Security ID", Rec."Windows Security ID");
        User.SETFILTER("User Security ID", '<>%1', Rec."User Security ID");
        IF User.FINDFIRST THEN
            ERROR(Text002, User."User Name");
    end;

    local procedure ValidateAuthentication(): Boolean
    var
        ValidationField: Text;
    begin
        UserSecID.RESET;
        IF (UserSecID.COUNT = 1) OR (USERSECURITYID = Rec."User Security ID") THEN BEGIN
            IF IdentityManagement.IsWindowsAuthentication AND (Rec."Windows Security ID" = '') THEN
                ValidationField := 'Windows User Name';

            IF IdentityManagement.IsUserNamePasswordAuthentication AND (Password = '') THEN
                ValidationField := 'Password';

            IF IdentityManagement.IsAccessControlServiceAuthentication AND (ACSStatus = 0) AND (AuthenticationStatus = 0) THEN
                ValidationField := 'ACSStatus / AuthenticationStatus';

            IF ValidationField <> '' THEN
                EXIT(CONFIRM(Confirm002Qst, FALSE, ValidationField));
        END ELSE BEGIN
            IF (Rec."Windows Security ID" = '') AND (Password = '') AND (ACSStatus = 0) AND (AuthenticationStatus = 0) THEN
                EXIT(CONFIRM(Confirm004Qst, FALSE));
        END;

        IF Rec.State <> Rec.State::Enabled THEN
            EXIT(CONFIRM(Confirm003Qst, FALSE));

        EXIT(TRUE);
    end;

    local procedure ValidateUserName()
    var
        UserMgt: Codeunit 418;
    begin
        UserMgt.ValidateUserName(Rec, xRec, WindowsUserName);
        CurrPage.UPDATE;
    end;

    local procedure EditWebServiceID()
    var
        SetWebServiceAccessKey: Page "Set Web Service Access Key";
    begin
        Rec.TESTFIELD("User Name");

        IF CONFIRM(Confirm001Qst) THEN BEGIN
            UserSecID.SETCURRENTKEY("User Security ID");
            UserSecID.SETRANGE("User Security ID", Rec."User Security ID", Rec."User Security ID");
            SetWebServiceAccessKey.SETRECORD(UserSecID);
            SetWebServiceAccessKey.SETTABLEVIEW(UserSecID);
            IF SetWebServiceAccessKey.RUNMODAL = ACTION::OK THEN
                CurrPage.UPDATE;
        END;
    end;

    local procedure EditNavPassword()
    var
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        Password: Text;

    begin
        Rec.TestField(Rec."User Name");

        CurrPage.SaveRecord;
        Commit();

        Password := PasswordDialogManagement.OpenPasswordDialog();
        BocPassword := Password;
        if Password = '' then
            exit;

        SetUserPassword(Rec."User Security ID", Password);
        CurrPage.Update(false);
    end;

    local procedure EditACSStatus()
    var
        UserACSSetup: Page 9811;
    begin
        Rec.TESTFIELD("User Name");

        UserSecID.SETCURRENTKEY("User Security ID");
        UserSecID.SETRANGE("User Security ID", Rec."User Security ID", Rec."User Security ID");
        UserACSSetup.SETRECORD(UserSecID);
        UserACSSetup.SETTABLEVIEW(UserSecID);
        IF UserACSSetup.RUNMODAL = ACTION::OK THEN
            CurrPage.UPDATE;
    end;

    local procedure SetUserName()
    begin
        Rec."User Name" := WindowsUserName;
        ValidateUserName;
    end;
}

#pragma implicitwith restore

