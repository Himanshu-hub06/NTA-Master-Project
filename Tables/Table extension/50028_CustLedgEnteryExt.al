tableextension 50028 CustLedgEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; "Aditional Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}