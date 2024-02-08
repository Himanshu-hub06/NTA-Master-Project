#pragma implicitwith disable
page 50789 "Meeting Card"
{
    AutoSplitKey = true;
    Caption = 'Meeting Details';
    DelayedInsert = false;
    PageType = Card;
    //ShowFilter = false;
    SourceTable = 50285;
    ApplicationArea = all;
    UsageCategory = Documents;


    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = MakeEditable; //rohit
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    // Visible = false;
                }

                field("Meeting No."; Rec."Meeting No.")
                {
                    ApplicationArea = All;
                    Caption = 'Meeting No.';
                    Editable = false;


                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Meeting Time"; Rec."Meeting Time")
                {
                    Caption = 'Meeting Time';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    ApplicationArea = all;

                }
                field("Meeting Venue"; Rec."Meeting Venue")
                {
                    ApplicationArea = all;
                }
                field("Meeting Subject"; Rec."Meeting Agenda")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Description; Rec."Meeting Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part("Pvt. FM Meeting List Part"; 50790)
            {
                ApplicationArea = All;
                Caption = 'Pvt. FM Meeting List';
                Editable = false;
                SubPageLink = "Committee Code" = FIELD("Committee Code"),
                              "Meeting No." = FIELD("Meeting No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                PromotedOnly = true;
                ApplicationArea = all;
                Visible = Vis001;
                trigger OnAction()
                begin

                    NTASetup.Get();
                    SelctedUser := '';
                    // IF Rec.Receiver_ID <> USERID THEN
                    //     ERROR('You can not Forward it due to user ID mismatch');
                    CurrPage.SetSelectionFilter(AvMetting1);
                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
                    AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN
                            SelctedUser := AppUserMem."User ID";
                    SequenceNo := AppUserMem."Sequence No.";
                    IF SelctedUser = '' THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to send approval request to %1?', FALSE, SelctedUser) THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Meeting Agenda");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry();
                    AvMetting.RESET;
                    AvMetting.SETRANGE(AvMetting."Meeting No.", Rec."Meeting No.");
                    IF AvMetting.FINDFIRST THEN BEGIN
                        AvMetting."Sender ID" := UserID;
                        AvMetting."Receiver ID" := SelctedUser;
                        AvMetting.Status := AvMetting.Status::"Pending for Approval";
                        IF AvMetting.MODIFY THEN
                            MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
                        // CurrPage.CLOSE;
                    END;
                end;
            }
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = Vis002; //rk

                trigger OnAction()
                begin
                    IF Rec."Receiver ID" <> USERID THEN
                        ERROR('You are not allowed to approve, due to user ID mismatch');
                    if not Confirm('Do you want to Approve.?') then
                        exit;

                    NTASetup.Get();
                    AppUserMem.RESET;
                    AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
                    AppUserMem.SETRANGE("User ID", UserId);
                    AppUserMem.SETRANGE("Approval Permission", TRUE);
                    IF AppUserMem.FIND('-') THEN BEGIN
                        // FILTERGROUP(10);
                        // AppEntInit.RESET; //rohit 1/11
                        // AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
                        // AppEntInit.SETRANGE("Document No.", rec.Name);
                        // IF AppEntInit.FINDLAST THEN BEGIN
                        //     AppEntInit.Status := AppEntInit.Status::Approved;
                        //     AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        //     AppEntInit."Last Modified By User ID" := USERID;
                        //     AppEntInit.MODIFY;
                        // END;//rohit 1/11
                        AvMetting.RESET;
                        AvMetting.SETRANGE(AvMetting."Meeting No.", rec."Meeting No.");
                        IF AvMetting.FINDFIRST THEN BEGIN
                            AvMetting.Status := AvMetting.Status::Approved;
                            AvMetting."Sender ID" := USERID;
                            AvMetting."Receiver ID" := SelctedUser;
                            //AvMetting.Blocked := true; //rohit1/11
                            IF AvMetting.MODIFY THEN
                                MESSAGE('Application has been successfully Approved!');
                            // CurrPage.CLOSE;
                        END;
                        // FILTERGROUP(0);
                        //CurrPage.Close();
                    END
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Vis002;//rk
                trigger OnAction()
                begin
                    IF rec."Receiver ID" <> USERID THEN
                        ERROR('You are not allowed to reject, due to user ID mismatch');

                    if not Confirm('Do you want to Reject.?') then
                        exit;

                    // FILTERGROUP(10);
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
                    AppEntInit.SETRANGE("Document No.", Rec."Meeting Agenda");
                    if AppEntInit.FINDLAST THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Rejected;
                        AppEntInit."Date-Time Sent for Approval" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    AvMetting.RESET;
                    AvMetting.SETRANGE(AvMetting."Meeting No.", rec."Meeting No.");
                    IF AvMetting.FINDFIRST THEN BEGIN
                        AvMetting.Status := AvMetting.Status::Rejected;
                        AvMetting."Sender ID" := USERID;
                        AvMetting."Receiver ID" := SelctedUser;
                        IF AvMetting.MODIFY THEN
                            MESSAGE('Application request has been rejected!!');
                        CurrPage.CLOSE;
                    END;
                    // FILTERGROUP(0);
                    //CurrPage.Close();
                END;
            }


        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if rec.status = rec.status::Open then begin
            Vis001 := true;
            Vis002 := false;
        end;
        if rec.status = rec.status::Open then begin
            NTASetup.Get;
            AppUserMem.Reset();
            AppUserMem.SetRange("Approval User Group Code", NTASetup."Budget Approval code");
            AppUserMem.SetRange("User ID", UserId);
            AppUserMem.SetRange("Approval Permission", true);
            if AppUserMem.Find('-') then begin
                Vis001 := false;
                Vis002 := false;
            end;
        end;

        IF (rec.Status = rec.Status::"Pending for Approval") then begin
            NTASetup.GET;
            AppUserMem.RESET;
            AppUserMem.SETRANGE("Approval User Group Code", NTASetup."Budget Approval code");
            AppUserMem.SETRANGE("User ID", USERID);
            AppUserMem.SETRANGE("Approval Permission", TRUE);
            IF AppUserMem.FIND('-') THEN BEGIN
                Vis002 := TRUE;
                Vis001 := false;
            END
            ELSE BEGIN
                Vis002 := FALSE; //open
                Vis001 := false;  //open
            END;
        end;
        IF (rec.Status = rec.Status::Approved) OR (rec.Status = rec.Status::Rejected) THEN BEGIN
            Vis001 := FALSE;
            Vis002 := FALSE;
            Edit001 := false;
            EnabledBtn1 := false;
        END
        ELSE BEGIN
            Edit001 := true;
            EnabledBtn1 := true;
        END;

    end;


    var
        NTASetup: Record "NTA Bill Setup";
        AppUserMem: Record "Approval User Group Member";
        AppEntInit: Record "Approval Entry";
        SelctedUser: code[20];
        SequenceNo: Integer;

        AvMetting, AvMetting1 : Record "AV Meeting Header";
        Vis001, Vis002, Edit001, EnabledBtn1 : Boolean;
        edite: Boolean;

        editwar: Boolean;



    local procedure InsertApprovalEntry()
    var
        ApproverId: Code[20];
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;

    begin

        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.RESET;
        ApprovalEntryRec."Table ID" := 95;
        ApprovalEntryRec."Sequence No." := 1;
        ApprovalEntryRec."Document No." := Rec."Meeting Agenda";
        ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Budget;
        ApprovalEntryRec."Entry No." := EntryNo + 1;
        ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
        ApprovalEntryRec."Sender ID" := USERID;
        ApprovalEntryRec."Approver ID" := SelctedUser;
        ApprovalEntryRec."Shortcut Dimension 2 Code" := 'S01';
        ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
        ApprovalEntryRec."Last Modified By User ID" := USERID;
        ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
        ApprovalEntryRec."Record ID to Approve" := AvMetting1.RECORDID;
        ApprovalEntryRec.INSERT;


    end;

    // procedure ApprovalNoedit(Satus: Text)
    // var

    // begin
    //     if Satus = 'Approved' then
    //         edite := false;
    // end;

    trigger OnOpenPage()
    var
        StatusL: Text;
    begin
        // StatusL := SinglCU.Getstatus();

        // Message(StatusL);
        // // IF StatusL = 'Approved' THEN
        // IF StatusL = 'Approved' THEN
        //     CurrPage.Editable := false;
    end;



    var
        SinglCU: Codeunit 50012;


    //     actions
    //     {
    //         area(processing)
    //         {
    //             group(Send)
    //             {
    //                 Caption = 'Send';
    //                 action("Send Mail To Committee")
    //                 {
    //                     ApplicationArea = All;
    //                     Image = SendMail;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     PromotedOnly = true;
    //                     Visible = ShowForward;

    //                     trigger OnAction()
    //                     var
    //                         ApprovalEntry: Record 454;
    //                         CommitteeLineRec: Record 50284;
    //                         Recipients: list of [Text];
    //                         //CommitteAppEntry: Record 50269; //ROHIT
    //                         MeetingLine: Record 50286;
    //                         FDRTab: Record "File Directory Detail";
    //                         BodyMessage, Subject, APIURL, URL, UserIDPass, Text001 : text;
    //                         Email: array[20] of Text[80];
    //                         CmtLnTab: Record "AV Committee Line";
    //                         Ln, II, jj, kk : Integer;
    //                         Client: HttpClient;
    //                         content: HttpContent;
    //                         Response: HttpResponseMessage;
    //                         DayOfWeek, Salutation : Text;
    //                         Succ: Boolean;
    //                     begin
    //                         FDRTab.Get();
    //                         URL := FDRTab."Mail API Url";
    //                         //rec.TESTFIELD(Rec.Status, Rec.Status::Open);
    //                         if Rec.Status <> Rec.Status::Open then//kc 25042023
    //                             Error('Mail is already sent or closed!');
    //                         MeetingLine.RESET;
    //                         MeetingLine.SETRANGE("Committee Code", Rec."Committee Code");
    //                         MeetingLine.SETRANGE("Meeting No.", Rec."Meeting No.");
    //                         IF NOT MeetingLine.FINDFIRST THEN
    //                             ERROR('There is nothing to send');

    //                         CommitteeLine.RESET;
    //                         CommitteeLine.SETRANGE("Committee Code", Rec."Committee Code");//ROHIT
    //                         IF CommitteeLine.FINDFIRST THEN
    //                             IF CommitteeLine."Member ID" = '' THEN
    //                                 ERROR('Login ID not created for committee members');

    //                         IF NOT CONFIRM('Do you want to send mail to Committee members', FALSE) THEN
    //                             EXIT;
    //                         //kc 23062023
    //                         Subject := 'Empanelment of Private FM Radio Stations with CBC - regarding.';
    //                         BodyMessage := 'In pursuance of the Policy Guidelines for empanelment of Private FM Radio Stations and fixation of rates for Government advertisements, the following Panel Advisory Committee (PAC) has been constituted:<br><br>';

    //                         Ln := 0;
    //                         CmtLnTab.Reset();
    //                         CmtLnTab.SetRange("Committee Code", Rec."Committee Code");
    //                         if CmtLnTab.FindSet() then
    //                             repeat begin
    //                                 Ln += 1;
    //                                 Email[ln] := CmtLnTab."E-mail ID";
    //                                 case CmtLnTab.Salutation of
    //                                     CmtLnTab.Salutation::"Mr.":
    //                                         Salutation := 'Mr.';
    //                                     CmtLnTab.Salutation::"Mrs.":
    //                                         Salutation := 'Mrs.';
    //                                     CmtLnTab.Salutation::"Ms.":
    //                                         Salutation := 'Ms.';
    //                                     CmtLnTab.Salutation::"Sh.":
    //                                         Salutation := 'Sh.';
    //                                     CmtLnTab.Salutation::"Smt.":
    //                                         Salutation := 'Smt.';
    //                                 end;
    //                                 BodyMessage := BodyMessage + Format(Ln) + '. ' + Salutation + ' ' + CmtLnTab."Member Name" + ', ' + CmtLnTab.Designation + '<br>';

    //                             end until CmtLnTab.Next() = 0;
    //                         kk := Date2DWY(rec."Meeting Date", 1);
    //                         case kk of
    //                             1:
    //                                 DayOfWeek := ' (Monday)';
    //                             2:
    //                                 DayOfWeek := ' (Tuesday)';
    //                             3:
    //                                 DayOfWeek := ' (Wednesday)';
    //                             4:
    //                                 DayOfWeek := ' (Thursday)';
    //                             5:
    //                                 DayOfWeek := ' (Friday)';
    //                             6:
    //                                 DayOfWeek := ' (Saturday)';
    //                             7:
    //                                 DayOfWeek := ' (Sunday)';
    //                         end;
    //                         BodyMessage := BodyMessage + '<br>';
    //                         BodyMessage := BodyMessage + 'This is to inform that the meeting of the PAC is scheduled to be convened at ';
    //                         BodyMessage := BodyMessage + Format(Rec."Meeting Time") + ' on ' + Format(Rec."Meeting Date", 0, '<Day,2>-<Month,2>-<Year4>') + DayOfWeek + ' in the Committee Room of CBC (erstwhile DAVP) at 3rd floor, Soochna Bhawan, CGO Complex, Lodhi Road, New Delhi.<br><br>';
    //                         BodyMessage := BodyMessage + 'All members of the Committee are requested to make it convenient to attend the meeting.<br><br><br>';
    //                         BodyMessage := BodyMessage + '<br>Kindly use the below URL for the login in the System<br><br>';
    //                         Ln := 0;
    //                         CmtLnTab.Reset();
    //                         CmtLnTab.SetRange("Committee Code", Rec."Committee Code");
    //                         if CmtLnTab.FindSet() then
    //                             repeat begin
    //                                 Ln += 1;
    //                                 clear(Text001);
    //                                 Text001 := BodyMessage + 'URL- http://20.219.125.221:8080/BC180/SignIn<br><br>';
    //                                 Text001 := Text001 + 'Username-' + CmtLnTab."Member ID" + '<br>Password-Boc@1234 ';
    //                                 APIURL := URL + '&email[]=' + CmtLnTab."E-mail ID" + '&subject=' + Subject + '&body=' + Text001;
    //                                 if Client.Post(APIURL, content, Response) then begin
    //                                     if Response.IsSuccessStatusCode() then
    //                                         Succ := true
    //                                     else
    //                                         Succ := false;
    //                                 end;
    //                             end until CmtLnTab.Next() = 0;

    //                         if Succ then begin
    //                             MESSAGE('Mail sent Succefully');
    //                             Rec.Status := Rec.Status::"Mail Sent";
    //                             Rec.MODIFY;
    //                         end
    //                         else
    //                             Error('Mail not sent');

    //                         //end 23062023

    //                         // ii := CompressArray(Email);
    //                         // for jj := 1 to ii do begin
    //                         //     APIURL := APIURL + '&email[]=' + Email[jj] + '&subject=' + Subject + '&body=' + BodyMessage;
    //                         // end;
    //                         /* //commented by kc 24042023
    //                         SMTPMailSetupRec.RESET;
    //                         SMTPMailSetupRec.GET;
    //                         Subject := Rec."Meeting Agenda";
    //                         Body := 'Dear Sir/Madam,';
    //                         //Recipients := '';

    //                         CommitteeLineRec.RESET;
    //                         CommitteeLineRec.SETRANGE("Committee Code", Rec."Committee Code");
    //                         IF CommitteeLineRec.FINDSET THEN
    //                             REPEAT
    //                                 Recipients.Add(CommitteeLineRec."E-mail ID");
    //                             UNTIL CommitteeLineRec.NEXT = 0;

    //                         SMTPMail.CreateMessage('BOC', SMTPMailSetupRec."User ID", Recipients, Subject, Body, TRUE);
    //                         //SMTPMail.AddBCC(SendLdgr."E-mail");
    //                         SMTPMail.AppendBody('<BR><BR>');
    //                         SMTPMail.AppendBody(Rec."Meeting Description");
    //                         SMTPMail.AppendBody('<BR><BR>');
    //                         SMTPMail.AppendBody('Meeting Date : ' + FORMAT(Rec."Meeting Date"));
    //                         SMTPMail.AppendBody('<BR><BR>');
    //                         SMTPMail.AppendBody('Meeting Start time : ' + FORMAT(Rec."Meeting Start Date Time"));
    //                         SMTPMail.AppendBody('<BR><BR><BR>');
    //                         SMTPMail.AppendBody('Thanks & Regards');
    //                         SMTPMail.AppendBody('<BR><BR>');
    //                         SMTPMail.AppendBody('CO');
    //                         SMTPMail.AppendBody('<BR>');
    //                         SMTPMail.AppendBody('Bureau of Outreach and Communication');
    //                         //SMTPMail.SendBSEB('');
    //                         */

    //                         // CommitteeLineRec.RESET;
    //                         // CommitteeLineRec.SETRANGE("Committee Code", Rec."Committee Code");
    //                         // IF CommitteeLineRec.FINDSET THEN BEGIN
    //                         //     REPEAT
    //                         //         MeetingLine.RESET;
    //                         //         MeetingLine.SETRANGE("Committee Code", Rec."Committee Code");
    //                         //         MeetingLine.SETRANGE("Meeting No.", Rec."Meeting No.");
    //                         //         IF MeetingLine.FINDSET THEN
    //                         //             REPEAT
    //                         //                 CommitteAppEntry.INIT;
    //                         //                 CommitteAppEntry."User ID" := CommitteeLineRec."Member ID";
    //                         //                 CommitteAppEntry."Committee Code" := Rec."Committee Code";
    //                         //                 CommitteAppEntry."Meeting No." := Rec."Meeting No.";
    //                         //                 CommitteAppEntry."Line No." := CommitteAppEntry."Line No." + 10000;
    //                         //                 CommitteAppEntry."FM Station Code" := MeetingLine."Newspaper Code";
    //                         //                 CommitteAppEntry."Agency Name" := MeetingLine."Newspaper Name";
    //                         //                 CommitteAppEntry."Language Code" := MeetingLine.Language;
    //                         //                 CommitteAppEntry."Publication Place" := MeetingLine."Place of Publication";
    //                         //                 CommitteAppEntry."Global Dimension 1 Code" := MeetingLine."Global Dimension 1 Code";
    //                         //                 CommitteAppEntry."Global Dimension 2 Code" := MeetingLine."Global Dimension 2 Code";
    //                         //                 CommitteAppEntry.INSERT;
    //                         //             UNTIL MeetingLine.NEXT = 0;
    //                         //     UNTIL CommitteeLineRec.NEXT = 0;
    //                         // END;



    //                         // MESSAGE('Mail sent Succefully');
    //                         // Rec.Status := Rec.Status::"Mail Sent";
    //                         // Rec.MODIFY;
    //                     end;
    //                 }
    //                 action("Forward For Approval")
    //                 {
    //                     ApplicationArea = All;
    //                     Image = Approval;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     //Visible = false;

    //                     trigger OnAction()
    //                     var
    //                         //VendEmpRec: Record 50152;  //Rohit++
    //                         ApprovalEntry: Record 454;
    //                         MeetingMasterRec: Record 50060;
    //                         MeetingLineRec: Record 50286;//50061;   //Rohit++
    //                         ApprovalUserGroupMemberRec: Record 50082; //50063;  //Rohit++
    //                         ApprovalUserGroupMembersc: Page 50133;
    //                         SelctedUser: Code[30];
    //                         ApprovalEntryRec2: Record 454;
    //                         EntryNo: Integer;
    //                         UserRec: Record 2000000120;
    //                     begin
    //                         MeetingLineRec.RESET;
    //                         MeetingLineRec.SETRANGE("Committee Code", Rec."Committee Code");
    //                         MeetingLineRec.SETRANGE("Meeting Type", Rec."Meeting Type");
    //                         MeetingLineRec.SETRANGE("Meeting No.", Rec."Meeting No.");
    //                         MeetingLineRec.SETRANGE(Approve, TRUE);
    //                         IF NOT MeetingLineRec.FINDFIRST THEN BEGIN
    //                             MESSAGE('Any vendor application is not find to send for approval.');
    //                             EXIT;
    //                         END;


    //                         ApprovalUserGroupMemberRec.RESET;
    //                         ApprovalUserGroupMemberRec.SETRANGE("Committee Code", Rec."Committee Code");
    //                         ApprovalUserGroupMemberRec.SETRANGE("Approval Permission", TRUE);
    //                         ApprovalUserGroupMemberRec.SETFILTER("Member ID", '<>%1', USERID);
    //                         IF NOT ApprovalUserGroupMemberRec.FINDFIRST THEN BEGIN
    //                             MESSAGE('You don not have any committe member with approval permission');
    //                             EXIT;
    //                         END;
    //                         CLEAR(ApprovalUserGroupMembersc);
    //                         CLEAR(SelctedUser);
    //                         ApprovalUserGroupMembersc.SETRECORD(ApprovalUserGroupMemberRec);
    //                         ApprovalUserGroupMembersc.SETTABLEVIEW(ApprovalUserGroupMemberRec);
    //                         ApprovalUserGroupMembersc.EDITABLE(FALSE);
    //                         ApprovalUserGroupMembersc.LOOKUPMODE(TRUE);
    //                         IF ApprovalUserGroupMembersc.RUNMODAL = ACTION::LookupOK THEN BEGIN
    //                             ApprovalUserGroupMembersc.GETRECORD(ApprovalUserGroupMemberRec);
    //                             SelctedUser := ApprovalUserGroupMemberRec."Member ID";
    //                         END;

    //                         IF NOT CONFIRM('Do you want to send for approval to %1 ?', FALSE, SelctedUser) THEN
    //                             EXIT;

    //                         IF SelctedUser = '' THEN
    //                             ERROR('Please select a committee member, who have approval permission.');
    //                         IF (Rec."Creater ID" = USERID) AND (Rec."Receiver ID" = USERID) THEN BEGIN
    //                             IF (Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::"Mail Sent") THEN BEGIN
    //                                 ApprovalEntry.RESET;
    //                                 ApprovalEntry.SETRANGE("Table ID", 50305);
    //                                 ApprovalEntry.SETRANGE("Document No.", Rec."Document No.");//"Committee Code" +'/'+FORMAT("Meeting No.")
    //                                 ApprovalEntry.SETRANGE("Approver ID", USERID);
    //                                 ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
    //                                 IF ApprovalEntry.FINDFIRST THEN BEGIN
    //                                     ApprovalEntry.Status := ApprovalEntry.Status::Forwarded;
    //                                     ApprovalEntry.MODIFY;
    //                                 END
    //                                 ELSE
    //                                     IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
    //                                         ApprovalEntryRec2.RESET;
    //                                         IF ApprovalEntryRec2.FINDLAST THEN
    //                                             EntryNo := ApprovalEntryRec2."Entry No." + 1;
    //                                         ApprovalEntryRec2.RESET;
    //                                         ApprovalEntryRec2.INIT;
    //                                         ApprovalEntryRec2."Table ID" := 50305;
    //                                         ApprovalEntryRec2."Entry No." := EntryNo;
    //                                         ApprovalEntryRec2."Document No." := Rec."Document No.";//"Committee Code" +'/'+FORMAT("Meeting No.");
    //                                         ApprovalEntryRec2."Approver ID" := USERID;
    //                                         ApprovalEntryRec2.Status := ApprovalEntryRec2.Status::Forwarded;
    //                                         ApprovalEntryRec2."Date-Time Sent for Approval" := CURRENTDATETIME;
    //                                         ApprovalEntryRec2."Record ID to Approve" := Rec.RECORDID;
    //                                         ApprovalEntryRec2.INSERT;
    //                                         CLEAR(EntryNo);
    //                                     END;
    //                             END;
    //                         END;

    //                         ApprovalEntry.RESET;
    //                         ApprovalEntry.SETRANGE("Table ID", 50305);
    //                         ApprovalEntry.SETRANGE("Document No.", Rec."Document No.");
    //                         ApprovalEntry.SETRANGE("Sender ID", USERID);
    //                         ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
    //                         IF ApprovalEntry.FINDFIRST THEN BEGIN
    //                             ERROR('Already sent for Approval to %1', ApprovalEntry."Approver ID");
    //                         END
    //                         ELSE
    //                             IF NOT ApprovalEntry.FINDFIRST THEN BEGIN
    //                                 ApprovalEntryRec2.RESET;
    //                                 IF ApprovalEntryRec2.FINDLAST THEN
    //                                     EntryNo := ApprovalEntryRec2."Entry No.";
    //                                 ApprovalEntryRec2.RESET;
    //                                 ApprovalEntryRec2.INIT;
    //                                 //ApprovalEntryRec2."Document Type" := ApprovalEntryRec2."Document Type"::Invoice;
    //                                 ApprovalEntryRec2."Table ID" := 50305;
    //                                 ApprovalEntryRec2."Document No." := Rec."Document No.";
    //                                 ApprovalEntryRec2."Sender ID" := USERID;
    //                                 ApprovalEntryRec2."Entry No." := EntryNo + 1;
    //                                 UserRec.RESET;
    //                                 UserRec.SETCURRENTKEY("User Name");
    //                                 UserRec.SETRANGE("User Name", USERID);
    //                                 IF UserRec.FINDFIRST THEN
    //                                     ApprovalEntryRec2."Sender Name" := UserRec."Full Name";
    //                                 ApprovalEntryRec2."Approver ID" := SelctedUser;
    //                                 UserRec.RESET;
    //                                 UserRec.SETCURRENTKEY("User Name");
    //                                 UserRec.SETRANGE("User Name", SelctedUser);
    //                                 IF UserRec.FINDFIRST THEN;
    //                                 ApprovalEntryRec2.Status := ApprovalEntryRec2.Status::Open;
    //                                 ApprovalEntryRec2."Date-Time Sent for Approval" := CURRENTDATETIME;
    //                                 ApprovalEntryRec2."Record ID to Approve" := Rec.RECORDID;
    //                                 //      ApprovalEntryRec2.us := UserRec."Full Name";
    //                                 //    ApprovalEntryRec2."Sequence No." := ;
    //                                 ApprovalEntryRec2.INSERT;
    //                                 CLEAR(EntryNo);
    //                             END;

    //                         MeetingMasterRec.RESET;
    //                         IF MeetingMasterRec.GET(Rec."Committee Code", Rec."Meeting No.") THEN BEGIN
    //                             MeetingMasterRec.VALIDATE(Status, MeetingMasterRec.Status::"Mail Sent");
    //                             MeetingMasterRec."Sender ID" := USERID;
    //                             MeetingMasterRec."Receiver ID" := SelctedUser;
    //                             //
    //                             MeetingLineRec.RESET;
    //                             MeetingLineRec.SETRANGE("Committee Code", MeetingMasterRec."Committee Code");
    //                             //MeetingLineRec.SETRANGE("Meeting Type",MeetingMasterRec."Meeting Type");
    //                             MeetingLineRec.SETRANGE("Meeting No.", MeetingMasterRec."Meeting No.");
    //                             MeetingLineRec.SETRANGE(Approve, TRUE);
    //                             IF MeetingLineRec.FINDSET THEN BEGIN
    //                                 REPEAT
    //                                 // VendEmpRec.RESET;
    //                                 // IF VendEmpRec.GET(MeetingLineRec."Newspaper Code") THEN BEGIN
    //                                 //     VendEmpRec.Status := VendEmpRec.Status::"Pending for Approval";
    //                                 //     VendEmpRec."Sender ID" := USERID;
    //                                 //     VendEmpRec."Receiver ID" := SelctedUser;
    //                                 //     VendEmpRec.MODIFY;
    //                                 // END;
    //                                 UNTIL MeetingLineRec.NEXT = 0;
    //                             END;
    //                             MeetingMasterRec.MODIFY;
    //                         END;

    //                         CurrPage.CLOSE;
    //                     end;
    //                 }
    //                 action(sendmail)
    //                 {
    //                     ApplicationArea = All;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     PromotedOnly = true;
    //                     Visible = false;
    //                     trigger OnAction()
    //                     var
    //                         FDRTab: Record "File Directory Detail";
    //                         BodyMessage, Subject, APIURL, URL, UserIDPass, Text001, Salutation : text;
    //                         Email: array[20] of Text[80];
    //                         CmtLnTab: Record "AV Committee Line";
    //                         Ln, II, jj, kk : Integer;
    //                         Client: HttpClient;
    //                         content: HttpContent;
    //                         Response: HttpResponseMessage;
    //                         DayOfWeek: Text;
    //                     begin
    //                         FDRTab.Get();
    //                         URL := FDRTab."Mail API Url";
    //                         Subject := 'Empanelment of Private FM Radio Stations with CBC – regarding.';

    //                         BodyMessage := 'In pursuance of the Policy Guidelines for empanelment of Private FM Radio Stations and fixation of rates for Government advertisements, the following Panel Advisory Committee (PAC) has been constituted:<br><br>';


    //                         //APIURL := APIURL + '&email[]=' + Email[1] + '&subject=' + Subject + '&body=' + BodyMessage;
    //                         Ln := 0;
    //                         CmtLnTab.Reset();
    //                         CmtLnTab.SetRange("Committee Code", Rec."Committee Code");
    //                         if CmtLnTab.FindSet() then
    //                             repeat begin
    //                                 Ln += 1;
    //                                 Email[ln] := CmtLnTab."E-mail ID";
    //                                 case CmtLnTab.Salutation of
    //                                     CmtLnTab.Salutation::"Mr.":
    //                                         Salutation := 'Mr.';
    //                                     CmtLnTab.Salutation::"Mrs.":
    //                                         Salutation := 'Mrs.';
    //                                     CmtLnTab.Salutation::"Ms.":
    //                                         Salutation := 'Ms.';
    //                                     CmtLnTab.Salutation::"Sh.":
    //                                         Salutation := 'Sh.';
    //                                     CmtLnTab.Salutation::"Smt.":
    //                                         Salutation := 'Smt.';
    //                                 end;
    //                                 BodyMessage := BodyMessage + Format(Ln) + '. ' + Salutation + ' ' + CmtLnTab."Member Name" + ', ' + CmtLnTab.Designation + '<br>';

    //                             end until CmtLnTab.Next() = 0;
    //                         kk := Date2DWY(rec."Meeting Date", 1);
    //                         case kk of
    //                             1:
    //                                 DayOfWeek := ' (Monday)';
    //                             2:
    //                                 DayOfWeek := ' (Tuesday)';
    //                             3:
    //                                 DayOfWeek := ' (Wednesday)';
    //                             4:
    //                                 DayOfWeek := ' (Thursday)';
    //                             5:
    //                                 DayOfWeek := ' (Friday)';
    //                             6:
    //                                 DayOfWeek := ' (Saturday)';
    //                             7:
    //                                 DayOfWeek := ' (Sunday)';
    //                         end;
    //                         BodyMessage := BodyMessage + '<br>';
    //                         BodyMessage := BodyMessage + 'This is to inform that the meeting of the PAC is scheduled to be convened at ';
    //                         BodyMessage := BodyMessage + Format(Rec."Meeting Time") + ' on ' + Format(Rec."Meeting Date", 0, '<Day,2>-<Month,2>-<Year4>') + DayOfWeek + ' in the Committee Room of CBC (erstwhile DAVP) at 3rd floor, Soochna Bhawan, CGO Complex, Lodhi Road, New Delhi.<br><br>';
    //                         BodyMessage := BodyMessage + '&& All members of the Committee are requested to make it convenient to attend the meeting.<br><br><br>';
    //                         BodyMessage := BodyMessage + '<br>Kindly use the below URL for the login in the System<br><br>';
    //                         Ln := 0;
    //                         CmtLnTab.Reset();
    //                         CmtLnTab.SetRange("Committee Code", Rec."Committee Code");
    //                         if CmtLnTab.FindSet() then
    //                             repeat begin
    //                                 Ln += 1;
    //                                 Clear(Text001);
    //                                 Text001 := BodyMessage + 'URL- http://20.219.125.221:8080/BC180/SignIn<br><br>';

    //                                 Text001 := Text001 + 'Username-' + CmtLnTab."Member ID" + '<br>Password-Boc@1234 ';

    //                                 APIURL := URL + '&email[]=' + CmtLnTab."E-mail ID" + '&subject=' + Subject + '&body=' + Text001;
    //                                 // Message(APIURL);
    //                                 // if Client.Post(APIURL, content, Response) then begin
    //                                 //     if Response.IsSuccessStatusCode() then
    //                                 //         Message('successfully send')
    //                                 //     else
    //                                 //         Error('Mail not sent.');
    //                                 // end;
    //                             end until CmtLnTab.Next() = 0;
    //                     end;
    //                 }
    //                 action("Close Meeting")
    //                 {
    //                     ApplicationArea = All;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     PromotedOnly = true;
    //                     Image = Close;
    //                     trigger OnAction()
    //                     var
    //                         AVMTLnTab: Record "AV Meeting Line";
    //                         Succ: Boolean;
    //                     //VendEmpTab: Record "Vend Emp - Pvt. FM";
    //                     begin
    //                         if Rec."Close Meeting" then
    //                             Error('Meeting has been ended.');
    //                         if rec."Empanelment Category" = rec."Empanelment Category"::"Pvt. FM" then begin
    //                             if not Confirm('Do you want to close the meeting?', true) then
    //                                 exit;
    //                             rec.Status := Rec.Status::Closed;
    //                             rec."Close Meeting" := true;
    //                             if rec.Modify() then begin
    //                                 AVMTLnTab.Reset();
    //                                 AVMTLnTab.SetCurrentKey("Committee Code", "Meeting No.", "Meeting Type");
    //                                 AVMTLnTab.SetRange("Committee Code", Rec."Committee Code");
    //                                 AVMTLnTab.SetRange("Meeting No.", rec."Meeting No.");
    //                                 if AVMTLnTab.FindSet() then
    //                                     repeat
    //                                         AVMTLnTab."Close Meeting" := true;
    //                                         Succ := AVMTLnTab.Modify();
    //                                         if Succ then begin
    //                                             // VendEmpTab.reset;
    //                                             // VendEmpTab.SetCurrentKey("FM Station ID");
    //                                             // VendEmpTab.SetRange("FM Station ID", AVMTLnTab."Newspaper Code");
    //                                             // IF VendEmpTab.findfirst then begin
    //                                             //     VendEmpTab.Status := VendEmpTab.Status::"Recommended by PAC";
    //                                             //     VendEmpTab.Modify();
    //                                             // end; //ROHIT
    //                                         end;
    //                                     until AVMTLnTab.Next() = 0;
    //                             end;
    //                         end;
    //                         if Succ then
    //                             Message('Meeting ended successfully.')
    //                         else
    //                             Error('Meeting not closed.');
    //                     end;
    //                 }
    //             }
    //             group(Attachment)
    //             {
    //                 Caption = 'Attachment';
    //                 Visible = false;
    //                 action("Upload Attachment")
    //                 {
    //                     ApplicationArea = All;
    //                     Image = Attach;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     Visible = false;

    //                     trigger OnAction()
    //                     begin
    //                         //Rec.UploadMOM(Rec, Rec."File Name");  //ROHIT
    //                     end;
    //                 }
    //                 action("View Attachment")
    //                 {
    //                     ApplicationArea = All;
    //                     Image = Attach;
    //                     Promoted = true;
    //                     PromotedCategory = Process;
    //                     Visible = false;

    //                     trigger OnAction()
    //                     begin
    //                         Rec.ViewMOM();
    //                     end;
    //                 }
    //             }
    //         }
    //     }

    //     trigger OnAfterGetRecord()
    //     begin
    //         CommitteeLine.RESET;
    //         CommitteeLine.SETRANGE("Committee Code", Rec."Committee Code");
    //         CommitteeLine.SETRANGE("Member ID", USERID);
    //         //CommitteeLine.SETRANGE("Approval Permission",TRUE);
    //         IF CommitteeLine.FINDFIRST THEN BEGIN
    //             ShowApproval := TRUE;
    //             ShowForward := FALSE;
    //         END
    //         ELSE BEGIN
    //             ShowApproval := FALSE;
    //             if Rec.Status = Rec.Status::Open then
    //                 ShowForward := TRUE;
    //         END;
    //         /*
    //         IF (Status <> Status::Approved) AND (("Creater ID" = USERID) OR ("Creater ID" = '')) THEN
    //           MakeEditable := TRUE
    //         ELSE
    //           MakeEditable := FALSE;
    //         */
    //         // CALCFIELDS("Note Sheet");
    //         // IF "Note Sheet".HASVALUE THEN BEGIN
    //         //  "Note Sheet".CREATEINSTREAM(InStr,TEXTENCODING::UTF16);
    //         //  InStr.READ(NoteSheet);
    //         // END;

    //     end;

    //     trigger OnInit()
    //     begin
    //         ShowApproval := FALSE;
    //         MakeEditable := TRUE;
    //     end;

    //     trigger OnNewRecord(BelowxRec: Boolean)
    //     var
    //         AVCommHdr: Record "AV Committee Header";
    //         AVMeetHdr: Record "AV Meeting Header";
    //         Mnumber: Integer;
    //         MTNoSrs: Text;
    //     begin
    //         Rec."Global Dimension 1 Code" := 'M002';
    //         Rec."Empanelment Category" := Rec."Empanelment Category"::"Pvt. FM";
    //         Rec."Committee Type" := Rec."Committee Type"::"AV Radio";
    //         // AVCommHdr.Reset();
    //         // AVCommHdr.SetCurrentKey("Committee Code");
    //         // AVCommHdr.SetRange("Committee Code", Rec."Committee Code");
    //         // AVCommHdr.SetFilter("Meeting No. Series", '<>%1', '');
    //         // if AVCommHdr.FindFirst() then begin
    //         //     MTNoSrs := NoSeriesMgt.GetNextNo(AVCommHdr."Meeting No. Series", Today, true);
    //         //     IF MTNoSrs <> '' THEN BEGIN
    //         //         Evaluate(rec."Meeting No.", MTNoSrs);
    //         //     END;
    //         // end
    //         // else
    //         //     Error('Please create ''No. Series''!');
    //         AVMeetHdr.Reset();
    //         AVMeetHdr.SetRange("Committee Code", Rec."Committee Code");
    //         IF AVMeetHdr.FindLast() then
    //             Mnumber := AVMeetHdr."Meeting No.";
    //         rec."Meeting No." := Mnumber + 10000;

    //     end;

    //     trigger OnOpenPage()
    //     begin
    //         CommitteeLine.RESET;
    //         CommitteeLine.SETRANGE("Committee Code", Rec."Committee Code");
    //         CommitteeLine.SETRANGE("Member ID", USERID);
    //         //CommitteeLine.SETRANGE("Approval Permission",TRUE);
    //         IF CommitteeLine.FINDFIRST THEN BEGIN
    //             ShowApproval := TRUE;
    //             ShowForward := FALSE;
    //         END
    //         ELSE BEGIN
    //             ShowApproval := FALSE;
    //             ShowForward := TRUE;
    //         END;
    //         /*
    //         IF (Status <> Status::Approved) AND (("Creater ID" = USERID) OR ("Creater ID" = '')) THEN
    //           MakeEditable := TRUE
    //         ELSE
    //           MakeEditable := FALSE;
    //         */

    //     end;

    //     var
    //         DeleteErrorText: Label 'You do not have permission to delete any remark, Please contact to your admin to delete your remark.';
    //         ModifyErrorText: Label 'You do not have any rights to modify another user remark.';
    //         ShowApproval: Boolean;
    //         CommitteeLine: Record 50284;
    //         Selection: Integer;
    //         Text001: Label 'Select ,Send Back For Correctionl,Approved and Send Back,Reject and Send Back ';
    //         Text002: Label 'Select Approval Options : ';
    //         Text1: Text;
    //         MakeEditable: Boolean;
    //         ShowForward: Boolean;
    // #pragma warning disable AL0432
    //         SMTPMailSetupRec: Record "Email Scenario Attachments";//409;
    // #pragma warning restore AL0432
    //         Subject: Text;
    // #pragma warning disable AL0432
    //         SMTPMail: Codeunit 397; //400;
    // #pragma warning restore AL0432
    //         Body: Text;
    //         NoSeriesMgt: Codeunit 396;

    //     local procedure Approval(var MeetingMaster: Record 50060; var SelctedVales: Integer)
    //     var
    //         ApprovalEntryRec: Record 454;
    //         //VendorEmpPrint: Record 50152;
    //         CommitteeLineRec: Record 50284;
    //         MeetingLineRec: Record 50286;
    //         //50061;
    //         ApprovalEntryRec2: Record 454;
    //         EntNo: Integer;
    //         Sender: Code[30];
    //     begin
    //         IF (SelctedVales = 3) OR (SelctedVales = 4) THEN BEGIN
    //             CommitteeLineRec.RESET;
    //             CommitteeLineRec.SETRANGE("Committee Code", MeetingMaster."Committee Code");
    //             CommitteeLineRec.SETRANGE("Member ID", USERID);
    //             CommitteeLineRec.SETRANGE("Approval Permission", TRUE);
    //             IF CommitteeLineRec.FINDFIRST THEN BEGIN
    //                 ApprovalEntryRec.RESET;
    //                 ApprovalEntryRec.SETRANGE("Table ID", 50305);
    //                 ApprovalEntryRec.SETRANGE("Document No.", MeetingMaster."Document No.");
    //                 ApprovalEntryRec.SETRANGE("Approver ID", USERID);
    //                 ApprovalEntryRec.SETRANGE(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Open);
    //                 IF ApprovalEntryRec.FINDFIRST THEN BEGIN
    //                     IF SelctedVales = 3 THEN BEGIN
    //                         ApprovalEntryRec.Status := ApprovalEntryRec.Status::Approved;
    //                         MeetingMaster.Status := MeetingMaster.Status::Approved;
    //                         MeetingLineRec.RESET;
    //                         MeetingLineRec.SETRANGE("Committee Code", MeetingMaster."Committee Code");
    //                         //    MeetingLineRec.SETRANGE("Meeting Type",MeetingMaster."Meeting Type");
    //                         MeetingLineRec.SETRANGE("Meeting No.", MeetingMaster."Meeting No.");
    //                         MeetingLineRec.SETRANGE(Approve, TRUE);
    //                         IF MeetingLineRec.FINDSET THEN
    //                             REPEAT
    //                                 // VendorEmpPrint.RESET;
    //                                 // VendorEmpPrint.SETRANGE("Newspaper Code", MeetingLineRec."Newspaper Code");
    //                                 // VendorEmpPrint.SETRANGE("Newspaper Name", MeetingLineRec."Newspaper Name");
    //                                 // VendorEmpPrint.SETRANGE(Status, VendorEmpPrint.Status::"Pending for Approval");
    //                                 // VendorEmpPrint.SETRANGE("Receiver ID", USERID);
    //                                 // IF VendorEmpPrint.FINDFIRST THEN BEGIN
    //                                 //     VendorEmpPrint.Status := VendorEmpPrint.Status::Approved;
    //                                 //     VendorEmpPrint."Sender ID" := USERID;
    //                                 //     VendorEmpPrint."Receiver ID" := ApprovalEntryRec."Sender ID";
    //                                 //     IF VendorEmpPrint.InsertToVendor(VendorEmpPrint) = TRUE THEN
    //                                 //         VendorEmpPrint.SendMail(VendorEmpPrint);
    //                                 //     VendorEmpPrint.MODIFY;
    //                                 // END;  // ROHIT
    //                                 MeetingLineRec.Status := MeetingLineRec.Status::Approved;
    //                                 MeetingLineRec.MODIFY;
    //                             UNTIL MeetingLineRec.NEXT = 0;
    //                     END
    //                     ELSE
    //                         IF SelctedVales = 4 THEN BEGIN
    //                             ApprovalEntryRec.Status := ApprovalEntryRec.Status::Rejected;
    //                             MeetingMaster.Status := MeetingMaster.Status::Rejected;
    //                         END;
    //                     Sender := ApprovalEntryRec."Sender ID";
    //                     ApprovalEntryRec.MODIFY;
    //                     ApprovalEntryRec2.RESET;
    //                     IF ApprovalEntryRec2.FINDLAST THEN
    //                         EntNo := ApprovalEntryRec2."Entry No.";
    //                     ApprovalEntryRec2.INIT;
    //                     ApprovalEntryRec2."Entry No." := EntNo + 1;
    //                     ApprovalEntryRec2."Table ID" := 50305;
    //                     ApprovalEntryRec2.Status := ApprovalEntryRec2.Status::Open;
    //                     ApprovalEntryRec2."Sender ID" := USERID;
    //                     ApprovalEntryRec2."Approver ID" := Sender;
    //                     ApprovalEntryRec2."Document No." := MeetingMaster."Document No.";
    //                     ApprovalEntryRec2."Date-Time Sent for Approval" := CURRENTDATETIME;
    //                     ApprovalEntryRec2."Record ID to Approve" := MeetingMaster.RECORDID;
    //                     ApprovalEntryRec2.INSERT;
    //                     MeetingMaster."Sender ID" := USERID;
    //                     MeetingMaster."Receiver ID" := Sender;
    //                     MeetingMaster.MODIFY;
    //                 END;
    //             END
    //             ELSE
    //                 IF NOT CommitteeLineRec.FINDFIRST THEN BEGIN
    //                     ERROR('You do not have approval permission');
    //                 END;
    //         END
    //         ELSE
    //             IF (SelctedVales = 2) THEN BEGIN
    //                 ApprovalEntryRec.RESET;
    //                 ApprovalEntryRec.SETRANGE("Table ID", 50305);
    //                 ApprovalEntryRec.SETRANGE("Document No.", MeetingMaster."Document No.");
    //                 ApprovalEntryRec.SETRANGE("Approver ID", USERID);
    //                 ApprovalEntryRec.SETRANGE(ApprovalEntryRec.Status, ApprovalEntryRec.Status::Open);
    //                 IF ApprovalEntryRec.FINDFIRST THEN BEGIN
    //                     ApprovalEntryRec.Status := ApprovalEntryRec.Status::Forwarded;
    //                     Sender := ApprovalEntryRec."Sender ID";
    //                     ApprovalEntryRec.MODIFY;
    //                     ApprovalEntryRec2.RESET;
    //                     IF ApprovalEntryRec2.FINDLAST THEN
    //                         EntNo := ApprovalEntryRec2."Entry No.";
    //                     ApprovalEntryRec2.INIT;
    //                     ApprovalEntryRec2."Entry No." := EntNo + 1;
    //                     ApprovalEntryRec2."Table ID" := 50305;
    //                     ApprovalEntryRec2.Status := ApprovalEntryRec2.Status::Open;
    //                     ApprovalEntryRec2."Sender ID" := USERID;
    //                     ApprovalEntryRec2."Approver ID" := Sender;
    //                     ApprovalEntryRec2."Document No." := MeetingMaster."Document No.";
    //                     ApprovalEntryRec2."Date-Time Sent for Approval" := CURRENTDATETIME;
    //                     ApprovalEntryRec2."Record ID to Approve" := MeetingMaster.RECORDID;
    //                     ApprovalEntryRec2.INSERT;
    //                 END;
    //             END;

    //     end;
}

