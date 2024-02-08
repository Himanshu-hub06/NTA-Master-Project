page 50184 "Approve Pay Proposal Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 39;
    SourceTableView = WHERE("Document Type" = FILTER('Invoice'));

    layout
    {
        area(content)
        {
            repeater(Repeater11)
            {
                /* //kamlesh date 08-02-2023
                field("No."; "No.")
                {
                    Editable = false;
                    ShowMandatory = TypeChosen;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        IF xRec."No." <> '' THEN
                            RedistributeTotalsOnAfterValidate;
                    end;
                }
                */
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                /* //kamlesh date 08-02-2023
               field(Quantity; Quantity)
               {
                   BlankZero = true;
                   ShowMandatory = TypeChosen;

                   trigger OnValidate()
                   begin
                       RedistributeTotalsOnAfterValidate;
                   end;
               }
               */
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {

                    trigger OnValidate()
                    begin
                        //  RedistributeTotalsOnAfterValidate;   //kamlesh date 08-02-2023
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    // ShowMandatory = TypeChosen;   //kamlesh date 08-02-2023

                    trigger OnValidate()
                    begin
                        //  RedistributeTotalsOnAfterValidate;   //kamlesh date 08-02-2023
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate; //kamlesh date 08-02-2023
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate; //kamlesh date 08-02-2023
                    end;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate; //kamlesh date 08-02-2023
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate; //kamlesh date 08-02-2023
                    end;
                }
                /* //kamlesh date 08-02-2023
                field("Assessable Value"; "Assessable Value")
                {
                    Visible = false;
                }
                field("TDS Nature of Deduction"; "TDS Nature of Deduction")
                {
                    Visible = false;
                }

                field("TDS Category"; "TDS Category")
                {
                }
                */
                field("TDS Amount"; Rec."TDS Amount")
                {
                }
                // field("Assessee Code"; "Assessee Code") //kamlesh date 08-02-2023
                // {
                // }
                field("TDS %"; Rec."TDS %")
                {
                }
                //     field("Nature of Remittance"; "Nature of Remittance")//Nitin 07-08-23
                //     {
                //         Visible = false;
                //     }
                //     field("GST Assessable Value"; "GST Assessable Value")
                //     {
                //     }
                //     field("GST Credit"; "GST Credit")
                //     {
                //         Visible = false;
                //     }
                //     field("GST Group Code"; "GST Group Code")
                //     {
                //     }
                //     field("GST Group Type"; "GST Group Type")
                //     {
                //     }
                //     field("HSN/SAC Code"; "HSN/SAC Code")
                //     {
                //     }
                //     // field("GST Base Amount"; "GST Base Amount") //kamlesh date 08-02-2023
                //     // {
                //     // }
                //     field("Total GST Amount"; "Total GST Amount")
                //     {
                //     }
                //     field("GST TDS/TCS"; "GST TDS/TCS")
                //     {
                //     }
                //     field("GST TCS State Code"; "GST TCS State Code")
                //     {
                //     }
                //     field("GST TDS/TCS Base Amount"; "GST TDS/TCS Base Amount")
                //     {
                //     }
                //     field("GST TDS/TCS %"; "GST TDS/TCS %")
                //     {
                //     }
                //     field("GST TDS/TCS Amount (LCY)"; "GST TDS/TCS Amount (LCY)")
                //     {
                //     }
                //     field(Exempted; Exempted)
                //     {
                //     }
                //     field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                //     {
                //         Visible = false;
                //     }
                //     field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                //     {
                //         Visible = false;
                //     }
                //     field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                //     {
                //         Visible = false;
                //     }
                //     /* //kamlesh date 08-02-2023
                //     field(ShortcutDimCode[3];ShortcutDimCode[3])
                //     {
                //         CaptionClass = '1,2,3';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(3), Dimension Value Type=CONST(Standard), Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                //         end;
                //     }
                //     field(ShortcutDimCode[4];ShortcutDimCode[4])
                //     {
                //         CaptionClass = '1,2,4';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(4),
                //                                                       Dimension Value Type=CONST(Standard),
                //                                                       Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                //         end;
                //     }
                //     field(ShortcutDimCode[5];ShortcutDimCode[5])
                //     {
                //         CaptionClass = '1,2,5';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(5),
                //                                                       Dimension Value Type=CONST(Standard),
                //                                                       Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                //         end;
                //     }
                //     field(ShortcutDimCode[6];ShortcutDimCode[6])
                //     {
                //         CaptionClass = '1,2,6';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(6),
                //                                                       Dimension Value Type=CONST(Standard),
                //                                                       Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                //         end;
                //     }
                //     field(ShortcutDimCode[7];ShortcutDimCode[7])
                //     {
                //         CaptionClass = '1,2,7';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(7),
                //                                                       Dimension Value Type=CONST(Standard),
                //                                                       Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                //         end;
                //     }
                //     field(ShortcutDimCode[8];ShortcutDimCode[8])
                //     {
                //         CaptionClass = '1,2,8';
                //         TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(8),
                //                                                       Dimension Value Type=CONST(Standard),
                //                                                       Blocked=CONST(No));
                //         Visible = false;

                //         trigger OnValidate()
                //         begin
                //             ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                //         end;
                //     }
                //     */
                //     field("Document No."; "Document No.")
                //     {
                //         Editable = false;
                //         Visible = false;
                //     }
                //     field("Line No."; "Line No.")
                //     {
                //         Editable = false;
                //         Visible = false;
                //     }
                //     field("Buy-From GST Registration No"; "Buy-From GST Registration No")
                //     {
                //         Editable = false;
                //     }
            }//Nitin 07-08-23
            group(Grp1)
            {
                group(Grp2)
                {
                    Visible = false;
                    field("Invoice Discount Amount"; TotalPurchaseLine."Inv. Discount Amount")
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;

                        trigger OnValidate()
                        var
                            PurchaseHeader: Record 38;
                            PurchaseLine: Record 39;
                        begin
                            PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                            PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount", PurchaseHeader);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                    field("Invoice Disc. Pct."; PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec))
                    {
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;
                    }
                }
                group(grp3)
                {
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = false;
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = false;
                    }
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                        Visible = false;
                    }
                    field(RefreshTotals; RefreshMessageText)
                    {
                        DrillDown = true;
                        Editable = false;
                        Enabled = RefreshMessageEnabled;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
                            DocumentTotals.PurchaseUpdateTotalsControls(
                              Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
                              TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
                        end;
                    }
                }
                // field("CWIP G/L Type"; "CWIP G/L Type") //kamlesh date 08-02-2023
                // {
                //     Visible = false;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData 90 = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    AccessByPermission = TableData 279 = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(GetReceiptLines)
                {
                    AccessByPermission = TableData 120 = R;
                    Caption = '&Get Receipt Lines';
                    Ellipsis = true;
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        GetReceipt;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments;
                    end;
                }
                action(ItemChargeAssignment)
                {
                    AccessByPermission = TableData 5800 = R;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action(DeferralSchedule)
                {
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;

                    trigger OnAction()
                    begin
                        PurchHeader.GET(PurchLine."Document Type", Rec."Document No.");
                        Rec.ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code");
                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    Image = Hierarchy;

                    trigger OnAction()
                    begin
                        ShowStrDetailsForm;
                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    Image = Excise;

                    trigger OnAction()
                    begin
                        ShowExcisePostingSetup;
                    end;
                }
                action("&Detailed Tax")
                {
                    Caption = '&Detailed Tax';
                    Image = TaxDetail;

                    trigger OnAction()
                    begin
                        ShowDetailedTaxEntryBuffer;
                    end;
                }
                action("Detailed GST")
                {
                    Caption = 'Detailed GST';
                    ApplicationArea = All;
                    Image = ServiceTax;
                    // RunObject = Page 16412;//kamlesh date 08-02-2023                                        
                    // RunPageLink = "Transaction Type" = FILTER('Purchase'), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF PurchHeader.GET(PurchLine."Document Type", Rec."Document No.") THEN;

        DocumentTotals.PurchaseUpdateTotalsControls(
          Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        // TypeChosen := HasTypeToFillMandatotyFields; //kamlesh date 08-02-2023
        CLEAR(DocumentTotals);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        TotalPurchaseHeader: Record 38;
        TotalPurchaseLine: Record 39;
        PurchHeader: Record 38;
        PurchLine: Record 39;
        TransferExtendedText: Codeunit 378;
        ItemAvailFormsMgt: Codeunit 353;
        PurchPriceCalcMgt: Codeunit 7010;
        PurchCalcDiscByType: Codeunit 66;
        DocumentTotals: Codeunit 57;
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        TypeChosen: Boolean;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure GetReceipt()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    local procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    local procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    local procedure ShowPrices()
    begin
        PurchHeader.GET(PurchLine."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    local procedure ShowLineDisc()
    begin
        PurchHeader.GET(PurchLine."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    procedure ShowStrDetailsForm()
    var
    // StrOrderLineDetails: Record 13795;
    // StrOrderLineDetailsForm: Page 16306;
    begin
        /*  //kamlesh date 08-02-2023
        StrOrderLineDetails.RESET;
        StrOrderLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
        StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
        StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
        StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        StrOrderLineDetails.SETRANGE("Item No.", "No.");
        StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
        StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
        StrOrderLineDetailsForm.RUNMODAL;
        */
    end;

    procedure ShowExcisePostingSetup()
    begin
        // GetExcisePostingSetup;  //kamlesh date 08-02-2023
    end;

    procedure ShowDetailedTaxEntryBuffer()
    var
    //   DetailedTaxEntryBuffer: Record 16480;
    begin
        /*
        DetailedTaxEntryBuffer.RESET;
        DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
        DetailedTaxEntryBuffer.SETRANGE("Transaction Type", DetailedTaxEntryBuffer."Transaction Type"::Purchase);
        DetailedTaxEntryBuffer.SETRANGE("Document Type", "Document Type");
        DetailedTaxEntryBuffer.SETRANGE("Document No.", "Document No.");
        DetailedTaxEntryBuffer.SETRANGE("Line No.", "Line No.");
        PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax", DetailedTaxEntryBuffer);
        */
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD;

        PurchHeader.GET(PurchLine."Document Type", Rec."Document No.");
        IF DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) THEN
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE;
    end;
}

