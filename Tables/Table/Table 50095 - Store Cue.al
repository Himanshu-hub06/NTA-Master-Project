table 50095 "Store Cue"
{
    Caption = 'Store Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
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
        field(22; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(23; "Open Requisition"; Integer)
        {
            //AccessByPermission = TableData 50170 = R;
            // CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Open)));
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Open), "User ID" = field("User Filter")));

            FieldClass = FlowField;
        }
        field(25; "Pending Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            // CalcFormula = Count("Requistion Header" WHERE(Status = CONST("Pending for Approval")));
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST("Pending for Approval"), "Approving UID" = FIELD("User Filter")));
            FieldClass = FlowField;
        }
        field(26; "Approved Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = FILTER(Approved), "Approving UID" = FIELD("User Filter")));
            // CalcFormula = Count("Requistion Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        field(49; "Rejected Requisition"; Integer)
        {
            // DataClassification = ToBeClassified;
            AccessByPermission = tabledata 50087 = R;
            FieldClass = FlowField;
            CalcFormula = count("Requistion Header" where(Status = FILTER(Rejected), "User ID" = field("User Filter")));
            //CalcFormula = count("Requistion Header" where(Status = const(Rejected)));
        }
        field(27; User; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Total Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = FILTER(Open | "Pending for Approval" | Approved | Rejected)));
            FieldClass = FlowField;
        }
        field(29; "Total pending Requisition"; Integer)
        {
            DataClassification = ToBeClassified;
            FieldClass = Normal;

            trigger OnValidate()
            begin
                //CALCDATE('-1Y',TODAY)
            end;
        }
        field(30; "YTD Verification - BOC"; Integer)
        {
            DataClassification = ToBeClassified;
            FieldClass = Normal;
        }
        field(31; "YTD Verification - Outside"; Integer)
        {
            CalcFormula = Count("Requistion Header" WHERE("Location Code" = CONST('NEW DELHI')));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //CALCDATE('-1Y',TODAY)
            end;
        }
        field(32; "At Current User"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Today Open Requisition Docs"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Open),
                                                           "Requisition to Section" = FIELD("Section Filter"),
                                                           "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(34; "Monthly Open Requisition Docs"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Open),
                                                           "Posting Date" = FIELD("Date Filter1"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(35; "Date Filter1"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(36; "Yearly Open Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Open),
                                                           "Posting Date" = FIELD("Date Filter2"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(37; "Today Pending Requisition Docs"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            FieldClass = Normal;
        }
        field(38; "Monthly Pending Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST("Pending for Approval"),
                                                           "Posting Date" = FIELD("Date Filter1"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(39; "Yearly Pending Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST("Pending for Approval"),
                                                           "Posting Date" = FIELD("Date Filter2"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(40; "Today Approved Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Approved),
                                                           "Posting Date" = FIELD("Date Filter"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(41; "Monthly Approved Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Approved),
                                                           "Posting Date" = FIELD("Date Filter1"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(42; "Yearly Approved Requisition"; Integer)
        {
            AccessByPermission = TableData 50087 = R;
            CalcFormula = Count("Requistion Header" WHERE(Status = CONST(Approved),
                                                           "Posting Date" = FIELD("Date Filter2"),
                                                           "Requisition to Section" = FIELD("Section Filter")));
            FieldClass = FlowField;
        }
        field(43; "Pending for Issue"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Section Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(45; "Open Indent"; Integer)
        {
            AccessByPermission = tabledata "Indent Header" = R;
            FieldClass = FlowField;
            CalcFormula = count("Indent Header" where(Status = const(Open), "User ID" = FIELD("User Filter")));

        }
        field(46; "Pending Indent"; Integer)
        {
            // DataClassification = ToBeClassified;
            AccessByPermission = tabledata "Indent Header" = R;
            FieldClass = FlowField;
            CalcFormula = count("Indent Header" where(Status = const("Pending for Approval"), "Pending From User Id" = FIELD("User Filter")));
            // CalcFormula = count("Indent Header" where(Status = const("Pending for Approval")));
        }
        field(47; "Approved Indent"; Integer)
        {
            // DataClassification = ToBeClassified;
            AccessByPermission = tabledata "Indent Header" = R;
            FieldClass = FlowField;
            CalcFormula = count("Indent Header" where(Status = const(Approved), "Pending From User Id" = FIELD("User Filter")));
            // CalcFormula = count("Indent Header" where(Status = const(Approved)));
        }
        field(48; "Rejected Indent"; Integer)
        {
            // DataClassification = ToBeClassified;
            AccessByPermission = tabledata "Indent Header" = R;
            FieldClass = FlowField;
            CalcFormula = count("Indent Header" where(Status = const(Rejected), "User ID" = FIELD("User Filter")));
            // CalcFormula = count("Indent Header" where(Status = const(Rejected)));
        }

        field(50; "User Filter"; Code[50])
        {

            FieldClass = FlowFilter;
        }
        field(51; "Open - Gem Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter('GeM'), Status = filter('Open'), Posted = filter(false), "User ID" = field("User Filter")));
        }
        field(52; "Pending - Gem Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter('GeM'), Status = filter('Pending for Approval'), Posted = filter(false), "Transfer User Id" = field("User Filter")));
        }
        field(53; "Approved - Gem Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter('GeM'), Status = filter(Approved), Posted = filter(false), "Approving UID" = field("User Filter")));
        }
        field(54; "Issue From Store"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Requistion Header" where(Posted = filter(true), Status = filter(Approved), Issued = filter(false), "User ID" = FIELD("User Filter")));
        }
        field(55; "Issued From Store"; Integer)
        {
            Caption = 'Issued/Closed';
            FieldClass = FlowField;
            CalcFormula = count("Posted Requistion Header" where(Status = FILTER(Closed | Issued), "User ID" = field("User Filter")));
        }
        field(56; "Open - DP-Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter(Direct), Status = const(Open), Posted = const(false), "User ID" = field("User Filter")));
        }
        field(57; "Pending - DP-Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter(Direct), Status = filter("Pending for Approval"), Posted = filter(false), "Transfer User Id" = field("User Filter")));
        }
        field(58; "Approved - DP-Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Proposal Header" where("Purchase Type" = filter(Direct), Status = filter(Approved), Posted = filter(false), "Approving UID" = field("User Filter")));
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

