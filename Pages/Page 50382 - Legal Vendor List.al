page 50382 "Legal Vendor List"
{
    Caption = 'NTA Legal Vendor List';
    CardPageID = "Legal Vendor Card";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(A1)
            {
                field("No."; rec."No.")
                {
                }
                field(Name; rec.Name)
                {
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Visible = false;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Visible = false;
                }
                field("Location Code2"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    Visible = false;
                }
            }
        }

        //HYC


        area(factboxes)
        {
            //HYC 

            // part(; 875)
            // {
            //     SubPageLink = Source Type=CONST(Vendor),
            //                   Source No.=FIELD(No.);
            //                                  Visible = SocialListeningVisible;
            // }
            // part(; 876)
            // {
            //     SubPageLink = Source Type=CONST(Vendor),
            //                   Source No.=FIELD(No.);
            //                                  UpdatePropagation = Both;
            //                                  Visible = SocialListeningSetupVisible;
            // }
            // part(; 9093)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                   Currency Filter=FIELD(Currency Filter),
            //                   Date Filter=FIELD(Date Filter),
            //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //     Visible = false;
            //}
            // part(;9094)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                   Currency Filter=FIELD(Currency Filter),
            //                   Date Filter=FIELD(Date Filter),
            //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //     Visible = false;
            // }
            // part(;50424)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                   Currency Filter=FIELD(Currency Filter),
            //                   Date Filter=FIELD(Date Filter),
            //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            // }
            // part(;9095)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                   Currency Filter=FIELD(Currency Filter),
            //                   Date Filter=FIELD(Date Filter),
            //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //     Visible = false;
            //}
            // part(;9096)
            // {
            //     SubPageLink = No.=FIELD(No.),
            //                   Currency Filter=FIELD(Currency Filter),
            //                   Date Filter=FIELD(Date Filter),
            //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
            //     Visible = false;
            // }
            // systempart(;Links)
            // {
            //     Visible = false;
            // }
            // systempart(;Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Visible = false;
                    // action("Dimensions-Single")
                    // {
                    //     Caption = 'Dimensions-Single';
                    //     Image = Dimensions;
                    //     RunObject = Page 540;
                    //                     RunPageLink = "Table ID" =CONST(23),
                    //                   "No."=FIELD("No.");
                    //     ShortCutKey = 'Shift+Ctrl+D';
                    // }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348 = R;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            Vend: Record Vendor;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Vend);
                            // DefaultDimMultiple.SetMultiVendor(Vend);   HYC220923
                            DefaultDimMultiple.RUNMODAL;

                        end;

                    }
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page 426;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    Visible = false;
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData 5050 = R;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.ShowContact;
                    end;
                }
                // separator()   HYC
                // {
                // }
                action("Order &Addresses")
                {
                    Caption = 'Order &Addresses';
                    Image = Addresses;
                    RunObject = Page 369;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    Visible = false;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                    Visible = false;
                }

                //HYC
                // action("Cross Re&ferences")
                // {
                //     Caption = 'Cross Re&ferences';
                //     Image = Change;
                //     RunObject = Page 5723;
                //                     RunPageLink = Cross-Reference Type=CONST(Vendor),
                //                   Cross-Reference Type No.=FIELD(No.);
                //     RunPageView = SORTING(Cross-Reference Type,Cross-Reference Type No.);
                //     Visible = false;
                // }
                // separator(t)
                // {
                // }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;
                Visible = false;
                action(Items)
                {
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page 297;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action("Invoice &Discounts")
                {
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page 28;
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7012;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7014;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page 665;
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action("S&td. Vend. Purchase Codes")
                {
                    Caption = 'S&td. Vend. Purchase Codes';
                    Image = CodesList;
                    RunObject = Page 178;
                    RunPageLink = "Vendor No." = FIELD("No.");
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Administration;
                Visible = false;
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page 9306;
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page 9307;
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page 9311;
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page 9310;
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.");
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                Visible = false;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 152;
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                 "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page 156;
                    RunPageLink = "No." = FIELD("No."),
                                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    Visible = false;
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page 303;
                    RunPageLink = "No." = FIELD("No."),
                                 "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("Statistics by C&urrencies")
                {
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page 487;
                    RunPageLink = "Vendor Filter" = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Date Filter" = FIELD("Date Filter");
                }

                //HYC220923
                // action("Item &Tracking Entries")
                // {
                //     Caption = 'Item &Tracking Entries';
                //     Image = ItemTrackingLedger;

                //     trigger OnAction()
                //     var
                //         ItemTrackingDocMgt: Codeunit 6503;
                //     begin
                //         ItemTrackingDocMgt.ShowItemTrackingForMasterData(2,"No.",'','','','','');
                //     end;
                // }
            }
        }
        area(creation)
        {
            action("Blanket Purchase Order")
            {
                Caption = 'Blanket Purchase Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page 509;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
            action("Purchase Quote")
            {
                Caption = 'Purchase Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page 49;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
            action("Purchase Invoice")
            {
                Caption = 'Purchase Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 51;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 50;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
            action("Purchase Credit Memo")
            {
                Caption = 'Purchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page 52;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
            action("Purchase Return Order")
            {
                Caption = 'Purchase Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page 6640;
                RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
            }
        }
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendVendorForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt";
                    begin
                        //ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);
                    end;
                }
            }
            action("Payment Journal")
            {
                Caption = 'Payment Journal';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 256;
                Visible = false;
            }
            action("Purchase Journal")
            {
                Caption = 'Purchase Journal';
                Image = Journals;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 254;
                Visible = false;
            }
        }
        area(reporting)
        {
            group(General)
            {
                Caption = 'General';
                Visible = false;
                action("Vendor - List")
                {
                    Caption = 'Vendor - List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 301;
                    Visible = false;
                }
                action("Vendor Register")
                {
                    Caption = 'Vendor Register';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 303;
                    Visible = false;
                }
                action("Vendor Item Catalog")
                {
                    Caption = 'Vendor Item Catalog';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 320;
                    Visible = false;
                }
                action("Vendor - Labels")
                {
                    Caption = 'Vendor - Labels';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 310;
                    Visible = false;
                }
                action("Vendor - Top 10 List")
                {
                    Caption = 'Vendor - Top 10 List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 311;
                    Visible = false;
                }
            }
            group(Order)
            {
                Caption = 'Orders';
                Image = "Report";
                Visible = false;
                action("Vendor - Order Summary")
                {
                    Caption = 'Vendor - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 307;
                    Visible = false;
                }
                action("Vendor - Order Detail")
                {
                    Caption = 'Vendor - Order Detail';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 308;
                    Visible = false;
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = Purchase;
                Visible = false;
                action("Vendor - Purchase List")
                {
                    Caption = 'Vendor - Purchase List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 309;
                    Visible = false;
                }
                action("Vendor/Item Purchases")
                {
                    Caption = 'Vendor/Item Purchases';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 313;
                    Visible = false;
                }
                action("Purchase Statistics")
                {
                    Caption = 'Purchase Statistics';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 312;
                    Visible = false;
                }
            }
            group("Financial Management")
            {
                Caption = 'Financial Management';
                Image = "Report";
                Visible = false;
                action("Payments on Hold")
                {
                    Caption = 'Payments on Hold';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 319;
                    Visible = false;
                }
                action("Vendor - Summary Aging")
                {
                    Caption = 'Vendor - Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 305;
                    Visible = false;
                }
                action("Aged Accounts Payable")
                {
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 322;
                    Visible = false;
                }
                action("Vendor - Balance to Date")
                {
                    Caption = 'Vendor - Balance to Date';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report 321;
                    Visible = false;
                }
                action("Vendor - Trial Balance")
                {
                    Caption = 'Vendor - Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 329;
                    Visible = false;
                }
                action("Vendor - Detail Trial Balance")
                {
                    Caption = 'Vendor - Detail Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 304;
                    Visible = false;
                }
            }
        }
    }
    //HYC 220923
    // trigger OnAfterGetCurrRecord()
    // begin
    //     SetSocialListeningFactboxVisibility;
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID)
    // end;

    trigger OnAfterGetRecord()
    begin
        //HYC 220923
        //SetSocialListeningFactboxVisibility
    end;
    //HYC 220923

    // trigger OnOpenPage()
    // begin
    //     REC.SETFILTER("Vendor Type",'%1|%2|%3',"Vendor Type"::"Internal Advocate","Vendor Type"::"External Advocate","Vendor Type"::"Advocate Clerk");
    //     UserSetup.GET(USERID);
    //     rec.SETFILTER("Global Dimension 2 Filter",UserSetup.Section);
    // end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgmt";
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UserSetup: Record 91;

    procedure GetSelectionFilter(): Text
    var
        Vend: Record 23;
        SelectionFilterManagement: Codeunit 46;
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
        EXIT(SelectionFilterManagement.GetSelectionFilterForVendor(Vend));
    end;

    procedure SetSelection(var Vend: Record 23)
    begin
        CurrPage.SETSELECTIONFILTER(Vend);
    end;
    //HYC220923
    // local procedure SetSocialListeningFactboxVisibility()
    // var
    //     SocialListeningMgt: Codeunit 871;
    // begin
    //     SocialListeningMgt.GetVendFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    // end;
}

