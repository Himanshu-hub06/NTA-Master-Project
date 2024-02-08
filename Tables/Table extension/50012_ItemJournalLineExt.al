tableextension 50012 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50051; "Requisition Line"; Integer)
        {
            Caption = '50051';
            DataClassification = ToBeClassified;
        }
        field(50052; "Requisition No."; Code[20])
        {
            Caption = '50052';
            DataClassification = ToBeClassified;
        }
    }
}
