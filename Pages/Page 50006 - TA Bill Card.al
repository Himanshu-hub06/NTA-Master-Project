page 50006 "TA Bill Card"
{
    DataCaptionExpression = 'Reference No';
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "TA Bill Header";
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Approval,Notesheet';
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; rec."Reference No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(BillType; rec.BillType)
                {
                    Caption = 'Bill Type';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(StartExamDate; StartExamDate)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("NTA Unique ID"; rec."NTA Unique ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Longitude; Rec.Longitude)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Latitude; Rec.Latitude)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(IP; Rec.IP)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Designation; rec.Designation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address For Communication"; rec."Address For Communication")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Contact No"; Rec."Contact No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Bank_Branch_Name; Rec.Bank_Branch_Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Bank_Account_No; Rec.Bank_Account_No)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IFSC Code"; rec."IFSC Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remuneration Days"; rec."Remuneration Days")
                {
                    ApplicationArea = All;
                    //Editable = RemunerationEditable;
                }
                field("Remuneration Rate"; rec."Remuneration Rate")
                {
                    ApplicationArea = All;
                    //Editable = RemunerationEditable;
                }
                field("Remuneration Amount"; rec."Remuneration Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hotel Amount"; rec."Total Amount Hotel")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Local Amount"; rec."Total Amount Local")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Oustation Amount"; rec."Total Amount Outstation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Amount Hotel"; Rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount" + rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount")
                {
                    Caption = 'Approved Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("TDS(%)"; Rec."TDS Percent")
                {
                    //Editable = TDS_Per_Enable;
                    ApplicationArea = All;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Payable Amount"; rec."Total Amount Hotel" + rec."Total Amount Outstation" + rec."Total Amount Local" + rec."Remuneration Amount" - rec."TDS Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Submitted Date"; rec."Last Modified on")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill Status"; Rec."Bill Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ApplicationArea = All;
                    Visible = false;


                }
                // field("Receiver User Name"; Rec."Receiver User Name")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }

                field(Remark; Rec.Remark)
                {
                    ApplicationArea = all;
                    Editable = true;
                }

                //new field pan no added after demo 26th july 2023 dicsion 
                field(PAN_N0; Rec.PAN_N0)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Bill ID"; Rec."Bill ID")
                {
                    ApplicationArea = All;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Sender_User_ID; Rec.Sender_User_ID)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Sending_User_Name; Rec.Sending_User_Name)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Sending_Date; Rec.Sending_Date)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Sending_Time; Rec.Sending_Time)
                {
                    ApplicationArea = All;
                    Visible = False;
                }

            }
            part("Outstation Journey"; "TA Bill Outstation Subform")
            {
                Caption = 'Outstation Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                //Visible = OutBill;
            }
            part("Details of Hotel/Food/Daily Allowance"; "TA Bill Hotel Subform")
            {
                Caption = 'Details of Hotel/Food/Daily Allowance';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                //Visible = OutBill;
            }
            part("Local Journey"; "TA Bill Loacl Subform")
            {
                Caption = 'Local Journey';
                SubPageLink = "Bill ID" = FIELD("Bill ID");
                //Visible = LocalBill;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Note Sheet")
            {
                Caption = 'Note Sheet';
                action(NoteSheet)
                {
                    ApplicationArea = All;
                    Caption = 'Note &Sheet';
                    Image = JobRegisters;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    Visible = VisNote;


                    trigger OnAction()
                    begin
                        NTab.FilterGroup(2);
                        NTab.SETRANGE("Table Id", 50170);
                        NTab.SETRANGE("Document No.", Rec."Reference No");
                        NTab.FilterGroup(0);
                        PAGE.RUN(50151, NTab);
                    end;

                }
                action("View Note Sheet")
                {
                    ApplicationArea = All;
                    Image = ViewWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        NTab.SETRANGE("Table Id", 50170);
                        NTab.SETRANGE("Document No.", Rec."Reference No");
                        IF NTab.FINDFIRST THEN
                            PAGE.RUN(PAGE::"NoteSheet Display", NTab);
                    end;
                }
            }
            // action(Forward)
            // {
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Visible = true;

            //     trigger OnAction()
            //     var
            //         SequenceNo: Integer;
            //         ApproverId: Code[20];
            //         PlanBudget: Decimal;
            //         PrintMediaPlanRecL: Record 50002;
            //         RecieverID: Code[20];
            //         Lvl: Integer;
            //         selection: Integer;
            //         RespCenter: Record 5714;
            //         AppLvl: Integer;
            //         SelctedUser: Code[50];
            //         CULevel: Integer;
            //     begin
            //         IF Rec.Receiver_ID <> USERID THEN
            //             ERROR('You can not Forward it due to user ID mismatch');
            //         IF RespCenter.GET(Rec."Responsibility Centre") THEN
            //             AppLvl := RespCenter."TA Bill Approval Lowest Lvl.";
            //         BUserTab11.RESET;
            //         BUserTab11.SETRANGE("User Name", USERID);
            //         IF BUserTab11.FINDFIRST THEN
            //             Lvl := BUserTab11.Level;
            //         IF Lvl > AppLvl THEN BEGIN
            //             CLEAR(BOCUsers);
            //             CLEAR(SelctedUser);
            //             BUserTab12.RESET;
            //             BUserTab12.SETRANGE("User Name", USERID);
            //             Rec.FILTERGROUP(10);
            //             IF BUserTab12.FINDFIRST THEN BEGIN
            //                 CULevel := BUserTab12.Level - 1;
            //                 BUserTab.SETRANGE(State, BUserTab.State::Enabled);
            //                 BUserTab.SETRANGE(Level, AppLvl, CULevel);
            //                 IF BUserTab.FINDFIRST THEN BEGIN
            //                     BOCUsers.SETRECORD(BUserTab);
            //                     BOCUsers.SETTABLEVIEW(BUserTab);
            //                     BOCUsers.EDITABLE(FALSE);
            //                     BOCUsers.LOOKUPMODE(TRUE);
            //                     MESSAGE('Select user from the List in the next screen');
            //                     IF BOCUsers.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //                         BOCUsers.GETRECORD(BUserTab);
            //                         SelctedUser := BUserTab."User Name";
            //                     END;
            //                     IF SelctedUser = '' THEN
            //                         EXIT;
            //                     IF NOT CONFIRM('Do you want to Forward Approval Request to %1?', FALSE, SelctedUser) THEN
            //                         EXIT;

            //                     AppEntInit.RESET;
            //                     AppEntInit.SETFILTER("Table ID", '%1', DATABASE::"TA Bill Header");
            //                     //AppEntInit.SETRANGE("Document Type",AppEntInit."Document Type"::Empanelment);
            //                     AppEntInit.SETRANGE("Document No.", Rec."Reference No");
            //                     IF AppEntInit.FINDLAST THEN BEGIN
            //                         AppEntInit.Status := AppEntInit.Status::Forwarded;
            //                         AppEntInit."Date-Time Sent for Approval" := CURRENTDATETIME;
            //                         AppEntInit.MODIFY;
            //                     END;
            //                     Rec.InsertApprovalEntry(DATABASE::"TA Bill Header", 0, Rec."Reference No", SelctedUser, Rec.RECORDID);
            //                     ;

            //                     TABillHeadTab.RESET;
            //                     TABillHeadTab.SETRANGE("Bill ID", Rec."Bill ID");
            //                     IF TABillHeadTab.FINDFIRST THEN BEGIN
            //                         TABillHeadTab.Status := TABillHeadTab.Status::"Pending Approval";
            //                         TABillHeadTab.Sender_ID := USERID;
            //                         TABillHeadTab.Receiver_ID := SelctedUser;
            //                         IF TABillHeadTab.MODIFY THEN
            //                             MESSAGE('Request is Successfully Forwarded to %1!!', SelctedUser);
            //                         CurrPage.CLOSE;
            //                     END;
            //                 END;
            //             END;
            //             Rec.FILTERGROUP(0);
            //         END;
            //     end;
            // }

            // action(Return)
            // {
            //     Image = Return;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Visible = true;

            //     trigger OnAction()
            //     var
            //         AppEnt: Record 454;
            //         ReturnUser: Page 50130;
            //         AppEnt11: Record 454;
            //         SelctedUser: Code[50];
            //     begin
            //         IF Rec.Receiver_ID <> USERID THEN
            //             ERROR('You can not Return it due to user ID mismatch');
            //         Rec.FILTERGROUP(10);
            //         AppEnt.RESET;
            //         AppEntInit.SETFILTER("Table ID", '%1', DATABASE::"TA Bill Header");
            //         AppEnt.SETRANGE("Document No.", Rec."Reference No");
            //         AppEnt11.COPY(AppEnt);
            //         AppEnt11.SETRANGE("Approver ID", USERID);
            //         IF AppEnt11.FINDFIRST THEN
            //             AppEnt.SETFILTER("Entry No.", '<%1', AppEnt11."Entry No.");
            //         IF AppEnt.FINDFIRST THEN BEGIN
            //             CLEAR(ReturnUser);
            //             CLEAR(SelctedUser);
            //             ReturnUser.SETRECORD(AppEnt);
            //             ReturnUser.SETTABLEVIEW(AppEnt);
            //             ReturnUser.EDITABLE(FALSE);
            //             ReturnUser.LOOKUPMODE(TRUE);
            //             IF ReturnUser.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //                 ReturnUser.GETRECORD(AppEnt);
            //                 SelctedUser := AppEnt."Approver ID";
            //             END;
            //             IF SelctedUser = '' THEN
            //                 EXIT;
            //             IF NOT CONFIRM('Do you want to Return Request to %1?', FALSE, SelctedUser) THEN
            //                 EXIT
            //             ELSE BEGIN
            //                 Rec.ApprovalComment;
            //                 AppEntInit.RESET;
            //                 AppEntInit.SETFILTER("Table ID", '%1', DATABASE::"TA Bill Header");
            //                 AppEntInit.SETRANGE("Document No.", Rec."Reference No");
            //                 IF AppEntInit.FINDLAST THEN BEGIN
            //                     AppEntInit.Status := AppEntInit.Status::Forwarded;
            //                     AppEntInit."Date-Time Sent for Approval" := CURRENTDATETIME;
            //                     AppEntInit.MODIFY;
            //                 END;
            //                 Rec.InsertApprovalEntry(DATABASE::"TA Bill Header", 0, Rec."Reference No", SelctedUser, Rec.RECORDID);

            //                 TABillHeadTab.RESET;
            //                 TABillHeadTab.SETRANGE("Bill ID", Rec."Bill ID");
            //                 IF TABillHeadTab.FINDFIRST THEN BEGIN
            //                     TABillHeadTab.Status := TABillHeadTab.Status::"Pending Approval";
            //                     TABillHeadTab.Sender_ID := USERID;
            //                     TABillHeadTab.Receiver_ID := SelctedUser;
            //                     IF TABillHeadTab.MODIFY THEN
            //                         MESSAGE('Request is Successfully Forwarded to %1!!', SelctedUser);
            //                     CurrPage.CLOSE;
            //                 END;
            //             END;
            //         END;
            //         Rec.FILTERGROUP(0);
            //     end;
            // }
            // action("Send For Approval")
            // {


            //     ApplicationArea = All;
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Visible = true;
            //     PromotedOnly = true;

            //     trigger OnAction()
            //     var
            //         SequenceNo: Integer;
            //         UserRec: Record 2000000120;
            //         CULevel: Integer;
            //         SelctedUser: Code[20];
            //         // QSheetHeader: Record 50120;
            //         ApprovalEntry: Record 454;
            //         "EntryNo.": Integer;
            //         TABillTab: record "TA Bill Header";
            //     begin
            //         // rec.TESTFIELD(Status, rec.Status::"Pending Approval");
            //         rec.TESTFIELD(Status, rec.Status::Open);
            //         rec.TestField(rec.Receiver_ID);
            //         // IF rec.Receiver_ID <> userid THEN
            //         //    ERROR('You can not send it for approval due to user ID mismatch')
            //         //  ELSE
            //         IF NOT CONFIRM('Do you want to send for Approval Request?', FALSE, TRUE) THEN
            //             EXIT
            //         ELSE BEGIN
            //             ApprovalEntry.RESET;
            //             ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 50005);
            //             ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", rec."Reference No");
            // ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            //             IF ApprovalEntry.FINDFIRST THEN
            //                 ERROR('Document no. allready forward');
            //             ApprovalEntry.RESET;
            //             IF ApprovalEntry.FINDLAST THEN BEGIN
            //                 "EntryNo." := ApprovalEntry."Entry No.";

            //             END;
            //             ApprovalEntry.RESET;
            //             ApprovalEntry."Entry No." := "EntryNo." + 1;
            //             ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::Quote;
            //             ApprovalEntry."Table ID" := 50005;
            //             ApprovalEntry."Document No." := rec."Reference No";
            //             ApprovalEntry."Sequence No." := 1;
            //             ApprovalEntry.Sender_ID := USERID;
            //             ApprovalEntry."Approver ID" := rec.Receiver_ID;
            //             ApprovalEntry.Status := ApprovalEntry.Status::Forwarded;
            //             ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
            //             ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
            //             ApprovalEntry."Last Modified By User ID" := USERID;
            //             //ApprovalEntry.VALIDATE("Location Code", 'BOC001');
            //             //ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
            //             ApprovalEntry."Record ID to Approve" := rec.RECORDID;
            //             ApprovalEntry.INSERT;

            //             TABillTab.RESET;
            //             TABillTab.SETRANGE(TABillTab."Bill ID", rec."Bill ID");
            //             IF TABillTab.FINDFIRST THEN BEGIN
            //                 TABillTab.Status := TABillTab.Status::"Pending Approval";
            //                 TABillTab.Pending_User_Id := TABillTab.Receiver_ID;
            //                 TABillTab.Pending_User_Name := TABillTab."Receiver User Name";
            //                 TABillTab.Rejected_User_Id := '';
            //                 TABillTab.Pending_User_Name := '';
            //                 TABillTab.MODIFY;

            //                 MESSAGE('Successfully Send for Approval Request to (%2)', Rec."Receiver User Name", Rec.Receiver_ID);
            //                 CurrPage.CLOSE;
            //             END;
            //             rec.FILTERGROUP(0);
            //         END;
            //     end;
            // }

            //--------------------------------------------------------------------------Rashmi 20-07-2023

            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = Vis001;
                trigger OnAction()
                begin
                    Clear(SequenceNo);
                    NTab.RESET;
                    NTab.SETRANGE(NTab."Document No.", rec."Reference No");
                    IF NOT NTab.FINDFIRST THEN
                        ERROR('Please create note sheet');

                    //28Aug st
                    AppUserMem.Reset();
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETRANGE("User ID", UserID);
                    IF AppUserMem.FindFirst() then
                        CurUserSeq := AppUserMem."Sequence No.";

                    //28Aug En
                    MPSetup.Get();
                    SelctedUser := '';
                    // IF Rec.Receiver_ID <> USERID THEN
                    //    ERROR('You can not Forward it due to user ID mismatch');
                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    AppUserMem.SetRange("Sequence No.", CurUserSeq + 1);  //28 aug
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN
                            SelctedUser := AppUserMem."User ID";
                    sendUserName := AppUserMem."User Full Name";
                    SequenceNo := AppUserMem."Sequence No.";
                    IF SelctedUser = '' THEN
                        EXIT;
                    IF NOT CONFIRM('Do you want to send approval request to %1?', FALSE, SelctedUser) THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    TABillHeadTab.RESET;
                    TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                    IF TABillHeadTab.FINDFIRST THEN BEGIN
                        TABillHeadTab.Sender_ID := USERID;
                        TABillHeadTab.Receiver_ID := SelctedUser;
                        TABillHeadTab.Sender_User_ID := UserId;
                        TABillHeadTab.Sending_User_Name := UserId;
                        TABillHeadTab."Bill Status" := TABillHeadTab."Bill Status"::"Pending For Approval";
                        TABillHeadTab.Pending_User_Id := SelctedUser;
                        TABillHeadTab.Pending_User_Name := sendUserName;
                        //TABillHeadTab.Sending_Date := CurrentDateTime;
                        TABillHeadTab.Sending_Time := CurrentDateTime;

                        IF TABillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
                        // CurrPage.CLOSE;


                    END;
                    CurrPage.Close();
                end;
            }
            // action(Modification)
            // {
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Caption = 'Send For Modification';
            //     Visible = Vis004;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         MPSetup.Get();
            //         IF rec.Receiver_ID <> USERID THEN
            //             ERROR('You can not send it for modification due to user ID mismatch');
            //         // if rec.Modification_Remark = '' then
            //         //     Error('Please fill remark before send for modification!');

            //         IF NOT CONFIRM('Do you want to send back for modification?', FALSE) THEN
            //             EXIT;
            //         TABillHeadTab.RESET;
            //         TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
            //         IF TABillHeadTab.FindFirst() THEN BEGIN
            //             TABillHeadTab.Status := TABillHeadTab.Status::"Send For Modification";
            //             TABillHeadTab.Sender_ID := USERID;
            //             TABillHeadTab.Receiver_ID := MPSetup."TA Bill Landing UID";
            //             IF TABillHeadTab.MODIFY THEN
            //                 MESSAGE('Sent successfully for modification!');
            //         END;
            //         CurrPage.CLOSE;
            //     end;
            // }

            action(APPROVEDDISPERMENT)
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                Caption = 'Approved for Bill Disbursement';
                Visible = DisVis01;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MPSetup.Get();
                    IF rec.Receiver_ID <> USERID THEN
                        ERROR('You can not send it for Approved for Bill Disbursement due to user ID mismatch');
                    // if rec.Modification_Remark = '' then
                    //     Error('Please fill remark before send for modification!');

                    IF NOT CONFIRM('Do you want to send back for Approved for Bill Disbursement?', FALSE) THEN
                        EXIT;
                    TABillHeadTab.RESET;
                    TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                    //TABillHeadTab.SETRANGE("CentreBill ID", Rec."CentreBill ID");
                    IF TABillHeadTab.FindFirst() THEN BEGIN
                        // TABillHeadTab.Status := TABillHeadTab.Status::"Disbursement Pending";
                        TABillHeadTab."Bill Status" := TABillHeadTab."Bill Status"::"Disbursement Pending";
                        TABillHeadTab.Sender_ID := USERID;
                        TABillHeadTab.Sender_User_ID := UserId;
                        TABillHeadTab.Sending_User_Name := UserId;
                        //TABillHeadTab.Sending_Date := CurrentDateTime;
                        TABillHeadTab.Sending_Time := CurrentDateTime;
                        TABillHeadTab.Receiver_ID := 'JD';
                        IF TABillHeadTab.MODIFY THEN
                            MESSAGE('Sent successfully for Approved for Bill Disbursement!');
                    END;
                    CurrPage.CLOSE;
                    TABillHeadTabPay.Reset();
                    TABillHeadTabPay.SetRange(TABillHeadTabPay."Reference No", rec."Reference No");
                    //TABillHeadTabPay.Bank_Account_No:= ba

                end;
            }
            action(Forward)
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = Vis003;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Clear(SequenceNo);
                    MPSetup.Get();
                    SelctedUser := '';
                    IF rec.Receiver_ID <> USERID THEN
                        ERROR('You can not Forward it due to user ID mismatch');
                    AppUserMem.Reset();
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETRANGE("User ID", UserID);
                    IF AppUserMem.FindFirst() then
                        CurUserSeq := AppUserMem."Sequence No.";

                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    AppUserMem.SetRange("Sequence No.", CurUserSeq + 1);
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN
                            SelctedUser := AppUserMem."User ID";
                    sendUserName := AppUserMem."User Full Name";
                    SequenceNo := AppUserMem."Sequence No.";
                    IF SelctedUser = '' THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    TABillHeadTab.RESET;
                    TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                    IF TABillHeadTab.FINDFIRST THEN BEGIN
                        TABillHeadTab.Sender_ID := USERID;
                        TABillHeadTab.Receiver_ID := SelctedUser;
                        TABillHeadTab.Sender_User_ID := UserId;
                        TABillHeadTab.Sending_User_Name := UserId;
                        //TABillHeadTab.Sending_Date := CurrentDateTime;
                        TABillHeadTab.Pending_User_Id := SelctedUser;
                        TABillHeadTab.Pending_User_Name := sendUserName;
                        TABillHeadTab.Sending_Time := CurrentDateTime;
                        TABillHeadTab."Bill Status" := TABillHeadTab."Bill Status"::"Pending For Approval";
                        IF TABillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
                    END;
                    CurrPage.Close();

                end;
            }
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Visible = Vis002;

                trigger OnAction()
                begin
                    IF Rec.Receiver_ID <> USERID THEN
                        ERROR('You are not allowed to approve, due to user ID mismatch');
                    if not Confirm('Do you want to Approve.?') then
                        exit;

                    MPSetup.Get();
                    AppUserMem.RESET;
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETRANGE("User ID", USERID);
                    AppUserMem.SETRANGE("Approval Permission", TRUE);
                    IF AppUserMem.FIND('-') THEN BEGIN
                        // FILTERGROUP(10);
                        AppEntInit.RESET;
                        AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
                        AppEntInit.SETRANGE("Document No.", rec."Reference No");
                        IF AppEntInit.FINDLAST THEN BEGIN
                            AppEntInit.Status := AppEntInit.Status::Approved;
                            AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                            AppEntInit."Last Modified By User ID" := USERID;
                            AppEntInit.MODIFY;
                        END;
                        TABillHeadTab.RESET;
                        TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                        IF TABillHeadTab.FINDFIRST THEN BEGIN
                            TABillHeadTab."Bill Status" := TABillHeadTab."Bill Status"::Approved;
                            TABillHeadTab.Sender_ID := USERID;
                            TABillHeadTab.Approved_User_ID := UserId;
                            TABillHeadTab.Approved_User_Name := AppUserMem."User Full Name";
                            TABillHeadTab.Approved_Date := WorkDate();
                            TABillHeadTab.Approved_Time := Time();
                            TABillHeadTab.Receiver_ID := MPSetup."TA & Centre Bill UID";
                            IF TABillHeadTab.MODIFY THEN
                                MESSAGE('Application has been successfully Approved!');
                            CurrPage.CLOSE;
                        END;
                        // FILTERGROUP(0);
                    END;
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Vis002;
                trigger OnAction()
                begin
                    IF rec.Receiver_ID <> USERID THEN
                        ERROR('You are not allowed to reject, due to user ID mismatch');

                    if rec."Rejection Remark" = '' then
                        Error('Please fill rejection remark!');

                    if not Confirm('Do you want to Reject.?') then
                        exit;

                    MPSetup.Get();
                    // FILTERGROUP(10);
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document Type", AppEntInit."Document Type"::Quote);
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No");
                    IF AppEntInit.FINDLAST THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Rejected;
                        AppEntInit."Date-Time Sent for Approval" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    TABillHeadTab.RESET;
                    TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                    IF TABillHeadTab.FINDFIRST THEN BEGIN
                        TABillHeadTab."Bill Status" := TABillHeadTab."Bill Status"::Rejected;
                        TABillHeadTab.Sender_ID := USERID;
                        TABillHeadTab.Sender_User_ID := UserId;
                        TABillHeadTab.Sending_User_Name := UserId;
                        TABillHeadTab.Rejected_Date := WorkDate();
                        TABillHeadTab.Rejected_Time := time;
                        TABillHeadTab.Rejected_User_Id := UserId;

                        // TABillHeadTab."Receiver User Name":= 
                        //TABillHeadTab.Sending_Date := CurrentDateTime;
                        TABillHeadTab.Sending_Time := CurrentDateTime;
                        TABillHeadTab.Receiver_ID := MPSetup."TA Bill Landing UID";
                        IF TABillHeadTab.MODIFY THEN
                            MESSAGE('Application request has been rejected!!');
                        CurrPage.CLOSE;
                    END;
                    CurrPage.Close();
                    // FILTERGROUP(0);
                END;
            }
            action(Return)
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Visible = Vis002;

                trigger OnAction()
                begin
                    SelctedUser := '';
                    IF rec.Receiver_ID <> USERID THEN
                        ERROR('You can not Forward it due to user ID mismatch');
                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN
                            SelctedUser := AppUserMem."User ID";
                    SequenceNo := AppUserMem."Sequence No.";
                    IF SelctedUser = '' THEN
                        EXIT;
                    IF NOT CONFIRM('Do you want to return to %1?', FALSE, SelctedUser) THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    TABillHeadTab.RESET;
                    TABillHeadTab.SETRANGE("Bill ID", rec."Bill ID");
                    IF TABillHeadTab.FINDFIRST THEN BEGIN
                        TABillHeadTab.Sender_ID := USERID;
                        TABillHeadTab.Receiver_ID := SelctedUser;
                        //TABillHeadTab.Status := TABillHeadTab.Status::"Pending Approval";  //DS-DS-18-12-2023
                        IF TABillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully returned to %1!!', SelctedUser);
                    END;
                    // FILTERGROUP(0);
                end;
            }

            //---------------------------------------------------------------------------Rashmi 20-07-2023

        }

    }

    trigger OnInit()
    begin
        Vis001 := TRUE;
        Vis002 := FALSE;
        Vis003 := false;
        Vis004 := false;
        VisRemark := false;
        ModRemark := false;
        ApproveVis := false;
        ROVis := true;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        Edate: Date;
    begin
        //CurrPage.Update();
        ExamMstr.Reset();
        ExamMstr.SetRange("Exam ID", rec.Exam_ID);
        if ExamMstr.FindFirst() then begin
            StartExamDate := ExamMstr."Start Date";
            EndExamDate := ExamMstr."End Date";
        end;

        IF (rec.Status = rec.Status::"CC Approved") or (rec.Status = rec.Status::"RC Approved") THEN BEGIN
            Vis001 := TRUE;//send for approval
            Vis002 := FALSE;//Approval/Reject
            Vis003 := FALSE;//forward
            Vis004 := FALSE;//Send for Modification

        END
        else begin
            Vis001 := false;
            Vis002 := True;
            Vis003 := true;
            Vis004 := true;
        end;


        IF (rec."Bill Status" = rec."Bill Status"::"Pending For Approval") then begin
            MPSetup.GET;
            AppUserMem.RESET;
            AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
            AppUserMem.SETRANGE("User ID", USERID);
            AppUserMem.SETRANGE("Approval Permission", TRUE);
            IF AppUserMem.FIND('-') THEN BEGIN
                Vis002 := TRUE;
                Vis003 := FALSE;
                Vis001 := false;
                Vis004 := true;
            END
            ELSE BEGIN
                Vis002 := FALSE;
                Vis003 := TRUE;
                Vis001 := false;
                Vis004 := true;
            END;
        end;

        IF (rec."Bill Status" = rec."Bill Status"::Approved) OR (rec."Bill Status" = rec."Bill Status"::Rejected) THEN BEGIN
            Vis001 := FALSE;
            Vis002 := FALSE;
            Vis003 := false;
            Vis004 := False;
            Edit001 := false;
            EnabledBtn1 := false;
        END
        ELSE BEGIN
            Edit001 := true;
            EnabledBtn1 := true;
            // Vis001 := true;
            // Vis002 := true;
            // Vis003 := true;
            // Vis004 := True;
        END;
        if rec."Bill Status" = rec."Bill Status"::Approved then begin
            DisVis01 := true;
            VisNote := false
        end
        else begin
            DisVis01 := false;
            VisNote := true
        end;

        if rec."Bill Status" = rec."Bill Status"::"Disbursement Pending" then
            Vis001 := false;

    end;

    trigger OnOpenPage()
    begin
        ExamMstr.Reset();
        ExamMstr.SetRange("Exam ID", rec.Exam_ID);
        if ExamMstr.FindFirst() then begin
            StartExamDate := ExamMstr."Start Date";
            EndExamDate := ExamMstr."End Date";
        end;

        IF rec.BillType = rec.BillType::"Local" THEN BEGIN
            LocalBill := TRUE;
            OutBill := FALSE;
        END ELSE
            IF rec.BillType = rec.BillType::OutStation THEN BEGIN
                LocalBill := TRUE;
                OutBill := TRUE;
            END;

        IF rec.Status = rec.Status::Open THEN
            SendForAppEnable := TRUE
        ELSE
            SendForAppEnable := FALSE;

        IF rec.Status IN [rec.Status::Approved, rec.Status::Posted, rec.Status::Rejected] THEN BEGIN
            TDS_Per_Enable := FALSE;
            RemunerationEditable := FALSE;
            Editable := FALSE;
        END ELSE BEGIN
            TDS_Per_Enable := TRUE;
            RemunerationEditable := TRUE;
            Editable := TRUE;
        END;
    end;

    var
        SequenceNo: Integer;
        CurUserSeq: Integer;
        MPSetup: Record "NTA Bill Setup";
        BUserTab: Record "User BOC";
        BUserTab12: Record "User BOC";
        BUserTab11: Record "User BOC";
        AppEntInit: Record 454;
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        Vis001, Vis002, Vis003, EnabledBtn1, Edit001, DisVis01, Vis004, VisRemark, VisDate, ModRemark, ApproveVis, ROVis, VisNote : Boolean;
        BOCUsers: Page "BOC Users";
        LocalBill: Boolean;
        OutBill: Boolean;
        Text001: Label 'Do you want to send for approval ?';
        SendForAppEnable, viewsend, viewforward : Boolean;
        TDS_Per_Enable: Boolean;
        TotalAppAmt: Decimal;
        RemunerationEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        AppUserMem: Record "Approval User Group Member";
        Editable1: Boolean;
        TABillHeadTab: record 50005;
        SelctedUser: code[20];
        NTab: Record NoteSheet;
        ExamMstr: Record "Exam Master";
        StartExamDate, EndExamDate : Date;
        sendUserName: Text[120];
        TABillHeadTabPay: Record 50005;


    local procedure InsertApprovalEntry()
    var
        ApproverId: Code[20];
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
        RecordRefID: RecordRef;
    begin
        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.RESET;
        RecordRefID.GetTable(Rec);
        ApprovalEntryRec."Table ID" := RecordRefID.Number();
        ApprovalEntryRec."Sequence No." := 1;
        ApprovalEntryRec."Document No." := rec."Reference No";
        ApprovalEntryRec."Document Type" := ApprovalEntryRec."Document Type"::Quote;
        ApprovalEntryRec."Entry No." := EntryNo + 1;
        ApprovalEntryRec.Status := ApprovalEntryRec.Status::Open;
        ApprovalEntryRec."Sender ID" := USERID;
        ApprovalEntryRec."Approver ID" := SelctedUser;
        ApprovalEntryRec."Date-Time Sent for Approval" := CURRENTDATETIME;
        ApprovalEntryRec."Last Modified By User ID" := USERID;
        ApprovalEntryRec."Last Date-Time Modified" := CURRENTDATETIME;
        ApprovalEntryRec."Record ID to Approve" := Rec.RECORDID;
        ApprovalEntryRec.INSERT;

    end;
}

