tableextension 50023 Budge_Ext extends "G/L Budget Name"
{
    fields
    {
        field(50000; Sender_ID; Text[250])
        {
            Caption = 'Sender ID';
            DataClassification = ToBeClassified;
        }
        field(50001; Receiver_Id; Text[250])
        {
            Caption = 'Receiver_Id';
            DataClassification = ToBeClassified;
        }
        field(50003; status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;

            OptionMembers = "Open","Pending Approval","Approved","Rejected";
        }

    }


}