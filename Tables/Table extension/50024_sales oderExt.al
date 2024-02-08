tableextension 50024 Salestest extends "Sales Header"
{
    fields
    {
        // field(50001; Remark; Text[200])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(50002; "Additional Remark"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}