page 50381 "Legal Vendor Card"
{
    Caption = 'NTA Legal Vendor Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    ApplicationArea = all;

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
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; rec.Name)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Address; rec.Address)
                {
                }
                field("Address 2"; rec."Address 2")
                {
                }
                field("Post Code"; rec."Post Code")
                {
                    Importance = Promoted;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                }
                field("State Code"; rec."State Code")
                {
                }
                field("Primary Contact No."; rec."Primary Contact No.")
                {
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     ActivateFields;
                    // end;                      //HYC
                }
                field(Contact; rec.Contact)
                {
                    Editable = true;
                    Importance = Promoted;
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     ContactOnAfterValidate;  // HYC 200923
                    // end;

                }
                field(City; Rec.City)
                {
                }
                field("Search Name"; rec."Search Name")
                {
                }
                field("Balance (LCY)"; rec."Balance (LCY)")
                {
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", Rec."No.");

                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");

                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
                        rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                        VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field("<Vendor Type1>"; rec."Vendor Type")
                {
                    Editable = true;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    Visible = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    Visible = false;
                }
                field(Blocked; rec.Blocked)
                {
                    Visible = false;
                }
                field("Privacy Blocked"; rec."Privacy Blocked")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                }
                field(Transporter; rec.Transporter)
                {
                    Visible = false;
                }
                field("Phone No."; rec."Phone No.")
                {
                }
                field("E-Mail"; rec."E-Mail")
                {
                    Importance = Promoted;
                }
                field("P.A.N. No."; rec."P.A.N. No.")
                {
                    Editable = true;
                    Importance = Promoted;
                }
                field("GST Registration No."; rec."GST Registration No.")
                {
                }
                field("GST Vendor Type"; rec."GST Vendor Type")
                {
                }
                // field(Structure; REC.Structure)
                // {
                // }
                field("Aggregate Turnover"; rec."Aggregate Turnover")
                {
                }
                // field("Parent Advocate"; rec."Parent Advocate")
                // {
                // }
                // field("Parent Advocate Name"; rec."Parent Advocate Name")
                // {
                // }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Vendor Posting Group"; rec."Vendor Posting Group")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    Visible = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Visible = false;
                field("Fax No."; rec."Fax No.")
                {
                }
                field("Home Page"; rec."Home Page")
                {
                }
                field("Phone No.2"; rec."Phone No.")
                {
                    Importance = Promoted;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                }
                field("VAT Registration No."; rec."VAT Registration No.")
                {

                    trigger OnDrillDown()
                    var
                        VATRegistrationLogMgt: Codeunit 249;
                    begin
                        VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
                    end;
                }
                // field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                // {
                // }
                field(GLN; rec.GLN)
                {
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                }
                field("Invoice Disc. Code"; rec."Invoice Disc. Code")
                {
                    NotBlank = true;
                }
                field("Prices Including VAT"; rec."Prices Including VAT")
                {
                }
                field("Prepayment %"; rec."Prepayment %")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Visible = false;
                field("Application Method"; rec."Application Method")
                {
                }
                field("Partner Type"; rec."Partner Type")
                {
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    Importance = Promoted;
                }
                field(Priority; rec.Priority)
                {
                }
                field("Cash Flow Payment Terms Code"; rec."Cash Flow Payment Terms Code")
                {
                }
                field("Our Account No."; rec."Our Account No.")
                {
                }

                //HYC 220923
                // field("Block Payment Tolerance"; rec."Block Payment Tolerance")
                // {

                //     trigger OnValidate()
                //     begin
                //         IF rec."Block Payment Tolerance" THEN BEGIN
                //             IF CONFIRM(Text002, FALSE) THEN
                //                 PaymentToleranceMgt.DelTolVendLedgEntry(Rec);
                //         END ELSE BEGIN
                //             IF CONFIRM(Text001, FALSE) THEN
                //                 PaymentToleranceMgt.CalcTolVendLedgEntry(Rec);
                //         END;
                //     end;
                // }
                field("Creditor No."; rec."Creditor No.")
                {
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                }
            }
            group(Receiving)
            {
                Caption = 'Receiving';
                Visible = false;
                field("Location Code"; rec."Location Code")
                {
                    Importance = Promoted;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    Importance = Promoted;
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    Importance = Promoted;
                }
                field("Base Calendar Code"; rec."Base Calendar Code")
                {
                    DrillDown = false;
                }
                //HYC
                // field("Customized Calendar"; CalendarMgmt.CustomizedCalendarExistText(CustomizedCalendar."Source Type"::Vendor, "No.", '', "Base Calendar Code"))
                // {
                //     Caption = 'Customized Calendar';
                //     Editable = false;

                //     trigger OnDrillDown()
                //     begin
                //         CurrPage.SAVERECORD;
                //         TESTFIELD("Base Calendar Code");
                //         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Vendor, "No.", '', "Base Calendar Code");
                //     end;
                // }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; rec."Currency Code")
                {
                    Importance = Promoted;
                }
                field("Language Code"; rec."Language Code")
                {
                }
            }
            // group("Tax Information")
            // {
            //     Caption = 'Tax Information';
            //     Visible = false;
            //     group(Tax)
            //     {
            //         Caption = 'Tax';
            //     //     field("L.S.T. No."; rec."L.S.T. No.")
            //     //     {
            //     //     }
            //     //     field("C.S.T. No."; rec."C.S.T. No.")
            //     //     {
            //     //     }

            // field("GST Registration No.";Rec."GST Registration No.")
            // {
            //                     }
            // }
            // group(Excise)
            // {
            //     Caption = 'Excise';
            //     field("E.C.C. No."; rec."E.C.C. No.")
            //     {
            //     }
            //     field(Range; rec.Range)
            //     {
            //     }
            //     field(Collectorate; rec.Collectorate)
            //     {
            //     }
            //     field("Vendor Type"; rec."Vendor Type")
            //     {
            //     }
            // }
            // //HYC

            // group(VAT)
            // {
            //     Caption = 'VAT';
            //     field("T.I.N. No."; "T.I.N. No.")
            //     {
            //         Importance = Promoted;
            //     }
            //     field(Composition; Composition)
            //     {
            //     }
            // }
            // group("Income Tax")
            // {
            //     Caption = 'Income Tax';
            //     field("P.A.N. Status"; rec."P.A.N. Status")
            //     {

            //         trigger OnValidate()
            //         begin
            //             PANStatusOnAfterValidate;
            //         end;
            //     }
            //     field("P.A.N. Reference No."; rec."P.A.N. Reference No.")
            //     {
            //     }
            // }
            // group("Service Tax")
            // {
            //     Caption = 'Service Tax';
            //     field("Service Entity Type"; rec."Service Entity Type")
            //     {
            //     }
            //     field("Service Tax Registration No."; rec."Service Tax Registration No.")
            //     {
            //     }
            // }
            // group(Subcontractor)
            // {
            //     Caption = 'Subcontractor';

            //     // HYC 190923

            //     field(Subcontractor; rec.Subcontractor)
            //     {
            //         Importance = Promoted;
            //     }
            //     field("Vendor Location"; rec."Vendor Location")
            //     {
            //     }
            //     field("Commissioner's Permission No."; rec."Commissioner's Permission No.")
            //     {
            //     }
            // }
            group(GST)
            {
                Caption = 'GST';
                field("Associated Enterprises"; rec."Associated Enterprises")
                {
                }
                field("ARN No."; rec."ARN No.")
                {
                }
            }
        }

        area(FactBoxes)
        {

            //HYC 190923

            //part(; 875)
            // {
            //     SubPageLink = Source Type=CONST(Vendor),
            //                     Source No.=FIELD(No.);
            //                                    Visible = SocialListeningVisible;
            // }
            // part(; 876)
            // {
            //     SubPageLink = Source Type=CONST(Vendor),
            //                     Source No.=FIELD(No.);
            //                                    UpdatePropagation = Both;
            //                                    Visible = SocialListeningSetupVisible;
            // }
            // part(; 9094)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                     Currency Filter=FIELD(Currency Filter),
            //                     Date Filter=FIELD(Date Filter),
            //                     Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                     Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //         Visible = true;
            //     }
            //      part(;9095)
            //     {
            //         SubPageLink = No.=FIELD(No.),
            //         Currency Filter=FIELD(Currency Filter),
            //         Date Filter=FIELD(Date Filter),
            //         Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //         Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //         Visible = false;
            //     }
            //      part(;9096)
            //     {
            //         SubPageLink = No.=FIELD(No.),
            //         Currency Filter=FIELD(Currency Filter),
            //         Date Filter=FIELD(Date Filter),
            //         Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //         Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //         Visible = false;
            //     }
            //     part(WorkflowStatus;1528)
            //     {
            //         Editable = false;
            //         Enabled = false;
            //         ShowFilter = false;
            //         Visible = ShowWorkflowStatus;
            //     }
            //     systempart(;Links)
            //     {
            //         Visible = false;
            //     }
            //     systempart(;Notes)
            //     {
            //      Visible = false;
            //     }
        }
    }

    actions
    {
        area(navigation)
        {
            // group("Ven&dor")
            // {
            //     Caption = 'Ven&dor';
            //     Image = Vendor;
            //     Visible = false;
            //      action(Dimensions)
            //      {
            //          Caption = 'Dimensions';
            //          Image = Dimensions;
            //          RunObject = Page 540;
            //                          RunPageLink = "Table ID"=CONST(23),
            //                       " No."=FIELD("No.");
            //          ShortCutKey = 'Shift+Ctrl+D';
            //      }
            //      action("Bank Accounts")
            //      {
            //          Caption = 'Bank Accounts';
            //          Image = BankAccount;
            //          RunObject = Page 426;
            //                          RunPageLink = Vendor No.=FIELD(No.);
            //      }
            //      action("C&ontact")
            //      {
            //          AccessByPermission = TableData 5050=R;
            //          Caption = 'C&ontact';
            //          Image = ContactPerson;

            //     trigger OnAction()
            //          begin
            //              ShowContact;
            //          end;
            //      }
            //      action("Order &Addresses")
            //      {
            //          Caption = 'Order &Addresses';
            //          Image = Addresses;
            //          RunObject = Page 369;
            //                          RunPageLink = Vendor No.=FIELD(No.);
            //      }
            //      action("Co&mments")
            //      {
            //          Caption = 'Co&mments';
            //          Image = ViewComments;
            //          RunObject = Page 124;
            //                          RunPageLink = Table Name=CONST(Vendor),
            //                        No.=FIELD(No.);
            //      }
            //      action("Cross References")
            //      {
            //          Caption = 'Cross References';
            //          Image = Change;
            //          RunObject = Page 5723;
            //                          RunPageLink = Cross-Reference Type=CONST(Vendor),
            //                        Cross-Reference Type No.=FIELD(No.);
            //          RunPageView = SORTING(Cross-Reference Type,Cross-Reference Type No.);
            //      }
            //      action("Online Map")
            //      {
            //         Caption = 'Online Map';
            //         Image = Map;

            //         trigger OnAction()
            //         begin
            //             DisplayMap;
            //         end;
            //     }
            //     action(VendorReportSelections)
            //     {
            //         Caption = 'Document Layouts';
            //         Image = Quote;
            //         Visible = false
            //      trigger OnAction()
            //         var
            //             CustomReportSelection: Record "9657";
            //          begin
            //              CustomReportSelection.SETRANGE("Source Type",DATABASE::Vendor);
            //              CustomReportSelection.SETRANGE("Source No.","No.");
            //              PAGE.RUNMODAL(PAGE::"Vendor Report Selections",CustomReportSelection);
            //          end;}
            // }
            //  separator()
            //  {
            //  }
            //  separator()
            //  {
            //      Caption = '';
            //  }
            //  separator()
            //  {
            //  }

            // Image = Item;
            //          RunObject = Page 297;
            //                          RunPageLink = "Vendor No."=FIELD(No.),
            //          RunPageView = SORTING("Vendor No.", "Vendor Item No.",Item No.);
            // }
            action("Invoice &Discounts")
            {
                //    group("&Purchases")
                // {
                //     Caption = '&Purchases';
                //     Image = Purchasing;
                //     Visible = false;
                //      action(Items)
                //      {
                //          Caption = 'Items';
                //               Caption = 'Invoice &Discounts';
                //         Image = CalculateInvoiceDiscount;
                //         RunObject = Page 28;
                //                         RunPageLink = Code = FIELD("Invoice Disc. Code");
                //     }
                //     action(Prices)
                //     {
                //         Caption = 'Prices';
                //         Image = Price;
                //         RunObject = Page 7012;
                //                         RunPageLink = "Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Vendor No.");
                //     }
                //     action("Line Discounts")
                //     {
                //         Caption = 'Line Discounts';
                //         Image = LineDiscount;
                //         RunObject = Page 7014;
                //                         RunPageLink = "Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Vendor No.");
                //     }
                //     action("Prepa&yment Percentages")
                //     {
                //         Caption = 'Prepa&yment Percentages';
                //         Image = PrepaymentPercentages;
                //         RunObject = Page 665;
                //                         RunPageLink = "Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Vendor No.");
                //     }
                //     action("S&td. Vend. Purchase Codes")
                //     {
                //         Caption = 'S&td. Vend. Purchase Codes';
                //         Image = CodesList;
                //         RunObject = Page 178;
                //                         RunPageLink = "Vendor No." = FIELD("No.");
                //     }
                //     separator()
                //     {
                //     }
            }
            group(Documents)
            {
                //     Caption = 'Documents';
                //     Image = Administration;
                //     Visible = false;
                //     action(Quotes)
                //     {
                //         Caption = 'Quotes';
                //         Image = Quote;
                //         RunObject = Page 9306;
                //                         RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                //     }
                //     action(Orders)
                //     {
                //         Caption = 'Orders';
                //         Image = Document;
                //         RunObject = Page 9307;
                //                         RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                //     }
                //     action("Return Orders")
                //     {
                //         Caption = 'Return Orders';
                //         Image = ReturnOrder;
                //         RunObject = Page 9311;
                //                         RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                //     }
                //     action("Blanket Orders")
                //     {
                //         Caption = 'Blanket Orders';
                //         Image = BlanketOrder;
                //         RunObject = Page 9310;
                //                         RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                //     }
            }
            group(History)
            {
                //     Caption = 'History';
                //     Image = History;
                //     Visible = false;
                //     action("Ledger E&ntries")
                //     {
                //         Caption = 'Ledger E&ntries';
                //         Image = VendorLedger;
                //         Promoted = false;
                //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //         PromotedCategory = Process;
                //         RunObject = Page 29;
                //                         RunPageLink = "Vendor No." = FIELD("No.");
                //         RunPageView = SORTING("Vendor No.");
                //         ShortCutKey = 'Ctrl+F7';
                //     }
                //     action(Statistics)
                //     {
                //         Caption = 'Statistics';
                //         Image = Statistics;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         RunObject = Page 152;
                //                         RunPageLink = " No." = FIELD("No."),
                //                       Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                //                       Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                //         ShortCutKey = 'F7';
                //         Visible = false;
                //     }
                //     action(Purchases)
                //     {
                //         Caption = 'Purchases';
                //         Image = Purchase;
                //         RunObject = Page 156;
                //                         RunPageLink =" No."= FIELD("No."),
                //                       Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                //                       Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                //     }
                //     action("Entry Statistics")
                //     {
                //         //HYC 200923

                //          Caption = 'Entry Statistics';
                //          Image = EntryStatistics;
                //          RunObject = Page 303;
                //                          RunPageLink = "No."=FIELD("No."),
                //                        Date Filter=FIELD(Date Filter),
                //                        Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                //                        Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                //     }
                //     action("Statistics by C&urrencies")
                //     {

                //         //HYC 200923

                //          Caption = 'Statistics by C&urrencies';
                //          Image = Currencies;
                //          RunObject = Page 487;
                //                          RunPageLink = "Vendor" Filter=FIELD("No."),
                //                        Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                //                        Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                //                        Date Filter=FIELD(Date Filter);
                //     }
                //     action("Item &Tracking Entries")
                //     {
                //         Caption = 'Item &Tracking Entries';
                //         Image = ItemTrackingLedger;

                //         trigger OnAction()
                //         var
                //             ItemTrackingDocMgt: Codeunit 6503;   //HYC 200923 
                //             //this codeunit is not opening
                //         begin
                //             ItemTrackingDocMgt.ShowItemTrackingForMasterData(2,"No.",'','','','','');
                //         end;
                //     }
            }

            //         area(creation)
            //         {


            //             //HYC 200923


            //              action("Blanket Purchase Order")
            //              {
            //                  Caption = 'Blanket Purchase Order';
            //                  Image = BlanketOrder;
            //                  Promoted = false;
            //                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //                 PromotedCategory = New;
            //         /     RunObject = Page 509;
            //                               RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                RunPageMode = Create;
            //                                   Visible = false;
            //             }

            //             action("Purchase Quote")
            //             {


            // //HYC 200923

            //                // HYC 200923
            //                 // This page id is not 
            //                 Caption = 'Purchase Quote';
            //                 Image = Quote;
            //                 Promoted = false;
            //             //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //                     PromotedCategory = New;
            //                  RunObject = Page 49;
            //                                  RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                  RunPageMode = Create;
            //                  Visible = false;
            //               }
            //              action("Purchase Invoice")
            //             {

            //                 //HYC 200923
            //                  Caption = 'Purchase Invoice';
            //                  Image = Invoice;
            //                  Promoted = true;
            //                  PromotedCategory = New;
            //                  RunObject = Page 51;
            //                                  RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                  RunPageMode = Create;
            //                  Visible = false;
            //             }
            //             action("Purchase Order")
            //             {

            //                  //HYC 200923
            //                  Caption = 'Purchase Order';
            //                  Image = Document;
            //                  Promoted = true;
            //                  PromotedCategory = New;
            //                  RunObject = Page 50;
            //                                  RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                  RunPageMode = Create;
            //                  Visible = false;
            //             }
            //             action("Purchase Credit Memo")
            //             {
            //                  //HYC 190923

            //                  Caption = 'Purchase Credit Memo';
            //                  Image = CreditMemo;
            //                  Promoted = false;
            //                 // //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //                 PromotedCategory = New;
            //                  RunObject = Page 52;
            //                                  RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                  RunPageMode = Create;
            //                  Visible = false;
            //             }
            //             action("Purchase Return Order")
            //             {

            //                  //HYC 190923

            //                 Caption = 'Purchase Return Order';
            //                 Image = ReturnOrder;
            //                 Promoted = false;
            //                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //                  PromotedCategory = New;
            //                  RunObject = Page 6640;
            //                                  RunPageLink = "Buy-from Vendor No."=FIELD("No.");
            //                  RunPageMode = Create;
            //                  Visible = false;
            //             }
        }

        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    // Visible = OpenApprovalEntriesExistCurrUser;


                    //HYC 190923

                    //  trigger OnAction()
                    //  var
                    //      ApprovalsMgmt: Codeunit approva
                    //  begin
                    //      ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    //  end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    // Visible = OpenApprovalEntriesExistCurrUser;

                    //HYC 190923

                    //  trigger OnAction()
                    //  var
                    //      ApprovalsMgmt: Codeunit 1535;
                    //  begin
                    //      ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    //  end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // Visible = OpenApprovalEntriesExistCurrUser;

                    //HYC 190923

                    //  trigger OnAction()
                    //  var
                    //      ApprovalsMgmt: Codeunit 1535;
                    //  begin
                    //      ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    // end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send & Approval Request';
                    // Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    //HYC 190923

                    // trigger OnAction()
                    // var
                    //    ApprovalsMgmt: Codeunit 1535;
                    // begin
                    //    IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                    //      ApprovalsMgmt.OnSendVendorForApproval(Rec);
                    // end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval & Request';
                    //Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    //HYC 190923

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit 1535;
                    // begin
                    //     ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);
                    // end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ApplyTemplate)
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    // trigger OnAction()
                    // var
                    //    ConfigTemplateMgt: Codeunit 8612;      //HYC 190923
                    //     RecRef: RecordRef;
                    // begin
                    //     RecRef.GETTABLE(Rec);
                    //     ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    //     RecRef.SETTABLE(Rec);
                    // end;
                }
            }

            //HYC 190923
            action("Payment Journal")
            {
                //HYC 190923

                Caption = 'Payment Journal';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 256;
                Visible = false;
            }

            action("Purchase Journal")
            {

                // HYC 200923

                Caption = 'Purchase Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 254;
                Visible = false;
            }
        }
        area(reporting)
        {
            // action("Vendor - Labels")
            // {
            //     Caption = 'Vendor - Labels';
            //     Image = "Report";
            //     Promoted = false;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";
            //     RunObject = Report 310;
            //                     Visible = false;
            // }
            // action("Vendor - Balance to Date")
            // {
            //     Caption = 'Vendor - Balance to Date';
            //     Image = "Report";
            //     Promoted = false;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";
            //     RunObject = Report 321;
            //                     Visible = false;
            // }
            //}
            //}

            // trigger OnAfterGetCurrRecord()
            // begin
            //     ActivateFields;
            //     OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
            //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
            //     //HYC 200923
            //     ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
            // end;

            // trigger OnAfterGetRecord()
            // begin
            //     ActivateFields;
            // end;

            // trigger OnInit()
            // begin
            //     ContactEditable := TRUE;
            //     "P.A.N. No.Editable" := TRUE;
            //     MapPointVisible := TRUE;
            // end;

            //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
            // begin
            //     "Vendor Type":="Vendor Type"::"Internal Advocate";
            //     "Gen. Bus. Posting Group":='NATIONAL';
            //     "VAT Bus. Posting Group":='NATIONAL';
            //     "Vendor Posting Group":='DOMESTIC';
            //     "GST Vendor Type":="GST Vendor Type"::Unregistered;
            //     "Aggregate Turnover":="Aggregate Turnover"::"Less than 20 lakh";
            //     Structure:='GST';
            // end;

            // trigger OnOpenPage()
            //var
            //MapMgt: Codeunit 802;  //HYC
            // begin
            //     ActivateFields;
            //     IF NOT MapMgt.TestSetup THEN
            //       MapPointVisible := FALSE;
            // end;

            //var

            //HYC 200923

            //    CalendarMgmt: Codeunit ;
            //     PaymentToleranceMgt: Codeunit ;
            //        ApprovalsMgmt: Codeunit 1535;
            //         CustomizedCalEntry: Record 7603;
            //         CustomizedCalendar: Record 7602;
            //         Text001: Label 'Do you want to allow payment tolerance for entries that are currently open?';
            //         Text002: Label 'Do you want to remove payment tolerance from entries that are currently open?';
            //         [InDataSet]
            //         MapPointVisible: Boolean;
            //         [InDataSet]
            //         "P.A.N. No.Editable": Boolean;
            //         [InDataSet]
            //         ContactEditable: Boolean;
            //         [InDataSet]
            //         SocialListeningSetupVisible: Boolean;
            //         [InDataSet]
            //         SocialListeningVisible: Boolean;
            //         OpenApprovalEntriesExistCurrUser: Boolean;
            //         OpenApprovalEntriesExist: Boolean;
            //         ShowWorkflowStatus: Boolean;}
            //         Vend: Record 23;
            // }

            // local procedure ActivateFields()
            // begin
            //     SetSocialListeningFactboxVisibility;
            //     ContactEditable := "Primary Contact No." = '';
            //     "P.A.N. No.Editable" := "P.A.N. Status" = 0;
            // end;

            // local procedure ContactOnAfterValidate()
            // begin
            //     ActivateFields;
            // end;

            // local procedure PANStatusOnAfterValidate()
            // begin
            //     ActivateFields();
            // end;


            // local procedure SetSocialListeningFactboxVisibility()
            // var
            //     SocialListeningMgt: Codeunit 871;
            // begin
            //     SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
            //end;



        }
    }
}
