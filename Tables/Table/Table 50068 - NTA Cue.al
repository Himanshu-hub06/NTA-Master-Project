table 50068 "NTA Cue"
{
    Caption = 'NTA Cue';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(3; "Date Filter2"; Date)
        {
            Caption = 'Date Filter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(4; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(5; "Total TA Bills"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("TA Bill Header" where(Status = filter("CC Approved" | "RC Approved"), "Bill Status" = const(open)));
        }
        field(6; "Open Bills - TADA"; Integer)
        {
            AccessByPermission = TableData 50005 = R;
            CalcFormula = Count("TA Bill Header" WHERE("Bill Status" = FILTER(Open),
                                                        Submitted = CONST(true)));
            FieldClass = FlowField;
        }
        field(7; "Pending Approval Bills - TADA"; Integer)
        {
            AccessByPermission = TableData 50005 = R;
            CalcFormula = Count("TA Bill Header" WHERE("Bill Status" = FILTER("Pending For Approval")));
            FieldClass = FlowField;
        }
        field(8; "Approved Bills - TADA"; Integer)
        {
            AccessByPermission = TableData 50005 = R;
            CalcFormula = Count("TA Bill Header" WHERE("Bill Status" = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(9; "Rejected Bills - TADA"; Integer)
        {
            AccessByPermission = TableData 50005 = R;
            CalcFormula = Count("TA Bill Header" WHERE("Bill Status" = FILTER(Rejected)));
            FieldClass = FlowField;
        }
        field(10; "Disbursment Bill"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("TA Bill Header" where("Bill Status" = filter("Disbursement Pending")));
        }
        field(11; "Total Centre Bill"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Centre Bill Header" where(Status = filter("CC Approved" | "RC Approved"),
                                                                           "Bill Status" = const(open)));
        }
        field(12; "Open Bills - Center"; Integer)
        {
            AccessByPermission = TableData 50002 = R;
            CalcFormula = Count("Centre Bill Header" WHERE(Status = FILTER(Open),
                                                            Submitted = filter(true)));
            FieldClass = FlowField;
        }
        field(13; "Approved Bills - Center"; Integer)
        {
            AccessByPermission = TableData 50002 = R;
            CalcFormula = Count("Centre Bill Header" WHERE("Bill Status" = FILTER(Approved)));

            FieldClass = FlowField;
        }
        field(14; "Pending Approval Bills - Cente"; Integer)
        {
            AccessByPermission = TableData 50002 = R;
            CalcFormula = Count("Centre Bill Header" WHERE("Bill Status" = FILTER("Pending For Approval")));
            FieldClass = FlowField;
        }
        field(15; "Rejected Bills  - Center"; Integer)
        {
            AccessByPermission = TableData 50002 = R;
            CalcFormula = count("Centre Bill Header" WHERE("Bill Status" = FILTER(Rejected)));
            FieldClass = FlowField;
        }
        field(16; "Centre Disburment Bill"; Integer)
        {
            CalcFormula = count("Centre Bill Header" where("Bill Status" = filter("Disbursement Pending")));
            FieldClass = FlowField;
        }
        field(17; "Transport All Application"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Transport/Fleet Log Master" where(Status = filter(Open),
                                                    "Receiver ID" = field("User Filter")));
        }
        field(18; "Transport Under Approval"; Integer)
        {
            Caption = 'Under Approval';
            FieldClass = FlowField;
            CalcFormula = count("Transport/Fleet Log Master" where(Status = filter("Under Approval"),
                                                                 "Receiver ID" = field("User Filter")));
        }
        field(19; "Transport Under GA Section"; Integer)
        {
            Caption = 'Under GA Section';
            FieldClass = FlowField;
            CalcFormula = count("Transport/Fleet Log Master" where(Status = filter("Under GA Secton"),
                                                                 "Receiver ID" = field("User Filter")));
        }
        field(20; "Trasport Approved"; Integer)
        {
            Caption = 'Approved';
            FieldClass = FlowField;
            CalcFormula = count("Transport/Fleet Log Master" where(Status = filter(Approved),
                                                        "Receiver ID" = field("User Filter")));
        }
        field(21; "Transport End Trip"; Integer)
        {
            Caption = 'End Trip';
            FieldClass = FlowField;
            CalcFormula = count("Transport/Fleet Log Master" where(Status = filter(Completed),
                                                            "Receiver ID" = field("User Filter")));
        }
        field(22; "User Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(31; "Ta Bill Hotel"; Integer)
        {
            AccessByPermission = TableData 50006 = R;
            CalcFormula = count("TA Bill Hotel" where("Total Amount" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(41; "Budget Open"; Integer)
        {
            AccessByPermission = TableData 95 = R;
            CalcFormula = count("G/L Budget Name" where(status = filter(Open)));
            FieldClass = FlowField;
        }
        field(42; "Budget Pending Approval Req"; Integer)
        {
            AccessByPermission = TableData 95 = R;
            CalcFormula = count("G/L Budget Name" where(status = filter("Pending Approval")));
            FieldClass = FlowField;
        }
        field(43; "Budget Approval"; Integer)
        {
            AccessByPermission = TableData 95 = R;
            CalcFormula = count("G/L Budget Name" where(status = filter(Approved)));
            FieldClass = FlowField;
        }
        field(44; "Budget Reject"; Integer)
        {
            AccessByPermission = TableData 95 = R;
            CalcFormula = count("G/L Budget Name" where(status = filter(Rejected)));
            FieldClass = FlowField;
        }

        field(45; Advocates; Integer)
        {
            AccessByPermission = TableData 50201 = R;
            CalcFormula = Count(Advocate WHERE(Active = CONST(true)));
            FieldClass = FlowField;
        }
        field(46; "New Write Case"; Integer)
        {
            AccessByPermission = TableData 50201 = R;
            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(New)));
            FieldClass = FlowField;
        }
        field(47; "Ongoing Write Cases"; Integer)
        {
            AccessByPermission = TableData 50201 = R;
            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Ongoing)));
            FieldClass = FlowField;
        }
        field(48; "Disposed Write Cases"; Integer)
        {
            AccessByPermission = TableData 50201 = R;
            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Disposed)));
            FieldClass = FlowField;
        }
        field(49; "Meeting Open"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Meeting Header" WHERE("Status" = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(50; "Meeting Pending Approval"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Meeting Header" where(Status = filter("Pending for Approval")));
            FieldClass = FlowField;
        }
        field(51; "Meeting Approved"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Meeting Header" where(Status = filter("Approved")));
            FieldClass = FlowField;
        }
        field(52; "Meeting Rejected"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Meeting Header" where(Status = filter("Rejected")));
            FieldClass = FlowField;
        }
        field(53; "Committee Active"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Committee Header" where(Status = filter(Active)));
            FieldClass = FlowField;
        }
        field(54; "Committee InActive"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Committee Header" where(Status = filter(InActive)));
            FieldClass = FlowField;
        }
        field(55; "Committee Draft"; Integer)
        {
            AccessByPermission = TableData 50285 = R;
            CalcFormula = count("AV Committee Header" where(Status = filter(Draft)));
            FieldClass = FlowField;
        }
        field(56; "Fee Recancilition"; Integer)
        {
            AccessByPermission = TableData 273 = R;
            CalcFormula = count("Bank Acc. Reconciliation");
            FieldClass = FlowField;
        }
        field(57; "Fee Reconc List"; Integer)
        {
            AccessByPermission = TableData 273 = R;
            CalcFormula = count("Bank Acc. Reconciliation");
            FieldClass = FlowField;



        }


    }


    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetRespCenterFilter()
    var
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenterCode: Code[10];
    begin
        RespCenterCode := UserSetupMgt.GetSalesFilter;
        IF RespCenterCode <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center Filter", RespCenterCode);
            FILTERGROUP(0);
        END;
    end;

    procedure CalculateAverageDaysDelayed() AverageDays: Decimal
    var
        SalesHeader: Record "Sales Header";
        SumDelayDays: Integer;
        CountDelayedInvoices: Integer;
    begin
        /*
        FilterOrders(SalesHeader,FIELDNO(Delayed));
        IF SalesHeader.FINDSET THEN BEGIN
          REPEAT
            SumDelayDays += MaximumDelayAmongLines(SalesHeader);
            CountDelayedInvoices += 1;
          UNTIL SalesHeader.NEXT = 0;
          AverageDays := SumDelayDays / CountDelayedInvoices;
        END;
        */

    end;

    local procedure MaximumDelayAmongLines(SalesHeader: Record "Sales Header") MaxDelay: Integer
    var
        SalesLine: Record "Sales Line";
    begin
        MaxDelay := 0;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Shipment Date", '<%1&<>%2', WORKDATE, 0D);
        IF SalesLine.FINDSET THEN
            REPEAT
                IF WORKDATE - SalesLine."Shipment Date" > MaxDelay THEN
                    MaxDelay := WORKDATE - SalesLine."Shipment Date";
            UNTIL SalesLine.NEXT = 0;
    end;

    procedure CountOrders(FieldNumber: Integer): Integer
    var
        CountSalesOrders: Query "Count Sales Orders";
    begin
        /*
        CountSalesOrders.SETRANGE(Status,CountSalesOrders.Status::Released);
        CountSalesOrders.SETRANGE(Completely_Shipped,FALSE);
        FILTERGROUP(2);
        CountSalesOrders.SETFILTER(Responsibility_Center,GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);

        CASE FieldNumber OF
          FIELDNO("Ready to Ship"):
            BEGIN
              CountSalesOrders.SETRANGE(Ship);
              CountSalesOrders.SETFILTER(Shipment_Date,GETFILTER("Date Filter2"));
            END;
          FIELDNO("Partially Shipped"):
            BEGIN
              CountSalesOrders.SETRANGE(Shipped,TRUE);
              CountSalesOrders.SETFILTER(Shipment_Date,GETFILTER("Date Filter2"));
            END;
          FIELDNO(Delayed):
            BEGIN
              CountSalesOrders.SETRANGE(Ship);
              CountSalesOrders.SETFILTER(Date_Filter,GETFILTER("Date Filter"));
              CountSalesOrders.SETRANGE(Late_Order_Shipping,TRUE);
            END;
        END;
        CountSalesOrders.OPEN;
        CountSalesOrders.READ;
        EXIT(CountSalesOrders.Count_Orders);
        */

    end;

    local procedure FilterOrders(var SalesHeader: Record "Sales Header"; FieldNumber: Integer)
    begin
        /*
        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Status,SalesHeader.Status::Released);
        SalesHeader.SETRANGE("Completely Shipped",FALSE);
        CASE FieldNumber OF
          FIELDNO("Ready to Ship"):
            BEGIN
              SalesHeader.SETRANGE(Ship);
              SalesHeader.SETFILTER("Shipment Date",GETFILTER("Date Filter2"));
            END;
          FIELDNO("Partially Shipped"):
            BEGIN
              SalesHeader.SETRANGE(Shipped,TRUE);
              SalesHeader.SETFILTER("Shipment Date",GETFILTER("Date Filter2"));
            END;
          FIELDNO(Delayed):
            BEGIN
              SalesHeader.SETRANGE(Ship);
              SalesHeader.SETFILTER("Date Filter",GETFILTER("Date Filter"));
              SalesHeader.SETRANGE("Late Order Shipping",TRUE);
            END;
        END;
        FILTERGROUP(2);
        SalesHeader.SETFILTER("Responsibility Center",GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);
        */

    end;

    procedure ShowOrders(FieldNumber: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        FilterOrders(SalesHeader, FieldNumber);
        PAGE.RUN(PAGE::"Sales Order List", SalesHeader);
    end;
}

