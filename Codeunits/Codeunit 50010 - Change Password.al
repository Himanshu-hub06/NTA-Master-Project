codeunit 50010 "Change Password"
{
    trigger OnRun()
    begin
        EditNavPassword();
    end;

    local procedure EditNavPassword()
    var
        PasswordDialogManagement: Codeunit "Password Dialog Management";
        Password: Text;
        UserTab, UserTab11 : Record User;
        UserSecurityID: Guid;
    begin
        Password := PasswordDialogManagement.OpenPasswordDialog();
        if Password = '' then
            exit;
        BOCUserTab.Reset();
        BOCUserTab.SetRange("User Name", UserId);
        if BOCUserTab.FindFirst() then begin
            if BOCUserTab."Exp Pass" = Password then
                Error('Previous password and current password are same, please enter different password !')
            else begin
                BOCUserTab."Exp Pass" := Password;
                BOCUserTab.Modify();
            end;
        end;
        UserTab.Reset();
        UserTab.SetRange("User Name", UserId);
        if UserTab.FindFirst() then begin
            if SetUserPassword(UserTab."User Security ID", Password) then begin
                Message('Password successfully changed !');
                UserTab11.Reset();
                UserTab11.SetRange("User Security ID", UserTab."User Security ID");
                if UserTab11.FindFirst() then begin
                    UserTab11."Change Password" := false;
                    UserTab11.Modify();
                end;
            end
        end;
    end;

    var
        ChangePassword: Label 'Change Password';
        BOCUserTab: Record "User BOC";
        ClosePage: Boolean;

}
