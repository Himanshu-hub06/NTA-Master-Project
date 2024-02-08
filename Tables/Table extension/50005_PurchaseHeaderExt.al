/// <summary>
/// TableExtension Purchase Header Extension (ID 50009) extends Record Purchase Header.
/// </summary>
tableextension 50005 "Purchase Header Extension" extends "Purchase Header"
{
    fields
    {
        field(50000; "Purchase Proposal"; Code[20])
        {
            Caption = 'Purchase Proposal';
            DataClassification = ToBeClassified;
        }
        field(50001; "Structure"; Code[10])
        {
            Caption = 'Structure';
            DataClassification = ToBeClassified;
        }
        field(50002; "RO Type"; Option)
        {

            DataClassification = ToBeClassified;
            OptionMembers = ,"Print Media","Out Door","TV","Radio";
        }
        field(50003; "RO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Control No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "RO Line"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Direct Purchase",Quotation,GeM,Tender;
        }
        field(50030; "Admin Bill"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Sanction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Sanction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50050; "Sanction No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "PFMS Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Sanction could not Pushed","Sanction Pushed";
        }
        field(50060; "Payment Proposal Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Proposal Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Approved,"Pending Approval",Rejected;
        }
        field(50062; MyField; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Transfer User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Transfer User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Pending To User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Pending To User Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Payment Voucher Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Calculate IT TDS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Calculate GST TDS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "PFMS File Attachment"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Account Accepted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Account Accepted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Account Accepted User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Loc Fund Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; Remark; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Exam Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Section Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Old File No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "e-office File No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Assessee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

}
