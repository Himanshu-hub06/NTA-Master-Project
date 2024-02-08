report 50190 "SDH Customer Export"
{
    ApplicationArea = All;
    Caption = 'SDH Customer Export';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnPreDataItem()
            begin

                CreateExcelHeader();
                Customer.SetAutoCalcFields("Balance (LCY)");
            end;

            trigger OnAfterGetRecord()
            begin

                CreateExcelBody();
            end;



        }
    }

    trigger OnInitReport()
    begin

        tempExcelbuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin

        CrateExcelBook();
    end;

    local procedure CreateExcelHeader()

    begin

        tempExcelbuffer.AddColumn(Customer.FieldCaption("No."), false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer.FieldCaption("Location Code"), false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn('Balances', false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer.FieldCaption("Gen. Bus. Posting Group"), false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer.FieldCaption("Customer Posting Group"), false, '', true, false, true, '', tempExcelbuffer."Cell Type"::Text);

    end;

    local procedure CreateExcelBody()

    begin



        tempExcelbuffer.NewRow();
        tempExcelbuffer.AddColumn(Customer."No.", false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer.Name, false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer."Location Code", false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Text);
        tempExcelbuffer.AddColumn(Customer."Gen. Bus. Posting Group", false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Number);
        tempExcelbuffer.AddColumn(Customer."Customer Posting Group", false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Number);
        tempExcelbuffer.AddColumn(Customer."Balance (LCY)", false, '', false, false, false, '', tempExcelbuffer."Cell Type"::Number);



    end;

    local procedure CrateExcelBook()

    begin

        tempExcelbuffer.CreateNewBook('Demo Excel');
        tempExcelbuffer.WriteSheet('Demo Excel', CompanyName, UserId);
        tempExcelbuffer.CloseBook();
        tempExcelbuffer.SetFriendlyFilename('Customer List');
        tempExcelbuffer.OpenExcel();


    end;

    var

        tempExcelbuffer: Record "Excel Buffer" temporary;

}
