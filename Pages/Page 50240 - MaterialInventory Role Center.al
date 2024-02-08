/// <summary>
/// Page Material/Inventory Role Center (ID 50790).
/// </summary>
page 50240 "Material/Inventory Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {


        area(rolecenter)
        {

            group(GRP00)
            {

                // part("Store Activities"; "Store Activities")
                part("Store Activities"; "Store Cue Activities")
                {
                    Visible = true;
                    ApplicationArea = All;
                }

            }

        }
    }

    actions
    {
        area(sections)
        {
            group(Approval)
            {
                Caption = 'Approval';
                Image = ResourcePlanning;
                action("Requests to Approve")
                {
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    RunObject = Page 654;
                }
            }


            group(Requisition)
            {
                Caption = 'Requisition';
                Image = ResourcePlanning;
                action(Requisition1)
                {
                    ApplicationArea = All;
                    Caption = 'Requisition';
                    RunObject = Page 50196;
                }
                action("Requisition Under Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Under Approval';
                    RunObject = Page 50202;
                }
                action("Approved Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Requisition';
                    RunObject = Page 50142;
                }
                action("Rejected Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Requisition';
                    RunObject = Page 50217;
                }
            }
            group(Indent)
            {
                Caption = 'Indent';
                Image = ResourcePlanning;
                action(Indent1)
                {
                    ApplicationArea = All;
                    Caption = 'Indent';

                    RunObject = Page 50201;
                }
                action("Indent Under Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Indent Under Approval';
                    RunObject = Page 50241;
                }
                action("Indent Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Indent Approved';
                    RunObject = Page 50237;
                }
                action("Rejected Indent")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Indent';
                    RunObject = Page 50225;
                }
            }
            group(PurchaseProposal)
            {
                Caption = 'Purchase Proposal';
                group(GEMPurchase)
                {
                    Caption = 'GeM Purchase Proposal';
                    action(OpenGeM)
                    {
                        ApplicationArea = All;
                        Caption = 'GeM Purchase Proposal List';
                        RunObject = page "GeM Purchase Proposal List";
                    }
                    action(UnderApprovalGeM)
                    {
                        ApplicationArea = All;
                        Caption = 'GeM Purch. Proposal Under App.List';
                        RunObject = page "GeM Purch. Proposal Under App";
                    }
                    action(ApprovedGeM)
                    {

                        ApplicationArea = All;
                        Caption = 'GeM Purchase Proposal Approved List';
                        RunObject = page "GeM Proposal Approved List";
                    }
                }
                group(DirectPurchase)
                {
                    Caption = 'Direct Purchase Proposal';
                    action(Open)
                    {
                        ApplicationArea = All;
                        Caption = 'Direct Purchase Proposal List';
                        RunObject = page "Purchase Proposal List";
                    }
                    action(UnderApproval)
                    {
                        ApplicationArea = All;
                        Caption = 'Direct Purch. Proposal Under App.List';
                        RunObject = page "Purch. Proposal Under App List";
                    }
                    action(Approved)
                    {
                        ApplicationArea = All;
                        Caption = 'Direct Purchase Proposal Approved List';
                        RunObject = page "Purch. Proposal Approved List";
                    }
                }
            }
            group("Group")
            {
                Caption = 'Purchasing';
                action("Vendors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                }
                action("Contacts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contacts';
                    Visible = false;
                    RunObject = page "Contact List";
                }
                action("Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                    Visible = False;
                    RunObject = page "Purchase Quotes";
                }
                action("GemOrders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Gem Purchase Orders';
                    RunObject = page "Gem Purchase Order List";
                }
                action("DirectOrders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Purchase Orders';
                    RunObject = page "Direct Purchase Order List";
                }
                action("Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    Visible = false;
                    RunObject = page "Purchase Order List";
                }
                action("Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Purchase Orders';
                    Visible = false;
                    RunObject = page "Blanket Purchase Orders";
                }
                action("Return Orders")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Purchase Return Orders';
                    RunObject = page "Purchase Return Order List";
                }
                action("Transfer Orders")
                {
                    ApplicationArea = Location;
                    Caption = 'Transfer Orders';
                    RunObject = page "Transfer Orders";
                }
                action("Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admin Purchase Invoices';
                    RunObject = page "Admin Invoices";
                }
                action("Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
                action("Certificates of Supply")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificates of Supply';
                    Visible = False;
                    RunObject = page "Certificates of Supply";
                }
                action("Subcontracting Worksheet")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Subcontracting Worksheets';
                    Visible = false;
                    RunObject = page "Subcontracting Worksheet";
                }
                action("Purchase Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    RunObject = page "Purchase Journal";
                }
                group("Group1")
                {
                    Caption = 'Budgets & Analysis';
                    action("Purchase Budgets")
                    {
                        ApplicationArea = PurchaseBudget;
                        Caption = 'Purchase Budgets';
                        Visible = false;
                        RunObject = page "Budget Names Purchase";
                    }
                    action("Purchase Analysis Reports")
                    {
                        ApplicationArea = PurchaseAnalysis;
                        Caption = 'Purchase Analysis Reports';
                        Visible = false;

                        RunObject = page "Analysis Report Purchase";
                    }
                    action("Analysis by Dimensions")
                    {
                        ApplicationArea = Dimensions, PurchaseAnalysis;
                        Caption = 'Purchase Analysis by Dimensions';
                        Visible = false;
                        RunObject = page "Analysis View List Purchase";
                    }
                    action("Item Dimensions - Detail")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Detail';
                        Visible = False;
                        RunObject = report "Item Dimensions - Detail";
                    }
                    action("Item Dimensions - Total")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Total';
                        Visible = false;
                        RunObject = report "Item Dimensions - Total";
                    }
                }
                group("Group2")
                {
                    Caption = 'Registers/Entries';
                    action("Purchase Quote Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Quote Archives';
                        Visible = false;
                        RunObject = page "Purchase Quote Archives";
                    }
                    action("Purchase Order Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        Caption = 'Purchase Order Archives';
                        RunObject = page "Purchase Order Archives";

                    }
                    action("Posted Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        Visible = false;
                        RunObject = page "Posted Return Shipments";
                    }
                    action("Posted Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Credit Memos';
                        Visible = false;
                        RunObject = page "Posted Purchase Credit Memos";
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("G/L Registers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        Visible = false;
                        RunObject = page "G/L Registers";
                    }
                    action("Item Tracing")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item Tracing';
                        Visible = false;
                        RunObject = page "Item Tracing";
                    }
                    action("Purchase Return Order Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        Caption = 'Purchase Return Order Archives';
                        RunObject = page "Purchase Return List Archive";
                    }
                    action("Vendor Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                    }
                    action("Value Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Value Entries';
                        Visible = false;
                        RunObject = page "Value Entries";
                    }
                }
                group("Group3")
                {
                    Caption = 'Reports';
                    action("Inventory Purchase Orders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory Purchase Orders';
                        RunObject = report "Inventory Purchase Orders";
                    }
                    action("Inventory - Transaction Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Transaction Detail';
                        RunObject = report "Inventory - Transaction Detail";
                    }
                    action("Inventory - Reorders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Reorders';
                        RunObject = report "Inventory - Reorders";
                    }
                    action("Item/Vendor Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = report "Item/Vendor Catalog";
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                    }
                    action("Inventory Cost and Price List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Cost and Price List';
                        RunObject = report "Inventory Cost and Price List";
                    }
                    action("Inventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Inventory Availability")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Availability';
                        RunObject = report "Inventory Availability";
                    }
                    action("Item Charges - Specification")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Vendor Purchases';
                        RunObject = report "Inventory - Vendor Purchases";
                    }
                    action("Item Substitutions")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    // action("Order")
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Order';
                    //     RunObject = codeunit 8815;
                    // }
                    action("Purchasing Deferral Summary")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Purchasing Deferral Summary';
                        RunObject = report "Deferral Summary - Purchasing";
                    }
                }
            }
            // group(BillPayment)//nitin 08-08-2023
            // {
            //     Caption = 'Bill Payment';
            //     Image = ResourcePlanning;
            //     action(VendorPayment)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Bill Payment';
            //         RunObject = Page 50690;
            //     }
            //     action(PendingVendorPayment)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Pending Bill Payment';
            //         RunObject = Page 50693;
            //     }
            //     action(ApprovedVendorPayment)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Approved Bill Payment';
            //         RunObject = Page 50697;
            //     }
            // }

            /*
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = ResourcePlanning;
                action("Purchase Order")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order';
                    RunObject = Page 9307;
                }
                action("Purchase Return")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Return';
                    RunObject = Page 9311;
                }
            }
            */
            group("Warehouse Receipt")
            {
                Caption = 'Warehouse Receipt';
                Image = ResourcePlanning;
                action("Material Receipt Note")
                {
                    ApplicationArea = All;
                    Caption = 'Material Receipt Note';
                    RunObject = Page 7332;
                }
                action("Warehouse shipment List")
                {
                    ApplicationArea = All;
                    Caption = 'Warehouse shipment List';
                    RunObject = Page 7339;
                }
                action("Warehouse Register")
                {
                    ApplicationArea = All;
                    Caption = 'Warehouse Register';
                    RunObject = Page 7325;
                }
            }

            group(Issue)
            {
                Caption = 'Issue';
                Image = ResourcePlanning;
                action("Requisition Received From Section")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Received From Section';
                    RunObject = Page 50214;
                }
                action("Issue From Store")
                {
                    ApplicationArea = All;
                    Caption = 'Issue From Store';
                    RunObject = Page 50208;
                }
                action("Issued/Closed Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Issued/Closed Requisition';
                    Image = PostedReceipt;
                    RunObject = Page 50212;
                }
            }
            // group("Group42")
            // {
            //     Caption = 'Fixed Assets';
            //     action("Fixed Assets")
            //     {
            //         ApplicationArea = FixedAssets;
            //         Caption = 'Fixed Assets';
            //         RunObject = page "Fixed Asset List";
            //     }
            //     action("Insurance")
            //     {
            //         ApplicationArea = FixedAssets;
            //         Caption = 'Insurance';
            //         RunObject = page "Insurance List";
            //     }
            //     action("Calculate Depreciation...")
            //     {
            //         ApplicationArea = FixedAssets;
            //         Caption = 'Calculate Depreciation...';
            //         RunObject = report "Calculate Depreciation";
            //     }
            //     action("Fixed Assets...")
            //     {
            //         ApplicationArea = FixedAssets;
            //         Caption = 'Index Fixed Assets...';
            //         RunObject = report "Index Fixed Assets";
            //     }
            //     action("Insurance...")
            //     {
            //         ApplicationArea = FixedAssets;
            //         Caption = 'Index Insurance...';
            //         RunObject = report "Index Insurance";
            //     }
            //     group("Group43")
            //     {
            //         Caption = 'Journals';
            //         action("G/L Journals")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA G/L Journals';
            //             RunObject = page "Fixed Asset G/L Journal";
            //         }
            //         action("FA Journals")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Journals';
            //             RunObject = page "Fixed Asset Journal";
            //         }
            //         action("FA Reclass. Journal")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Reclassification Journals';
            //             RunObject = page "FA Reclass. Journal";
            //         }
            //         action("Insurance Journals")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Insurance Journals';
            //             RunObject = page "Insurance Journal";
            //         }
            //         action("Recurring Journals1")
            //         {
            //             ApplicationArea = Suite, FixedAssets;
            //             Caption = 'Recurring General Journals';
            //             RunObject = page "Recurring General Journal";
            //         }
            //         action("Recurring Fixed Asset Journals")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Recurring Fixed Asset Journals';
            //             RunObject = page "Recurring Fixed Asset Journal";
            //         }
            //     }
            //     group("Group44")
            //     {
            //         Caption = 'Reports';
            //         group("Group45")
            //         {
            //             Caption = 'Fixed Assets';
            //             action("Posting Group - Net Change")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Posting Group - Net Change';
            //                 RunObject = report "FA Posting Group - Net Change";
            //             }
            //             action("Register1")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Register';
            //                 RunObject = report "Fixed Asset Register";
            //             }
            //             action("Acquisition List")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Acquisition List';
            //                 RunObject = report "Fixed Asset - Acquisition List";
            //             }
            //             action("Analysis1")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Analysis';
            //                 RunObject = report "Fixed Asset - Analysis";
            //             }
            //             action("Book Value 01")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Book Value 01';
            //                 RunObject = report "Fixed Asset - Book Value 01";
            //             }
            //             action("Book Value 02")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Book Value 02';
            //                 RunObject = report "Fixed Asset - Book Value 02";
            //             }
            //             action("Details")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Details';
            //                 RunObject = report "Fixed Asset - Details";
            //             }
            //             action("G/L Analysis")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA G/L Analysis';
            //                 RunObject = report "Fixed Asset - G/L Analysis";
            //             }
            //             action("List1")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA List';
            //                 RunObject = report "Fixed Asset - List";
            //             }
            //             action("Projected Value")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Projected Value';
            //                 RunObject = report "Fixed Asset - Projected Value";
            //             }
            //         }
            //         group("Group46")
            //         {
            //             Caption = 'Insurance';
            //             action("Uninsured FAs")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Uninsured FAs';
            //                 RunObject = report "Insurance - Uninsured FAs";
            //             }
            //             action("Register2")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Insurance Register';
            //                 RunObject = report "Insurance Register";
            //             }
            //             action("Analysis2")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Insurance Analysis';
            //                 RunObject = report "Insurance - Analysis";
            //             }
            //             action("Coverage Details")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Insurance Coverage Details';
            //                 RunObject = report "Insurance - Coverage Details";
            //             }
            //             action("List2")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Insurance List';
            //                 RunObject = report "Insurance - List";
            //             }
            //             action("Tot. Value Insured")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'FA Total Value Insured';
            //                 RunObject = report "Insurance - Tot. Value Insured";
            //             }
            //         }
            //         group("Group47")
            //         {
            //             Caption = 'Maintenance';
            //             action("Register3")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Maintenance Register';
            //                 RunObject = report "Maintenance Register";
            //             }
            //             action("Analysis3")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Maintenance Analysis';
            //                 RunObject = report "Maintenance - Analysis";
            //             }
            //             action("Details1")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Maintenance Details';
            //                 RunObject = report "Maintenance - Details";
            //             }
            //             action("Next Service")
            //             {
            //                 ApplicationArea = FixedAssets;
            //                 Caption = 'Maintenance Next Service';
            //                 RunObject = report "Maintenance - Next Service";
            //             }
            //         }
            //     }
            //     group("Group48")
            //     {
            //         Caption = 'Registers/Entries';
            //         action("FA Registers")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Registers';
            //             RunObject = page "FA Registers";
            //         }
            //         action("Insurance Registers")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Insurance Registers';
            //             RunObject = page "Insurance Registers";
            //         }
            //         action("FA Ledger Entries")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Ledger Entries';
            //             RunObject = page "FA Ledger Entries";
            //         }
            //         action("Maintenance Ledger Entries")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Maintenance Ledger Entries';
            //             RunObject = page "Maintenance Ledger Entries";
            //         }
            //         action("Ins. Coverage Ledger Entries")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Insurance Coverage Ledger Entries';
            //             RunObject = page "Ins. Coverage Ledger Entries";
            //         }
            //     }
            //     group("Group49")
            //     {
            //         Caption = 'Setup';
            //         action("FA Setup")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Setup';
            //             RunObject = page "Fixed Asset Setup";
            //         }
            //         action("FA Classes")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Classes';
            //             RunObject = page "FA Classes";
            //         }
            //         action("FA Subclasses")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Subclasses';
            //             RunObject = page "FA Subclasses";
            //         }
            //         action("FA Locations")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Locations';
            //             RunObject = page "FA Locations";
            //         }
            //         action("Insurance Types")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Insurance Types';
            //             RunObject = page "Insurance Types";
            //         }
            //         action("Maintenance")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Maintenance';
            //             RunObject = page "Maintenance";
            //         }
            //         action("Depreciation Books")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Depreciation Books';
            //             RunObject = page "Depreciation Book List";
            //         }
            //         action("Depreciation Tables")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Depreciation Tables';
            //             RunObject = page "Depreciation Table List";
            //         }
            //         action("FA Journal Templates")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Journal Templates';
            //             RunObject = page "FA Journal Templates";
            //         }
            //         action("FA Reclass. Journal Templates")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'FA Reclassification Journal Template';
            //             RunObject = page "FA Reclass. Journal Templates";
            //         }
            //         action("Insurance Journal Templates")
            //         {
            //             ApplicationArea = FixedAssets;
            //             Caption = 'Insurance Journal Templates';
            //             RunObject = page "Insurance Journal Templates";
            //         }
            //     }
            // }
            group(Transfer)
            {
                Caption = 'Transfer';
                Image = ResourcePlanning;
                action("Transfer Order")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Order';
                    RunObject = Page 5742;
                }
                action("Released Transfer Order")
                {
                    ApplicationArea = All;
                    Caption = 'Released Transfer Order';
                    RunObject = Page 5742;
                    RunPageView = WHERE(Status = FILTER(Released));
                }
            }
            /*
            group(Setup)
            {
                Caption = 'Setup';
                Image = ResourcePlanning;
                action(Items)
                {
                    ApplicationArea = All;
                    RunObject = Page 31;
                }
                action(Vendors)
                {
                    ApplicationArea = All;
                    RunObject = Page 27;
                }
            }
            */

            //...............kamlesh

            group(PaymentProposal)
            {
                Caption = 'Payment Proposal';
                Image = ResourcePlanning;
                // action(PaymentProposal1)//nitin 090823
                // {
                //     ApplicationArea = All;
                //     Caption = 'Payment Proposal';
                //     RunObject = Page 50664;
                // }
                action("Payment Proposal Under Proposal")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Proposal Under Proposal';
                    // RunObject = Page 50666;
                }
                action("Payment Proposal Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Proposal Approved';
                    //  RunObject = Page 50668;
                }
                action("Payment Proposal rejected")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Payment Proposal';
                    RunObject = Page 50225;
                }
            }

            group("Group4")
            {
                Caption = 'Planning';
                Visible = false;
                action("Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    RunObject = page "Item List";
                }
                action("Vendors1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                }
                action("Production Forecasts")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Forecasts';
                    RunObject = page "Demand Forecast Names";
                }
                action("Orders1")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    RunObject = page "Purchase Order List";
                }
                action("Orders2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    RunObject = page "Sales Order List";
                }
                action("Blanket Orders1")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders';
                    RunObject = page "Blanket Sales Orders";
                }
                action("Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Assembly Orders';
                    RunObject = page "Assembly Orders";
                }
                action("Orders3")
                {
                    ApplicationArea = Service;
                    Caption = 'Service Orders';
                    RunObject = page "Service Orders";
                }
                action("Jobs")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Jobs';
                    RunObject = page "Job List";
                }
                action("Planned Prod. Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Planned Production Orders';
                    RunObject = page "Planned Production Orders";
                }
                action("Firm Planned Prod. Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Firm Planned Prod. Orders';
                    RunObject = page "Firm Planned Prod. Orders";
                }
                action("Transfer Orders1")
                {
                    ApplicationArea = Location;
                    Caption = 'Transfer Orders';
                    RunObject = page "Transfer Orders";
                }
                action("Requisition Worksheets")
                {
                    ApplicationArea = Planning;
                    Caption = 'Requisition Worksheets';
                    RunObject = page "Req. Worksheet";
                }
                action("Recurring Req. Worksheet")
                {
                    ApplicationArea = Planning;
                    Caption = 'Recurring Requisition Worksheets';
                    RunObject = page "Recurring Req. Worksheet";
                }
                action("Order Planning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Order Planning';
                    RunObject = page "Order Planning";
                }
                group("Group5")
                {
                    Caption = 'Reports';
                    action("Purchase Reservation Avail.")
                    {
                        ApplicationArea = Reservation;
                        Caption = 'Purchase Reservation Avail.';
                        RunObject = report "Purchase Reservation Avail.";
                    }
                    action("Nonstock Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Nonstock Item Sales';
                        RunObject = report "Catalog Item Sales";
                    }
                    action("Item/Vendor Catalog1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = report "Item/Vendor Catalog";
                    }
                    action("Prod. Order - Shortage List")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Prod. Order - Shortage List';
                        RunObject = report "Prod. Order - Shortage List";
                    }
                    action("Prod. Order - Mat. Requisition")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Prod. Order - Mat. Requisition';
                        RunObject = report "Prod. Order - Mat. Requisition";
                    }
                    action("Purchase Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Statistics';
                        RunObject = report "Purchase Statistics";
                    }
                    action("Item Substitutions1")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    group("Group6")
                    {
                        Caption = 'Vendor';
                        action("Vendor - Balance to Date")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Balance to Date';
                            RunObject = report "Vendor - Balance to Date";
                        }
                        action("Vendor/Item Purchases1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor/Item Purchases';
                            RunObject = report "Vendor/Item Purchases";
                        }
                        action("Vendor - Purchase List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Purchase List';
                            RunObject = report "Vendor - Purchase List";
                        }
                        action("Vendor - Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Trial Balance';
                            RunObject = report "Vendor - Trial Balance";
                        }
                        action("Vendor - Detail Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Detail Trial Balance';
                            RunObject = report "Vendor - Detail Trial Balance";
                        }
                        action("Vendor - Top 10 List")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Vendor - Top 10 List';
                            RunObject = report "Vendor - Top 10 List";
                        }
                        action("Vendor - List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - List';
                            RunObject = report "Vendor - List";
                        }
                        action("Vendor - Summary Aging")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Summary Aging';
                            RunObject = report "Vendor - Summary Aging";
                        }
                        action("Vendor Item Catalog")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor Item Catalog';
                            RunObject = report "Vendor Item Catalog";
                        }
                    }
                    group("Group7")
                    {
                        Caption = 'Inventory';
                        Visible = false;
                        action("Inventory - Cost Variance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Cost Variance';
                            RunObject = report "Inventory - Cost Variance";
                        }
                        action("Inventory - Vendor Purchases1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Vendor Purchases';
                            RunObject = report "Inventory - Vendor Purchases";
                        }
                        action("Inventory - Availability Plan")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Availability Plan';
                            RunObject = report "Inventory - Availability Plan";
                        }
                        action("Inventory Purchase Orders1")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Inventory Purchase Orders';
                            RunObject = report "Inventory Purchase Orders";
                        }
                        action("Inventory - List1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - List';
                            RunObject = report "Inventory - List";
                        }
                        action("Inventory - Inbound Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Inbound Transfer';
                            RunObject = report "Inventory - Inbound Transfer";
                        }
                        action("Inventory Cost and Price List1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Cost and Price List';
                            RunObject = report "Inventory Cost and Price List";
                        }
                    }
                }
            }
            group("Group8")
            {
                Caption = 'Inventory & Costing';
                Visible = false;
                action("Items1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    RunObject = page "Item List";
                }
                action("Nonstock Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nonstock Items';
                    RunObject = page "Catalog Item List";
                }
                action("Stock keeping Units")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Stockkeeping Units';
                    RunObject = page "Stockkeeping Unit List";
                }
                action("Adjust Cost - Item Entries...")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Cost Item Entries';
                    RunObject = report "Adjust Cost - Item Entries";
                }
                action("Standard Costs Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Costs Worksheet';
                    RunObject = page "Standard Cost Worksheet";
                }
                action("Adjust Item Costs/Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Item Costs/Prices';
                    RunObject = report "Adjust Item Costs/Prices";
                }
                group("Group9")
                {
                    Caption = 'Journals';
                    action("Item Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Journals';
                        RunObject = page "Item Journal";
                    }
                    action("Item Reclass. Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Reclassification Journals';
                        RunObject = page "Item Reclass. Journal";
                    }
                    action("Recurring Item Journals")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Recurring Item Journals';
                        RunObject = page "Recurring Item Jnl.";
                    }
                }
                group("Group10")
                {
                    Caption = 'Reports';
                    action("Inventory - List2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Item Age Composition - Qty.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Qty.';
                        RunObject = report "Item Age Composition - Qty.";
                    }
                    action("Inventory - Cost Variance1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Cost Variance';
                        RunObject = report "Inventory - Cost Variance";
                    }
                    action("Item Charges - Specification1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Inventory - Inbound Transfer1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Inbound Transfer';
                        RunObject = report "Inventory - Inbound Transfer";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                    }
                    action("Inventory Availability1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Availability';
                        RunObject = report "Inventory Availability";
                    }
                    action("Item Register - Quantity")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Quantity';
                        RunObject = report "Item Register - Quantity";
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                    }
                    action("Item Expiration - Quantity")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item Expiration - Quantity';
                        RunObject = report "Item Expiration - Quantity";
                    }
                }
            }
            group("Inventory_Setup1")
            {
                Caption = 'GST Setup';
                action("GST Group")
                {
                    ApplicationArea = All;
                    Caption = 'GST Group';
                    RunObject = Page 18001;
                }
                action("GST Component")
                {
                    ApplicationArea = All;
                    Caption = 'GST Component';
                    RunObject = Page 18202;
                }
                action("GST Posting Setup")
                {
                    ApplicationArea = All;
                    Caption = 'GST Posting Setup';
                    RunObject = Page 18003;
                }
                action("GST Setup")
                {
                    ApplicationArea = All;
                    Caption = 'GST Setup';
                    RunObject = Page 18008;
                }
                action("VAT Posting Setup")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'VAT Posting Setup';
                    RunObject = Page 472;
                }
                action("GST Configuration")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'GST Configuration';
                    //RunObject = Page 16407;
                }
            }
            group("Group11")
            {
                Caption = 'Setup';
                action("Purchases & Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchases & Payables Setup';
                    RunObject = page "Purchases & Payables Setup";
                }
                action("Standard Purchase Codes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Standard Purchase Codes';
                    RunObject = page "Standard Purchase Codes";
                }
                action("Purchasing Codes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchasing Codes';
                    RunObject = page "Purchasing Codes";
                }
                action("Shipment Methods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Shipment Methods';
                    RunObject = page "Shipment Methods";
                }
                action("Return Reasons")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Return Reasons';
                    RunObject = page "Return Reasons";
                }
                action("Report Selection Purchase")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selections Purchase';
                    RunObject = page "Report Selection - Purchase";
                }
                action("Req. Worksheet")
                {
                    ApplicationArea = Planning;
                    Caption = 'Requisition Worksheet Templates';
                    RunObject = page "Req. Worksheet Templates";
                }
                action("Units of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Units of Measure';
                    RunObject = page "Units of Measure";
                }
                action("Manufacturers")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Manufacturers';
                    RunObject = page "Manufacturers";
                }
                action("Nonstock Item Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nonstock Item Setup';
                    RunObject = page "Catalog Item Setup";
                }
                action("Item Journal Templates")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Journal Templates';
                    RunObject = page "Item Journal Templates";
                }
                action("Salespeople")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salespeople/Purchasers';
                    RunObject = page "Salespersons/Purchasers";
                }
                action("Item Disc. Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Discount Groups';
                    RunObject = page "Item Disc. Groups";
                }
                action("Item Tracking Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Tracking Codes';
                    RunObject = page "Item Tracking Codes";
                }
                action("Inventory Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Setup';
                    RunObject = page "Inventory Setup";
                }
                action("Requisition Worksheets1")
                {
                    ApplicationArea = Planning;
                    Caption = 'Requisition Worksheets';
                    RunObject = page "Req. Worksheet";
                }
                action("NTA Approval Setup")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'NTA Approval Setup';
                    RunObject = Page 50131;
                }
                group("Group12")
                {
                    Caption = 'Purchase Analysis';
                    action("Analysis Types")
                    {
                        ApplicationArea = SalesAnalysis, PurchaseAnalysis, InventoryAnalysis;
                        Caption = 'Analysis Types';
                        RunObject = page "Analysis Types";
                    }
                    action("Analysis by Dimensions1")
                    {
                        ApplicationArea = Dimensions, PurchaseAnalysis;
                        Caption = 'Purchase Analysis by Dimensions';
                        RunObject = page "Analysis View List Purchase";
                    }
                    action("Analysis Column Templates")
                    {
                        ApplicationArea = PurchaseAnalysis;
                        Caption = 'Purch. Analysis Column Templates';
                        RunObject = report "Run Purch. Analysis Col. Temp.";
                    }
                    action("Analysis Line Templates")
                    {
                        ApplicationArea = PurchaseAnalysis;
                        Caption = 'Purch. Analysis Line Templates';
                        RunObject = report "Run Purch. Analysis Line Temp.";
                    }
                }
            }
        }
        area(Processing)
        {
            // action("Item_Journal")
            //  {
            //     ApplicationArea = All;
            //   Caption = 'Item Journal';
            //     RunObject = Page 40;
            //  }
            action(Notification)

            {
                ApplicationArea = All;
                RunObject = Page 50192;

                Image = ReceiptReminder;

            }
        }

    }

}

