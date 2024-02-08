report 50040 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number);
            trigger OnPreDataItem()
            begin
                Number := 1;
            end;

            trigger OnAfterGetRecord()
            begin
                Integer.SetRange(Integer.Number, 1, 0);
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := 'DEFAULT';
                ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                ItemJnlLine."Document No." := 'ADJ-001';
                ItemJnlLine.VALIDATE("Entry Type", Adjustment);
                ItemJnlLine.VALIDATE("Posting Date", Today);
                ItemJnlLine.VALIDATE("Item No.", ItemNo);
                ItemJnlLine.VALIDATE("Location Code", Location);
                ItemJnlLine.VALIDATE(Quantity, Quantity);
                ItemJnlPost.RunWithCheck(ItemJnlLine);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = All;
                    TableRelation = Item;
                }
                field(Adjustment; Adjustment)
                {
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {

                }
                field(Location; Location)
                {
                    ApplicationArea = All;
                    TableRelation = Location;
                }
            }
        }

    }
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemNo: Code[20];
        Adjustment: Option;
        Quantity: Decimal;
        Location: Code[10];
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
}