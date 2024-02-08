table 50000 "User BOC"
{
    // SetExpPassword(Pwd : Text[250])
    // UTab.SETRANGE("User Security ID","User Security ID");
    // IF UTab.FINDFIRST THEN BEGIN
    //   UTab."Exp Pass" := Pwd;
    //   IF UTab.MODIFY(TRUE) THEN;
    //    // MESSAGE('Password Changed');
    //  END;
    // {
    // UTabBSEB.SETRANGE("User Security ID","User Security ID");
    // IF UTabBSEB.FINDFIRST THEN BEGIN
    //   UTabBSEB."Exp Pass" := Pwd;
    //   IF UTabBSEB.MODIFY(TRUE) THEN
    //     MESSAGE('Password Changed');
    //  END;
    // }

    Caption = 'User';
    DataPerCompany = false;

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
        }
        field(2; "User Name"; Code[50])
        {
            Caption = 'User Name';
        }
        field(3; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
        }
        field(4; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(5; "Expiry Date"; DateTime)
        {
            Caption = 'Expiry Date';
        }
        field(7; "Windows Security ID"; Text[119])
        {
            Caption = 'Windows Security ID';
        }
        field(8; "Change Password"; Boolean)
        {
            Caption = 'Change Password';
        }
        field(10; "License Type"; Option)
        {
            Caption = 'License Type';
            OptionCaption = 'Full User,Limited User,Device Only User,Windows Group,External User';
            OptionMembers = "Full User","Limited User","Device Only User","Windows Group","External User";
        }
        field(11; "Authentication Email"; Text[250])
        {
            Caption = 'Authentication Email';
        }
        field(14; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
        }
        field(15; "Exchange Identifier"; Text[250])
        {
            Caption = 'Exchange Identifier';
        }
        field(16; "Application ID"; Guid)
        {
            Caption = 'Application ID';
        }
        field(17; "Exp Pass"; Text[250])
        {
            Caption = 'Exp Pass';
            DataClassification = ToBeClassified;
        }
        field(18; "Emp Code"; Code[20])
        {
            Caption = 'Emp Code';
            DataClassification = ToBeClassified;
        }
        field(19; "WS Call"; Integer)
        {
            Caption = 'WS Call';
            DataClassification = ToBeClassified;
        }
        // field(15; "Exp Pass"; Text[250])
        // {
        //     DataClassification = ToBeClassified;

        //     trigger OnValidate()
        //     begin
        //         /*
        //         IF "WS Call" = 1 THEN BEGIN
        //           UserBseb.RESET;
        //           UserBseb.SETCURRENTKEY("User Security ID");
        //           UserBseb.SETRANGE("User Security ID","User Security ID");
        //           IF UserBseb.FIND('-') THEN BEGIN
        //             SETUSERPASSWORD(UserBseb."User Security ID","Exp Pass");
        //             UserBseb."Change Password":=FALSE;
        //             UserBseb.MODIFY;

        //             Usertab.RESET;
        //             Usertab.SETCURRENTKEY("User Security ID");
        //             Usertab.SETRANGE("User Security ID","User Security ID");
        //             IF Usertab.FIND('-') THEN BEGIN
        //               Usertab."Exp Pass":="Exp Pass";
        //               Usertab."Change Password":=FALSE;
        //               Usertab.MODIFY;
        //             END;
        //           END;
        //         END;
        //         */

        //     end;
        // }
        // field(16; "Emp Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(17; "WS Call"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(50021; Designation; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Level; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(21; "Designation Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User Security ID")
        {
        }
        key(Key2; "User Name", Level)
        {
        }
        key(Key3; "Windows Security ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User Name", "Full Name")
        {
        }
    }

    trigger OnDelete()
    begin
        // BOCUSER.RESET;
        // BOCUSER.SETRANGE(BOCUSER."User Security ID", "User Security ID");
        // IF BOCUSER.FIND('-') THEN
        //     BOCUSER.DELETE;
    end;

    trigger OnModify()
    begin
        VALIDATE("Exp Pass");
    end;

    var
        UserBseb: Record 50000;
        Usertab: Record 2000000120;
        BOCUSER: Record 2000000120;

    procedure SetExpPassword(Pwd: Text[250])
    var
        UTab: Record 2000000120;
    begin
        /*
        UTab.SETRANGE(UTab."User Security ID","User Security ID");
        IF UTab.FINDFIRST THEN BEGIN
          UTab."Exp Pass" := Pwd;
          UTab.MODIFY(TRUE);
         END;
         */

        UTab.SETRANGE("User Security ID", "User Security ID");
        IF UTab.FINDFIRST THEN BEGIN
            //UTab."Exp Pass" := Pwd;
            IF UTab.MODIFY(TRUE) THEN;
            // MESSAGE('Password Changed');
        END;

    end;
}

