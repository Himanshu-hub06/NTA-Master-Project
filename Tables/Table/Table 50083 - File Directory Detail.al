table 50083 "File Directory Detail"
{
    Caption = 'File Directroy Detail';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }

        field(20; "Location Image URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; DatabaseName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; ConnectionString; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Password; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(30; "Mail API Url"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Message API URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Requisition Read"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Purchase Proposal Read"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Requisition Write"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Purchase Proposal Write"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Indent Read"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Indent Write"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Pfms Read"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Pfms Write"; text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "PFMS Sanction Status"; Text[120])
        {
            DataClassification = ToBeClassified;
            Description = 'Sanction Status XML File Location';
        }
        field(81; "PFMS Payment Status"; Text[120])
        {
            DataClassification = ToBeClassified;
            Description = 'Payment Status XML File Location';
        }
        field(82; "PFMS Push Status"; Text[120])
        {
            DataClassification = ToBeClassified;
            Description = 'Push Status XML File Location';
        }
        field(83; "Bill File Path"; Text[120])
        {
            DataClassification = ToBeClassified;
            Description = 'Bill File Path';
        }
        field(84; "Parliament Qtns Read"; text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Parliament Qtns Write"; Text[120])
        {
            DataClassification = ToBeClassified;
        }

        field(86; "Writ Case Write Path"; Text[120])
        {
            DataClassification = ToBeClassified;
        }

        field(87; "Writ Case Read Path"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
