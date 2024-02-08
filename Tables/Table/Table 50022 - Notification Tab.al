table 50022 "Notification Tab"
{
    Caption = 'Notification Tab';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Receiver ID"; Code[50])
        {
            Caption = 'Receiver ID';
            DataClassification = ToBeClassified;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Notification Details"; Text[250])
        {
            Caption = 'Notification Details';
            DataClassification = ToBeClassified;
        }
        field(7; Unread; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; read; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")

        {
            Clustered = true;
        }
        key(Pk2; "Posting Date")
        {

        }
    }
}
