// codeunit 50760 "Adv Expense Mgt."
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         TrailingSalesOrdersSetup: Record "50760";
//         SalesHeader: Record "36";

//     procedure OnOpenPage(var TrailingSalesOrdersSetup: Record "50760")
//     begin
//         WITH TrailingSalesOrdersSetup DO
//           IF NOT GET(USERID) THEN BEGIN
//             LOCKTABLE;
//             "User ID" := USERID;a
//             "Use Work Date as Base" := TRUE;
//             "Period Length" := "Period Length"::Month;
//             "Value to Calculate" := "Value to Calculate"::"No. of Orders";
//             "Chart Type" := "Chart Type"::"Stacked Column";
//             INSERT;
//           END;
//     end;

//     procedure DrillDown(var BusChartBuf: Record "485")
//     var
//         SalesHeader: Record "36";
//         ToDate: Date;
//         Measure: Integer;
//     begin
//         Measure := BusChartBuf."Drill-Down Measure Index";
//         IF (Measure < 0) OR (Measure > 3) THEN
//           EXIT;
//         TrailingSalesOrdersSetup.GET(USERID);
//         SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
//         IF TrailingSalesOrdersSetup."Show Orders" = TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders" THEN
//           SalesHeader.SETFILTER("Shipment Date",'<%1',TrailingSalesOrdersSetup.GetStartDate);
//         IF EVALUATE(SalesHeader.Status,BusChartBuf.GetMeasureValueString(Measure),9) THEN
//           SalesHeader.SETRANGE(Status,SalesHeader.Status);

//         ToDate := BusChartBuf.GetXValueAsDate(BusChartBuf."Drill-Down X Index");
//         SalesHeader.SETRANGE("Document Date",0D,ToDate);
//         PAGE.RUN(PAGE::"Sales Order List",SalesHeader);
//     end;

//     procedure UpdateData(var BusChartBuf: Record "485")
//     var
//         ChartToStatusMap: array [4] of Integer;
//         ToDate: array [5] of Date;
//         FromDate: array [5] of Date;
//         Value: Decimal;
//         TotalValue: Decimal;
//         ColumnNo: Integer;
//         SalesHeaderStatus: Integer;
//     begin
//         TrailingSalesOrdersSetup.GET(USERID);
//         WITH BusChartBuf DO BEGIN
//           Initialize;
//           "Period Length" := TrailingSalesOrdersSetup."Period Length";
//           SetPeriodXAxis;

//           CreateMap(ChartToStatusMap);
//           FOR SalesHeaderStatus := 1 TO ARRAYLEN(ChartToStatusMap) DO BEGIN
//             SalesHeader.Status := ChartToStatusMap[SalesHeaderStatus];
//             AddMeasure(FORMAT(SalesHeader.Status),SalesHeader.Status,"Data Type"::Decimal,TrailingSalesOrdersSetup.GetChartType);
//           END;

//           IF CalcPeriods(FromDate,ToDate,BusChartBuf) THEN BEGIN
//             AddPeriods(ToDate[1],ToDate[ARRAYLEN(ToDate)]);

//             FOR SalesHeaderStatus := 1 TO ARRAYLEN(ChartToStatusMap) DO BEGIN
//               TotalValue := 0;
//               FOR ColumnNo := 1 TO ARRAYLEN(ToDate) DO BEGIN
//                 Value := GetSalesOrderValue(ChartToStatusMap[SalesHeaderStatus],FromDate[ColumnNo],ToDate[ColumnNo]);
//                 IF ColumnNo = 1 THEN
//                   TotalValue := Value
//                 ELSE
//                   TotalValue += Value;
//                 SetValueByIndex(SalesHeaderStatus - 1,ColumnNo - 1,TotalValue);
//               END;
//             END;
//           END;
//         END;
//     end;

//     local procedure CalcPeriods(var FromDate: array [5] of Date;var ToDate: array [5] of Date;var BusChartBuf: Record "485"): Boolean
//     var
//         MaxPeriodNo: Integer;
//         i: Integer;
//     begin
//         MaxPeriodNo := ARRAYLEN(ToDate);
//         ToDate[MaxPeriodNo] := TrailingSalesOrdersSetup.GetStartDate;
//         IF ToDate[MaxPeriodNo] = 0D THEN
//           EXIT(FALSE);
//         FOR i := MaxPeriodNo DOWNTO 1 DO BEGIN
//           IF i > 1 THEN BEGIN
//             FromDate[i] := BusChartBuf.CalcFromDate(ToDate[i]);
//             ToDate[i - 1] := FromDate[i] - 1;
//           END ELSE
//             FromDate[i] := 0D
//         END;
//         EXIT(TRUE);
//     end;

//     local procedure GetSalesOrderValue(Status: Option;FromDate: Date;ToDate: Date): Decimal
//     begin
//         IF TrailingSalesOrdersSetup."Value to Calculate" = TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders" THEN
//           EXIT(GetSalesOrderCount(Status,FromDate,ToDate));
//         EXIT(GetSalesOrderAmount(Status,FromDate,ToDate));
//     end;

//     local procedure GetSalesOrderAmount(Status: Option;FromDate: Date;ToDate: Date): Decimal
//     var
//         CurrExchRate: Record "330";
//         TrailingSalesOrderQry: Query "760";
//         Amount: Decimal;
//         TotalAmount: Decimal;
//     begin
//         IF TrailingSalesOrdersSetup."Show Orders" = TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders" THEN
//           TrailingSalesOrderQry.SETFILTER(ShipmentDate,'<%1',TrailingSalesOrdersSetup.GetStartDate);

//         TrailingSalesOrderQry.SETRANGE(Status,Status);
//         TrailingSalesOrderQry.SETRANGE(DocumentDate,FromDate,ToDate);
//         TrailingSalesOrderQry.OPEN;
//         WHILE TrailingSalesOrderQry.READ DO BEGIN
//           IF TrailingSalesOrderQry.CurrencyCode = '' THEN
//             Amount := TrailingSalesOrderQry.Amount
//           ELSE
//             Amount := ROUND(TrailingSalesOrderQry.Amount / CurrExchRate.ExchangeRate(TODAY,TrailingSalesOrderQry.CurrencyCode));
//           TotalAmount := TotalAmount + Amount;
//         END;
//         EXIT(TotalAmount);
//     end;

//     local procedure GetSalesOrderCount(Status: Option;FromDate: Date;ToDate: Date): Decimal
//     begin
//         SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
//         IF TrailingSalesOrdersSetup."Show Orders" = TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders" THEN
//           SalesHeader.SETFILTER("Shipment Date",'<%1',TrailingSalesOrdersSetup.GetStartDate)
//         ELSE
//           SalesHeader.SETRANGE("Shipment Date");
//         SalesHeader.SETRANGE(Status,Status);
//         SalesHeader.SETRANGE("Document Date",FromDate,ToDate);
//         EXIT(SalesHeader.COUNT);
//     end;

//     procedure CreateMap(var Map: array [4] of Integer)
//     var
//         SalesHeader: Record "36";
//     begin
//         Map[1] := SalesHeader.Status::Released;
//         Map[2] := SalesHeader.Status::"Pending Prepayment";
//         Map[3] := SalesHeader.Status::"Pending Approval";
//         Map[4] := SalesHeader.Status::Open;
//     end;
// }

