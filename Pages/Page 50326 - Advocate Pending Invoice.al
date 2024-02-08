page 50326 "Advocate Pending Invoice"
{

    Caption = 'Service Invoice';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve';
    RefreshOnActivate = true;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            Status = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    Importance = Promoted;

                    //HYC

                    // trigger OnValidate()
                    // begin
                    //     SetLocGSTRegNoEditable;
                    // end;
                }


                // field("Vendor Type";rec."Vendor Type")
                // {
                //     Caption = 'Advocate Type';
                // }

                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    Caption = 'Advocate No.';
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        // BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; rec."Buy-from Contact No.")
                {
                    Caption = 'Advocate Contact No.';
                    Editable = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    Caption = 'Advocate Name';
                    Editable = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    Caption = 'Advocate Address';
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    Caption = 'Advocate Address 2';
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    Caption = 'Advocate Post Code';
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    Caption = 'Advocate City';
                    Editable = false;
                }

                //HYC 

                // field("Parent Advocate";rec."Parent Advocate")
                // {
                //     DrillDown = false;
                //     Editable = false;
                //     Lookup = false;
                // }
                // field("Parent Advocate Name";rec."Parent Advocate Name")
                // {
                //     DrillDown = false;
                //     Editable = false;
                //     Lookup = false;
                // }
                field(Structure; rec.Structure)
                {
                    Editable = true;
                    Importance = Promoted;

                    // trigger OnValidate()
                    // begin
                    //     SetLocGSTRegNoEditable;
                    // end;
                }
                // field("Old File No.";rec."Old File No.")
                // {
                // }
                // field("e-office File No.";rec."e-office File No.")
                // {
                // }
                field("Posting Date"; rec."Posting Date")
                {
                    Importance = Promoted;

                    // trigger OnValidate()
                    // begin
                    //     SaveInvoiceDiscountAmount;
                    // end;
                }
                field("Document Date"; rec."Document Date")
                {
                }
                field("Incoming Document Entry No."; rec."Incoming Document Entry No.")
                {
                    Visible = false;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    Caption = 'Advocate Invoice No.';
                    //ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        // ShortcutDimension1CodeOnAfterV;
                    end;
                }
                // field("Exam Name"; rec."Exam Name")
                // {
                // }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterV;
                    end;
                }
                // field("Section Name"; rec."Section Name")
                // {
                // }
                field(Status; rec.Status)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Transfer User Id"; rec."Transfer User Id")
                {
                }
                field("Transfer User Name"; rec."Transfer User Name")
                {
                }
                // field("Assessee Code";rec."Assessee Code")
                // {
                // }
                field("Calculate IT TDS"; rec."Calculate IT TDS")
                {
                }
                field("Calculate GST TDS"; rec."Calculate GST TDS")
                {
                }
            }

            //HYC
            // part(PurchLines;5031)
            // {
            //     SubPageLink = "Document No"=FIELD("No.");
            //     UpdatePropagation = Both;
            // }
        }
        area(factboxes)
        {
            part(MyPart; 9103)
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                //Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox; 9092)
            {
                Visible = false;
            }
            part(MyPart1; 9093)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
            }
            part(MyPart2; 9094)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
            }
            part(MyPart3; 9095)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part(MyPart4; 9096)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            // part(MyPart5;9100)
            // {
            //     //Provider = PurchLines;
            //     SubPageLink ="Document Type"=FIELD("Document Type"),
            //                  "Document No."=FIELD("Document No."),
            //                  "Line No."=FIELD("Line No.");
            //     Visible = false;
            // }
            part(WorkflowStatus; 1528)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                //Visible = ShowWorkflowStatus;
            }
            systempart(MyPart6; Links)
            {
                Visible = false;
            }
            systempart(MyPart7; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    // trigger OnAction()
                    // begin
                    //     CalcInvDiscForHeader;
                    //     COMMIT;
                    //     IF Structure <> '' THEN BEGIN
                    //       PurchLine.CalculateStructures(Rec);
                    //       PurchLine.AdjustStructureAmounts(Rec);
                    //       PurchLine.UpdatePurchLines(Rec);
                    //       PurchLine.CalculateTDS(Rec);
                    //       PurchLine.UpdatePurchLines(Rec);
                    //       COMMIT;
                    //     END ELSE BEGIN
                    //       PurchLine.CalculateTDS(Rec);
                    //       PurchLine.UpdatePurchLines(Rec);
                    //       COMMIT;
                    //     END;
                    //     PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
                    // end;
                }
                action("Calculation Sheet")
                {
                    Promoted = true;

                    // trigger OnAction()
                    // begin
                    //     PurchHead.RESET;
                    //     PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
                    //     PurchHead.SETRANGE("No.","No.");
                    //     IF PurchHead.FINDFIRST THEN
                    //       REPORT.RUN(50163,TRUE,TRUE,PurchHead);
                    // end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                "No." = FIELD("No."),
                                 "Document Line No." = CONST(0);
                    Visible = false;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    // trigger OnAction()
                    // begin
                    //     ShowDocDim;
                    //     CurrPage.SAVERECORD;
                    // end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Visible = false;

                    // trigger OnAction()
                    // var
                    //     ApprovalEntries: Page 658;
                    // begin
                    //     ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
                    //     ApprovalEntries.RUN;
                    // end;
                }
                // action("Note &Sheet")
                // {
                //     Caption = 'Note &Sheet';
                //     Image = ViewComments;
                //     Promoted = true;

                //     trigger OnAction()
                //     begin

                //         ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id",38);
                //         ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.","No.");
                //         PAGE.RUN(PAGE::"Notesheet List",ApprovalCommentLine);
                //     end;
                // }
                action("View Note Sheet")
                {
                    Visible = true;

                    // trigger OnAction()
                    // begin

                    //     ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.","No.");
                    //     PAGE.RUN(PAGE::"NoteSheet Display",ApprovalCommentLine);
                    // end;
                }
                // action("Note &Sheet")
                // {
                //     Caption = 'Note &Sheet';
                //     Image = ViewComments;
                //     Promoted = true;
                //     RunObject = Page 66;
                //                     RunPageLink = Document Type=FIELD(Document Type),
                //                   No.=FIELD(No.),
                //                   Document Line No.=CONST(0);
                //     Visible = false;
                // }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action("Forword ")
                {
                    Caption = 'Forward';
                    Promoted = true;

                    // trigger OnAction()
                    // begin
                    //     IF NOT CONFIRM(Text0004) THEN
                    //         EXIT;
                    //     TESTFIELD("Transfer User Id");

                    //     NoteshetTab.RESET;
                    //     NoteshetTab.SETRANGE("Document No.","No.");
                    //     IF NoteshetTab.FIND('-') THEN BEGIN
                    //       Entryno := NoteshetTab."Last Entry No." + 1;
                    //       NoteshetTab.CALCFIELDS("Running Note");
                    //       IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
                    //         NoteshetTab."Running Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
                    //         Isstream.READ(NsheetOld);
                    //      END;
                    //       NoteshetTab.CALCFIELDS("Current Note");

                    //       IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
                    //          NoteshetTab."Current Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
                    //          Isstream.READ(Nsheet);
                    //       END;
                    //       Char10:=10;
                    //       NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm,TEXTENCODING::UTF16);
                    //       IF Nsheet <> '' THEN BEGIN
                    //         IF NsheetOld <> '' THEN BEGIN
                    //           SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  + Nsheet + '    ';
                    //         END
                    //         ELSE
                    //          SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                    //         len := STRLEN(SaveTxt);
                    //         SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
                    //         SaveTxt := INSSTR(SaveTxt,'         ',len+2);
                    //         UserTab.RESET;
                    //         UserTab.SETRANGE(UserTab."User Name",USERID);
                    //         IF UserTab.FINDFIRST THEN
                    //           IF UserTab."Designation Name" <> '' THEN
                    //             SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
                    //           ELSE
                    //             SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
                    //             SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
                    //             ostrm.WRITE(SaveTxt);
                    //         IF NoteshetTab.MODIFY THEN BEGIN
                    //           NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
                    //          //ostrm1.WRITETEXT();
                    //           NoteshetTab."Last Entry No." := Entryno;
                    //           ostrm1.WRITE('');
                    //           NoteshetTab.MODIFY;
                    //         END;
                    //        END
                    //       ELSE BEGIN

                    //         SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  ;
                    //         len := STRLEN(SaveTxt);
                    //         SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
                    //         SaveTxt := INSSTR(SaveTxt,'         ',len+2);
                    //         UserTab.RESET;
                    //         UserTab.SETRANGE(UserTab."User Name",USERID);
                    //         IF UserTab.FINDFIRST THEN
                    //           IF UserTab."Designation Name" <> '' THEN
                    //             SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
                    //           ELSE
                    //             SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
                    //          SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
                    //         ostrm.WRITE(SaveTxt);
                    //         IF NoteshetTab.MODIFY THEN BEGIN
                    //           NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
                    //         //ostrm1.WRITETEXT();
                    //           NoteshetTab."Last Entry No." := Entryno;
                    //           ostrm1.WRITE('');
                    //           NoteshetTab.MODIFY;
                    //         END;
                    //       END;
                    //     END;
                    //     ApprovalEntry1.RESET;
                    //     ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID",38);
                    //     ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.","No.");
                    //     ApprovalEntry1.SETRANGE(ApprovalEntry1.Status,ApprovalEntry1.Status::Open);
                    //     ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID",USERID);
                    //     IF ApprovalEntry1.FINDFIRST THEN BEGIN
                    //       ApprovalEntry1.Status:= ApprovalEntry1.Status::Forworded;
                    //       ApprovalEntry1."Forwarding Date-Time"  := CURRENTDATETIME;
                    //       ApprovalEntry1.MODIFY;

                    //     END;
                    //     ApprovalEntry.RESET;
                    //     IF ApprovalEntry.FINDLAST THEN BEGIN
                    //       "EntryNo." := ApprovalEntry."Entry No.";

                    //     END;
                    //     ApprovalEntry.RESET;
                    //     ApprovalEntry."Entry No." := "EntryNo." +1;
                    //     ApprovalEntry."Table ID" := 38;
                    //     ApprovalEntry."Document No." := "No.";
                    //     ApprovalEntry."Sequence No." := 1;
                    //     ApprovalEntry."Sender ID" := USERID;
                    //     ApprovalEntry."Approver ID" := "Transfer User Id";
                    //     ApprovalEntry.Status := ApprovalEntry.Status::Open;
                    //     ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                    //     ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
                    //     ApprovalEntry."Last Modified By User ID" := USERID;
                    //     ApprovalEntry.VALIDATE("Location Code","Location Code");
                    //     ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
                    //     ApprovalEntry."Record ID to Approve" := RECORDID;
                    //     ApprovalEntry.INSERT;
                    //     PurchHead.RESET;
                    //     PurchHead.SETRANGE(PurchHead."No.","No.");
                    //     IF PurchHead.FINDFIRST THEN BEGIN
                    //       PurchHead."Pending To User ID" := "Transfer User Id";
                    //       PurchHead."Pending To User Name" := "Transfer User Name";
                    //       PurchHead."Transfer User Id" := '';
                    //       PurchHead."Transfer User Name" := '';
                    //     PurchHead.MODIFY;
                    //     END;


                    //     CurrPage.CLOSE;
                    // end;
                }
                action(Approve)
                {
                    Caption = 'Create Payment Proposal';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit 1535;
                    // begin

                    //     AppuserGroupMem.RESET;
                    //     AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code", 'INVOICE');
                    //     AppuserGroupMem.SETRANGE(AppuserGroupMem."User Name", USERID);
                    //     AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission", FALSE);
                    //     IF AppuserGroupMem.FINDFIRST THEN
                    //         ERROR('You do not have permision to approve invoice');
                    //     IF NOT CONFIRM(Text0003) THEN
                    //         EXIT;
                    //     TESTFIELD("Transfer User Id");
                    //     NoteshetTab.SETRANGE("Document No.", "No.");
                    //     IF NoteshetTab.FIND('-') THEN BEGIN
                    //         Entryno := NoteshetTab."Last Entry No." + 1;
                    //         NoteshetTab.CALCFIELDS("Running Note");
                    //         IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
                    //             NoteshetTab."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                    //             Isstream.READ(NsheetOld);
                    //         END;
                    //         NoteshetTab.CALCFIELDS("Current Note");

                    //         IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
                    //             NoteshetTab."Current Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                    //             Isstream.READ(Nsheet);
                    //         END;
                    //         Char10 := 10;
                    //         NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
                    //         IF Nsheet <> '' THEN BEGIN
                    //             IF NsheetOld <> '' THEN BEGIN
                    //                 SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                    //             END
                    //             ELSE
                    //                 SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                    //             len := STRLEN(SaveTxt);
                    //             SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                    //             SaveTxt := INSSTR(SaveTxt, '         ', len + 2);
                    //             UserTab.RESET;
                    //             UserTab.SETRANGE(UserTab."User Name", USERID);
                    //             IF UserTab.FINDFIRST THEN
                    //                 IF UserTab."Designation Name" <> '' THEN
                    //                     SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                    //                 ELSE
                    //                     SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                    //             SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                    //             ostrm.WRITE(SaveTxt);
                    //             IF NoteshetTab.MODIFY THEN BEGIN
                    //                 NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                    //                 //ostrm1.WRITETEXT();
                    //                 NoteshetTab."Last Entry No." := Entryno;
                    //                 ostrm1.WRITE('');
                    //                 NoteshetTab.MODIFY;
                    //             END;
                    //         END
                    //         ELSE BEGIN

                    //             SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ';
                    //             len := STRLEN(SaveTxt);
                    //             SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                    //             SaveTxt := INSSTR(SaveTxt, '         ', len + 2);
                    //             UserTab.RESET;
                    //             UserTab.SETRANGE(UserTab."User Name", USERID);
                    //             IF UserTab.FINDFIRST THEN
                    //                 IF UserTab."Designation Name" <> '' THEN
                    //                     SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                    //                 ELSE
                    //                     SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                    //             SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                    //             ostrm.WRITE(SaveTxt);
                    //             IF NoteshetTab.MODIFY THEN BEGIN
                    //                 NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                    //                 //ostrm1.WRITETEXT();
                    //                 NoteshetTab."Last Entry No." := Entryno;
                    //                 ostrm1.WRITE('');
                    //                 NoteshetTab.MODIFY;
                    //             END;
                    //         END;
                    //     END;


                    //     ApprovalEntry.RESET;
                    //     ApprovalEntry.SETRANGE("Document No.", "No.");

                    //     ApprovalEntry.SETRANGE("Table ID", 38);
                    //     ApprovalEntry.SETRANGE("Approver ID", USERID);
                    //     ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //     IF ApprovalEntry.FINDFIRST THEN BEGIN
                    //         ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                    //         ApprovalEntry.MODIFY;
                    //     END;
                    //     ApprovalEntry1.RESET;
                    //     IF ApprovalEntry1.FINDLAST THEN BEGIN
                    //         "EntryNo." := ApprovalEntry1."Entry No.";

                    //     END;
                    //     ApprovalEntry1.RESET;
                    //     ApprovalEntry1."Entry No." := "EntryNo." + 1;
                    //     ApprovalEntry1."Table ID" := 38;
                    //     ApprovalEntry1."Document No." := "No.";
                    //     ApprovalEntry1."Sequence No." := 1;
                    //     ApprovalEntry1."Sender ID" := USERID;
                    //     ApprovalEntry1."Approver ID" := "Transfer User Id";
                    //     ApprovalEntry1.Status := ApprovalEntry.Status::Open;
                    //     ApprovalEntry1."Date-Time Sent for Approval" := CURRENTDATETIME;
                    //     ApprovalEntry1."Last Date-Time Modified" := CURRENTDATETIME;
                    //     ApprovalEntry1."Last Modified By User ID" := USERID;
                    //     ApprovalEntry1.VALIDATE("Location Code", "Location Code");
                    //     ApprovalEntry1.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    //     ApprovalEntry1."Record ID to Approve" := RECORDID;
                    //     ApprovalEntry1.INSERT;

                    //     PurchHead.RESET;
                    //     PurchHead.SETRANGE(PurchHead."Document Type", PurchHead."Document Type"::Invoice);
                    //     PurchHead.SETRANGE(PurchHead."No.", "No.");
                    //     IF PurchHead.FINDFIRST THEN BEGIN
                    //         PurchHead.Status := PurchHead.Status::Released;
                    //         PurchHead."Pending To User ID" := "Transfer User Id";
                    //         PurchHead."Pending To User Name" := "Transfer User Name";
                    //         //PurchHead."Payment Pro Upword Created" := TRUE;
                    //         PurchHead."Transfer User Id" := '';
                    //         PurchHead."Transfer User Name" := '';
                    //         PurchHead.MODIFY;
                    //     END;

                    //     CurrPage.CLOSE;
                    // end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit 1535;
                    // begin

                    //     IF NOT CONFIRM(Text0005) THEN
                    //         EXIT;
                    //     TESTFIELD("Rejected Remarks");
                    //     ApprovalEntry.RESET;
                    //     ApprovalEntry.SETRANGE("Document No.", "No.");
                    //     ApprovalEntry.SETRANGE("Table ID", 38);
                    //     ApprovalEntry.SETRANGE("Approver ID", USERID);
                    //     ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    //     IF ApprovalEntry.FINDFIRST THEN BEGIN
                    //         //CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    //         // ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                    //         ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                    //         ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                    //         ApprovalEntry.MODIFY;
                    //     END;
                    //     PurchHead.RESET;
                    //     PurchHead.SETRANGE(PurchHead."Document Type", PurchHead."Document Type"::Invoice);
                    //     PurchHead.SETRANGE(PurchHead."No.", "No.");
                    //     IF PurchHead.FINDFIRST THEN BEGIN
                    //         PurchHead.Status := PurchHead.Status::Rejected;
                    //         PurchHead.MODIFY;
                    //     END;

                    //end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID)
                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = Release;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(sep)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;

                    // trigger OnAction()
                    // begin
                    //     PurchLine.CalculateStructures(Rec);
                    //     PurchLine.AdjustStructureAmounts(Rec);
                    //     PurchLine.UpdatePurchLines(Rec);
                    // end;
                }
                // action("Calculate TDS")
                // {
                //     Caption = 'Calculate TDS';
                //     Image = CalculateVATExemption;

                //     trigger OnAction()
                //     begin
                //         PurchLine.CalculateTDS(Rec);
                //     end;
                // }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                // action("Calculate &Invoice Discount")
                // {
                //     AccessByPermission = TableData 24 = R;
                //     Caption = 'Calculate &Invoice Discount';
                //     Image = CalculateInvoiceDiscount;

                //     trigger OnAction()
                //     begin
                //         ApproveCalcInvDisc;
                //     end;
                // }
                separator(sep1)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;
                    Visible = false;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record 175;
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    Image = GetLines;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //GetGateEntryLines;
                    end;
                }
                separator(sep2)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        // CopyPurchDoc.SetPurchHeader(Rec);
                        // CopyPurchDoc.RUNMODAL;
                        // CLEAR(CopyPurchDoc);
                        // IF GET("Document Type", "No.") THEN;
                    end;
                }
                action(MoveNegativeLines)
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // CLEAR(MoveNegPurchLines);
                        // MoveNegPurchLines.SetPurchHeader(Rec);
                        // MoveNegPurchLines.RUNMODAL;
                        // MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(sep3)
                {
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        Caption = 'View Incoming Document';
                        //Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                        // IncomingDocument: Record "130";
                        begin
                            // IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData 130 = R;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                        // IncomingDocument: Record "130";
                        begin
                            //VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        // Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                        // IncomingDocumentAttachment: Record "133";
                        begin
                            //IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        Caption = 'Remove Incoming Document';
                        // Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        begin
                            //"Incoming Document Entry No." := 0;
                        end;
                    }
                }
            }
            // group("Request Approval")
            // {
            //     Caption = 'Request Approval';
            //     action(SendApprovalRequest)
            //     {
            //         Caption = 'Send A&pproval Request';
            //         Enabled = NOT OpenApprovalEntriesExist;
            //         Image = SendApprovalRequest;
            //         Visible = false;

            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit 1535;
            //         begin

            //             /*IF "Agreement Done" THEN BEGIN
            //             TESTFIELD("Agreement Date");
            //             TESTFIELD("Agreement Valid Till Date");
            //             END ELSE BEGIN
            //               TESTFIELD("Agreement Remarks");
            //               END;
            //             IF "Performance Guarantee Seen" THEN BEGIN
            //               TESTFIELD("Performance Guarantee Date");
            //               TESTFIELD("Performance Guarantee Amount");
            //               TESTFIELD("BG/DD No./RTGS No.");
            //               TESTFIELD("Issuing Bank Name");
            //               END*/
            //               /*
            //             IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
            //               ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
            //               */
            //               TESTFIELD(Status,Status::Open);
            //             IF NOT CONFIRM(Text004) THEN
            //               EXIT;
            //             PurchHead.RESET;
            //             PurchHead.SETRANGE(PurchHead."No.","No.");
            //             IF PurchHead.FINDFIRST THEN
            //               REPORT.RUN(50027,TRUE,FALSE,PurchHead);

            //             CurrPage.CLOSE;

            //         end;
            //     }
            //     action(CancelApprovalRequest)
            //     {
            //         Caption = 'Cancel Approval Re&quest';
            //         Enabled = OpenApprovalEntriesExist;
            //         Image = Cancel;
            //         Visible = false;

            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "1535";
            //         begin
            //             ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
            //         end;
            //     }
            // }
            // group("P&osting")
            // {
            //     Caption = 'P&osting';
            //     Image = Post;
            //     action(Post)
            //     {
            //         Caption = 'P&ost';
            //         Image = PostOrder;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         ShortCutKey = 'F9';
            //         Visible = false;

            //         trigger OnAction()
            //         begin
            //             Post(CODEUNIT::"Purch.-Post (Yes/No)");
            //         end;
            //     }
            //     action(Preview)
            //     {
            //         Caption = 'Preview Posting';
            //         Image = ViewPostedOrder;
            //         Visible = false;

            //         trigger OnAction()
            //         var
            //             PurchPostYesNo: Codeunit "91";
            //         begin
            //             PurchPostYesNo.Preview(Rec);
            //         end;
            //     }
            //     action(TestReport)
            //     {
            //         Caption = 'Test Report';
            //         Ellipsis = true;
            //         Image = TestReport;
            //         Visible = false;

            //         trigger OnAction()
            //         begin
            //             ReportPrint.PrintPurchHeader(Rec);
            //         end;
            //     }
            //     action(PostAndPrint)
            //     {
            //         Caption = 'Post and &Print';
            //         Image = PostPrint;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         ShortCutKey = 'Shift+F9';
            //         Visible = false;

            //         trigger OnAction()
            //         begin
            //             Post(CODEUNIT::"Purch.-Post + Print");
            //         end;
            //     }
            //     action(PostBatch)
            //     {
            //         Caption = 'Post &Batch';
            //         Ellipsis = true;
            //         Image = PostBatch;
            //         Visible = false;

            //         trigger OnAction()
            //         begin
            //             REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices",TRUE,TRUE,Rec);
            //             CurrPage.UPDATE(FALSE);
            //         end;
            //     }
            //     action(RemoveFromJobQueue)
            //     {
            //         Caption = 'Remove From Job Queue';
            //         Image = RemoveLine;
            //         Visible = false;

            //         trigger OnAction()
            //         begin
            //             CancelBackgroundPosting;
            //         end;
            //     }
            //     action("St&ructure")
            //     {
            //         Caption = 'St&ructure';
            //         Image = Hierarchy;
            //         RunObject = Page 16305;
            //                         RunPageLink = Type=CONST(Purchase),
            //                       Document Type=FIELD(Document Type),
            //                       Document No.=FIELD(No.),
            //                       Structure Code=FIELD(Structure);
            //     }
            //     action("Transit Documents")
            //     {
            //         Caption = 'Transit Documents';
            //         Image = TransferOrder;
            //         RunObject = Page 13705;
            //                         RunPageLink = Type=CONST(Purchase),
            //                       PO / SO No.=FIELD(No.),
            //                       Vendor / Customer Ref.=FIELD(Buy-from Vendor No.);
            //         Visible = false;
            //     }
            //     action("Attached Gate Entry")
            //     {
            //         Caption = 'Attached Gate Entry';
            //         Image = InwardEntry;
            //         RunObject = Page 16481;
            //                         RunPageLink = Entry Type=CONST(Inward),
            //                       Purchase Invoice No.=FIELD(No.);
            //         Visible = false;
            //     }
            //     action("Detailed Tax")
            //     {
            //         Caption = 'Detailed Tax';
            //         Image = TaxDetail;
            //         RunObject = Page 16341;
            //                         RunPageLink = Document Type=FIELD(Document Type),
            //                       Document No.=FIELD(No.),
            //                       Transaction Type=CONST(Purchase);
            //     }
            //     action("Detailed GST")
            //     {
            //         Caption = 'Detailed GST';
            //         Image = ServiceTax;
            //         RunObject = Page 16412;
            //                         RunPageLink = Transaction Type=FILTER(Purchase),
            //                       Document Type=FIELD(Document Type),
            //                       Document No.=FIELD(No.);
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        // ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        // CurrPage.ApprovalFactBox.PAGE.RefreshPage(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        // SetControlAppearance;
        // SetLocGSTRegNoEditable;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        // EXIT(ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        // SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Vendor Type" := "Vendor Type"::"Internal Advocate";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // "Responsibility Center" := UserMgt.GetPurchasesFilter;
        // "Vendor Invoice Type" := "Vendor Invoice Type"::Legal;
    end;

    trigger OnOpenPage()
    begin
        //SetDocNoVisible;

        // IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
        //     FILTERGROUP(0);

        // SetLocGSTRegNoEditable;
    end;

    var
        // ChangeExchangeRate: Page 511;
        //                         CopyPurchDoc: Report 492;
        //                         MoveNegPurchLines: Report "6698";
        //                         ReportPrint: Codeunit "228";
        //                         UserMgt: Codeunit "5700";
        //                         GSTManagement: Codeunit "16401";
        //                         PurchLine: Record "39";
        //                         HasIncomingDocument: Boolean;
        //                         DocNoVisible: Boolean;
        //                         VendorInvoiceNoMandatory: Boolean;
        //                         OpenApprovalEntriesExist: Boolean;
        //                         OpenApprovalEntriesExistForCurrUser: Boolean;
        //                         ShowWorkflowStatus: Boolean;
        //                         GSTLocRegNo: Boolean;
        //                         IsRateChangeEnabled: Boolean;
        //                         Text004: Label 'Do you want to send for approval?';
        PurchHead: Record 38;
        Text0004: Label 'Do you want to forword Service Invoicel?';
        //ApprovalCommentLine: Record 50116;
        ApprovalUserGroup: Record 50091;
        ApprovalEntry: Record 454;
        "EntryNo.": Integer;
        AppuserGroupMem: Record 50091;
        Text0003: Label 'Do you want to approve invoice?';
        ApprovalEntry1: Record 454;
        Text0005: Label 'Do you want to reject invoice?';
        Usersetup: Record 91;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        Newline: Text;
        //NSheetTab: Record 50116;
        USetup: Record 91;
        SectCode: Code[10];
        SectUser: Code[20];
    // USetupList: Page "119";
    //                 NStTab: Record "50116";
    //                 SaveTxt: Text;
    //                 len: Integer;
    //                 Edtble: Boolean;
    //                 UserTab: Record "2000000120";
    //                 Char10: Char;
    //                 NoteSheetTab: Record "50116";
    //                 Entryno: Integer;
    //                 NoteshetTab: Record "50116";

    // procedure LineModified()
    // begin
    // end;

    // local procedure Post(PostingCodeunitID: Integer)
    // begin
    //     SendToPosting(PostingCodeunitID);
    //     IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
    //         CurrPage.CLOSE;
    //     CurrPage.UPDATE(FALSE);
    // end;

    // local procedure ApproveCalcInvDisc()
    // begin
    //     CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    // end;

    // local procedure SaveInvoiceDiscountAmount()
    // var
    //     DocumentTotals: Codeunit "57";
    // begin
    //     CurrPage.SAVERECORD;
    //     DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
    //     CurrPage.UPDATE(FALSE);
    // end;

    // local procedure BuyfromVendorNoOnAfterValidate()
    // begin
    //     IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
    //         IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
    //             SETRANGE("Buy-from Vendor No.");
    //     CurrPage.UPDATE;
    // end;

    // local procedure PurchaserCodeOnAfterValidate()
    // begin
    //     CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    // end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    // local procedure PricesIncludingVATOnAfterValid()
    // begin
    //     CurrPage.UPDATE;
    // end;

    // local procedure SetDocNoVisible()
    // var
    //     DocumentNoVisibility: Codeunit "1400";
    //     DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    // begin
    //     DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, "No.");
    // end;

    // local procedure SetExtDocNoMandatoryCondition()
    // var
    //     PurchasesPayablesSetup: Record "312";
    // begin
    //     PurchasesPayablesSetup.GET;
    //     VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    // end;

    // local procedure SetControlAppearance()
    // var
    //     ApprovalsMgmt: Codeunit "1535";
    // begin
    //     HasIncomingDocument := "Incoming Document Entry No." <> 0;
    //     SetExtDocNoMandatoryCondition;

    //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    // end;

    // local procedure SetLocGSTRegNoEditable()
    // begin
    //     IF GSTManagement.IsGSTApplicable(Structure) THEN
    //         IF "Location Code" <> '' THEN
    //             GSTLocRegNo := FALSE
    //         ELSE
    //             GSTLocRegNo := TRUE;

    //     IsRateChangeEnabled := "Rate Change Applicable";
    // end;
}

