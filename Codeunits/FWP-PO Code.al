// /// <summary>
// /// Report Rep Purchase Order (ID 70018).
// /// </summary>
// report 70018 "Rep Purchase Order"
// {
//     ApplicationArea = All;
//     Caption = 'Order Confirmation';
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = './src\Purchase Order.rdl';
//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             column(DocNo_; "No.")
//             {
//             }
//             column(Posting_Date; "Posting Date")
//             {
//             }
//             column(CompInfoName; CompInfoRec.Name)
//             {
//             }
//             column(CompInfoRecPic; CompInfoRec.Picture)
//             {
//             }
//             column(LocationRecName; LocationRec.Name)
//             {
//             }
//             column(LocationRecName2; LocationRec."Name 2")
//             {
//             }
//             column(LocationRecAdd; LocationRec.Address)
//             {
//             }
//             column(LocationRecAdd2; LocationRec."Address 2")
//             {
//             }
//             column(LocationRecCity; LocationRec.City)
//             {
//             }
//             column(LocationRecPostCode; LocationRec."Post Code")
//             {
//             }
//             column(LocationRecGSTIN; LocationRec."GST Registration No.")
//             {
//             }
//             column(StateRecDesc; StateRec.Description)
//             {
//             }
//             column(VendorRecName; VendorRec.Name)
//             {
//             }
//             column(VendorRecAdd; VendorRec.Address)
//             {
//             }
//             column(VendorRecAdd2; VendorRec."Address 2")
//             {
//             }
//             column(VendorRecCity; VendorRec.City)
//             {
//             }
//             column(VendorRecPostCOde; VendorRec."Post Code")
//             {
//             }
//             column(StateVendRecDesc; StateVendRec.Description)
//             {
//             }
//             column(VendorRecGSTIN; VendorRec."GST Registration No.")
//             {
//             }

//             dataitem("Purchase Line"; "Purchase Line")
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 column(No_; "No.")
//                 {
//                 }
//                 column(Description; Description)
//                 {
//                 }
//                 column(HSN_SAC_Code; "HSN/SAC Code")
//                 {
//                 }
//                 column(Quantity; Quantity)
//                 {
//                 }
//                 column(Unit_of_Measure_Code; "Unit of Measure Code")
//                 {
//                 }
//                 column(Unit_Cost; "Unit Cost")
//                 {
//                 }
//                 column(Line_Amount; "Line Amount")
//                 {
//                 }
//                 column(Direct_Unit_Cost; "Direct Unit Cost")
//                 {
//                 }
//                 column(TaxamtCGST; TaxamtCGST)
//                 {
//                 }
//                 column(CGST_; "CGST%")
//                 {
//                 }
//                 column(TaxamtSGST; TaxamtSGST)
//                 {
//                 }
//                 column(SGST_; "SGST%")
//                 {
//                 }
//                 column(TaxamtIGST; TaxamtIGST)
//                 {
//                 }
//                 column(IGST_; "IGST%")
//                 {
//                 }
//                 column(CGSTAmt; CGSTAmt)
//                 {
//                 }
//                 column(SGSTAmt; SGSTAmt)
//                 {
//                 }
//                 column(IGSTAmt; IGSTAmt)
//                 {
//                 }
//                 column(atext; atext[1] + atext[2])
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin

//                     TaxamtCGST := 0;
//                     TaxamtSGST := 0;
//                     TaxamtIGST := 0;
//                     "SGST%" := 0;
//                     "CGST%" := 0;
//                     "IGST%" := 0;

//                     GSTSetup.Get();
//                     GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 CompInfoRec.get();
//                 CompInfoRec.CalcFields(Picture);

//                 IF LocationRec.Get("Location Code") THEN;
//                 IF StateRec.Get(LocationRec."State Code") THEN;
//                 IF VendorRec.Get("Buy-from Vendor No.") THEN;
//                 IF StateVendRec.Get(VendorRec."State Code") then;

//                 TotalLineAmt := 0;
//                 PurchaseLineRec.Reset;
//                 PurchaseLineRec.SetRange("Document No.", "No.");
//                 if PurchaseLineRec.FindSet then
//                     repeat
//                         TotalLineAmt += PurchaseLineRec."Line Amount";

//                         GSTSetup.Get();
//                         TotalGSTAmountinText(TaxTransactionValue, PurchaseLineRec, GSTSetup);
//                     until PurchaseLineRec.next = 0;

//                 convr.InitTextVariable;
//                 convr.FormatNoText(atext, TotalLineAmt + CGSTAmt + SGSTAmt + IGSTAmt, "Currency Code");

//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     var
//         CompInfoRec: Record "Company Information";
//         VendorRec: Record Vendor;
//         LocationRec: Record Location;
//         StateRec: Record State;
//         StateVendRec: Record State;

//         TCSEntryAmt: Decimal;
//         TCSEntryPrc: Decimal;
//         TaxamtSGST: Decimal;
//         TaxamtCGST: Decimal;
//         TaxamtIGST: Decimal;
//         "SGST%": Decimal;
//         "IGST%": Decimal;
//         "CGST%": Decimal;
//         SGSTAmt: Decimal;
//         IGSTAmt: Decimal;
//         CGSTAmt: Decimal;
//         IGSTLbl: Label 'IGST';
//         SGSTLbl: Label 'SGST';
//         CGSTLbl: Label 'CGST';
//         CESSLbl: Label 'CESS';
//         GSTLbl: Label 'GST';
//         GSTCESSLbl: Label 'GST CESS';
//         TaxTransactionValue: Record "Tax Transaction Value";
//         GSTSetup: Record "GST Setup";
//         PurchaseLineRec: Record "Purchase Line";
//         TotalLineAmt: Decimal;
//         Convr: Report "Check Report New";
//         atext: array[2] of Text;
//         ShipToAddRec: Record "Ship-to Address";
//         ShipToName: Text;
//         ShipToAdd: Text;
//         ShipToAdd2: Text;
//         ShipToCity: Text;
//         ShipToPostCode: Code[30];
//         ShipToStateDesc: Text;
//         ShipToGSTIN: Code[20];
//         StateBillRec: Record State;
//         StateShipRec: Record State;
//         VendShipToRec: Record Vendor;


//     /// <summary>
//     /// GetGSTRoundingPrecision.
//     /// </summary>
//     /// <param name="ComponentName">Code[30].</param>
//     /// <returns>Return value of type Decimal.</returns>
//     procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
//     var
//         TaxComponent: Record "Tax Component";
//         GSTSetup: Record "GST Setup";
//         GSTRoundingPrecision: Decimal;
//     begin
//         if not GSTSetup.Get() then
//             exit;
//         GSTSetup.TestField("GST Tax Type");

//         TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
//         TaxComponent.SetRange(Name, ComponentName);
//         TaxComponent.FindFirst();
//         if TaxComponent."Rounding Precision" <> 0 then
//             GSTRoundingPrecision := TaxComponent."Rounding Precision"
//         else
//             GSTRoundingPrecision := 1;
//         exit(GSTRoundingPrecision);
//     end;

//     local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
//        PurchaseLine1: Record "Purchase Line";
//        GSTSetup: Record "GST Setup")
//     var
//         ComponentName: Code[30];
//     begin
//         ComponentName := GetComponentName(PurchaseLine1, GSTSetup);

//         if (PurchaseLine1.Type <> PurchaseLine1.Type::" ") then begin
//             TaxTransactionValue.Reset();
//             TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine1.RecordId);
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//             TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//             TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//             if TaxTransactionValue.FindSet() then
//                 repeat
//                     case TaxTransactionValue."Value ID" of
//                         6:
//                             begin
//                                 TaxamtSGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                                 "SGST%" := TaxTransactionValue.Percent;
//                                 SGSTAmt += taxamtSGST;
//                             end;
//                         2:
//                             begin
//                                 TaxAmtCGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                                 "CGST%" := TaxTransactionValue.Percent;
//                                 CGSTAmt += TaxAmtCGST;
//                             end;
//                         3:
//                             begin
//                                 TaxamtIGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                                 "IGST%" := TaxTransactionValue.Percent;
//                                 IGSTAmt += taxamtIGST;
//                             end;
//                     end;
//                 until TaxTransactionValue.Next() = 0;
//         end;

//     end;

//     local procedure GetComponentName(PurchaseLine1: Record "Purchase Line";
//         GSTSetup: Record "GST Setup"): Code[30]
//     var
//         ComponentName: Code[30];
//     begin
//         if GSTSetup."GST Tax Type" = GSTLbl then
//             if PurchaseLine1."GST Jurisdiction Type" = PurchaseLine1."GST Jurisdiction Type"::Interstate then
//                 ComponentName := IGSTLbl
//             else
//                 ComponentName := CGSTLbl
//         else
//             if GSTSetup."Cess Tax Type" = GSTCESSLbl then
//                 ComponentName := CESSLbl;
//         exit(ComponentName)
//     end;

//     local procedure GetTCSAmount(TaxTransactionValue: Record "Tax Transaction Value";
//         PurchaseLine: Record "Purchase Line";
//         TCSSetup: Record "TCS Setup")
//     begin
//         if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
//             TaxTransactionValue.Reset();
//             TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
//             TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
//             TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//             TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//             if TaxTransactionValue.FindSet() then
//                 repeat
//                     TCSEntryAmt += TaxTransactionValue.Amount;
//                     TCSEntryPrc := TaxTransactionValue.Percent;

//                 until TaxTransactionValue.Next() = 0;
//         end;
//         TCSEntryAmt := Round(TCSEntryAmt, 0.01);
//     end;

//     local procedure TotalGSTAmountinText(TaxTransactionValue: Record "Tax Transaction Value";
//        PurchaseLine1: Record "Purchase Line";
//        GSTSetup: Record "GST Setup")
//     var
//         ComponentName: Code[30];
//     begin
//         ComponentName := GetComponentName(PurchaseLine1, GSTSetup);

//         if (PurchaseLine1.Type <> PurchaseLine1.Type::" ") then begin
//             TaxTransactionValue.Reset();
//             TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine1.RecordId);
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//             TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//             TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//             if TaxTransactionValue.FindSet() then
//                 repeat
//                     case TaxTransactionValue."Value ID" of
//                         6:
//                             begin
//                                 SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                             end;
//                         2:
//                             begin
//                                 CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                             end;
//                         3:
//                             begin
//                                 IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
//                             end;
//                     end;
//                 until TaxTransactionValue.Next() = 0;
//         end;

//     end;

// }
