table 50286 "AV Meeting Line"
{

    fields
    {
        field(1; "Committee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Meeting No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Meeting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fresh Empanelment,Renewal';
            OptionMembers = " ","Fresh Empanelment",Renewal;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Approve; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Newspaper Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            // trigger OnValidate()
            // var
            //     VendorEmpPrintRec, VendorEmpPrintRec2 : Record 50152;
            //     //   ,          VendorEmpPrintRec2: Record "50152";
            //     MeetingLineRec: Record 50061;
            // begin
            //     IF "Newspaper Code" <> '' THEN BEGIN
            //         MeetingMasterG.RESET;
            //         IF MeetingMasterG.GET(Rec."Committee Code", Rec."Meeting Type", Rec."Meeting No.") THEN BEGIN
            //             DefaultValues(MeetingMasterG);
            //         END;
            //         MeetingLineRec.RESET;
            //         MeetingLineRec.SETRANGE("Committee Code", Rec."Committee Code");
            //         MeetingLineRec.SETRANGE("Meeting No.", Rec."Meeting No.");
            //         MeetingLineRec.SETRANGE("Meeting Type", Rec."Meeting Type");
            //         MeetingLineRec.SETRANGE("Newspaper Code", Rec."Newspaper Code");
            //         IF MeetingLineRec.FINDFIRST THEN
            //             ERROR('Newspaper %1 already exist. You can not select a newspaper more than one time')
            //         ELSE BEGIN
            //             CASE "Meeting Type" OF
            //                 "Meeting Type"::" ":
            //                     BEGIN
            //                         VendorEmpPrintRec.RESET;
            //                         VendorEmpPrintRec.SETRANGE(VendorEmpPrintRec."Newspaper Code", Rec."Newspaper Code");
            //                         IF VendorEmpPrintRec.FINDFIRST THEN BEGIN
            //                         END;
            //                         "Newspaper Name" := VendorEmpPrintRec."Newspaper Name";
            //                         "Place of Publication" := VendorEmpPrintRec."Place of Publication";
            //                         Language := VendorEmpPrintRec.Language;
            //                         "Bank Account No." := VendorEmpPrintRec."Bank Account No.";
            //                         "Bank Name" := VendorEmpPrintRec."Bank Name";
            //                         "Account Holder Name" := VendorEmpPrintRec."Account Holder Name";
            //                         "Account Address" := VendorEmpPrintRec."Account Address";
            //                         "IFSC Code" := VendorEmpPrintRec."IFSC Code";
            //                         Branch := VendorEmpPrintRec.Branch;
            //                         "RNI Registration No." := VendorEmpPrintRec."RNI Registration No.";
            //                     END;
            //             END;
            //         END;
            //     END;
            // end;  //ROHIT
        }
        field(7; "Newspaper Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Place of Publication"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Language; Code[30])
        {
            //  DataClassification = ToBeClassified;
            //  TableRelation = Language.Code WHERE("BOC used Indian Language" = CONST(true)); //ROHIT
        }
        field(10; "Bank Account No."; Code[30])
        {
            Caption = 'Bank Account No. for recieving Payments';
            DataClassification = ToBeClassified;
        }
        field(11; "Account Holder Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Account Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "IFSC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Bank Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Branch; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "RNI Registration No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Approved,Rejected,Pending';
            OptionMembers = Open,Approved,Rejected,Pending;
        }
        field(19; "All Approval"; Boolean)
        {
            // FieldClass = FlowField;// ROHIT
            // CalcFormula = - exist("AV Committee Member App Entry" where("Committee Code" = field("Committee Code"), "Meeting No." = field("Meeting No."), "FM Station Code" = field("Newspaper Code"), Submitted = const(false)));
        }
        field(20; "Final Approval"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Final Rejection" THEN
                    "Final Rejection" := FALSE;
            end;
        }

        field(21; "Total Member"; Integer)
        {
            // CalcFormula = Count("AV Committee Line" WHERE("Committee Code" = FIELD("Committee Code")));   HYC 
            // FieldClass = FlowField;
        }
        field(22; "Total Approved"; Integer)
        {
            // CalcFormula = Count("AV Committee Member App Entry" WHERE("FM Station Code" = FIELD("Newspaper Code"),
            //                                                         Approve = FILTER(true)));
            // FieldClass = FlowField; //ROHIT
        }
        field(23; "Total Rejected"; Integer)
        {
            // CalcFormula = Count("AV Committee Member App Entry" WHERE("FM Station Code" = FIELD("Newspaper Code"),
            //                                                         Reject = FILTER(true)));
            // FieldClass = FlowField; // ROHIT
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "Final Rejection"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Final Approval" THEN
                    "Final Approval" := FALSE;
            end;
        }
        field(27; "Final Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Last Modified DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Proposed Circulation"; Integer)//kamlesh date 08-04-2023
        {
            DataClassification = ToBeClassified;
        }
        // field(33; "All Submition"; Integer)//kamlesh 110423
        // {
        //     CalcFormula = Count("Committee Member App Entry" WHERE("Newspaper Code" = FIELD("Newspaper Code"),
        //                                                             Submitted = FILTER(true)));
        //     FieldClass = FlowField;
        // }
        field(34; "Returned By DG"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Doc Completed"; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = exist("Vend Emp - Pvt. FM" where("FM Station ID" = field("Newspaper Code"), "Documents Completed" = filter(Yes))); //ROHIT
        }
        field(36; "Close Meeting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //used for production
        field(37; "Applied For"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Application Category"; Option)
        {
            Caption = 'Application Category';
            OptionMembers = A,B,C;
            DataClassification = ToBeClassified;
        }
        //used for production
    }

    keys
    {
        key(Key1; "Committee Code", "Meeting No.", "Line No.")
        {
        }
        key(Key2; "Newspaper Code", "Newspaper Name")
        {
        }
        key(Key3; "Document No.", "Newspaper Code", "Newspaper Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Newspaper Code");
    end;

    var
        FieldRec: Record 2000000041;
        TableNo: Integer;
        MeetingMasterG: Record 50060;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        "Last Modified By" := UserId;
        "Last Modified DateTime" := CurrentDateTime;
    end;

    local procedure DefaultValues(var MeetingMaster: Record 50060)
    begin
        // "Document No." := MeetingMaster."Document No.";
        // Status := MeetingMaster.Status;  //ROHIT
    end;

    // procedure LoadApplicationProduction()
    // var
    //     ProductionEMPLst: Page 50541;
    //     VendEmpProducersTab: Record "Vendor Emp - Producers";
    // begin
    //     Clear(ProductionEMPLst);
    //     VendEmpProducersTab.Reset();
    //     VendEmpProducersTab.SetRange(Status, VendEmpProducersTab.Status::"Recommended in EAC");
    //     if VendEmpProducersTab.FindSet() then;
    //     ProductionEMPLst.SetRecord(VendEmpProducersTab);
    //     ProductionEMPLst.Editable(false);

    // end;// ROHIT

}

