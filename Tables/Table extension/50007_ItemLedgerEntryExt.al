/// <summary>
/// TableExtension Item Ledger Entry Ext (ID 50007) extends Record Item Ledger Entry.
/// </summary>
tableextension 50007 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;
        }
    }
}
