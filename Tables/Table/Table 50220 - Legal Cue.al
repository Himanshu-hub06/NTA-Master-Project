table 50220 "Legal Cue"
{
    Caption = 'Legal Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(3; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(4; Advocates; Integer)
        {
            AccessByPermission = TableData 50201 = R;
            CalcFormula = Count(Advocate WHERE(Active = CONST(true)));

            FieldClass = FlowField;
        }
        field(5; "New Write Case"; Integer)
        {
            AccessByPermission = TableData 50203 = R;

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(New)));
            FieldClass = FlowField;
        }

        field(6; "Ongoing Write Cases;"; Integer)
        {
            AccessByPermission = TableData 50203 = R;

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Ongoing)));
            FieldClass = FlowField;
        }

        field(7; "Disposed Write Cases"; Integer)
        {
            AccessByPermission = TableData 50203 = R;

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Disposed)));
            FieldClass = FlowField;
        }



    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        StDt: Date;
}

