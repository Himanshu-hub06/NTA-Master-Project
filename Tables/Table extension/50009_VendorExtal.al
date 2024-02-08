/// <summary>
/// TableExtension Vendor_Ext.al (ID 50002) extends Record Vendor.
/// </summary>
tableextension 50009 "Vendor_Ext" extends Vendor
{
    fields
    {
        field(50001; "GeM Vendor"; Boolean)
        {
            Caption = 'GeM Vendor';
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor Account No."; Code[20])
        {
            Caption = 'Vendor Account No.';
            DataClassification = ToBeClassified;
        }
        field(50003; "IFSC Code"; Code[20])
        {
            Caption = 'IFSC Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec."IFSC Code" := UpperCase(Rec."IFSC Code");
            end;
        }

        field(50004; "Bank Name"; Text[30])
        {
            Caption = 'Bank Name';
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor A/C Full Name"; Text[80])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(50011; "Approval Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
            OptionCaption = ' ,Open,Pending,Approved,Rejected';
        }
        field(50012; "Approved User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Rejected Reason"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "PFMS Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Organization Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Organization Dapartment"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Organization Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Organization Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Organization City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Organization State"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(50022; "Organization Pincode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Organization Office No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Vendor D.O.B"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Address3; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; Branch; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Branch';
            trigger OnValidate()
            begin
                Rec.Branch := UpperCase(Rec.Branch);
            end;
        }
        field(50027; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",City_Coordinator,Deputy_Observer,Flying_Squad,National_Coordinator,Observer,Special_Coordinator,Special_Observer,State_Coordinator,Technical_Observer,Virtual_Observer,Zonal_Observer;
            OptionCaption = ' ,City_Coordinator,Deputy_Observer,Flying_Squad,National_Coordinator,Observer,Special_Coordinator,Special_Observer,State_Coordinator,Technical_Observer,Virtual_Observer,Zonal_Observer';
        }
    }
}
