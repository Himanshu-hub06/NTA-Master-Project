/// <summary>
/// TableExtension Dimension Value Ext (ID 50006) extends Record Dimension Value.
/// </summary>
tableextension 50004 "Dimension Value Ext" extends "Dimension Value"
{
    fields
    {
        field(50106; "Issue Depatment"; Boolean)
        {
            Caption = 'Issue Depatment';
            DataClassification = ToBeClassified;
        }
        field(50107; "Section Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
    }
}
