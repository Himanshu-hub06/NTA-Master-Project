table 50080 "Trailing Advertisement Setup"
{
    Caption = 'Trailing Sales Orders Setup';

    fields
    {
        field(1; "User ID"; Text[132])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(2; "Period Length"; Option)
        {
            Caption = 'Period Length';
            OptionCaption = 'Day,Week,Month,Quarter,Year';
            OptionMembers = Day,Week,Month,Quarter,Year;
        }
        field(3; "Show Orders"; Option)
        {
            Caption = 'Show Orders';
            OptionCaption = 'All Orders,Orders Until Today,Delayed Orders';
            OptionMembers = "All Orders","Orders Until Today","Delayed Orders";
        }
        field(4; "Use Work Date as Base"; Boolean)
        {
            Caption = 'Use Work Date as Base';
        }
        field(5; "Value to Calculate"; Option)
        {
            Caption = 'Value to Calculate';
            OptionCaption = 'Amount Excl. VAT,No. of Orders';
            OptionMembers = "Amount Excl. VAT","No. of Orders";
        }
        field(6; "Chart Type"; Option)
        {
            Caption = 'Chart Type';
            OptionCaption = 'Stacked Area,Stacked Area (%),Stacked Column,Stacked Column (%)';
            OptionMembers = "Stacked Area","Stacked Area (%)","Stacked Column","Stacked Column (%)";
        }
        field(7; "Latest Order Document Date"; Date)
        {
            AccessByPermission = TableData 110 = R;
            CalcFormula = Max("Sales Header"."Document Date" WHERE("Document Type" = CONST(Order)));
            Caption = 'Latest Order Document Date';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Updated at %1.';

    procedure GetCurrentSelectionText(): Text[100]
    begin
        EXIT(FORMAT("Show Orders") + '|' +
          FORMAT("Period Length") + '|' +
          FORMAT("Value to Calculate") + '|. (' +
          STRSUBSTNO(Text001, TIME) + ')');
    end;

    procedure GetStartDate(): Date
    var
        StartDate: Date;
    begin
        IF "Use Work Date as Base" THEN
            StartDate := WORKDATE
        ELSE
            StartDate := TODAY;
        IF "Show Orders" = "Show Orders"::"All Orders" THEN BEGIN
            CALCFIELDS("Latest Order Document Date");
            StartDate := "Latest Order Document Date";
        END;

        EXIT(StartDate);
    end;

    procedure GetChartType(): Integer
    var
        BusinessChartBuf: Record "Business Chart Buffer";
    begin
        CASE "Chart Type" OF
            "Chart Type"::"Stacked Area":
                EXIT(BusinessChartBuf."Chart Type"::StackedArea);
            "Chart Type"::"Stacked Area (%)":
                EXIT(BusinessChartBuf."Chart Type"::StackedArea100);
            "Chart Type"::"Stacked Column":
                EXIT(BusinessChartBuf."Chart Type"::StackedColumn);
            "Chart Type"::"Stacked Column (%)":
                EXIT(BusinessChartBuf."Chart Type"::StackedColumn100);
        END;
    end;

    procedure SetPeriodLength(PeriodLength: Option)
    begin
        "Period Length" := PeriodLength;
        MODIFY;
    end;

    procedure SetShowOrders(ShowOrders: Integer)
    begin
        "Show Orders" := ShowOrders;
        MODIFY;
    end;

    procedure SetValueToCalcuate(ValueToCalc: Integer)
    begin
        "Value to Calculate" := ValueToCalc;
        MODIFY;
    end;

    procedure SetChartType(ChartType: Integer)
    begin
        "Chart Type" := ChartType;
        MODIFY;
    end;
}

