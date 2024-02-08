page 50180 "Payment Proposal"
{
    Caption = 'Payment Proposal';
    DeleteAllowed = false;
    InsertAllowed = True;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approve';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER('Invoice'), "Proposal Status" = CONST(Open),
                       "Payment Proposal Created" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetLocGSTRegNoEditable;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Structure; Rec.Structure)
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetLocGSTRegNoEditable;
                    end;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Editable = false;

                    ApplicationArea = All;
                }
                field("Proposal Status"; Rec."Proposal Status")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Transfer User Id"; Rec."Transfer User Id")
                {

                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        ApprovalUserGroup.RESET;
                        ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'PAYPROPOSAL');
                        ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User ID", '<>%1', USERID);
                        IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
                            Rec."Transfer User Id" := ApprovalUserGroup."User ID";
                            Rec."Transfer User Name" := ApprovalUserGroup."User Full Name";
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        IF Rec."Transfer User Id" = '' THEN
                            Rec."Transfer User Name" := '';
                    end;
                }
                field("Transfer User Name"; Rec."Transfer User Name")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Payment Proposal Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }

            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {

                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }

                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF Rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            SaveInvoiceDiscountAmount;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }

            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                }
            }
            group("Tax Information") //nitin 07-08-2023
            {
                Caption = 'Tax Information';
                field("Location State Code"; Rec."Location State Code")
                {
                }
                field("Location GST Reg. No."; Rec."Location GST Reg. No.")
                {
                    Editable = GSTLocRegNo;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                }
                field("GST Input Service Distribution"; Rec."GST Input Service Distribution")
                {
                }
                field("Associated Enterprises"; Rec."Associated Enterprises")
                {
                }
                field("Without Bill Of Entry"; Rec."Without Bill Of Entry")
                {
                }
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    Importance = Additional;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    Importance = Additional;
                }
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    Importance = Additional;
                }
                field("GST Order Address State"; Rec."GST Order Address State")
                {
                    Editable = false;
                }
                field("Order Address GST Reg. No."; Rec."Order Address GST Reg. No.")
                {
                }
                field("Vendor GST Reg. No."; Rec."Vendor GST Reg. No.")
                {
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Visible = false;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Visible = false;
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; 9103)
            {
                Caption = 'Pending Approval';
                SubPageLink = "Table ID" = CONST(38),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox; 9092)
            {
                Visible = false;
            }
            part("Vendor Details Factbox"; 9093)
            {
                Caption = 'Vendor Details';
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
            }
            part("Vendor Statistics Factbox"; 9094)
            {
                Caption = 'Vendor Statistics';
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
            }
            part("Vendor History Buy From Factbox"; 9095)
            {
                Caption = 'Vendor Histyr -Buy from';
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("9096"; 9096)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part("9100"; 9100)
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No."),
                                  "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(WorkflowStatus; 1528)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            //             group("&Invoice")
            //             {
            //                 Caption = '&Invoice';
            //                 Image = Invoice;
            //                 action(Statistics)
            //                 {
            //                     Caption = 'Payment Proposal Statistics';
            //                     Image = Statistics;
            //                     Promoted = true;
            //                     PromotedCategory = Process;
            //                     ShortCutKey = 'F7';

            //                     trigger OnAction()
            //                     begin
            //                         CalcInvDiscForHeader;
            //                         COMMIT;
            //                         IF Structure <> '' THEN BEGIN
            //                             PurchLine.CalculateStructures(Rec);
            //                             PurchLine.AdjustStructureAmounts(Rec);
            //                             PurchLine.UpdatePurchLines(Rec);
            //                             PurchLine.CalculateTDS(Rec);
            //                             PurchLine.UpdatePurchLines(Rec);
            //                             COMMIT;
            //                         END ELSE BEGIN
            //                             PurchLine.CalculateTDS(Rec);
            //                             PurchLine.UpdatePurchLines(Rec);
            //                             COMMIT;
            //                         END;
            //                         //PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
            //                         PAGE.RUNMODAL(PAGE::"Payment Proposal Statistics", Rec);
            //                     end;
            //                 }
            //                 action("Calculation Sheet")
            //                 {
            //                     Promoted = true;

            //                     trigger OnAction()
            //                     begin
            //                         //kamlesh date 07-02-2023
            //                         // PurchHead.RESET;
            //                         // PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
            //                         // PurchHead.SETRANGE("No.","No.");
            //                         // IF PurchHead.FINDFIRST THEN
            //                         //   REPORT.RUN(50009,TRUE,TRUE,PurchHead);
            //                         //end kamlesh date 07-02-2023
            //                     end;
            //                 }
            //                 action(Vendor)
            //                 {
            //                     Caption = 'Vendor';
            //                     Image = Vendor;
            //                     RunObject = Page 26;
            //                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
            //                     ShortCutKey = 'Shift+F7';
            //                 }
            action("Note &Sheet")
            {
                Caption = 'Note &Sheet';
                Image = ViewComments;
                Promoted = true;

                trigger OnAction()
                begin
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id", 38);
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", Rec."No.");
                    PAGE.RUN(PAGE::"Notesheet List", ApprovalCommentLine);
                end;
            }
            action("View Note Sheet")
            {
                Visible = true;

                trigger OnAction()
                begin
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", Rec."No.");
                    PAGE.RUN(PAGE::"NoteSheet Display", ApprovalCommentLine);
                end;
            }
            //                 action(Dimensions)
            //                 {
            //                     AccessByPermission = TableData 348 = R;
            //                     Caption = 'Dimensions';
            //                     Image = Dimensions;
            //                     ShortCutKey = 'Shift+Ctrl+D';

            //                     trigger OnAction()
            //                     begin
            //                         ShowDocDim;
            //                         CurrPage.SAVERECORD;
            //                     end;
            //                 }

            //                 action("Attatch Document")
            //                 {
            //                     Image = Attach;
            //                     Promoted = true;
            //                     PromotedCategory = Process;
            //                     PromotedIsBig = true;

            //                     trigger OnAction()
            //                     begin
            //                         /*
            //                         FilePath := 'C:\Requistion\';
            //                         OldFileName:=(FilePath + Attachment);
            //                         ServerFileName:=FileManagement.UploadFile(DialogTitle,'');
            //                         ClientFileName:=FileManagement.GetFileName(ServerFileName);
            //                         FileExtension:=FileManagement.GetExtension(ClientFileName);
            //                         IF ClientFileName <> '' THEN BEGIN
            //                           Attachment:=DELCHR("No.",'=','/') + '.'+FileExtension;
            //                           MODIFY(TRUE);
            //                          END ELSE
            //                           BEGIN
            //                           Attachment:='';
            //                           MODIFY(TRUE);
            //                         END;

            //                         ClientFileName := FilePath + DELCHR("No.",'=','/')+'.'+FileExtension;
            //                         FileManagement.CopyServerFile(ServerFileName,ClientFileName,TRUE);
            //                         IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
            //                           FileManagement.DeleteServerFile(OldFileName);


            //                         */
            //                         IF Attachment <> '' THEN
            //                             IF NOT CONFIRM('Document is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
            //                         FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchInvoice\';
            //                         OldFileName := (FilePath + Attachment);
            //                         ServerFileName := FileManagement.UploadFile(DialogTitle, '');
            //                         ClientFileName := FileManagement.GetFileName(ServerFileName);
            //                         IF ClientFileName <> '' THEN BEGIN
            //                             Attachment := DELCHR("No.", '=', '/') + ClientFileName;
            //                             MODIFY(TRUE);
            //                         END;
            //                         ClientFileName := FilePath + Attachment;
            //                         FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
            //                         IF OldFileName <> '' THEN
            //                             FileManagement.DeleteServerFile(OldFileName);
            //                         //MESSAGE('Upload successfully');

            //                     end;
            //                 }
            action("View attachment")
            {
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FilePath := 'http://115.243.18.40/bseb_ftp/PurchInvoice/';
                    //   IF Attachment <> '' THEN BEGIN
                    //       OldFileName := Attachment;
                    //          ServerFileName := FilePath + Attachment;
                    //          HYPERLINK(ServerFileName);
                    //    END;
                end;
            }
            //   }
            //  }





            //             group("F&unctions")
            //             {
            //                 Caption = 'F&unctions';
            //                 Image = "Action";
            //                 action("Calculate &Invoice Discount")
            //                 {
            //                     AccessByPermission = TableData 24 = R;
            //                     Caption = 'Calculate &Invoice Discount';
            //                     Image = CalculateInvoiceDiscount;

            //                     trigger OnAction()
            //                     begin
            //                         ApproveCalcInvDisc;
            //                     end;
            //                 }
            //                 separator(separator2)
            //                 {
            //                     Caption = '';
            //                 }
            //                 action("Get St&d. Vend. Purchase Codes")
            //                 {
            //                     Caption = 'Get St&d. Vend. Purchase Codes';
            //                     Ellipsis = true;
            //                     Image = VendorCode;
            //                     Visible = false;

            //                     trigger OnAction()
            //                     var
            //                         StdVendPurchCode: Record 175;
            //                     begin
            //                         StdVendPurchCode.InsertPurchLines(Rec);
            //                     end;
            //                 }
            //                 action("Get Gate Entry Lines")
            //                 {
            //                     Caption = 'Get Gate Entry Lines';
            //                     Image = GetLines;
            //                     Visible = false;

            //                     trigger OnAction()
            //                     begin
            //                         GetGateEntryLines;
            //                     end;
            //                 }




            //                 group(IncomingDocument)
            //                 {
            //                     Caption = 'Incoming Document';
            //                     Image = Documents;
            //                     action(IncomingDocCard)
            //                     {
            //                         Caption = 'View Incoming Document';
            //                         Enabled = HasIncomingDocument;
            //                         Image = ViewOrder;
            //                         //The property 'ToolTip' cannot be empty.
            //                         //ToolTip = '';

            //                         trigger OnAction()
            //                         var
            //                             IncomingDocument: Record 130;
            //                         begin
            //                             IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
            //                         end;
            //                     }
            //                     action(SelectIncomingDoc)
            //                     {
            //                         AccessByPermission = TableData 130 = R;
            //                         Caption = 'Select Incoming Document';
            //                         Image = SelectLineToApply;
            //                         //The property 'ToolTip' cannot be empty.
            //                         //ToolTip = '';

            //                         trigger OnAction()
            //                         var
            //                             IncomingDocument: Record 130;
            //                         begin
            //                             VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
            //                         end;
            //                     }
            action(IncomingDocAttachFile)
            {
                Caption = 'Create Incoming Document from File';
                Ellipsis = true;
                Enabled = NOT HasIncomingDocument;
                Image = Attach;
                //                         //The property 'ToolTip' cannot be empty.
                //                         //ToolTip = '';

                trigger OnAction()
                var
                    IncomingDocumentAttachment: Record 133;
                begin
                    IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                end;
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin


                        Rec.TESTFIELD("Proposal Status", Rec."Proposal Status"::Open);
                        IF NOT CONFIRM(Text004) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");

                        NoteshettabFin.RESET;
                        NoteshettabFin.SETRANGE(NoteshettabFin."Document No.", Rec."No.");
                        IF NOT NoteshettabFin.FINDFIRST THEN
                            ERROR('Please create note sheet in Invoice');
                        NoteshetTab.RESET;
                        NoteshetTab.SETRANGE("Document No.", Rec."No.");
                        IF NoteshetTab.FIND('-') THEN BEGIN
                            Entryno := NoteshetTab."Last Entry No." + 1;
                            NoteshetTab.CALCFIELDS("Running Note");
                            IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
                                NoteshetTab."Running Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(NsheetOld);
                            END;
                            NoteshetTab.CALCFIELDS("Current Note");

                            IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
                                NoteshetTab."Current Note".CREATEINSTREAM(Isstream, TEXTENCODING::UTF16);
                                Isstream.READ(Nsheet);
                            END;
                            Char10 := 10;
                            NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm, TEXTENCODING::UTF16);
                            IF Nsheet <> '' THEN BEGIN
                                IF NsheetOld <> '' THEN BEGIN
                                    SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                END
                                ELSE
                                    SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END
                            ELSE BEGIN

                                SaveTxt := NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  ';
                                len := STRLEN(SaveTxt);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                SaveTxt := INSSTR(SaveTxt, '         ', len + 2);
                                UserTab.RESET;
                                UserTab.SETRANGE(UserTab."User Name", USERID);
                                IF UserTab.FINDFIRST THEN
                                    IF UserTab."Designation Name" <> '' THEN
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + UserTab."Designation Name" + '  Dt.-' + FORMAT(CURRENTDATETIME)
                                    ELSE
                                        SaveTxt += USERID + '(' + UserTab."Full Name" + ')' + '  Dt.-' + FORMAT(CURRENTDATETIME);
                                SaveTxt += FORMAT(Char10) + FORMAT(Char10);
                                ostrm.WRITE(SaveTxt);
                                IF NoteshetTab.MODIFY THEN BEGIN
                                    NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1, TEXTENCODING::UTF16);
                                    //ostrm1.WRITETEXT();
                                    NoteshetTab."Last Entry No." := Entryno;
                                    ostrm1.WRITE('');
                                    NoteshetTab.MODIFY;
                                END;
                            END;
                        END;
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Table ID", 38);
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        IF ApprovalEntry.FINDFIRST THEN
                            ERROR(Text0001, Rec."No.");
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::Invoice;
                        ApprovalEntry."Table ID" := 38;
                        ApprovalEntry."Document No." := Rec."No.";
                        ApprovalEntry."Sequence No." := 1;
                        ApprovalEntry."Sender ID" := USERID;
                        ApprovalEntry."Approver ID" := Rec."Transfer User Id";
                        ApprovalEntry.Status := ApprovalEntry.Status::Open;
                        ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
                        ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
                        ApprovalEntry."Last Modified By User ID" := USERID;
                        ApprovalEntry.VALIDATE("Location Code", Rec."Location Code");
                        ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        ApprovalEntry."Record ID to Approve" := Rec.RECORDID;
                        ApprovalEntry.INSERT;

                        PurchHead.RESET;
                        PurchHead.SETRANGE(PurchHead."Document Type", PurchHead."Document Type"::Invoice);
                        PurchHead.SETRANGE(PurchHead."No.", Rec."No.");
                        IF PurchHead.FINDFIRST THEN BEGIN
                            PurchHead."Proposal Status" := PurchHead."Proposal Status"::"Pending Approval";
                            PurchHead."Pending To User ID" := Rec."Transfer User Id";
                            PurchHead."Pending To User Name" := Rec."Transfer User Name";
                            PurchHead."Transfer User Id" := '';
                            PurchHead."Transfer User Name" := '';
                            PurchHead.MODIFY;
                        END;

                        CurrPage.CLOSE;

                    end;
                }
            }
            //                
            //            // }
            //             group("P&osting")
            //             {
            //                 Caption = 'P&osting';
            //                 Image = Post;
            //                 action(Post)
            //                 {
            //                     Caption = 'P&ost';
            //                     Image = PostOrder;
            //                     Promoted = true;
            //                     PromotedCategory = Process;
            //                     PromotedIsBig = true;
            //                     ShortCutKey = 'F9';
            //                     Visible = false;

            //                     trigger OnAction()
            //                     begin
            //                         Post(CODEUNIT::"Purch.-Post (Yes/No)");
            //                     end;
            //                 }
            //                 action(Preview)
            //                 {
            //                     Caption = 'Preview Posting';
            //                     Image = ViewPostedOrder;
            //                     Visible = false;

            //                     trigger OnAction()
            //                     var
            //                         PurchPostYesNo: Codeunit 91;
            //                     begin
            //                         PurchPostYesNo.Preview(Rec);
            //                     end;
            //                 }
            //                 action(TestReport)
            //                 {
            //                     Caption = 'Test Report';
            //                     Ellipsis = true;
            //                     Image = TestReport;

            //                     trigger OnAction()
            //                     begin
            //                         ReportPrint.PrintPurchHeader(Rec);
            //                     end;
            //                 }
            //                 action(PostAndPrint)
            //                 {
            //                     Caption = 'Post and &Print';
            //                     Image = PostPrint;
            //                     Promoted = true;
            //                     PromotedCategory = Process;
            //                     PromotedIsBig = true;
            //                     ShortCutKey = 'Shift+F9';
            //                     Visible = false;

            //                     trigger OnAction()
            //                     begin
            //                         Post(CODEUNIT::"Purch.-Post + Print");
            //                     end;
            //                 }
            //                 action(PostBatch)
            //                 {
            //                     Caption = 'Post &Batch';
            //                     Ellipsis = true;
            //                     Image = PostBatch;
            //                     Visible = false;

            //                     trigger OnAction()
            //                     begin
            //                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
            //                         CurrPage.UPDATE(FALSE);
            //                     end;
            //                 }
            //                 action(RemoveFromJobQueue)
            //                 {
            //                     Caption = 'Remove From Job Queue';
            //                     Image = RemoveLine;
            //                     Visible = false;

            //                     trigger OnAction()
            //                     begin
            //                         CancelBackgroundPosting;
            //                     end;
            //                 }
            //                 action("St&ructure")
            //                 {
            //                     Caption = 'St&ructure';
            //                     Image = Hierarchy;
            //                     //kamlesh Date 07-01-2023
            //                     // RunObject = Page 16305;
            //                     // RunPageLink = Type = CONST('Purchase'),
            //                     //               "Document Type" = FIELD("Document Type"),
            //                     //               "Document No." = FIELD("No."),
            //                     //               "Structure Code" = FIELD(Structure);
            //                     //kamlesh end
            //                 }
            //                 action("Transit Documents")
            //                 {
            //                     Caption = 'Transit Documents';
            //                     Image = TransferOrder;
            //                     //kamlesh date 07-02-2023
            //                     // RunObject = Page 13705;
            //                     // RunPageLink = Type = CONST(Purchase),
            //                     //               "PO / SO No." = FIELD("No."),
            //                     //               "Vendor / Customer Ref." = FIELD("Buy-from Vendor No.");
            //                     // Visible = false;
            //                     //kamlesh end
            //                 }
            //                 action("Attached Gate Entry")
            //                 {
            //                     Caption = 'Attached Gate Entry';
            //                     Image = InwardEntry;
            //                     //kamlesh date - 07-02-2023
            //                     // RunObject = Page 16481;
            //                     // RunPageLink = "Entry Type" = CONST('Inward'),
            //                     //               "Purchase Invoice No." = FIELD("No.");
            //                     // Visible = false;
            //                     // kamlesh end
            //                 }


            //             }
            //         }
            //     }

            //     trigger OnAfterGetCurrRecord()
            //     begin
            //         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
            //         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
            //         CurrPage.ApprovalFactBox.PAGE.RefreshPage(RECORDID);
            //     end;

            //     trigger OnAfterGetRecord()
            //     begin
            //         SetControlAppearance;
            //         SetLocGSTRegNoEditable;
            //     end;

            //     trigger OnDeleteRecord(): Boolean
            //     begin
            //         CurrPage.SAVERECORD;
            //         EXIT(ConfirmDeletion);
            //     end;

            //     trigger OnInit()
            //     begin
            //         SetExtDocNoMandatoryCondition;
            //     end;

            //     trigger OnNewRecord(BelowxRec: Boolean)
            //     begin
            //         "Responsibility Center" := UserMgt.GetPurchasesFilter;
            //     end;

            //     trigger OnOpenPage()
            //     begin
            //         SetDocNoVisible;

            //         IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            //             FILTERGROUP(2);
            //             SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            //             FILTERGROUP(0);
            //         END;
            //         SetLocGSTRegNoEditable;
            //         IF "Agreement Done" THEN BEGIN
            //             AgreeRemVisible := FALSE;
            //         END ELSE BEGIN
            //             AgreeRemVisible := TRUE;
            //         END;
            //     end;
        }
    }
    trigger OnInsertRecord(Xrec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."Payment Proposal Created" := True;
    end;

    var
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        MoveNegPurchLines: Report 6698;
        ReportPrint: Codeunit 228;
        UserMgt: Codeunit 5700;
        // GSTManagement: Codeunit 16401; //kamlesh date 07-02-2023
        // GSTManagement: Codeunit gst;
        PurchLine: Record 39;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        UserSetup: Record 91;
        AgreeRemVisible: Boolean;
        Text004: Label 'Do you want to send for approval ?';
        PurchHead: Record 38;
        ServerFileName: Text;
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
        OldFileName: Text;
        FilePath: Text;
        FileExtension: Text;
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50082;
        ApprovalEntry: Record 454;
        Text0001: Label 'Payment Proposal No.  %1 allready pending for approval.';
        "EntryNo.": Integer;
        NoteshettabFin: Record 50084;
        Nsheet: Text;
        ostrm: OutStream;
        Isstream: InStream;
        NsheetOld: Text;
        ostrm1: OutStream;
        Newline: Text;
        NSheetTab: Record 50084;
        USetup: Record 91;
        SectCode: Code[10];
        SectUser: Code[20];
        USetupList: Page 119;
        NStTab: Record 50084;
        SaveTxt: Text;
        len: Integer;
        Edtble: Boolean;
        UserTab: Record "User BOC";
        Char10: Char;
        NoteSheetTab: Record 50084;
        Entryno: Integer;
        NoteshetTab: Record 50084;




    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit 57;
    begin
        CurrPage.SAVERECORD;
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    //     local procedure PurchaserCodeOnAfterValidate()
    //     begin
    //         CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    //     end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    //     local procedure ShortcutDimension1CodeOnAfterV()
    //     begin
    //         CurrPage.UPDATE;
    //     end;

    //     local procedure ShortcutDimension2CodeOnAfterV()
    //     begin
    //         CurrPage.UPDATE;
    //     end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    //     local procedure SetDocNoVisible()
    //     var
    //         DocumentNoVisibility: Codeunit "1400";
    //         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    //     begin
    //         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, "No.");
    //     end;

    //     local procedure SetExtDocNoMandatoryCondition()
    //     var
    //         PurchasesPayablesSetup: Record 312;
    //     begin
    //         PurchasesPayablesSetup.GET;
    //         VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    //     end;

    //     local procedure SetControlAppearance()
    //     var
    //         ApprovalsMgmt: Codeunit "1535";
    //     begin
    //         HasIncomingDocument := "Incoming Document Entry No." <> 0;
    //         SetExtDocNoMandatoryCondition;

    //         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    //         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    //     end;

    local procedure SetLocGSTRegNoEditable()
    begin
        // IF GSTManagement.IsGSTApplicable(Structure) THEN //kamlesh date 08-02-2023
        //     IF "Location Code" <> '' THEN
        //         GSTLocRegNo := FALSE
        //     ELSE
        //         GSTLocRegNo := TRUE;

        IsRateChangeEnabled := Rec."Rate Change Applicable";//Nitin 07-08-2023
    end;

}

