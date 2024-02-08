page 50115 "Finance & Budget"
{
    ApplicationArea = All;
    Caption = 'Finance Role Center';

    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            //group(Finance)
            //{

            // part("Store Activities"; "Store Activities")
            /*part("NTA Activities"; 50038)
            {
                Caption = '';
                Visible = true;
                ApplicationArea = All;
            }*/

            //}
        }
    }
    actions
    {
        area(sections)
        {
            group("Posting Setups")
            {
                Caption = 'Posting Setups';
                Image = Setup;
                ToolTip = 'To do all Posting Setups.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;

                action("General Ledger Setup")
                {
                    Caption = 'General Ledger Setup';
                    ApplicationArea = All;
                    RunObject = Page "General Ledger Setup";
                }
                action("Inventory Setup")
                {
                    Caption = 'Inventory Setup';
                    ApplicationArea = All;
                    RunObject = Page "Inventory Setup";
                }
                action("Gen. Prod. Posting Setup")
                {
                    Caption = 'Gen. Prod. Posting Setup';
                    ApplicationArea = All;
                    RunObject = Page "General Posting Setup";
                }
                action("Inventory Posting Setup")
                {
                    Caption = 'Inventory Posting Setup';
                    ApplicationArea = All;
                    RunObject = Page "Inventory Posting Setup";
                }
                action("Gen. Business Posting Groups")
                {
                    Caption = 'Gen. Business Posting Groups';
                    ApplicationArea = All;
                    RunObject = Page "Gen. Business Posting Groups";
                }

                action("Vendor Posting Groups")
                {
                    Caption = 'Vendor Posting Groups';
                    ApplicationArea = All;
                    RunObject = Page "Vendor Posting Groups";
                }

                action("Customer Posting Groups")
                {
                    Caption = 'Customer Posting Groups';
                    ApplicationArea = All;
                    RunObject = Page "Customer Posting Groups";
                }

            }

            group("Account Payable")

            {
                Caption = 'Account Payable';
                Image = Payables;
                ToolTip = 'To do all Account Payable.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                action("Purchase Quotes")
                {
                    Caption = 'Purchase Quotes';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Quotes";
                }
                action("Blanket Purchase Order")
                {
                    Caption = 'Blanket Purchase Order';
                    RunObject = Page "Blanket Purchase Orders";
                    ApplicationArea = All;
                }
                action("Purchase Order")
                {
                    Caption = 'Purchase Order';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Order List";
                }
                action("Purchase Invoice")
                {
                    Caption = 'Purchase Invoice';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Return Order")
                {
                    Caption = 'Purchase Return Order';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Return Order List";
                }
                action("Purchase Credit Memos")
                {
                    Caption = 'Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Credit Memos";
                }

            }

            group("Account Receivable")

            {
                Caption = 'Account Receivable';
                Image = Receivables;
                ToolTip = 'To do all Account Receivable.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                action("Sales Quotes")
                {
                    Caption = 'Service Quotes';
                    ApplicationArea = All;
                    RunObject = Page "Sales Quotes";
                }
                action("Blanket Sales Order")
                {
                    Caption = 'Blanket Service Order';
                    RunObject = Page "Blanket Sales Orders";
                    ApplicationArea = All;
                }
                action("Sales Order")
                {
                    Caption = 'Service Order';
                    ApplicationArea = All;
                    RunObject = Page "Sales Order List";
                }
                action("Sales Invoice")
                {
                    Caption = 'Service Invoice';
                    ApplicationArea = All;
                    RunObject = Page "Sales Invoice List";
                }
                action("Sales Return Order")
                {
                    Caption = 'Service Return Order';
                    ApplicationArea = All;
                    RunObject = Page "Sales Return Order List";
                }
                action("Sales Credit Memos")
                {
                    Caption = 'Service Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Sales Credit Memos";
                }

            }

            group("Vouchers")
            {
                Caption = 'Vouchers';
                Image = Bank;
                ToolTip = 'To do all Voucher Entries', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                action("Journal Voucher")
                {
                    Caption = 'Journal Voucher';
                    ApplicationArea = All;
                    RunObject = Page "Journal Voucher";
                }
                action("Payment Journal")
                {
                    Caption = 'Payment Journal';
                    ApplicationArea = All;
                    RunObject = Page "Payment Journal";
                }
                action("Cash Receipt Journal")
                {
                    Caption = 'Cash Receipt Voucher';
                    ApplicationArea = All;
                    RunObject = Page "Cash Receipt Journal";
                }
                action("Cash Payment Journal")
                {
                    Caption = 'Cash Payment Voucher';
                    ApplicationArea = All;
                    RunObject = Page "Cash Payment Voucher";
                }
                action("Bank Payment Journal")
                {
                    Caption = 'Bank Payment Voucher';
                    ApplicationArea = All;
                    RunObject = Page "Bank Payment Voucher";
                }
                action("Bank Receipt Journal")
                {
                    Caption = 'Bank Receipt Voucher';
                    ApplicationArea = All;
                    RunObject = Page "Bank Receipt Voucher";
                }

            }

            group("Posted Documents")

            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'To do all Posted Documents.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                action("Posted Purchase Receipt")
                {
                    Caption = 'Posted Purchase Receipts';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoice")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Posted Purchase Return Shipments")
                {
                    Caption = 'Posted Purchase Return Shipments';
                    ApplicationArea = All;
                    RunObject = Page "Posted Return Shipments";
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Posted Sales Shipment")
                {
                    Caption = 'Posted Service Shipment';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posteds Sales Invoices")
                {
                    Caption = 'Posted Service Invoices';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posteds Sales Return Receipt")
                {
                    Caption = 'Posted Service Return Receipt';
                    ApplicationArea = All;
                    RunObject = Page "Posted Return Receipts";
                }
                action("Posteds Sales Credit Memos")
                {
                    Caption = 'Posted Service Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Credit Memos";
                }

            }

            group("Reports")

            {
                Caption = 'Reports';
                Image = ResourcePlanning;
                ToolTip = 'To do all Tax Reports.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                action("Customer Top 10 List")
                {
                    Caption = 'Customer Top 10 List';
                    ApplicationArea = All;
                    RunObject = report "Customer - Top 10 List";
                }
                action("Vendor Top 10 List")
                {
                    Caption = 'Vendor Top 10 List';
                    ApplicationArea = All;
                    RunObject = report "Vendor - Top 10 List";
                }

            }
            group("Tax Reports")

            {
                Caption = 'Tax Reports';
                Image = ResourcePlanning;
                ToolTip = 'To do all Tax Reports.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;


            }
            group("Masters")

            {
                Caption = 'Masters';
                Image = Marketing;
                ToolTip = 'To do all Tax Reports.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;

                action("Items")
                {
                    Caption = 'Items';
                    ApplicationArea = All;
                    RunObject = Page "Item List";
                }
                action("Vendor")
                {
                    Caption = 'Vendor';
                    ApplicationArea = All;
                    RunObject = Page "Vendor List";
                }
                action("Customer")
                {
                    Caption = 'Customer';
                    ApplicationArea = All;
                    RunObject = Page "Customer List";
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    ApplicationArea = All;
                    RunObject = Page "Bank Account List";
                }
                action("Chart of Accounts")
                {
                    Caption = 'Chart of Accounts';
                    ApplicationArea = All;
                    RunObject = Page "Chart of Accounts";
                }
            }
        }
    }
}
