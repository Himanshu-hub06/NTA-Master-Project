/// <summary>
/// TableExtension Item Ext (ID 50008) extends Record Item.
/// </summary>
tableextension 50008 "Item Ext" extends Item
{
    fields
    {
        field(50001; "Test Item Code"; Code[10])
        {
            Caption = 'Test Item Code';
            DataClassification = ToBeClassified;
        }
        field(50010; "From Serial No."; Code[15])
        {
            Caption = 'From Serial No.';
            DataClassification = ToBeClassified;
        }
        field(50011; "To Serial No."; Code[15])
        {
            Caption = 'To Serial No.';
            DataClassification = ToBeClassified;
        }
        field(50012; "USER ID"; Code[50])
        {
            Caption = 'USER ID';
            DataClassification = ToBeClassified;
        }
        field(50013; "Date & Time"; DateTime)
        {
            Caption = 'Date & Time';
            DataClassification = ToBeClassified;
        }
        field(50021; "Examination Code"; Code[20])
        {
            Caption = 'Examination Code';
            DataClassification = ToBeClassified;
        }
        field(50024; Sepicification; Text[50])
        {
            Caption = 'Sepicification';
            DataClassification = ToBeClassified;
        }
        field(50025; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionMembers = ,Consumable,Transferable;
            DataClassification = ToBeClassified;
        }
        field(60041; "Req Item"; Boolean)
        {
            Caption = 'Req Item';
            DataClassification = ToBeClassified;
        }

    }
}
