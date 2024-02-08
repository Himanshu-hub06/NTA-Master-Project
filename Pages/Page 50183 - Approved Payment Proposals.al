page 50183 "Approved Payment Proposals"
{
    Caption = 'Approved Payment Proposals';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve';
    RefreshOnActivate = true;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER('Invoice'),
                            "Proposal Status" = CONST(Approved),
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

                    trigger OnValidate()
                    begin
                        //   SetLocGSTRegNoEditable;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                }
                field(Structure; Rec.Structure)
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        //  SetLocGSTRegNoEditable;
                    end;
                }


                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    Visible = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Editable = false;
                    ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Proposal Status"; Rec."Proposal Status")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Transfer User Id"; Rec."Transfer User Id")
                {

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
                }
            }
            part(PurchLines; "Approve Pay Proposal Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            /*  //kamlesh date 08-02-2023
            group("Other Informantion")
            {
                Caption = 'Other Informantion';
                Visible = true;
                field("Stock Entry as Per Invoice"; "Stock Entry as Per Invoice")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Work Order No."; "Work Order No.")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Work Order Date"; "Work Order Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Agreement Done"; "Agreement Done")
                {
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        IF "Agreement Done" THEN BEGIN
                            AgreeRemVisible := FALSE;
                        END ELSE BEGIN
                            AgreeRemVisible := TRUE;
                        END;
                    end;
                }
                field("Agreement Date"; "Agreement Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Agreement Remarks"; "Agreement Remarks")
                {
                    Editable = false;
                    ShowMandatory = true;
                    Visible = AgreeRemVisible;
                }
                field("According to Agreement"; "According to Agreement")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Penalty Clause Seen"; "Penalty Clause Seen")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Performance Guarantee Seen"; "Performance Guarantee Seen")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Agreement Valid Till Date"; "Agreement Valid Till Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Issuing Bank Code"; "Issuing Bank Code")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Issuing Bank Name"; "Issuing Bank Name")
                {
                    Editable = false;
                }
                field("Performance Guarantee Date"; "Performance Guarantee Date")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Perfor. Guar. Valid Till Date"; "Perfor. Guar. Valid Till Date")
                {
                    Caption = 'Performance Guarantee Valid Till Date';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Performance Guarantee Amount"; "Performance Guarantee Amount")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("BG/DD No./RTGS No."; "BG/DD No./RTGS No.")
                {
                    Editable = false;
                }
                field("According To Time Delivery"; "According To Time Delivery")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Quantity Verify"; "Quantity Verify")
                {
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Quality Test Report"; "Quality Test Report")
                {
                    Editable = false;
                }
                field("GSM Test"; "GSM Test")
                {
                    Editable = false;
                }
            }
            */
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    Importance = Additional;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Importance = Additional;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Importance = Additional;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Importance = Additional;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Importance = Additional;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Importance = Promoted;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Importance = Additional;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                }
                field("On Hold"; Rec."On Hold")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                }
                // field("Transit Document"; "Transit Document")  //kamlesh date 08-02-2023
                // {
                // }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Importance = Promoted;
                }
                field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;

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
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Entry Point"; Rec."Entry Point")
                {
                }
                //         field(Area;Area)  //kamlesh date 08-02-2023
                // {
                // }
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
            group("Tax Information")
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
            part("9103"; 9103)
            {
                Caption = '';
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox; 9092)
            {
                Visible = false;
            }
            part("9093"; 9093)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
            }
            part("9094"; 9094)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
            }
            part("9095"; 9095)
            {
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
                Caption = 'Purchase List';
                //kamlesh date 08-02-2023
                // Provider = PurchLines;  //kamlesh date 08-02-2023
                //SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(WorkflowStatus; 1528)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart("Links"; Links)
            {
                Visible = false;
            }
            systempart("Notes"; Notes)
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
                    Caption = 'Payment Proposal Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        IF Rec.Structure <> '' THEN BEGIN
                            PurchLine.CalculateStructures(Rec);
                            PurchLine.AdjustStructureAmounts(Rec);
                            PurchLine.UpdatePurchLines(Rec);
                            //PurchLine.CalculateTDS(Rec);  //kamlesh date 08-02-2023
                            PurchLine.UpdatePurchLines(Rec);
                            COMMIT;
                        END ELSE BEGIN
                            // PurchLine.CalculateTDS(Rec);  //kamlesh date 08-02-2023
                            PurchLine.UpdatePurchLines(Rec);
                            COMMIT;
                        END;
                        //PAGE.RUNMODAL(PAGE::"Purchase Statistics",Rec);
                        PAGE.RUNMODAL(PAGE::"Payment Proposal Statistics", Rec);//EXP
                    end;
                }
                action("Calculation Sheet")
                {
                    Promoted = true;

                    trigger OnAction()
                    begin
                        /* //kamlesh date 07-02-2023
                        PurchHead.RESET;
                        PurchHead.SETRANGE(PurchHead."Document Type",PurchHead."Document Type"::Invoice);
                        PurchHead.SETRANGE("No.","No.");
                        IF PurchHead.FINDFIRST THEN
                          REPORT.RUN(50009,TRUE,TRUE,PurchHead);
                          *///end kamlesh
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
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
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Attatch Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*
                        FilePath := 'C:\Requistion\';
                        OldFileName:=(FilePath + Attachment);
                        ServerFileName:=FileManagement.UploadFile(DialogTitle,'');
                        ClientFileName:=FileManagement.GetFileName(ServerFileName);
                        FileExtension:=FileManagement.GetExtension(ClientFileName);
                        IF ClientFileName <> '' THEN BEGIN
                          Attachment:=DELCHR("No.",'=','/') + '.'+FileExtension;
                          MODIFY(TRUE);
                         END ELSE
                          BEGIN
                          Attachment:='';
                          MODIFY(TRUE);
                        END;

                        ClientFileName := FilePath + DELCHR("No.",'=','/')+'.'+FileExtension;
                        FileManagement.CopyServerFile(ServerFileName,ClientFileName,TRUE);
                        IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
                          FileManagement.DeleteServerFile(OldFileName);


                        */
                        // IF Attachment <> '' THEN //kamlesh date 08-02-2023
                        //     IF NOT CONFIRM('Document is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FilePath := 'G:\Published_APP\BSEB\BSEB_FTP\PurchInvoice\';
                        // OldFileName := (FilePath + Attachment); //kamlesh date 08-02-2023
                        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                        ClientFileName := FileManagement.GetFileName(ServerFileName);
                        IF ClientFileName <> '' THEN BEGIN
                            // Attachment := DELCHR("No.", '=', '/') + ClientFileName; //kamlesh date 08-02-2023
                            Rec.MODIFY(TRUE);
                        END;
                        // ClientFileName := FilePath + Attachment; //kamlesh date 08-02-2023
                        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                        IF OldFileName <> '' THEN
                            FileManagement.DeleteServerFile(OldFileName);
                        //MESSAGE('Upload successfully');

                    end;
                }
                action("View attachment")
                {
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //kamlesh date 08-02-2023
                        // FilePath := 'http://115.243.18.40/bseb_ftp/PurchInvoice/';
                        // IF Attachment <> '' THEN BEGIN
                        //     OldFileName := Attachment;
                        //     ServerFileName := FilePath + Attachment;
                        //     HYPERLINK(ServerFileName);
                        // END;
                    end;
                }
                action("Create Payment Voucher")
                {
                    Caption = 'Create Payment Voucher';
                    Promoted = true;

                    trigger OnAction()
                    begin
                        PurchHead.RESET;
                        PurchHead.SETRANGE(PurchHead."No.", Rec."No.");
                        PurchHead.SETRANGE(PurchHead."Payment Voucher Created", TRUE);
                        IF PurchHead.FINDFIRST THEN
                            ERROR('Vendor Payment Voucher allready created');
                        //  ItemJnlManagement.CreateVendorPaymentVoucher("No."); //kamlesh date 08-02-2023
                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 38);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        //ApprovalEntry1.SETRANGE(ApprovalEntry1.Status,ApprovalEntry1.Status::Open);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID", USERID);
                        IF ApprovalEntry1.FINDFIRST THEN BEGIN
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Approved;
                            ApprovalEntry1."Forwarding Date-Time" := CURRENTDATETIME;
                            ApprovalEntry1.MODIFY;

                        END;
                    end;
                }
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

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text0004) THEN
                            EXIT;
                        Rec.TESTFIELD("Transfer User Id");
                        ApprovalEntry1.RESET;
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Table ID", 38);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Document No.", Rec."No.");
                        ApprovalEntry1.SETRANGE(ApprovalEntry1.Status, ApprovalEntry1.Status::Open);
                        ApprovalEntry1.SETRANGE(ApprovalEntry1."Approver ID", USERID);
                        IF ApprovalEntry1.FINDFIRST THEN BEGIN
                            ApprovalEntry1.Status := ApprovalEntry1.Status::Forwarded;
                            ApprovalEntry1."Forwarding Date-Time" := CURRENTDATETIME;
                            ApprovalEntry1.MODIFY;

                        END;
                        ApprovalEntry.RESET;
                        IF ApprovalEntry.FINDLAST THEN BEGIN
                            "EntryNo." := ApprovalEntry."Entry No.";

                        END;
                        ApprovalEntry.RESET;
                        ApprovalEntry."Entry No." := "EntryNo." + 1;
                        ApprovalEntry."Table ID" := 38;
                        ApprovalEntry."Document Type" := ApprovalEntry."Document Type"::Invoice;
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
                            PurchHead."Pending To User ID" := Rec."Transfer User Id";
                            PurchHead."Pending To User Name" := Rec."Transfer User Name";
                            PurchHead."Transfer User Id" := '';
                            PurchHead."Transfer User Name" := '';

                            PurchHead.MODIFY;
                        END;
                        /*
                        PurchHead.RESET;
                        PurchHead.SETRANGE(PurchHead."No.","No.");
                        IF PurchHead.FINDFIRST THEN
                          REPORT.RUN(50030,TRUE,FALSE,PurchHead);
                        */
                        CurrPage.CLOSE;

                    end;
                }
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID)
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID)
                    end;
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID)
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
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(sep1)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;

                    trigger OnAction()
                    begin
                        PurchLine.CalculateStructures(Rec);
                        PurchLine.AdjustStructureAmounts(Rec);
                        PurchLine.UpdatePurchLines(Rec);
                    end;
                }

                // action("Calculate TDS")
                //   {
                //       Caption = 'Calculate TDS';
                //        Image = CalculateVATExemption;

                //       trigger OnAction()
                //       begin
                //             PurchLine.CalculateTDS(Rec);
                //         end;
                //    }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    AccessByPermission = TableData 24 = R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator("")
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
                        // GetGateEntryLines; //kamlesh date 08-02-2023
                    end;
                }
                separator("1")
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                        IF Rec.GET(Rec."Document Type", Rec."No.") THEN;
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
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(" ")
                {
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                            IncomingDocument: Record 130;
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
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
                            IncomingDocument: Record 130;
                        begin
                            // VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.")); //kamlesh date 08-02-2023
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record 133;
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';

                        trigger OnAction()
                        begin
                            Rec."Incoming Document Entry No." := 0;
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        /*
                        IF "Agreement Done" THEN BEGIN
                        TESTFIELD("Agreement Date");
                        TESTFIELD("Agreement Valid Till Date");
                        END ELSE BEGIN
                          TESTFIELD("Agreement Remarks");
                          END;
                        IF "Performance Guarantee Seen" THEN BEGIN
                          TESTFIELD("Performance Guarantee Date");
                          TESTFIELD("Performance Guarantee Amount");
                          TESTFIELD("BG/DD No./RTGS No.");
                          TESTFIELD("Issuing Bank Name");
                          END;

                        TESTFIELD("Proposal Status","Proposal Status"::Open);
                        IF NOT CONFIRM(Text004) THEN
                          EXIT;
                        PurchHead.RESET;
                        PurchHead.SETRANGE(PurchHead."No.","No.");
                        IF PurchHead.FINDFIRST THEN
                          REPORT.RUN(50029,TRUE,FALSE,PurchHead);

                        CurrPage.CLOSE;
                        */

                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit 91;
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                /*
                action("St&ructure")
                {
                    Caption = 'St&ructure';
                    Image = Hierarchy;
                    RunObject = Page 16305;
                    RunPageLink = Type = CONST(Purchase),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No."),
                                  "Structure Code" = FIELD(Structure);
                }
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    Image = TransferOrder;
                    RunObject = Page 13705;
                    RunPageLink = Type = CONST(Purchase),
                                  "PO / SO No." = FIELD("No."),
                                  "Vendor / Customer Ref." = FIELD("Buy-from Vendor No.");
                    Visible = false;
                }
                action("Attached Gate Entry")
                {
                    Caption = 'Attached Gate Entry';
                    Image = InwardEntry;
                    RunObject = Page 16481;
                    RunPageLink = "Entry Type" = CONST(Inward),
                                  "Purchase Invoice No." = FIELD("No.");
                    Visible = false;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Image = TaxDetail;
                    RunObject = Page 16341;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No."),
                                  "Transaction Type" = CONST('Purchase');
                }

                action("Detailed GST")
                {
                    Caption = 'Detailed GST';
                    Image = ServiceTax;
                    RunObject = Page 16412;
                    RunPageLink = "Transaction Type" = FILTER('Purchase'), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                }
               */  //kamlesh date 08-02-2023
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //     CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        //  ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        //   CurrPage.ApprovalFactBox.PAGE.RefreshPage(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        //  SetLocGSTRegNoEditable;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        SetDocNoVisible;

        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;
        //   SetLocGSTRegNoEditable;

    end;

    var
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        MoveNegPurchLines: Report 6698;
        ReportPrint: Codeunit 228;
        UserMgt: Codeunit 5700;
        //GSTManagement: Codeunit 16401; //kamlesh date 08-02-2023
        PurchLine: Record 39;
        HasIncomingDocument, DocNoVisible, VendorInvoiceNoMandatory, OpenApprovalEntriesExist, OpenApprovalEntriesExistForCurrUser, ShowWorkflowStatus : Boolean;
        GSTLocRegNo, IsRateChangeEnabled : Boolean;
        UserSetup: Record 91;
        AgreeRemVisible: Boolean;
        Text0004: Label 'Do you want to send for approval ?';
        PurchHead: Record 38;
        ServerFileName, ClientFileName : Text;
        FileManagement: Codeunit 419;
        DialogTitle, OldFileName, FilePath, FileExtension : Text;
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50082;
        ApprovalEntry1: Record 454;
        "EntryNo.": Integer;
        ApprovalEntry: Record 454;
        ItemJnlManagement: Codeunit 240;

    procedure LineModified()
    begin
    end;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

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
        IF Rec.GETFILTER(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

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

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit 1400;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        PurchasesPayablesSetup: Record 312;
    begin
        PurchasesPayablesSetup.GET;
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;

    // local procedure SetLocGSTRegNoEditable()
    // begin
    //      IF GSTManagement.IsGSTApplicable(Structure) THEN
    //       IF "Location Code" <> '' THEN
    //         GSTLocRegNo := FALSE
    //       ELSE
    //          GSTLocRegNo := TRUE;

    //   IsRateChangeEnabled := "Rate Change Applicable";
    // end;
}

