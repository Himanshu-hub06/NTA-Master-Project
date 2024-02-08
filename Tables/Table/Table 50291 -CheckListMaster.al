table 50291 "CheckList Master "
{
    Caption = 'CheckList Master ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Session; Text[50])
        {
            Caption = 'Session';
        }
        field(2; "Display Order"; Code[50])
        {
            Caption = 'Display Order';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Type of Check List"; Text[50])
        {
            Caption = 'Type of Check List';
        }
        field(5; "No.series"; Code[20])
        {
            Caption = 'No.series';
        }
    }
    keys
    {
        key(PK; Session)
        {
            Clustered = true;
        }
    }
}
