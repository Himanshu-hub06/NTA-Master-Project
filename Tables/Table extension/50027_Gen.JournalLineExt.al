tableextension 50027  GenJournalLine extends "Gen. Journal Line" 
{
    fields
    {
        field(50001; "Aditional Remarks"; Text[50])
        {
            
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }
    
    var
        myInt: Integer;
}