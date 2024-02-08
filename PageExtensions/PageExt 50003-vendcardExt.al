pageextension 50019 vendcardExt extends "Vendor Card"
{
    layout
    {

        addafter("Disable Search by Name")
        {
            field("Vendor D.O.B"; Rec."Vendor D.O.B")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address 2")
        {
            field(Address3; Rec.Address3)
            {
                Caption = 'Address 3';
                ApplicationArea = All;
            }

        }
        addafter("State Code")
        {
            field("Vendor Account No."; Rec."Vendor Account No.")
            {
                ApplicationArea = All;

            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = All;

            }
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;

            }
            field(Branch; Rec.Branch)
            {
                ApplicationArea = All;

            }

            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;

            }
        }
        addafter("Address & Contact")
        {
            group(Organization)
            {
                field("Organization Name"; Rec."Organization Name")
                {
                    ApplicationArea = All;
                }
                field("Organization Department"; Rec."Organization Dapartment")
                {
                    ApplicationArea = All;
                }
                field("Organization Type"; Rec."Organization Type")
                {
                    ApplicationArea = All;
                }
                field("Organization Address"; Rec."Organization Address")
                {
                    ApplicationArea = All;
                }
                field("Organization City"; Rec."Organization City")
                {
                    ApplicationArea = All;
                }
                field("Organization State"; Rec."Organization State")
                {
                    ApplicationArea = All;
                }
                field("Organization Pincode"; Rec."Organization Pincode")
                {
                    ApplicationArea = All;
                }
                field("Organization Office No."; Rec."Organization Office No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    // actions
    // {
    //     addafter(PayVendor)
    //     {
    //         action("Update Vendor")
    //         {
    //             ApplicationArea = All;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             trigger OnAction()
    //             var
    //                 VendorTab: Record Vendor;
    //             begin
    //                 VendorTab.Reset();
    //                 VendorTab.SetCurrentKey("No.");
    //                 VendorTab.SetRange(VendorTab."Global Dimension 1 Code", 'M001');
    //                 if VendorTab.FindSet() then
    //                     repeat
    //                         VendorTab."Vendor Posting Group" := 'PM';
    //                         VendorTab."VAT Bus. Posting Group" := 'DOMESTIC';
    //                         VendorTab."Assessee Code" := 'COM';
    //                         VendorTab."Gen. Bus. Posting Group" := 'DOMESTIC';
    //                         VendorTab.Modify();
    //                     until VendorTab.Next() = 0;
    //                 Message('Done;');
    //             end;
    //         }
    //     }
    // }
}
