page 50786 "Committee Header"
{
    Caption = 'Committee Creation';
    PageType = Document;
    SourceTable = 50283;
    PromotedActionCategories = 'New,Process,Report';
    DeleteAllowed = false;
    RefreshOnActivate = true;
    ApplicationArea = all;
    UsageCategory = Documents;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Committee Code"; Rec."Committee Code")
                {
                    Caption = 'Committee Code';
                    //Editable = true;
                    ApplicationArea = all;

                    trigger OnAssistEdit()

                    begin
                        IF rec.AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Committee No."; Rec."Committee No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    Caption = 'Committee Name';
                    ApplicationArea = all;
                    Editable = LogEnble;

                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                    Editable = LogEnble;
                    trigger OnValidate()
                    begin
                        // IF "Start Date" <> 0D THEN
                        //     IF "Start Date" < TODAY THEN
                        //         ERROR('Back Dates are not valid'); //ROHIT
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Editable = LogEnble;
                    trigger OnValidate()
                    begin
                        // IF "End Date" < "Start Date" THEN
                        //     ERROR('End Date can not be less than from Start Date %1', "Start Date"); // ROHIT
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Media Code';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Media Description"; Rec."Media Description")
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                // field(Type; Rec.Type)
                // {
                //     Visible = false;
                //     ApplicationArea = all;
                // }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
            }
            part(Member; 50793)
            {
                ApplicationArea = All;
                SubPageLink = "Committee Code" = FIELD("Committee Code"); //ROHIT

                UpdatePropagation = Both;

            }



        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                // ComLine: Record 50063;  //ROHIT
                // ComHdr: Record 50062;   //ROHIT
                begin
                end;
            }
            // action(Meetings)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Meetings';
            //     Image = ContactPerson;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Meeting List";//50338;
            //     RunPageLink = "Committee Code" = FIELD("Committee Code"),
            //                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
            //                   "Committee Type" = field("Committee Type");

            //     trigger OnAction()
            //     var
            //         MeetHdr: Record 50060;
            //     begin
            //     end;
            // }
            action(Meetings)
            {
                ApplicationArea = All;
                Caption = 'Meetings';
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AVMeetingHdr: Record 50285;
                begin
                    if Rec.Status = Rec.Status::Active then begin
                        AVMeetingHdr.Reset();
                        AVMeetingHdr.setrange("Committee Type", AVMeetingHdr."Committee Type"::"AV Radio");
                        AVMeetingHdr.SetRange("Committee Code", Rec."Committee Code");
                        if AVMeetingHdr.FindFirst() then;
                        Page.Run(50220, AVMeetingHdr);
                    end
                    else
                        Error('Committee is not active or Members are not created!');
                end;
            }
            action("Login Creation")
            {
                ApplicationArea = All;
                Image = LogSetup;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = LogEnble;
                trigger OnAction()
                var
                    CommLine: Record 50284;
                    //MemLine: Record 50287;  //HYC
                    UserTab: Record 2000000120;
                    AccessTab: Record 2000000053;
                    UserPerTab: Record 2000000073;
                    AllProfile: record "All Profile";
                    TempPass: Text;
                    UserCode: Code[50];
                    membid, yr11 : Integer;
                    yrtxt: Text;
                    NosrsemgtCU: Codeunit NoSeriesManagement;
                    InvtStupTab: Record "Inventory Setup";
                begin
                    IF NOT CONFIRM('Do you want to create Login ID for committee members?') THEN
                        EXIT;
                    CommLine.SETRANGE("Committee Code", REC."Committee Code"); // ComLine
                    IF CommLine.FINDFIRST THEN BEGIN                        // Comline
                        REPEAT
                            TempPass := 'Boc@1234';
                            UserTab.INIT;
                            UserTab."User Security ID" := CREATEGUID;
                            /* 
                              yr11 := Date2DMY(WorkDate(), 3);
                              yrtxt := CopyStr(Format(Yr11), 3, 2);
                              //Error(yrtxt);
                              membid += 1;
                              IF membid < 10 then
                                  UserCode := 'AVPAC' + yrtxt + '0' + FORMAT(membid)
                              else
                                  UserCode := 'AVPAC' + yrtxt + FORMAT(membid);
                              */
                            //    UserCode := COPYSTR(CommLine."Member Name", 1, 3) + 'C' + COPYSTR("Committee Code", 6, 2) + '0' + COPYSTR(FORMAT(CommLine."Line No."), 1, 1);
                            InvtStupTab.Reset();
                            InvtStupTab.Get();
                            //UserCode := NosrsemgtCU.GetNextNo(InvtStupTab."AVFM Comm_Member No. series", Today, true); //ROHIT
                            UserTab."User Name" := UserCode;
                            //UserTab."Full Name" := ComLine."Member Name";//Comline HYc
                            //UserTab.Designation := CommLine.Designation;
                            //UserTab."Authentication Email" := CommLine."E-mail ID";//commentd by kc 24062023 due toenter the multiple time same email to same user name
                            UserTab."Change Password" := FALSE;
                            //UserTab."Exp Pass" := TempPass;
                            IF UserTab.INSERT THEN BEGIN
                                SETUSERPASSWORD(UserTab."User Security ID", TempPass);
                                AccessTab.INIT;
                                AccessTab."User Security ID" := UserTab."User Security ID";
                                // AccessTab."Role ID" := 'SUPER';//commented by KC 12-05-2023
                                //AccessTab."Role ID" := 'AVFMPAC';//KC 12-05-2023 permission set for  Committee Member
                                AccessTab.Validate("Role ID", 'AVFMPAC');//KC 16-05-2023 permission set for  Committee Member
                                // AccessTab.Validate("Role Name", 'AV FM PAC Permission');//KC 16-05-2023 permission set for  Committee Member
                                AccessTab.Scope := AccessTab.Scope::Tenant;//KC 16-05-2023 permission set for  Committee Member
                                AccessTab."User Name" := UserTab."User Name";
                                AccessTab.INSERT;
                                UserPerTab.INIT;
                                UserPerTab."User SID" := UserTab."User Security ID";
                                AllProfile.Reset();
                                AllProfile.SetRange("Profile ID", 'PVT. FM VEND EMP');
                                AllProfile.SetRange(Scope, AllProfile.Scope::Tenant);
                                if AllProfile.FindFirst() then begin
                                    UserPerTab."Profile ID" := AllProfile."Profile ID";
                                    UserPerTab.Scope := AllProfile.Scope;
                                end;
                                //UserPerTab.Role := 'VEND_EMP';
                                UserPerTab.INSERT;
                                //ComLine."Member ID" := UserCode; //ComLine HYC
                                //ComLine.MODIFY;     // ComLine HYC
                            END;
                        UNTIL CommLine.NEXT = 0; // ComLine HYC
                        rec."Login Created" := true;
                        rec.Status := rec.Status::Active;
                        LogEnble := false;
                        if Rec.Modify() then
                            MESSAGE('User login successfully created');
                    END;
                end;
            }
            group(MOM)
            {
                Caption = 'Reports';
                action(ViewDownloadMOM)
                {
                    Caption = 'View/Download(MOM)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        MeetingTab: Record "AV Meeting Header";
                    begin
                        MeetingTab.Reset();
                        MeetingTab.SetRange("Committee Code", Rec."Committee Code");
                        if MeetingTab.FindFirst() then
                            report.Run(50089, true, false, MeetingTab);
                    end;
                }
                action(SummaryList)
                {
                    Caption = 'Summary List(Pvt. FM)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        // VendorEmp: record "Vend Emp - Pvt. FM";  //ROHIT
                        AVMeetingLine: Record "AV Meeting Line";
                    begin
                        AVMeetingLine.Reset();
                        AVMeetingLine.FilterGroup(2);
                        //AVMeetingLine.SetRange("Committee Code", "Committee Code");  //ROHIT
                        AVMeetingLine.FilterGroup(0);
                        if AVMeetingLine.FindSet() then
                            report.Run(50355, true, false, AVMeetingLine);
                    end;
                }
                action(AnnextureA)
                {
                    Caption = 'View (Annexture A)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        //VendorEmp: record "Vend Emp - Pvt. FM";  //ROHIT
                        AVMeetingLine: Record "AV Meeting Line";
                    begin
                        // VendorEmp.Reset();
                        // if VendorEmp.FindSet() then
                        //     report.Run(50356, true, false, VendorEmp);
                        AVMeetingLine.Reset();
                        AVMeetingLine.FilterGroup(2);
                        AVMeetingLine.SetCurrentKey("Committee Code");
                        // AVMeetingLine.SetRange("Committee Code", "Committee Code"); //ROHIT
                        AVMeetingLine.FilterGroup(0);
                        if AVMeetingLine.FindFirst() then
                            report.Run(50356, true, false, AVMeetingLine);
                    end;
                }
                action(AnnextureB)
                {
                    Caption = 'View (Annexture B)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        //VendorEmp: record "Vend Emp - Pvt. FM";  //ROHIT
                        AVMtngLn: Record "AV Meeting Line";
                    begin
                        AVMtngLn.Reset();
                        AVMtngLn.FilterGroup(2);
                        //AVMtngLn.SetRange("Committee Code", "Committee Code");  //ROHIT
                        AVMtngLn.FilterGroup(0);
                        if AVMtngLn.FindFirst() then
                            report.Run(50357, true, false, AVMtngLn);
                    end;
                }
                action(AnnextureC)
                {
                    Caption = 'View (Annexture C)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        //VendorEmp: record "Vend Emp - Pvt. FM";  //ROHIT
                        AVMtngLn: Record "AV Meeting Line";
                    begin
                        AVMtngLn.Reset();
                        AVMtngLn.FilterGroup(2);
                        // AVMtngLn.SetRange("Committee Code", "Committee Code");  //ROHIT
                        AVMtngLn.SetAutoCalcFields("Total Rejected");
                        AVMtngLn.SetFilter("Total Rejected", '<>0');
                        AVMtngLn.FilterGroup(0);
                        if AVMtngLn.Findset() then
                            report.Run(50358, true, false, AVMtngLn);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF ((Rec."Created By" = USERID) OR (Rec."Created By" = '')) AND (NOT rec."Login Created") THEN
            CurrPage.EDITABLE(TRUE)
        ELSE
            CurrPage.EDITABLE(FALSE);
        IF NOT rec."Login Created" then
            LogEnble := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RespCentre: Record "Responsibility Center";
    begin
        USRTAB.Reset();
        USRTAB.SetRange("User Name", UserId);
        USRTAB.SetRange(State, USRTAB.State::Enabled);
        USRTAB.SetFilter(Level, '<=%1', 7);
        if USRTAB.FindFirst() then begin
            Rec."Global Dimension 1 Code" := 'M002';
            Rec."Empanelment Category" := Rec."Empanelment Category"::"Pvt. FM";
            Rec."Committee Type" := Rec."Committee Type"::"Radio";
            //RespCentre.SETRANGE("Document Type", rec."Committee Type");  //Rohit
            IF RespCentre.FindFirst() then begin
                Rec."Responsibility Centre" := RespCentre.Code;
            end;
        end
        else
            Error('You cann''t create a committee!\\ Only Campaign Officer and Higher Authority can create the Committee');

    end;

    trigger OnOpenPage()
    begin  //Rohit++
        // IF (("Created By" = USERID) OR ("Created By" = '')) AND (NOT rec."Login Created") THEN
        //     CurrPage.EDITABLE(TRUE)
        // ELSE
        //     CurrPage.EDITABLE(FALSE);
        // IF NOT rec."Login Created" then
        //     LogEnble := true;  //Rohit++
    end;

    var
        UserTab: Record 2000000120;
        USRTAB: Record "User BOC";
        UserCode: Code[20];
        TempPass: Text[20];
        AccessTab: Record 2000000053;
        UserPerTab: Record 2000000073;
        NoSrMgmt: Codeunit 396;
        LogEnble, Edit001 : Boolean;
        EnableActn: Boolean;
}

