// page 50760 "Advertisement Expense Chart"
// {
//     Caption = 'Advertisement Expense Chart';
//     PageType = CardPart;
//     SourceTable = Table485;

//     layout
//     {
//         area(content)
//         {
//             field(StatusText;StatusText)
//             {
//                 Caption = 'Status Text';
//                 ShowCaption = false;
//             }
//             usercontrol(BusinessChart;"Microsoft.Dynamics.Nav.Client.BusinessChart")
//             {

//                 trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
//                 begin
//                     SetDrillDownIndexes(point);
//                     TrailingSalesOrdersMgt.DrillDown(Rec);
//                 end;

//                 trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
//                 begin
//                 end;

//                 trigger AddInReady()
//                 begin
//                     IsChartAddInReady := TRUE;
//                     TrailingSalesOrdersMgt.OnOpenPage(TrailingSalesOrdersSetup);
//                     UpdateStatus;
//                     IF IsChartDataReady THEN
//                       UpdateChart;
//                 end;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Show)
//             {
//                 Caption = 'Show';
//                 Image = View;
//                 action(AllOrders)
//                 {
//                     Caption = 'All Orders';
//                     Enabled = AllOrdersEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"All Orders");
//                         UpdateStatus;
//                     end;
//                 }
//                 action(OrdersUntilToday)
//                 {
//                     Caption = 'Orders Until Today';
//                     Enabled = OrdersUntilTodayEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today");
//                         UpdateStatus;
//                     end;
//                 }
//                 action(DelayedOrders)
//                 {
//                     Caption = 'Delayed Orders';
//                     Enabled = DelayedOrdersEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetShowOrders(TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders");
//                         UpdateStatus;
//                     end;
//                 }
//             }
//             group(PeriodLength)
//             {
//                 Caption = 'Period Length';
//                 Image = Period;
//                 action(Day)
//                 {
//                     Caption = 'Day';
//                     Enabled = DayEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Day);
//                         UpdateStatus;
//                     end;
//                 }
//                 action(Week)
//                 {
//                     Caption = 'Week';
//                     Enabled = WeekEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Week);
//                         UpdateStatus;
//                     end;
//                 }
//                 action(Month)
//                 {
//                     Caption = 'Month';
//                     Enabled = MonthEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Month);
//                         UpdateStatus;
//                     end;
//                 }
//                 action(Quarter)
//                 {
//                     Caption = 'Quarter';
//                     Enabled = QuarterEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Quarter);
//                         UpdateStatus;
//                     end;
//                 }
//                 action(Year)
//                 {
//                     Caption = 'Year';
//                     Enabled = YearEnabled;

//                     trigger OnAction()
//                     begin
//                         TrailingSalesOrdersSetup.SetPeriodLength(TrailingSalesOrdersSetup."Period Length"::Year);
//                         UpdateStatus;
//                     end;
//                 }
//             }
//             group(Options)
//             {
//                 Caption = 'Options';
//                 Image = SelectChart;
//                 group(ValueToCalculate)
//                 {
//                     Caption = 'Value to Calculate';
//                     Image = Calculate;
//                     action(Amount)
//                     {
//                         Caption = 'Amount';
//                         Enabled = AmountEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetValueToCalcuate(TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT");
//                             UpdateStatus;
//                         end;
//                     }
//                     action(NoofOrders)
//                     {
//                         Caption = 'No. of Orders';
//                         Enabled = NoOfOrdersEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetValueToCalcuate(TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders");
//                             UpdateStatus;
//                         end;
//                     }
//                 }
//                 group("Chart Type")
//                 {
//                     Caption = 'Chart Type';
//                     Image = BarChart;
//                     action(StackedArea)
//                     {
//                         Caption = 'Stacked Area';
//                         Enabled = StackedAreaEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area");
//                             UpdateStatus;
//                         end;
//                     }
//                     action(StackedAreaPct)
//                     {
//                         Caption = 'Stacked Area (%)';
//                         Enabled = StackedAreaPctEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)");
//                             UpdateStatus;
//                         end;
//                     }
//                     action(StackedColumn)
//                     {
//                         Caption = 'Stacked Column';
//                         Enabled = StackedColumnEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Column");
//                             UpdateStatus;
//                         end;
//                     }
//                     action(StackedColumnPct)
//                     {
//                         Caption = 'Stacked Column (%)';
//                         Enabled = StackedColumnPctEnabled;

//                         trigger OnAction()
//                         begin
//                             TrailingSalesOrdersSetup.SetChartType(TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)");
//                             UpdateStatus;
//                         end;
//                     }
//                 }
//             }
//             separator()
//             {
//             }
//             action(Refresh)
//             {
//                 Caption = 'Refresh';
//                 Image = Refresh;

//                 trigger OnAction()
//                 begin
//                     NeedsUpdate := TRUE;
//                     UpdateStatus;
//                 end;
//             }
//             separator()
//             {
//             }
//             action(Setup)
//             {
//                 Caption = 'Setup';
//                 Image = Setup;

//                 trigger OnAction()
//                 begin
//                     RunSetup;
//                 end;
//             }
//         }
//     }

//     trigger OnFindRecord(Which: Text): Boolean
//     begin
//         UpdateChart;
//         IsChartDataReady := TRUE;

//         IF NOT IsChartAddInReady THEN
//           SetActionsEnabled;
//     end;

//     trigger OnOpenPage()
//     begin
//         SetActionsEnabled;
//     end;

//     var
//         TrailingSalesOrdersSetup: Record "50760";
//         OldTrailingSalesOrdersSetup: Record "50760";
//         TrailingSalesOrdersMgt: Codeunit "50760";
//         StatusText: Text[250];
//         NeedsUpdate: Boolean;
//         [InDataSet]
//         AllOrdersEnabled: Boolean;
//         [InDataSet]
//         OrdersUntilTodayEnabled: Boolean;
//         [InDataSet]
//         DelayedOrdersEnabled: Boolean;
//         [InDataSet]
//         DayEnabled: Boolean;
//         [InDataSet]
//         WeekEnabled: Boolean;
//         [InDataSet]
//         MonthEnabled: Boolean;
//         [InDataSet]
//         QuarterEnabled: Boolean;
//         [InDataSet]
//         YearEnabled: Boolean;
//         [InDataSet]
//         AmountEnabled: Boolean;
//         [InDataSet]
//         NoOfOrdersEnabled: Boolean;
//         [InDataSet]
//         StackedAreaEnabled: Boolean;
//         [InDataSet]
//         StackedAreaPctEnabled: Boolean;
//         [InDataSet]
//         StackedColumnEnabled: Boolean;
//         [InDataSet]
//         StackedColumnPctEnabled: Boolean;
//         IsChartAddInReady: Boolean;
//         IsChartDataReady: Boolean;

//     local procedure UpdateChart()
//     begin
//         IF NOT NeedsUpdate THEN
//           EXIT;
//         IF NOT IsChartAddInReady THEN
//           EXIT;
//         TrailingSalesOrdersMgt.UpdateData(Rec);
//         Update(CurrPage.BusinessChart);
//         UpdateStatus;
//         NeedsUpdate := FALSE;
//     end;

//     local procedure UpdateStatus()
//     begin
//         NeedsUpdate :=
//           NeedsUpdate OR
//           (OldTrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length") OR
//           (OldTrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders") OR
//           (OldTrailingSalesOrdersSetup."Use Work Date as Base" <> TrailingSalesOrdersSetup."Use Work Date as Base") OR
//           (OldTrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate") OR
//           (OldTrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type");

//         OldTrailingSalesOrdersSetup := TrailingSalesOrdersSetup;

//         IF NeedsUpdate THEN
//           StatusText := TrailingSalesOrdersSetup.GetCurrentSelectionText;

//         SetActionsEnabled;
//     end;

//     local procedure RunSetup()
//     begin
//         PAGE.RUNMODAL(PAGE::"Trailing Sales Orders Setup",TrailingSalesOrdersSetup);
//         TrailingSalesOrdersSetup.GET(USERID);
//         UpdateStatus;
//     end;

//     procedure SetActionsEnabled()
//     begin
//         AllOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"All Orders") AND
//           IsChartAddInReady;
//         OrdersUntilTodayEnabled :=
//           (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today") AND
//           IsChartAddInReady;
//         DelayedOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders") AND
//           IsChartAddInReady;
//         DayEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Day) AND
//           IsChartAddInReady;
//         WeekEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Week) AND
//           IsChartAddInReady;
//         MonthEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Month) AND
//           IsChartAddInReady;
//         QuarterEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Quarter) AND
//           IsChartAddInReady;
//         YearEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Year) AND
//           IsChartAddInReady;
//         AmountEnabled :=
//           (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT") AND
//           IsChartAddInReady;
//         NoOfOrdersEnabled :=
//           (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders") AND
//           IsChartAddInReady;
//         StackedAreaEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area") AND
//           IsChartAddInReady;
//         StackedAreaPctEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)") AND
//           IsChartAddInReady;
//         StackedColumnEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column") AND
//           IsChartAddInReady;
//         StackedColumnPctEnabled :=
//           (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)") AND
//           IsChartAddInReady;
//     end;
// }

