page 50810 "Temp Purch Praposal Line"
{
    ApplicationArea = All;
    Caption = 'Temp Purch Praposal Line';
    PageType = List;
    SourceTable = "Purchase Proposal Line";
    UsageCategory = Lists;
    Permissions = TableData 50097 = rimd;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Act. Rem. Indent Qty"; Rec."Act. Rem. Indent Qty")
                {
                    ToolTip = 'Specifies the value of the Act. Rem. Indent Qty field.';
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field.';
                }
                field("Approved Quantity"; Rec."Approved Quantity")
                {
                    ToolTip = 'Specifies the value of the Approved Quantity field.';
                }
                field("Approved Quantity (Base)"; Rec."Approved Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Approved Quantity (Base) field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Capital Item"; Rec."Capital Item")
                {
                    ToolTip = 'Specifies the value of the Capital Item field.';
                }
                field("Consumption Type"; Rec."Consumption Type")
                {
                    ToolTip = 'Specifies the value of the Consumption Type field.';
                }
                field("Demand Order Date"; Rec."Demand Order Date")
                {
                    ToolTip = 'Specifies the value of the Demand Order Date field.';
                }
                field("Demand Order No."; Rec."Demand Order No.")
                {
                    ToolTip = 'Specifies the value of the Demand Order No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Description 2 New"; Rec."Description 2 New")
                {
                    ToolTip = 'Specifies the value of the Description 2 New field.';
                }
                field("Description 3"; Rec."Description 3")
                {
                    ToolTip = 'Specifies the value of the Description 3 field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost field.';
                }
                field("Estimated Cost Including GST"; Rec."Estimated Cost Including GST")
                {
                    ToolTip = 'Specifies the value of the Estimated Cost Including GST field.';
                }
                field("Excise Prod. Posting Group"; Rec."Excise Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Excise Prod. Posting Group field.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                }
                field("GST %"; Rec."GST %")
                {
                    ToolTip = 'Specifies the value of the GST % field.';
                }
                field("GST Amount"; Rec."GST Amount")
                {
                    ToolTip = 'Specifies the value of the GST Amount field.';
                }
                field("GST Include"; Rec."GST Include")
                {
                    ToolTip = 'Specifies the value of the GST Include field.';
                }
                field("Gen.Prod.Posting Group"; Rec."Gen.Prod.Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen.Prod.Posting Group field.';
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ToolTip = 'Specifies the value of the Indent Date field.';
                }
                field("Inventory Main Store"; Rec."Inventory Main Store")
                {
                    ToolTip = 'Specifies the value of the Inventory Main Store field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ToolTip = 'Specifies the value of the Order Quantity field.';
                }
                field("Original Quantity"; Rec."Original Quantity")
                {
                    ToolTip = 'Specifies the value of the Original Quantity field.';
                }
                field("PO Completed"; Rec."PO Completed")
                {
                    ToolTip = 'Specifies the value of the PO Completed field.';
                }
                field("PO No."; Rec."PO No.")
                {
                    ToolTip = 'Specifies the value of the PO No. field.';
                }
                field("PO Outstanding Quantity"; Rec."PO Outstanding Quantity")
                {
                    ToolTip = 'Specifies the value of the PO Outstanding Quantity field.';
                }
                field("PO Received Quantity"; Rec."PO Received Quantity")
                {
                    ToolTip = 'Specifies the value of the PO Received Quantity field.';
                }
                field("PO Selected"; Rec."PO Selected")
                {
                    ToolTip = 'Specifies the value of the PO Select field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.';
                }
                field("Production Order Qty"; Rec."Production Order Qty")
                {
                    ToolTip = 'Specifies the value of the Production Order Qty field.';
                }
                field("Purchase Line No"; Rec."Purchase Line No")
                {
                    ToolTip = 'Specifies the value of the Purchase Line No field.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ToolTip = 'Specifies the value of the Purchase Type field.';
                }
                field("Qty On Component Line"; Rec."Qty On Component Line")
                {
                    ToolTip = 'Specifies the value of the Qty On Component Line field.';
                }
                field("Qty. per Unit Of Measure"; Rec."Qty. per Unit Of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit Of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                }
                field("Quantity-Base unit of Measure"; Rec."Quantity-Base unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Quantity-Base unit of Measure field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ToolTip = 'Specifies the value of the Pending Indent QTY field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Requisition Line No."; Rec."Requisition Line No.")
                {
                    ToolTip = 'Specifies the value of the Requisition Line No. field.';
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Sale Order Date"; Rec."Sale Order Date")
                {
                    ToolTip = 'Specifies the value of the Sale Order Date field.';
                }
                field("Sale Order No."; Rec."Sale Order No.")
                {
                    ToolTip = 'Specifies the value of the Sale Order No. field.';
                }
                field("Select Item For Praposal"; Rec."Select Item For Praposal")
                {
                    ToolTip = 'Specifies the value of the Select Item For Praposal field.';
                }
                field(Selected; Rec.Selected)
                {
                    ToolTip = 'Specifies the value of the Selected field.';
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ToolTip = 'Specifies the value of the Shelf No. field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ToolTip = 'Specifies the value of the Stock In Hand field.';
                }
                field("Sub Categories Code"; Rec."Sub Categories Code")
                {
                    ToolTip = 'Specifies the value of the Sub Categories Code field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Transfer form Code"; Rec."Transfer form Code")
                {
                    ToolTip = 'Specifies the value of the Transfer form Code field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                }
                field("Units Per Parcel"; Rec."Units Per Parcel")
                {
                    ToolTip = 'Specifies the value of the Units Per Parcel field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
            }
        }
    }
}
