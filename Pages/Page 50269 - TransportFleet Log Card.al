page 50269 "Transport/Fleet Log Card"
{
    Caption = 'Transport/Fleet Log';
    PageType = Card;
    SourceTable = 50108;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("TF Code"; Rec."TF Code")
                {
                    Caption = 'Transport/Fleet ID';
                    Editable = false;
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("TF Date"; Rec."TF Date")
                {
                    ApplicationArea = all;
                }
                field("TF Time"; Rec."TF Time")
                {
                    ApplicationArea = all;
                }
                field("Place to Visit"; Rec."Place to Visit")
                {
                    ApplicationArea = all;
                }
                field("Journey Type"; Rec."Journey Type")
                {
                    ApplicationArea = all;
                }
                field("Requirement Type"; Rec."Requirement Type")
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = all;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        BOCUsersPage: Page 50147;
                    begin
                        // UserBOC.RESET;
                        // UserBOC.SETRANGE("User Name",USERID);
                        // IF UserBOC.FINDFIRST THEN
                        //  BOCUsersPage.SETRECORD(UserBOC);
                        //  BOCUsersPage.SETTABLEVIEW(UserBOC);
                        //  BOCUsersPage.EDITABLE(FALSE);
                        //  BOCUsersPage.LOOKUPMODE(TRUE);
                        //  IF BOCUsersPage.RUNMODAL=ACTION::LookupOK THEN BEGIN
                        //    BOCUsersPage.GETRECORD(UserBOC);
                        //    Name:=UserBOC."Full Name";
                        //    Rec.Designation:=UserBOC.Designation;
                        //    END;
                    end;
                }
                field(Designation; Designation)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = EnableBtn2;
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = EnableBtn2;
                    ApplicationArea = all;
                }
                // field("Transfer User"; TransferUser)
                // {
                //     Caption = 'Transfer User Name';
                //     Editable = false;
                //     Visible = EnableBtn5;
                //     ApplicationArea = all;
                //     trigger OnDrillDown()
                //     var
                //         UserPage: Page 50148;
                //     begin

                //         // UserBOC.RESET;
                //         // UserBOC.SETRANGE(Level,;
                //         // IF Rec.Status = Rec.Status::"Under Approval" THEN
                //         //     UserBOC.SETFILTER("User Name", '=%1', 'NLDD')
                //         // ELSE
                //         // UserBOC.SETFILTER("User Name", '<>%1', 'NLDD');
                //         // IF (Status=Status::"Under GA Secton") AND (USERID="Receiver ID") THEN
                //         //  ERROR('You have permit to Approve!!')
                //         // ELSE
                //         //  ERROR('You cann''t Approve!!');
                //         UserBOC.RESET;
                //         IF UserBOC.FINDFIRST THEN BEGIN
                //             UserPage.SETRECORD(UserBOC);
                //             UserPage.SETTABLEVIEW(UserBOC);
                //             UserPage.EDITABLE(FALSE);
                //             UserPage.LOOKUPMODE(TRUE);
                //             IF UserPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                //                 UserPage.GETRECORD(UserBOC);
                //                 TransferUser := UserBOC."Full Name";
                //                 Receiverid := UserBOC."User Name";
                //             END;
                //         END;
                //     end;
                // }
                field("Transfer User ID"; Rec."Transfer User ID")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'TRANSPORT');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User ID", '<>%1', USERID);

                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Transfer User Id" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Full Name";
                        END;
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;

                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group(Vehicle)
            {
                Caption = 'Vehicle';
                Visible = EnableBtn;
                field("Vehicle Code"; Rec."Vehicle Code")
                {
                    ApplicationArea = all;
                    Editable = Editable001;
                    trigger OnDrillDown()
                    var
                        VHPage: Page 50264;
                        VhCode: Code[10];
                    begin
                        IF Rec.Status <> Rec.Status::"Under GA Secton" THEN
                            ERROR('You cann''t select Vehicle!!');
                        IF Rec."Requirement Type" = Rec."Requirement Type"::Urgent THEN
                            IF Rec."Vehicle Code" = '' THEN
                                ERROR('Please Book ''General Taxi'',due to urgent requirment !!')
                            ELSE
                                EXIT;
                        VHRec.RESET;
                        VHRec.SETRANGE(Availability, TRUE);
                        IF VHRec.FIND('-') THEN BEGIN
                            VHPage.SETRECORD(VHRec);
                            VHPage.SETTABLEVIEW(VHRec);
                            VHPage.EDITABLE(FALSE);
                            VHPage.LOOKUPMODE(TRUE);
                            IF VHPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                VHRec1.RESET;
                                VHRec1.SETRANGE("Vehicle Code", Rec."Vehicle Code");
                                VHRec1.SETRANGE(Availability, FALSE);
                                IF VHRec1.FINDFIRST THEN BEGIN
                                    VHRec1.Availability := TRUE;
                                    VHRec1.MODIFY;
                                END;
                                VHPage.GETRECORD(VHRec);
                                Rec."Vehicle Code" := VHRec."Vehicle Code";
                                Rec."Start KM" := VHRec1."Total (KM)";
                                VHRec.Availability := FALSE;
                                VHRec.MODIFY;
                            END;
                        END
                        ELSE
                            MESSAGE('Book the General Taxi,Fill the Vehicle Code!!');
                    end;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                    Editable = Editable001;
                    trigger OnDrillDown()
                    var
                        DvrPage: Page 50266;
                        DrCode: Code[10];
                    begin
                        IF Rec.Status <> Rec.Status::"Under GA Secton" THEN
                            ERROR('You cann''t select Vehicle!!');
                        IF Rec."Requirement Type" = Rec."Requirement Type"::Urgent THEN BEGIN
                            IF Rec."Driver Code" = '' THEN
                                ERROR('Please Enter General Taxi ''Driver Code'' or ''Name''!!')
                            ELSE
                                EXIT;
                        END;
                        DvrRec.RESET;
                        DvrRec.SETFILTER(Availability, '=%1', TRUE);
                        IF DvrRec.FIND('-') THEN BEGIN
                            DvrPage.SETRECORD(DvrRec);
                            DvrPage.EDITABLE(FALSE);
                            DvrPage.SETTABLEVIEW(DvrRec);
                            DvrPage.LOOKUPMODE(TRUE);
                            IF DvrPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                DvrRec1.RESET;
                                DvrRec1.SETRANGE("Driver Code", Rec."Driver Code");
                                IF DvrRec1.FINDFIRST THEN BEGIN
                                    DvrRec1.Availability := TRUE;
                                    DvrRec1.MODIFY;
                                END;

                                DvrPage.GETRECORD(DvrRec);
                                Rec."Driver Code" := DvrRec."Driver Code";
                                DvrRec.Availability := FALSE;
                                DvrRec.MODIFY;
                            END;
                        END
                        ELSE
                            MESSAGE('Please Enter General Taxi Driver Code/Name!!');
                    end;
                }
                field("Start KM"; Rec."Start KM")
                {
                    ApplicationArea = all;
                }
                field("End KM"; Rec."End KM")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send Approval Request")
            {
                ApplicationArea = all;
                Image = SendTo;
                Promoted = true;
                Visible = EnableBtn2;

                trigger OnAction()
                begin
                    IF Rec."Requirement Type" = Rec."Requirement Type"::" " THEN
                        ERROR('Please Select "Requirement Type"!!');
                    IF Rec."Journey Type" = Rec."Journey Type"::" " THEN
                        ERROR('Please Select "Journey Type"!!');
                    IF Rec."Transfer User ID" = '' THEN
                        ERROR('Please Select Transfer User Name !!');

                    IF USERID <> Rec."Receiver ID" THEN
                        ERROR('You cann''t send it for approval due to user ID mismatch!!');

                    IF NOT CONFIRM('Do you want to send an approval request to %1 (%2)?', FALSE, TransferUser, Receiverid) THEN
                        EXIT;

                    InsertApprovalEntry;
                    /*
                    AppEnt.INIT;
                    AppEnt."Table ID":=50196;
                    AppEnt."Document No.":=Rec."TF Code";
                    AppEnt."Document Type":=AppEnt."Document Type"::" ";
                    AppEnt."Sequence No.":=1;
                    AppEnt."Entry No.":=Entryno+1;
                    AppEnt.Status:=AppEnt.Status::Open;
                    AppEnt."Sender ID":=USERID;
                    AppEnt."Approver ID":="Recever ID";
                    AppEnt."Last Date-Time Modified":=CURRENTDATETIME;
                    AppEnt."Date-Time Sent for Approval":=CURRENTDATETIME;
                    AppEnt."Last Modified By User ID":=USERID;
                    AppEnt."Record ID to Approve":=Rec.RECORDID;
                    AppEnt.INSERT;
                    */
                    TFlogRec.RESET;
                    TFlogRec.SETRANGE("TF Code", Rec."TF Code");
                    IF TFlogRec.FINDFIRST THEN BEGIN
                        TFlogRec."Sender ID" := USERID;
                        TFlogRec."Receiver ID" := rec."Transfer User ID";
                        TFlogRec.Status := Rec.Status::"Under Approval";
                        TFlogRec."Transfer User ID" := '';
                        IF TFlogRec.MODIFY THEN
                            CurrPage.CLOSE;
                    END;

                end;
            }
            action("Forward to GA Section")
            {
                ApplicationArea = all;
                Image = SendTo;
                Promoted = true;
                Visible = EnableBtn3;

                trigger OnAction()
                begin
                    IF Rec."Transfer User ID" = '' THEN
                        ERROR('Please Select Transfer User !!');

                    IF USERID <> Rec."Receiver ID" THEN
                        ERROR('You cann''t send it for approval due to user ID mismatch!!');

                    IF NOT CONFIRM('Do you want to send an approval request to %1 (%2)?', FALSE, TransferUser, Receiverid) THEN
                        EXIT
                    ELSE BEGIN
                        AppEnt.RESET;
                        AppEnt.SETRANGE("Table ID", 50108);
                        AppEnt.SETRANGE(Status, AppEnt.Status::Open);
                        IF AppEnt.FINDFIRST THEN BEGIN
                            AppEnt.Status := AppEnt.Status::Forwarded;
                            AppEnt."Last Date-Time Modified" := CURRENTDATETIME;
                            AppEnt."Last Modified By User ID" := USERID;
                            AppEnt.MODIFY;
                        END;
                        InsertApprovalEntry;
                        TFlogRec.RESET;
                        TFlogRec.SETRANGE("TF Code", Rec."TF Code");
                        IF TFlogRec.FINDFIRST THEN BEGIN
                            TFlogRec."Sender ID" := USERID;
                            TFlogRec."Receiver ID" := rec."Transfer User ID";
                            TFlogRec.Status := Rec.Status::"Under GA Secton";
                            TFlogRec."Transfer User ID" := '';
                            IF TFlogRec.MODIFY THEN
                                CurrPage.CLOSE;
                        END;
                    END;
                end;
            }
            action(Approve)
            {
                ApplicationArea = all;
                Image = Approval;
                Promoted = true;
                Visible = EnableBtn4;

                trigger OnAction()
                begin
                    IF USERID <> Rec."Receiver ID" THEN
                        ERROR('You cann''t approve due to user ID mismatch!!');

                    IF Rec."Vehicle Code" = '' THEN
                        ERROR('Please select Vehicle Code!!');
                    IF Rec."Driver Code" = '' THEN
                        ERROR('Please select Driver Code!!');
                    IF Rec."Start KM" = 0 THEN
                        ERROR('Please fill ''Start KM'' !!');
                    IF NOT CONFIRM('Do you want to Approve?', FALSE) THEN
                        EXIT;
                    IF Rec."Requirement Type" = Rec."Requirement Type"::General THEN
                        selection := STRMENU('Approve,General Taxi', 1, 'Go through selected option!!,''Approve'' or ''General Taxi''')
                    ELSE
                        selection := STRMENU('Approve,General Taxi', 2, 'Go through selected option!!,''Approve'' or ''General Taxi''');
                    IF selection = 1 THEN BEGIN
                        Rec.FILTERGROUP(10);
                        AppEnt.RESET;
                        AppEnt.SETRANGE("Document Type", AppEnt."Document Type"::" ");
                        AppEnt.SETRANGE("Table ID", 50108);
                        AppEnt.SETRANGE("Document No.", Rec."TF Code");
                        IF AppEnt.FINDLAST THEN BEGIN
                            AppEnt.Status := AppEnt.Status::Approved;
                            AppEnt."Last Date-Time Modified" := CURRENTDATETIME;
                            AppEnt."Last Modified By User ID" := USERID;
                            AppEnt.MODIFY;
                        END;
                        TFlogRec.RESET;
                        TFlogRec.SETRANGE("TF Code", Rec."TF Code");
                        IF TFlogRec.FINDFIRST THEN BEGIN
                            TFlogRec.Status := Rec.Status::Approved;
                            IF TFlogRec.MODIFY THEN
                                CurrPage.CLOSE;
                        END;
                        Rec.FILTERGROUP(0);
                    END
                    ELSE
                        IF selection = 2 THEN BEGIN
                            MESSAGE('General Taxi');
                            Rec.FILTERGROUP(10);
                            AppEnt.RESET;
                            AppEnt.SETRANGE("Document Type", AppEnt."Document Type"::" ");
                            AppEnt.SETRANGE("Table ID", 50108);
                            AppEnt.SETRANGE("Document No.", Rec."TF Code");
                            IF AppEnt.FINDLAST THEN BEGIN
                                AppEnt.Status := AppEnt.Status::Approved;
                                AppEnt."Last Date-Time Modified" := CURRENTDATETIME;
                                AppEnt."Last Modified By User ID" := USERID;
                                AppEnt.MODIFY;
                            END;
                            TFlogRec.RESET;
                            TFlogRec.SETRANGE("TF Code", Rec."TF Code");
                            IF TFlogRec.FINDFIRST THEN BEGIN
                                TFlogRec.Status := Rec.Status::Approved;
                                IF TFlogRec.MODIFY THEN
                                    CurrPage.CLOSE;
                            END;
                            Rec.FILTERGROUP(0);
                        END;
                end;
            }
            action("End Trip")
            {
                ApplicationArea = all;
                Promoted = true;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Approved THEN
                        ERROR('Still waiting for Approvel !!');
                    IF Rec."End Trip" <> FALSE THEN ERROR('the journey has already ended!!');
                    IF (Rec."End KM" = 0) or (Rec."End KM" < Rec."Start KM") THEN
                        ERROR('''End KM'' is not 0 or less to the ''Start KM''.');
                    IF NOT CONFIRM('Do you want to End Trip?', FALSE) THEN
                        EXIT;

                    TFlogRec.RESET;
                    TFlogRec.SETRANGE("TF Code", Rec."TF Code");
                    TFlogRec.SETRANGE("Requirement Type", Rec."Requirement Type"::General);
                    IF TFlogRec.FINDFIRST THEN BEGIN

                        TFlogRec.Modify();
                        if VHRec.GET(TFlogRec."Vehicle Code") then begin
                            VHRec.Availability := TRUE;
                            VHRec.MODIFY;
                        end;
                        if DvrRec.GET(TFlogRec."Driver Code") then begin
                            DvrRec.Availability := TRUE;
                            DvrRec.MODIFY;
                        end;
                        TFlogRec.Status := Rec.Status::Completed;

                    END;
                    Rec."End Trip" := TRUE;
                    rec.Status := rec.Status::Completed;
                    IF Rec.MODIFY THEN MESSAGE('Success!!');
                    CurrPage.CLOSE;
                end;
            }
        }
    }


    trigger OnInit()
    begin
        EnableBtn := FALSE;
        EnableBtn2 := FALSE;
        EnableBtn3 := FALSE;
        EnableBtn4 := FALSE;
        EnableBtn5 := TRUE;
        Editable001 := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BOCUsersPage: Page 50148;
    begin
        UserBOC.RESET;
        UserBOC.SETRANGE("User Name", USERID);
        IF UserBOC.FINDFIRST THEN BEGIN
            Rec.Name := UserBOC."Full Name";
            Designation := UserBOC.Designation;
        END;
        Rec."Receiver ID" := UserId;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Status = Rec.Status::Open THEN
            EnableBtn2 := TRUE;
        IF Rec.Status = Rec.Status::"Under Approval" THEN
            EnableBtn3 := TRUE;
        IF Rec.Status = Rec.Status::"Under GA Secton" THEN
            EnableBtn4 := TRUE;

        IF (Rec.Status = Rec.Status::"Under GA Secton") OR (Rec.Status = Rec.Status::Approved) THEN BEGIN
            EnableBtn := TRUE;
            EnableBtn5 := FALSE
        END;

        if Rec."Requirement Type" = Rec."Requirement Type"::Urgent then
            Editable001 := true
        else
            Editable001 := false;

    end;

    var
        ApprovalUserGroup: Record "Approval User Group Member";
        VHRec: Record 50106;
        DvrRec: Record 50107;
        VHRec1: Record 50106;
        DvrRec1: Record 50107;
        UserBOC: Record 50000;
        Designation: Text;
        EnableBtn, Editable001, Editable002 : Boolean;
        TransferUser: Text;
        AppEnt: Record 454;
        Entryno: Integer;
        TFlogRec: Record 50108;
        EnableBtn2: Boolean;
        GLSetup: Record 98;
        NSMgt: Codeunit 396;
        EnableBtn3: Boolean;
        EnableBtn4: Boolean;
        Receiverid: Code[20];
        selection: Integer;
        EnableBtn5: Boolean;
        mydialog: Dialog;
        int: Integer;

    local procedure InsertApprovalEntry()
    var
        ApproverId: Code[20];
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
    begin
        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.INIT;
        ApprovalEntryRec.RESET;
        ApprovalEntryRec."Table ID" := 50108;
        ApprovalEntryRec."Document No." := Rec."TF Code";
        ApprovalEntryRec."Sequence No." := 1;
        ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::" ";
        ApprovalEntryRec."Entry No." := EntryNo + 1;
        ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
        ApprovalEntryRec."Sender ID" := USERID;
        ApprovalEntryRec."Approver ID" := Receiverid;
        ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
        ApprovalEntryRec."Last Modified By User ID" := USERID;
        ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
        ApprovalEntryRec."Record ID to Approve" := Rec.RECORDID;
        ApprovalEntryRec.INSERT;
        //.................
    end;
}

