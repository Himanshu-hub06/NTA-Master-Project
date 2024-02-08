// page 50666 "Pending Payment Proposal"
// {
//     Caption = 'Payment Proposal Upword';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve';
//     RefreshOnActivate = true;
//     SourceTable = 38;
//     SourceTableView = WHERE("Document Type" = FILTER('Invoice'),
//                             "Proposal Status" = CONST("Pending Approval"),
//                             "Payment Proposal Created" = CONST(true));

//     layout
//     {
//         /*
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; "No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Location Code"; "Location Code")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SetLocGSTRegNoEditable;
//                     end;
//                 }
//                 field("Buy-from Vendor No."; "Buy-from Vendor No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Vendor Name"; "Buy-from Vendor Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Buy-from Address"; "Buy-from Address")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Address 2"; "Buy-from Address 2")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Post Code"; "Buy-from Post Code")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from City"; "Buy-from City")
//                 {
//                     Editable = false;
//                 }
//                 field(Structure; Structure)
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         SetLocGSTRegNoEditable;
//                     end;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SaveInvoiceDiscountAmount;
//                     end;
//                 }
//                 field("Document Date"; "Document Date")
//                 {
//                     Editable = false;
//                 }
//                 field("Incoming Document Entry No."; "Incoming Document Entry No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Vendor Invoice No."; "Vendor Invoice No.")
//                 {
//                     Editable = false;
//                     ShowMandatory = VendorInvoiceNoMandatory;
//                 }
//                 field("Proposal Status"; "Proposal Status")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Transfer User Id"; "Transfer User Id")
//                 {

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         ApprovalUserGroup.RESET;
//                         ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code", 'PAYPROPOSAL');
//                         ApprovalUserGroup.SETFILTER(ApprovalUserGroup."User Name", '<>%1', USERID);
//                         IF PAGE.RUNMODAL(0, ApprovalUserGroup) = ACTION::LookupOK THEN BEGIN
//                             "Transfer User Id" := ApprovalUserGroup."User Name";
//                             "Transfer User Name" := ApprovalUserGroup."User Description";
//                         END;
//                     end;

//                     trigger OnValidate()
//                     begin
//                         IF "Transfer User Id" = '' THEN
//                             "Transfer User Name" := '';
//                     end;
//                 }
//                 field("Transfer User Name"; "Transfer User Name")
//                 {
//                 }
//             }
//             part(PurchLines; 50351)
//             {
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group("Other Information")
//             {
//                 Caption = 'Other Information';
//                 field("Stock Entry as Per Invoice"; "Stock Entry as Per Invoice")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Work Order No."; "Work Order No.")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Work Order Date"; "Work Order Date")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Agreement Done"; "Agreement Done")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         IF "Agreement Done" THEN BEGIN
//                             AgreeRemVisible := FALSE;
//                         END ELSE BEGIN
//                             AgreeRemVisible := TRUE;
//                         END;
//                     end;
//                 }
//                 field("Agreement Date"; "Agreement Date")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Agreement Remarks"; "Agreement Remarks")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                     Visible = AgreeRemVisible;
//                 }
//                 field("According to Agreement"; "According to Agreement")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Penalty Clause Seen"; "Penalty Clause Seen")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Performance Guarantee Seen"; "Performance Guarantee Seen")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Agreement Valid Till Date"; "Agreement Valid Till Date")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Issuing Bank Code"; "Issuing Bank Code")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Issuing Bank Name"; "Issuing Bank Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Performance Guarantee Date"; "Performance Guarantee Date")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Perfor. Guar. Valid Till Date"; "Perfor. Guar. Valid Till Date")
//                 {
//                     Caption = 'Performance Guarantee Valid Till Date';
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Performance Guarantee Amount"; "Performance Guarantee Amount")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("BG/DD No./RTGS No."; "BG/DD No./RTGS No.")
//                 {
//                     Editable = false;
//                 }
//                 field("According To Time Delivery"; "According To Time Delivery")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Quantity Verify"; "Quantity Verify")
//                 {
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Quality Test Report"; "Quality Test Report")
//                 {
//                     Editable = false;
//                 }
//                 field("GSM Test"; "GSM Test")
//                 {
//                     Editable = false;
//                 }
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 Visible = false;
//                 field("Pay-to Vendor No."; "Pay-to Vendor No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; "Pay-to Contact No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Name"; "Pay-to Name")
//                 {
//                 }
//                 field("Pay-to Address"; "Pay-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Address 2"; "Pay-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Post Code"; "Pay-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to City"; "Pay-to City")
//                 {
//                 }
//                 field("Pay-to Contact"; "Pay-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Terms Code"; "Payment Terms Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; "Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; "Payment Discount %")
//                 {
//                 }
//                 field("Pmt. Discount Date"; "Pmt. Discount Date")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Method Code"; "Payment Method Code")
//                 {
//                 }
//                 field("Payment Reference"; "Payment Reference")
//                 {
//                 }
//                 field("Creditor No."; "Creditor No.")
//                 {
//                 }
//                 field("On Hold"; "On Hold")
//                 {
//                 }
//                 field("Prices Including VAT"; "Prices Including VAT")
//                 {

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
//                 {
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 Visible = false;
//                 field("Ship-to Name"; "Ship-to Name")
//                 {
//                 }
//                 field("Ship-to Address"; "Ship-to Address")
//                 {
//                 }
//                 field("Ship-to Address 2"; "Ship-to Address 2")
//                 {
//                 }
//                 field("Ship-to Post Code"; "Ship-to Post Code")
//                 {
//                 }
//                 field("Ship-to City"; "Ship-to City")
//                 {
//                 }
//                 field("Ship-to Contact"; "Ship-to Contact")
//                 {
//                 }
//                 field("Transit Document"; "Transit Document")
//                 {
//                 }
//                 field("Shipment Method Code"; "Shipment Method Code")
//                 {
//                 }
//                 field("Expected Receipt Date"; "Expected Receipt Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Bill to-Location(POS)"; "Bill to-Location(POS)")
//                 {
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 Visible = false;
//                 field("Currency Code"; "Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF "Posting Date" <> 0D THEN
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
//                         ELSE
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             SaveInvoiceDiscountAmount;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;
//                 }
//                 field("Transaction Type"; "Transaction Type")
//                 {
//                 }
//                 field("Transaction Specification"; "Transaction Specification")
//                 {
//                 }
//                 field("Transport Method"; "Transport Method")
//                 {
//                 }
//                 field("Entry Point"; "Entry Point")
//                 {
//                 }
//                 field(Area;Area)
//         {
//         }
//         */
//     }

//             group(Application)
//             {
//                 Caption = 'Application';
//                 field("Applies-to Doc. Type";"Applies-to Doc. Type")
//                 {
//                 }
//                 field("Applies-to Doc. No.";"Applies-to Doc. No.")
//                 {
//                 }
//                 field("Applies-to ID";"Applies-to ID")
//                 {
//                 }
//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Location State Code";"Location State Code")
//                 {
//                 }
//                 field("Location GST Reg. No.";"Location GST Reg. No.")
//                 {
//                     Editable = GSTLocRegNo;
//                 }
//                 field("GST Vendor Type";"GST Vendor Type")
//                 {
//                 }
//                 field("Invoice Type";"Invoice Type")
//                 {
//                 }
//                 field("GST Input Service Distribution";"GST Input Service Distribution")
//                 {
//                 }
//                 field("Associated Enterprises";"Associated Enterprises")
//                 {
//                 }
//                 field("Without Bill Of Entry";"Without Bill Of Entry")
//                 {
//                 }
//                 field("Bill of Entry No.";"Bill of Entry No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill of Entry Date";"Bill of Entry Date")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill of Entry Value";"Bill of Entry Value")
//                 {
//                     Importance = Additional;
//                 }
//                 field("GST Order Address State";"GST Order Address State")
//                 {
//                     Editable = false;
//                 }
//                 field("Order Address GST Reg. No.";"Order Address GST Reg. No.")
//                 {
//                 }
//                 field("Vendor GST Reg. No.";"Vendor GST Reg. No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Vehicle No.";"Vehicle No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Vehicle Type";"Vehicle Type")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipping Agent Code";"Shipping Agent Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipping Agent Service Code";"Shipping Agent Service Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Distance (Km)";"Distance (Km)")
//                 {
//                     Visible = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(;9103)
//             {
//                 SubPageLink = Table ID=CONST(38),
//                               Document Type=FIELD(Document Type),
//                               Document No.=FIELD(No.);
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(ApprovalFactBox;9092)
//             {
//                 Visible = false;
//             }
//             part(;9093)
//             {
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = false;
//             }
//             part(IncomingDocAttachFactBox;193)
//             {
//                 ShowFilter = false;
//             }
//             part(;9094)
//             {
//                 SubPageLink = No.=FIELD(Pay-to Vendor No.);
//                 Visible = true;
//             }
//             part(;9095)
//             {
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = true;
//             }
//             part(;9096)
//             {
//                 SubPageLink = No.=FIELD(Pay-to Vendor No.);
//                 Visible = false;
//             }
//             part(;9100)
//             {
//                 Provider = PurchLines;
//                 SubPageLink = Document Type=FIELD(Document Type),
//                               Document No.=FIELD(Document No.),
//                               Line No.=FIELD(Line No.);
//                 Visible = false;
//             }
//             part(WorkflowStatus;1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(;Links)
//             {
//                 Visible = false;
//             }
//             systempart(;Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
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
//                           PurchLine.CalculateStructures(Rec);
//                           PurchLine.AdjustStructureAmounts(Rec);
//                           PurchLine.UpdatePurchLines(Rec);
//                           PurchLine.CalculateTDS(Rec);
//                           PurchLine.UpdatePurchLines(Rec);
//                           COMMIT;
//                         END ELSE BEGIN
//                           PurchLine.CalculateTDS(Rec);
//                           PurchLine.UpdatePurchLines(Rec);
//                           COMMIT;
//                         END;
//                         //PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
//                         PAGE.RUNMODAL(PAGE::"Payment Proposal Statistics",Rec);//EXP
//                     end;
//                 }
//                 action("Calculation Sheet")
//                 {
//                     Promoted = true;

//                     trigger OnAction()
//                     begin
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
//                         PurchHead.SETRANGE("No.","No.");
//                         IF PurchHead.FINDFIRST THEN
//                           REPORT.RUN(50009,TRUE,TRUE,PurchHead);
//                     end;
//                 }
//                 action(Vendor)
//                 {
//                     Caption = 'Vendor';
//                     Image = Vendor;
//                     RunObject = Page 26;
//                                     RunPageLink = No.=FIELD(Buy-from Vendor No.);
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action("Note &Sheet")
//                 {
//                     Caption = 'Note &Sheet';
//                     Image = ViewComments;
//                     Promoted = true;

//                     trigger OnAction()
//                     begin

//                         ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Table Id",38);
//                         ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.","No.");
//                         PAGE.RUN(PAGE::"Notesheet List",ApprovalCommentLine);
//                     end;
//                 }
//                 action("View Note Sheet")
//                 {
//                     Visible = true;

//                     trigger OnAction()
//                     begin

//                         ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.","No.");
//                         PAGE.RUN(PAGE::"NoteSheet Display",ApprovalCommentLine);
//                     end;
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348=R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "658";
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
//                         ApprovalEntries.RUN;
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
//                           IF NOT CONFIRM('Document is already uploaded. Do you want to replace it?',FALSE,TRUE) THEN EXIT;
//                         FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchInvoice\';
//                         OldFileName:=(FilePath + Attachment);
//                         ServerFileName:= FileManagement.UploadFile(DialogTitle,'');
//                         ClientFileName:= FileManagement.GetFileName(ServerFileName);
//                         IF ClientFileName <> '' THEN BEGIN
//                            Attachment := DELCHR("No.",'=','/')+ClientFileName;
//                            MODIFY(TRUE);
//                          END;
//                         ClientFileName := FilePath + Attachment;
//                         FileManagement.CopyServerFile(ServerFileName,ClientFileName,TRUE);
//                         IF OldFileName <> '' THEN
//                           FileManagement.DeleteServerFile(OldFileName);
//                         //MESSAGE('Upload successfully');

//                     end;
//                 }
//                 action("View attachment")
//                 {
//                     Promoted = true;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         FilePath := 'http://115.243.18.40/bseb_ftp/PurchInvoice/';
//                         IF Attachment <> '' THEN BEGIN
//                           OldFileName:= Attachment;
//                           ServerFileName:= FilePath + Attachment;
//                           HYPERLINK(ServerFileName);
//                         END;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         //ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID)
//                         TESTFIELD("Transfer User Id");
//                         AppuserGroupMem.RESET;
//                         AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval User Group Code",'PAYPROPOSAL');
//                         AppuserGroupMem.SETRANGE(AppuserGroupMem."User Name",USERID);
//                         AppuserGroupMem.SETRANGE(AppuserGroupMem."Approval Permission",FALSE);
//                         IF AppuserGroupMem.FINDFIRST THEN
//                            ERROR('You do not have permision to approve Payment Proposal');
//                         IF NOT CONFIRM(Text0003) THEN
//                             EXIT;

//                         NoteshettabFin.RESET;
//                         NoteshettabFin.SETRANGE(NoteshettabFin."Document No.","No.");
//                         IF NOT NoteshettabFin.FINDFIRST THEN
//                           ERROR('Please create note sheet in Invoice');
//                         NoteshetTab.RESET;
//                         NoteshetTab.SETRANGE("Document No.","No.");
//                         IF NoteshetTab.FIND('-') THEN BEGIN
//                           Entryno := NoteshetTab."Last Entry No." + 1;
//                           NoteshetTab.CALCFIELDS("Running Note");
//                           IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
//                             NoteshetTab."Running Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
//                             Isstream.READ(NsheetOld);
//                          END;
//                           NoteshetTab.CALCFIELDS("Current Note");

//                           IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
//                              NoteshetTab."Current Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
//                              Isstream.READ(Nsheet);
//                           END;
//                           Char10:=10;
//                           NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm,TEXTENCODING::UTF16);
//                           IF Nsheet <> '' THEN BEGIN
//                             IF NsheetOld <> '' THEN BEGIN
//                               SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  + Nsheet + '    ';
//                             END
//                             ELSE
//                              SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
//                             len := STRLEN(SaveTxt);
//                             SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             SaveTxt := INSSTR(SaveTxt,'         ',len+2);
//                             UserTab.RESET;
//                             UserTab.SETRANGE(UserTab."User Name",USERID);
//                             IF UserTab.FINDFIRST THEN
//                               IF UserTab."Designation Name" <> '' THEN
//                                 SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
//                               ELSE
//                                 SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
//                                 SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                                 ostrm.WRITE(SaveTxt);
//                             IF NoteshetTab.MODIFY THEN BEGIN
//                               NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
//                              //ostrm1.WRITETEXT();
//                               NoteshetTab."Last Entry No." := Entryno;
//                               ostrm1.WRITE('');
//                               NoteshetTab.MODIFY;
//                             END;
//                            END
//                           ELSE BEGIN

//                             SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  ;
//                             len := STRLEN(SaveTxt);
//                             SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             SaveTxt := INSSTR(SaveTxt,'         ',len+2);
//                             UserTab.RESET;
//                             UserTab.SETRANGE(UserTab."User Name",USERID);
//                             IF UserTab.FINDFIRST THEN
//                               IF UserTab."Designation Name" <> '' THEN
//                                 SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
//                               ELSE
//                                 SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
//                              SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             ostrm.WRITE(SaveTxt);
//                             IF NoteshetTab.MODIFY THEN BEGIN
//                               NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
//                             //ostrm1.WRITETEXT();
//                               NoteshetTab."Last Entry No." := Entryno;
//                               ostrm1.WRITE('');
//                               NoteshetTab.MODIFY;
//                             END;
//                           END;
//                         END;
//                         ApprovalEntry.RESET;
//                         ApprovalEntry.SETRANGE("Document No.","No.");

//                         ApprovalEntry.SETRANGE("Table ID",38);
//                         ApprovalEntry.SETRANGE("Approver ID",USERID);
//                         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
//                         IF ApprovalEntry.FINDFIRST THEN BEGIN
//                           //CurrPage.SETSELECTIONFILTER(ApprovalEntry);
//                          // ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
//                           ApprovalEntry.Status := ApprovalEntry.Status::Approved;

//                           ApprovalEntry.MODIFY ;
//                         END;


//                         ApprovalEntry1.RESET;
//                         IF ApprovalEntry1.FINDLAST THEN BEGIN
//                           "EntryNo." := ApprovalEntry1."Entry No.";

//                         END;
//                         ApprovalEntry1.RESET;
//                         ApprovalEntry1."Entry No." := "EntryNo." +1;
//                         ApprovalEntry1."Table ID" := 38;
//                         ApprovalEntry1."Document Type" := ApprovalEntry1."Document Type"::Invoice;
//                         ApprovalEntry1."Document No." := "No.";
//                         ApprovalEntry1."Sequence No." := 1;
//                         ApprovalEntry1."Sender ID" := USERID;
//                         ApprovalEntry1."Approver ID" := "Transfer User Id";
//                         ApprovalEntry1.Status := ApprovalEntry1.Status::Open;
//                         ApprovalEntry1."Date-Time Sent for Approval" := CURRENTDATETIME;
//                         ApprovalEntry1."Last Date-Time Modified" := CURRENTDATETIME;
//                         ApprovalEntry1."Last Modified By User ID" := USERID;
//                         ApprovalEntry1.VALIDATE("Location Code","Location Code");
//                         ApprovalEntry1.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
//                         ApprovalEntry1."Record ID to Approve" := RECORDID;
//                         ApprovalEntry1.INSERT;
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
//                         PurchHead.SETRANGE(PurchHead."No.","No.");
//                         //PurchHead.SETRANGE(PurchHead."Payment Proposal Created",TRUE);
//                         IF PurchHead.FINDFIRST THEN BEGIN
//                           PurchHead."Proposal Status":= PurchHead."Proposal Status"::Approved;
//                           PurchHead."Pending To User ID" := "Transfer User Id";
//                           PurchHead."Pending To User Name" := "Transfer User Name";
//                           PurchHead."Transfer User Id" := '';
//                           PurchHead."Transfer User Name" := '';
//                          // PurchHead."Proposal Status Downword" := PurchHead."Proposal Status Downword"::"Pending Approval";
//                           //PurchHead."Payment Proposal Created" := FALSE;
//                          // PurchHead."Payment Pro Downword Created"  := TRUE;
//                         PurchHead.MODIFY  ;
//                         END;
//                         PurchcoomentLine.RESET;
//                         PurchcoomentLine.SETRANGE(PurchcoomentLine."Document Type",PurchcoomentLine."Document Type"::Invoice);
//                         PurchcoomentLine.SETRANGE(PurchcoomentLine."No.","No.");
//                         //PurchcoomentLine.SETRANGE(PurchcoomentLine.Active,FALSE);
//                         IF PurchcoomentLine.FINDFIRST THEN BEGIN
//                         REPEAT
//                           PurchcoomentLine.Active := TRUE;
//                         PurchcoomentLine.MODIFY  ;
//                           UNTIL PurchcoomentLine.NEXT= 0;
//                         END;
//                         CurrPage.CLOSE;
//                     end;
//                 }
//                 action("Forword ")
//                 {
//                     Caption = 'Forward';
//                     Promoted = true;

//                     trigger OnAction()
//                     begin
//                         IF NOT CONFIRM(Text0004) THEN
//                             EXIT;
//                         TESTFIELD("Transfer User Id");

//                         NoteshettabFin.RESET;
//                         NoteshettabFin.SETRANGE(NoteshettabFin."Document No.","No.");
//                         IF NOT NoteshettabFin.FINDFIRST THEN
//                           ERROR('Please create note sheet in Invoice');
//                         NoteshetTab.RESET;
//                         NoteshetTab.SETRANGE("Document No.","No.");
//                         IF NoteshetTab.FIND('-') THEN BEGIN
//                           Entryno := NoteshetTab."Last Entry No." + 1;
//                           NoteshetTab.CALCFIELDS("Running Note");
//                           IF NoteshetTab."Running Note".HASVALUE THEN BEGIN
//                             NoteshetTab."Running Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
//                             Isstream.READ(NsheetOld);
//                          END;
//                           NoteshetTab.CALCFIELDS("Current Note");

//                           IF NoteshetTab."Current Note".HASVALUE THEN BEGIN
//                              NoteshetTab."Current Note".CREATEINSTREAM(Isstream,TEXTENCODING::UTF16);
//                              Isstream.READ(Nsheet);
//                           END;
//                           Char10:=10;
//                           NoteshetTab."Running Note".CREATEOUTSTREAM(ostrm,TEXTENCODING::UTF16);
//                           IF Nsheet <> '' THEN BEGIN
//                             IF NsheetOld <> '' THEN BEGIN
//                               SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  + Nsheet + '    ';
//                             END
//                             ELSE
//                              SaveTxt := ' Note :- ' + FORMAT(Entryno) + '  ' + Nsheet + '    ';
//                             len := STRLEN(SaveTxt);
//                             SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             SaveTxt := INSSTR(SaveTxt,'         ',len+2);
//                             UserTab.RESET;
//                             UserTab.SETRANGE(UserTab."User Name",USERID);
//                             IF UserTab.FINDFIRST THEN
//                               IF UserTab."Designation Name" <> '' THEN
//                                 SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
//                               ELSE
//                                 SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
//                                 SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                                 ostrm.WRITE(SaveTxt);
//                             IF NoteshetTab.MODIFY THEN BEGIN
//                               NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
//                              //ostrm1.WRITETEXT();
//                               NoteshetTab."Last Entry No." := Entryno;
//                               ostrm1.WRITE('');
//                               NoteshetTab.MODIFY;
//                             END;
//                            END
//                           ELSE BEGIN

//                             SaveTxt :=  NsheetOld + ' Note :- ' + FORMAT(Entryno) + '  '  ;
//                             len := STRLEN(SaveTxt);
//                             SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             SaveTxt := INSSTR(SaveTxt,'         ',len+2);
//                             UserTab.RESET;
//                             UserTab.SETRANGE(UserTab."User Name",USERID);
//                             IF UserTab.FINDFIRST THEN
//                               IF UserTab."Designation Name" <> '' THEN
//                                 SaveTxt +=  USERID +'('+ UserTab."Full Name" +')'+ UserTab."Designation Name" +'  Dt.-'+FORMAT(CURRENTDATETIME)
//                               ELSE
//                                 SaveTxt +=   USERID +'('+ UserTab."Full Name" +')'+'  Dt.-'+FORMAT(CURRENTDATETIME);
//                              SaveTxt +=  FORMAT(Char10)+FORMAT(Char10);
//                             ostrm.WRITE(SaveTxt);
//                             IF NoteshetTab.MODIFY THEN BEGIN
//                               NoteshetTab."Current Note".CREATEOUTSTREAM(ostrm1,TEXTENCODING::UTF16);
//                             //ostrm1.WRITETEXT();
//                               NoteshetTab."Last Entry No." := Entryno;
//                               ostrm1.WRITE('');
//                               NoteshetTab.MODIFY;
//                             END;
//                           END;
//                         END;
//                         ApprovalEntry1.RESET;
//                         ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID",38);
//                         ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.","No.");
//                         ApprovalEntry1.SETRANGE(ApprovalEntry1.Status,ApprovalEntry1.Status::Open);
//                         ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID",USERID);
//                         IF ApprovalEntry1.FINDFIRST THEN BEGIN
//                           ApprovalEntry1.Status:= ApprovalEntry1.Status::Forworded;
//                           ApprovalEntry1."Forwarding Date-Time"  := CURRENTDATETIME;
//                           ApprovalEntry1.MODIFY;

//                         END;
//                         ApprovalEntry.RESET;
//                         IF ApprovalEntry.FINDLAST THEN BEGIN
//                           "EntryNo." := ApprovalEntry."Entry No.";

//                         END;
//                         ApprovalEntry.RESET;
//                         ApprovalEntry."Entry No." := "EntryNo." +1;
//                         ApprovalEntry."Table ID" := 38;
//                         ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::Invoice;
//                         ApprovalEntry."Document No." := "No.";
//                         ApprovalEntry."Sequence No." := 1;
//                         ApprovalEntry."Sender ID" := USERID;
//                         ApprovalEntry."Approver ID" := "Transfer User Id";
//                         ApprovalEntry.Status := ApprovalEntry.Status::Open;
//                         ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
//                         ApprovalEntry."Last Date-Time Modified" := CURRENTDATETIME;
//                         ApprovalEntry."Last Modified By User ID" := USERID;
//                         ApprovalEntry.VALIDATE("Location Code","Location Code");
//                         ApprovalEntry.VALIDATE("Shortcut Dimension 2 Code","Shortcut Dimension 2 Code");
//                         ApprovalEntry."Record ID to Approve" := RECORDID;
//                         ApprovalEntry.INSERT;
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
//                         PurchHead.SETRANGE(PurchHead."No.","No.");
//                         IF PurchHead.FINDFIRST THEN BEGIN
//                           PurchHead."Pending To User ID" := "Transfer User Id";
//                           PurchHead."Pending To User Name" := "Transfer User Name";
//                           PurchHead."Transfer User Id" := '';
//                           PurchHead."Transfer User Name" := '';

//                         PurchHead.MODIFY  ;
//                         END;
//                         /*
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."No.","No.");
//                         IF PurchHead.FINDFIRST THEN
//                           REPORT.RUN(50030,TRUE,FALSE,PurchHead);
//                         */
//                         CurrPage.CLOSE;

//                     end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         //ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID)
//                         IF NOT CONFIRM(Text0005) THEN
//                            EXIT;
//                         TESTFIELD("Rejected Remarks");
//                         ApprovalEntry.RESET;
//                         ApprovalEntry.SETRANGE("Document No.","No.");
//                         ApprovalEntry.SETRANGE("Table ID",38);
//                         ApprovalEntry.SETRANGE("Approver ID",USERID);
//                         ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
//                         IF ApprovalEntry.FINDFIRST THEN BEGIN
//                           //CurrPage.SETSELECTIONFILTER(ApprovalEntry);
//                          // ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
//                           ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
//                           ApprovalEntry."Date-Time Sent for Approval" := CURRENTDATETIME;
//                           ApprovalEntry.MODIFY ;
//                         END;
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
//                         PurchHead.SETRANGE(PurchHead."Payment Proposal Created",TRUE);
//                         PurchHead.SETRANGE(PurchHead."No.","No.");
//                         IF PurchHead.FINDFIRST THEN BEGIN
//                         PurchHead."Proposal Status"  := PurchHead."Proposal Status"::Rejected;
//                         PurchHead.MODIFY;
//                         END;
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID)
//                     end;
//                 }
//             }
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = Release;
//                 action("Re&lease")
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calc&ulate Structure Values")
//                 {
//                     Caption = 'Calc&ulate Structure Values';
//                     Image = CalculateHierarchy;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateStructures(Rec);
//                         PurchLine.AdjustStructureAmounts(Rec);
//                         PurchLine.UpdatePurchLines(Rec);
//                     end;
//                 }
//                 action("Calculate TDS")
//                 {
//                     Caption = 'Calculate TDS';
//                     Image = CalculateVATExemption;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateTDS(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Calculate &Invoice Discount")
//                 {
//                     AccessByPermission = TableData 24=R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     Image = VendorCode;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record "175";
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
//                 separator()
//                 {
//                 }
//                 action("Copy Document")
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                         IF GET("Document Type","No.") THEN;
//                     end;
//                 }
//                 action(MoveNegativeLines)
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 separator()
//                 {
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
//                             IncomingDocument: Record "130";
//                         begin
//                             IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
//                         end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData 130=R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "130";
//                         begin
//                             VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record "133";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         begin
//                             "Incoming Document Entry No." := 0;
//                         end;
//                     }
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF "Agreement Done" THEN BEGIN
//                         TESTFIELD("Agreement Date");
//                         TESTFIELD("Agreement Valid Till Date");
//                         END ELSE BEGIN
//                           TESTFIELD("Agreement Remarks");
//                           END;
//                         IF "Performance Guarantee Seen" THEN BEGIN
//                           TESTFIELD("Performance Guarantee Date");
//                           TESTFIELD("Performance Guarantee Amount");
//                           TESTFIELD("BG/DD No./RTGS No.");
//                           TESTFIELD("Issuing Bank Name");
//                           END;
//                           /*
//                         IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                         */
//                         TESTFIELD("Proposal Status","Proposal Status"::Open);
//                         IF NOT CONFIRM(Text0004) THEN
//                           EXIT;
//                         PurchHead.RESET;
//                         PurchHead.SETRANGE(PurchHead."No.","No.");
//                         IF PurchHead.FINDFIRST THEN
//                           REPORT.RUN(50029,TRUE,FALSE,PurchHead);

//                         CurrPage.CLOSE;

//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//             }
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
//                         PurchPostYesNo: Codeunit "91";
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
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices",TRUE,TRUE,Rec);
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
//                     RunObject = Page 16305;
//                                     RunPageLink = Type=CONST(Purchase),
//                                   Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Structure Code=FIELD(Structure);
//                 }
//                 action("Transit Documents")
//                 {
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                                     RunPageLink = Type=CONST(Purchase),
//                                   PO / SO No.=FIELD(No.),
//                                   Vendor / Customer Ref.=FIELD(Buy-from Vendor No.);
//                     Visible = false;
//                 }
//                 action("Attached Gate Entry")
//                 {
//                     Caption = 'Attached Gate Entry';
//                     Image = InwardEntry;
//                     RunObject = Page 16481;
//                                     RunPageLink = Entry Type=CONST(Inward),
//                                   Purchase Invoice No.=FIELD(No.);
//                     Visible = false;
//                 }
//                 action("Detailed Tax")
//                 {
//                     Caption = 'Detailed Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16341;
//                                     RunPageLink = Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Transaction Type=CONST(Purchase);
//                 }
//                 action("Detailed GST")
//                 {
//                     Caption = 'Detailed GST';
//                     Image = ServiceTax;
//                     RunObject = Page 16412;
//                                     RunPageLink = Transaction Type=FILTER(Purchase),
//                                   Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.);
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
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
//           FILTERGROUP(0);
//         END;
//         SetLocGSTRegNoEditable;
//         IF "Agreement Done" THEN BEGIN
//           AgreeRemVisible   := FALSE;
//         END ELSE BEGIN
//           AgreeRemVisible   := TRUE;
//         END;
//     end;

//     var
//         ChangeExchangeRate: Page "511";
//                                 CopyPurchDoc: Report "492";
//                                 MoveNegPurchLines: Report "6698";
//                                 ReportPrint: Codeunit "228";
//                                 UserMgt: Codeunit "5700";
//                                 GSTManagement: Codeunit "16401";
//                                 PurchLine: Record "39";
//                                 HasIncomingDocument: Boolean;
//                                 DocNoVisible: Boolean;
//                                 VendorInvoiceNoMandatory: Boolean;
//                                 OpenApprovalEntriesExist: Boolean;
//                                 OpenApprovalEntriesExistForCurrUser: Boolean;
//                                 ShowWorkflowStatus: Boolean;
//                                 GSTLocRegNo: Boolean;
//                                 IsRateChangeEnabled: Boolean;
//                                 UserSetup: Record "91";
//                                 AgreeRemVisible: Boolean;
//                                 Text0004: Label 'Do you want to forword Payment Proposal for Approval?';
//         Text0003: Label 'Do you want to Approved Payment Proposal?';
//         Text0005: Label 'Do you want to Reject Payment Proposal?';
//         PurchHead: Record "38";
//         AppuserGroupMem: Record "50091";
//         ApprovalEntry: Record "454";
//         ApprovalEntry1: Record "454";
//         "EntryNo.": Integer;
//         ServerFileName: Text;
//         ClientFileName: Text;
//         FileManagement: Codeunit "419";
//         DialogTitle: Text;
//         OldFileName: Text;
//         FilePath: Text;
//         FileExtension: Text;
//         PurchcoomentLine: Record "43";
//         ApprovalUserGroup: Record "50091";
//         ApprovalCommentLine: Record "50116";
//         NoteshettabFin: Record "50116";
//         Nsheet: Text;
//         ostrm: OutStream;
//         Isstream: InStream;
//         NsheetOld: Text;
//         ostrm1: OutStream;
//         Newline: Text;
//         NSheetTab: Record "50116";
//         USetup: Record "91";
//         SectCode: Code[10];
//         SectUser: Code[20];
//         USetupList: Page "119";
//                         NStTab: Record "50116";
//                         SaveTxt: Text;
//                         len: Integer;
//                         Edtble: Boolean;
//                         UserTab: Record "2000000120";
//                         Char10: Char;
//                         NoteSheetTab: Record "50116";
//                         Entryno: Integer;
//                         NoteshetTab: Record "50116";

//     procedure LineModified()
//     begin
//     end;

//     local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//             CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SaveInvoiceDiscountAmount()
//     var
//         DocumentTotals: Codeunit "57";
//     begin
//         CurrPage.SAVERECORD;
//         DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure BuyfromVendorNoOnAfterValidate()
//     begin
//         IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
//             IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
//                 SETRANGE("Buy-from Vendor No.");
//         CurrPage.UPDATE;
//     end;

//     local procedure PurchaserCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure PaytoVendorNoOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit "1400";
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, "No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         PurchasesPayablesSetup: Record "312";
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

//     local procedure SetLocGSTRegNoEditable()
//     begin
//         IF GSTManagement.IsGSTApplicable(Structure) THEN
//             IF "Location Code" <> '' THEN
//                 GSTLocRegNo := FALSE
//             ELSE
//                 GSTLocRegNo := TRUE;

//         IsRateChangeEnabled := "Rate Change Applicable";
//     end;
// }

