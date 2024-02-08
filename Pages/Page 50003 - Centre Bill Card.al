page 50003 "Centre Bill Card"
{
    DataCaptionExpression = 'Reference No';
    PageType = Card;
    ApplicationArea = all;
    SourceTable = "Centre Bill Header";
    SourceTableView = SORTING("CentreBill ID");
    PromotedActionCategories = 'New,Process,Report,Approval,Notesheet';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; rec."Reference No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Centre No."; Rec."Centre No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Centre Address"; Rec."Centre Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Centre City"; rec."Centre City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Centre ID"; Rec."Centre ID")
                {
                    ApplicationArea = all;
                    //Visible = false;

                    trigger OnValidate()
                    begin
                        recCenterMaster.Reset();
                        recCenterMaster.SetRange(ID, Rec."Centre ID");
                        if recCenterMaster.FindFirst() then
                            Rec."Centre Address" := recCenterMaster.Centre_Address;
                        REC."Contact No." := recCenterMaster.Centre_ContactNo;
                    end;
                }
                field(Longitude; Rec.Longitude)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Latitude; Rec.Latitude)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(IP; Rec.IP)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Superintendent Name"; rec."Superintendent Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Exam Date"; rec."Exam Date")
                {
                    Caption = 'Exam Date';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Claimed Amount"; rec."Claimed Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Advance Amount"; rec."Advance Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Refund Amount"; rec."Refund Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("TDS (%)"; rec."Tds percentage")
                {
                    //  Editable = TDSEnable;
                    ApplicationArea = all;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    ApplicationArea = all;
                }
                field("Net Payble Amount"; rec."Net Payble Amount")
                {
                    Caption = 'Net Payble Amount';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Submitted Date"; DT2DATE(rec."Created on"))
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Receiver_ID"; rec.Receiver_ID)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sender_ID"; (rec.Sender_ID))
                {
                    ApplicationArea = all;

                }
                field(Remark; Rec.Remark)
                {
                    Editable = true;
                }
                //new field pan no added after demo 26th july 2023 dicsion 
                field(PAN_N0; Rec.PAN_N0)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                }
                field("Bill Status"; Rec."Bill Status")
                {
                    ApplicationArea = All;
                }

                // field("File Path"; Rec."File Path")
                // {

                //     ApplicationArea = all;
                //     Editable = true;
                // }

                // field(Attachment_Link; Rec.Attachment_Link)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }


                //field("Supporting Document"; AttachDoc)
                // {
                //     Editable = false;
                //     Style = Attention;
                //     StyleExpr = TRUE;

                //     trigger OnDrillDown()
                //     begin
                //         /// InvSetup.GET;
                // IF "File Path"<> '' THEN
                //   HYPERLINK(InvSetup."FTP Path" + "File Path");
                //end;
                // }


                // part(Lines; "Centre Bill Subform")
                // {
                //     Caption = 'Lines';
                //     SubPageLink = "Centre Bill ID" = FIELD("Centre ID");
                //     UpdatePropagation = SubPart;
                // }

            }

            // group("Bill Image")
            // {
            //     part("Picture"; 50775)

            //     {
            //         ApplicationArea = all;
            //         // Filter on the sales orders that relate to the customer in the card page.
            //         SubPageLink = CentreBillDetails_ID = FIELD("CentreBill ID");

            //     }
            // }
            part("Picture"; 50050)
            {
                //SubPageLink = id = FIELD("CentreBill ID");
                SubPageLink = CentreBillDetails_ID = FIELD("CentreBill ID");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = all;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = Vis001;

                //ApplicationArea = all;
                trigger OnAction()
                var
                    SqNo: Integer;
                begin
                    Clear(SequenceNo);
                    MPSetup.Get();
                    SelctedUser := '';
                    ;
                    NTab.RESET;
                    NTab.SETRANGE(NTab."Document No.", rec."Reference No.");
                    IF NOT NTab.FINDFIRST THEN
                        ERROR('Please create note sheet');

                    //28Aug st++
                    AppUserMem.Reset();
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    IF AppUserMem.FindLast() then
                        SqNo := AppUserMem."Sequence No.";
                    AppUserMem.SETRANGE("User ID", UserID);
                    IF AppUserMem.FindFirst() then
                        CurUserSeq := AppUserMem."Sequence No." + 1;
                    //28Aug En--

                    MPSetup.Get();
                    SelctedUser := '';
                    IF Rec.Receiver_ID <> USERID THEN
                        ERROR('You can not Forward it due to user ID mismatch');
                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    // AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    AppUserMem.SetRange("Sequence No.", CurUserSeq, SqNo);  //28 aug
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN begin
                            SelctedUser := AppUserMem."User ID";
                            SequenceNo := AppUserMem."Sequence No.";
                        end;
                    IF SelctedUser = '' THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to send approval request to %1?', FALSE, SelctedUser) THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No.");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    CentreBillHeadTab.RESET;
                    CentreBillHeadTab.SETRANGE("CentreBill ID", rec."CentreBill ID");
                    IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                        CentreBillHeadTab.Sender_ID := USERID;
                        CentreBillHeadTab.Receiver_ID := SelctedUser;
                        // CentreBillHeadTab.Status := CentreBillHeadTab.Status::"Pending Approval";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::"Pending For Approval";
                        IF CentreBillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
                        // CurrPage.CLOSE;
                    END;
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
                    SequenceNo := AppUserMem."Sequence No.";
                    IF SelctedUser = '' THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No.");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    CentreBillHeadTab.RESET;
                    CentreBillHeadTab.SETRANGE("CentreBill ID", rec."CentreBill ID");
                    IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                        CentreBillHeadTab.Sender_ID := USERID;
                        CentreBillHeadTab.Receiver_ID := SelctedUser;
                        // CentreBillHeadTab.Status := CentreBillHeadTab.Status::"Pending Approval";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::"Pending For Approval";
                        IF CentreBillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully forwarded to %1!!', SelctedUser);
                    END;
                    // FILTERGROUP(0);
                end;
            }

            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Visible = Vis002;// ROH

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
                        AppEntInit.SETRANGE("Document No.", rec."Reference No.");
                        IF AppEntInit.FINDLAST THEN BEGIN
                            AppEntInit.Status := AppEntInit.Status::Approved;
                            AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                            AppEntInit."Last Modified By User ID" := USERID;
                            AppEntInit.MODIFY;
                        END;
                        CentreBillHeadTab.RESET;
                        CentreBillHeadTab.SETRANGE(CentreBillHeadTab."CentreBill ID", rec."CentreBill ID");
                        IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                            // CentreBillHeadTab.Status := CentreBillHeadTab.Status::Approved;
                            CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::Approved;
                            CentreBillHeadTab.Sender_ID := USERID;
                            CentreBillHeadTab.Receiver_ID := MPSetup."TA & Centre Bill UID";
                            IF CentreBillHeadTab.MODIFY THEN
                                MESSAGE('Application has been successfully Approved!');
                            CurrPage.CLOSE;
                        END;
                        // FILTERGROUP(0);
                    END
                end;
            }

            action(AttachedBill)
            {
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                //Support#2022Visible = Vis002;

                trigger OnAction()
                begin
                    // FILTERGROUP(0);
                    Hyperlink('http://20.219.166.69:84/NTA_ERP/backend/web/' + recFileDrectory."Bill File Path" + Rec."File Path");

                end;
            }

            action(Reject)
            {
                ApplicationArea = all;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                //Visible = Vis001;

                //ApplicationArea = all;
                trigger OnAction()
                var
                    SqNo: Integer;   /////
                begin
                    Clear(SequenceNo);
                    MPSetup.Get();
                    SelctedUser := '';

                    NTab.RESET;
                    NTab.SETRANGE(NTab."Document No.", rec."Reference No.");
                    IF NOT NTab.FINDFIRST THEN
                        ERROR('Please create note sheet');

                    //28Aug st++
                    AppUserMem.Reset();
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    IF AppUserMem.FindLast() then
                        SqNo := AppUserMem."Sequence No.";
                    AppUserMem.SETRANGE("User ID", UserID);
                    IF AppUserMem.FindFirst() then
                        CurUserSeq := AppUserMem."Sequence No." - 1; /////
                    //28Aug En--

                    MPSetup.Get();
                    SelctedUser := '';
                    IF Rec.Receiver_ID <> USERID THEN
                        ERROR('You can not Forward it due to user ID mismatch');
                    AppUserMem.RESET();
                    AppUserMem.FILTERGROUP(2);
                    AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    // AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    AppUserMem.SetRange("Sequence No.", CurUserSeq, SqNo);  //28 aug     ////////////
                    IF AppUserMem.FindFirst() then
                        IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN begin
                            SelctedUser := AppUserMem."User ID";
                            SequenceNo := AppUserMem."Sequence No.";
                        end;
                    IF SelctedUser = '' THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to reject request to %1?', FALSE, SelctedUser) THEN
                        EXIT;
                    AppEntInit.RESET;
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No.");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    CentreBillHeadTab.RESET;
                    CentreBillHeadTab.SETRANGE("CentreBill ID", rec."CentreBill ID");
                    IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                        CentreBillHeadTab.Sender_ID := USERID;
                        CentreBillHeadTab.Receiver_ID := SelctedUser;
                        //CentreBillHeadTab.Status := CentreBillHeadTab.Status::"Pending Approval";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::Rejected;
                        IF CentreBillHeadTab.MODIFY THEN
                            MESSAGE('Application request has been rejected %1!!', SelctedUser);
                        // CurrPage.CLOSE;
                    END;

                    // ApplicationArea = All;
                    // Image = Reject;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    // PromotedOnly = true;
                    // //Visible = Vis002; //show all user after  open comment  ROH


                    // trigger OnAction()
                    // var
                    //     SqNo: Integer;// Rohit
                    // begin
                    //     Clear(SequenceNo);
                    //     MPSetup.Get();
                    //     SelctedUser := '';
                    //     IF rec.Receiver_ID <> USERID THEN
                    //         ERROR('You are not allowed to reject, due to user ID mismatch');

                    //     if rec."Rejection Remark" = '' then
                    //         Error('please Remark');

                    //     if not Confirm('Do you want to Reject.?') then
                    //         exit;

                    //     AppUserMem.Reset();
                    //     AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    //     AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    //     IF AppUserMem.FindLast() then //rk
                    //         SqNo := AppUserMem."Sequence No."; //rk
                    //     AppUserMem.SETRANGE("User ID", UserID);
                    //     IF AppUserMem.FindFirst() then
                    //         CurUserSeq := AppUserMem."Sequence No." + 1; //rk
                    //     Clear(SequenceNo);
                    //     MPSetup.Get();
                    //     SelctedUser := '';
                    //     AppUserMem.RESET();
                    //     AppUserMem.FILTERGROUP(2);
                    //     AppUserMem.SETCURRENTKEY("Approval User Group Code", "Sequence No.", "User ID");
                    //     AppUserMem.SETRANGE("Approval User Group Code", MPSetup."Workflow Code2");
                    //     // AppUserMem.SETFILTER("User ID", '<>%1', USERID);
                    //     AppUserMem.SetRange("Sequence No.", CurUserSeq, SqNo); //rk
                    //     // AppUserMem.SetRange("Sequence No.", CurUserSeq + 1);
                    //     IF AppUserMem.FindFirst() then
                    //         IF PAGE.RUNMODAL(50150, AppUserMem) = ACTION::LookupOK THEN begin
                    //             SelctedUser := AppUserMem."User ID";
                    //             SequenceNo := AppUserMem."Sequence No.";
                    //         end;
                    //     IF SelctedUser = '' THEN
                    //         EXIT;
                    //     IF NOT CONFIRM('Do you want to Reject to %1?', FALSE, SelctedUser) THEN
                    //         EXIT;
                    //     AppEntInit.RESET;
                    //     AppEntInit.SETRANGE("Document No.", Rec."Reference No.");
                    //     AppEntInit.SetRange("Approver ID", UserId);
                    //     AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    //     IF AppEntInit.FindFirst() THEN BEGIN
                    //         AppEntInit.Status := AppEntInit.Status::Forwarded;
                    //         AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                    //         AppEntInit."Last Modified By User ID" := USERID;
                    //         AppEntInit.MODIFY;
                    //     END;
                    //     CentreBillHeadTab.RESET;
                    //     CentreBillHeadTab.SETRANGE(CentreBillHeadTab."CentreBill ID", rec."CentreBill ID");
                    //     IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                    //         // CentreBillHeadTab.Status := CentreBillHeadTab.Status::Rejected;
                    //         CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::Rejected;
                    //         CentreBillHeadTab.Sender_ID := USERID;
                    //         CentreBillHeadTab.Receiver_ID := SelctedUser;
                    //         IF CentreBillHeadTab.MODIFY THEN
                    //             MESSAGE('Application request has been rejected!!');
                    //         CurrPage.CLOSE;
                    //     END;
                    //     // FILTERGROUP(0);
                END;

            }

            action(Return)
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                Visible = false;
                //Visible = Vis002; //ROH

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
                    AppEntInit.SETRANGE("Document No.", Rec."Reference No.");
                    AppEntInit.SetRange("Approver ID", UserId);
                    AppEntInit.SetRange(Status, AppEntInit.Status::Open);
                    IF AppEntInit.FindFirst() THEN BEGIN
                        AppEntInit.Status := AppEntInit.Status::Forwarded;
                        AppEntInit."Last Date-Time Modified" := CURRENTDATETIME;
                        AppEntInit."Last Modified By User ID" := USERID;
                        AppEntInit.MODIFY;
                    END;
                    InsertApprovalEntry;
                    CentreBillHeadTab.RESET;
                    CentreBillHeadTab.SETRANGE(CentreBillHeadTab."CentreBill ID", rec."CentreBill ID");
                    IF CentreBillHeadTab.FINDFIRST THEN BEGIN
                        CentreBillHeadTab.Sender_ID := USERID;
                        CentreBillHeadTab.Receiver_ID := SelctedUser;
                        // CentreBillHeadTab.Status := CentreBillHeadTab.Status::"Pending Approval";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::"Pending For Approval";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::Open;//ROH
                        IF CentreBillHeadTab.MODIFY THEN
                            MESSAGE('Application successfully returned to %1!!', SelctedUser);
                    END;
                    // FILTERGROUP(0);
                end;
            }
            //exds-25-8-2023
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
            //         TABillHeadTab.SETRANGE("CentreBill ID", Rec."CentreBill ID");
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
                Visible = DISVis01;
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
                    CentreBillHeadTab.RESET;
                    CentreBillHeadTab.SETRANGE("CentreBill ID", Rec."CentreBill ID");
                    IF CentreBillHeadTab.FindFirst() THEN BEGIN
                        // CentreBillHeadTab.Status := CentreBillHeadTab.Status::"Disbursement Pending";
                        CentreBillHeadTab."Bill Status" := CentreBillHeadTab."Bill Status"::"Disbursement Pending";
                        CentreBillHeadTab.Sender_ID := USERID;
                        CentreBillHeadTab.Receiver_ID := 'Joint_Director';
                        IF CentreBillHeadTab.MODIFY THEN
                            MESSAGE('Sent successfully for Approved for Bill Disbursement!');
                    END;
                    CurrPage.CLOSE;
                end;
            }

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
                        NTab.SETRANGE("Document No.", Rec."Reference No.");
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
                        NTab.SETRANGE("Document No.", Rec."Reference No.");
                        IF NTab.FINDFIRST THEN
                            PAGE.RUN(PAGE::"NoteSheet Display", NTab);
                    end;
                }
            }

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

        //clear(CurUserSeq);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //CurrPage.Update();

        //IF (rec.Status = rec.Status::Open) THEN BEGIN
        ERPMSTR.reset();
        ERPMSTR.SetRange(ID, rec."Centre ID");
        if ERPMSTR.FindFirst() then begin
            rec."Centre Address" := ERPMSTR.Centre_Address;
            rec."Contact No." := ERPMSTR.Centre_ContactNo;
        end;

        IF (rec.Status = rec.Status::"CC Approved") or (rec.Status = rec.Status::"RC Approved") THEN BEGIN
            Vis001 := TRUE;//send for approval
            Vis002 := false;//Approval/Reject
            Vis003 := false;//forward
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
            //Vis001 := true;
            //Vis002 := true;
            //Vis003 := true;
            //Vis004 := True;
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
    var

    begin
        ERPMSTR.reset();
        ERPMSTR.SetRange(ID, rec."Centre ID");
        if ERPMSTR.FindFirst() then begin
            rec."Centre Address" := ERPMSTR.Centre_Address;
            rec."Contact No." := ERPMSTR.Centre_ContactNo;
        end;

        recCenterMaster.Reset();
        recCenterMaster.SetRange(ID, Rec."Centre ID");

        if recCenterMaster.FindFirst() then
            Rec."Centre Address" := recCenterMaster.Centre_Address;

        clear(CurUserSeq);
        IF rec.Status = rec.Status::Open THEN
            SendForAppEnable := TRUE
        ELSE
            SendForAppEnable := FALSE;


    end;

    var
        ERPMSTR: Record ERP_MASTER_Centre;
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
        ApproverUser: Code[20];
        ApprovalUserGroupMemberRec: Record 50082;
        Enabled: Boolean;
        EnabledBtn: Boolean;
        SeqNo: Integer;
        SendForAppEnable, viewsend, viewforward : Boolean;
        SequenceNo: Integer;
        ContingentBillHeader: Record 50002;
        MPSetup: Record "NTA Bill Setup";

        ApprovalCommentLine, NTab : Record NoteSheet;

        FileDir: Record "File Directory Detail";
        recFileDrectory: Record 50083;  //Dhananjay added 8th Aug 2023

        SelctedUser: code[20];
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;

        Text001: Label '''You do not have permission to approve "Q Sheet"''';
        Text002: Label '''Q Sheet'' not exist for Approve !';
        BOCUsers: Record 50000;
        Vis001, Vis002, Vis003, Edit001, DISVis01, Vis004, VisRemark, VisDate, ModRemark, ApproveVis, ROVis, VisNote : Boolean;
        //InsertApprovalEntry :Codeunit  50002;
        "--**----": Integer;
        //AppEntInit: Record 454;

        EnabledBtn1: Boolean;

        EnabledBtn2: Boolean;

        EnabledBtn3: Boolean;

        EnabledBtn4: Boolean;

        CurUserSeq: Integer;

        CentreBillHeadTab: record "Centre Bill Header";
        AppEntInit: Record 454;
        //BOCUsers: Page 50130;


        //UserSetupManagement: Codeunit 50004; Need From Team 
        RespCentre: Code[10];
        GenLedSetup: Record 98;

        AppUserMem: Record "Approval User Group Member";
        recCenterMaster: Record ERP_MASTER_Centre;
    //AppUserMem: page 50133;
    //BillMang: Codeunit "Bills Management-OD";
    // contRollHir: Record "Contingent Bill Rollback";
    // contbillline: Record "Contingent Bill Lines";
    // contbillline1: Record "Contingent Bill Lines";


    local procedure InsertApprovalEntry()//Rashmi 20-07-2023
    var
        ApproverId: Code[20];
        ApprovalEntryRec: Record 454;
        EntryNo: Integer;
        RecordRef: RecordRef;
    begin

        ApprovalEntryRec.RESET;
        IF ApprovalEntryRec.FINDLAST THEN
            EntryNo := ApprovalEntryRec."Entry No.";
        ApprovalEntryRec.RESET;
        //KISHAN-07022024
        RecordRef.GetTable(Rec);
        ApprovalEntryRec."Table ID" := RecordRef.Number();
        //KISHAN-07022024
        ApprovalEntryRec."Sequence No." := 1;
        ApprovalEntryRec."Document No." := rec."Reference No.";
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


    // local procedure UpdateButtons()
    // var
    //     RespCenter: Record 5714;
    //     AppLvl: Integer;
    //     ULvl: Integer;
    // begin
    //     //EnabledBtn1 := Status=Status::Open;
    //     EnabledBtn1 := TRUE;
    //     EnabledBtn2 := TRUE;
    //     IF RespCenter.GET("Responsibility Centre") THEN
    //         AppLvl := RespCenter."QSheet Approval Lowest Lvl.";
    //     BUserTab11.RESET;
    //     BUserTab11.SETRANGE("User Name", USERID);
    //     IF BUserTab11.FINDFIRST THEN
    //         ULvl := BUserTab11.Level;
    //     IF ULvl = AppLvl THEN BEGIN
    //         EnabledBtn2 := TRUE;
    //         EnabledBtn3 := FALSE;

    //     END
    //     ELSE BEGIN
    //         EnabledBtn2 := FALSE;
    //         EnabledBtn3 := TRUE;
    //     END;
    //     IF (Status = Status::Open) THEN BEGIN
    //         EnabledBtn1 := TRUE;
    //         EnabledBtn2 := FALSE;
    //         EnabledBtn3 := FALSE;
    //         EnabledBtn4 := FALSE;
    //     END
    //     ELSE
    //         IF (Status = Status::Release) OR (Status = Status::Rejected) THEN BEGIN
    //             EnabledBtn1 := FALSE;
    //             EnabledBtn2 := FALSE;
    //             EnabledBtn3 := FALSE;
    //             EnabledBtn4 := FALSE;
    //         END
    //         ELSE BEGIN
    //             EnabledBtn1 := FALSE;
    //             //EnabledBtn2:=TRUE;
    //             //EnabledBtn3:=TRUE;
    //             EnabledBtn4 := TRUE;
    //         END;

    /*
    IF (Status=Status::Open) THEN BEGIN
      EnabledBtn1:=TRUE;
      EnabledBtn2:=FALSE;
     END
    ELSE IF (Status=Status::Release) THEN BEGIN
      EnabledBtn1:=FALSE;
      EnabledBtn2:=FALSE;
     END
    ELSE BEGIN
      EnabledBtn1:=FALSE;
      EnabledBtn2:=TRUE;
    END;
    */

    // end;
}

