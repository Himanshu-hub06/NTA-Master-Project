table 50212 "Writ/Case Header Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            Caption = 'Date Filter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(23; "Writ/Case - New (Sec.)"; Integer)
        {


        }
        field(24; "Writ/Case - New (S Sec.)"; Integer)
        {

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(New), "User Exam Code" = CONST('EXESSEC')));

            FieldClass = FlowField;
        }
        field(25; "Writ/Case - Ongoing (Sec.)"; Integer)
        {

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Ongoing),
                                                          "User Exam Code" = CONST('EXESEC')));
            FieldClass = FlowField;
        }
        field(26; "Writ/Case - Ongoing (S Sec.)"; Integer)
        {

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Ongoing),
                                                          "User Exam Code" = CONST('EXESSEC')));
            FieldClass = FlowField;
        }
        field(27; "Writ/Case - Disposed (Sec.)"; Integer)
        {

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Disposed),
                                                          "User Exam Code" = CONST('EXESEC')));
            FieldClass = FlowField;
        }
        field(28; "Writ/Case - Disposed (S Sec.)"; Integer)
        {

            CalcFormula = Count("Writ/Case Header" WHERE(Status = CONST(Disposed),
                                                          "User Exam Code" = CONST('EXESSEC')));
            FieldClass = FlowField;
        }
        field(29; "Writ/Case - All (Sec.)"; Integer)
        {
            CalcFormula = Count("Writ/Case Header" WHERE("User Exam Code" = CONST('EXESEC')));
            FieldClass = FlowField;
        }
        field(30; "Writ/Case - All (S Sec.)"; Integer)
        {
            CalcFormula = Count("Writ/Case Header" WHERE("User Exam Code" = CONST('EXESSEC')));
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
}

