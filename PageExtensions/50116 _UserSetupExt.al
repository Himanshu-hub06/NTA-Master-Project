pageextension 50116 "User Setup Ext." extends "User Setup"
{
    layout
    {
        modify("User ID")
        {
            ApplicationArea = All;
            trigger OnAfterValidate()
            var
                myInt: Integer;
                BOCUser: Record "User BOC";
            begin
                BOCUser.Reset();
                BOCUser.SetRange("User Name", Rec."User ID");
                if BOCUser.FindFirst() then
                    Rec.Designation := BOCUser.Designation;
                //Message('aFTER VALIDATE');
            end;
        }

        addafter(PhoneNo)
        {

            field(Designation; Rec.Designation)
            {
                ApplicationArea = All;
            }
            field(Section; Rec.Section)
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Store Section"; Rec."Store Section")
            {
                ApplicationArea = All;
            }
            field("Section Approver"; Rec."Section Approver")
            {
                ApplicationArea = All;
            }
            field("Indent Approval"; Rec."Indent Approval")
            {
                ApplicationArea = All;
            }
            field("Requisition Approval"; Rec."Requisition Approval")
            {
                ApplicationArea = All;
            }
            field("Indent Approver ID"; Rec."Indent Approver ID")
            {
                ApplicationArea = All;
            }
            field("Vendor Payment Approval"; Rec."Vendor Payment Approval")
            {
                ApplicationArea = All;

            }
            field("Requsition Approver ID"; Rec."Requsition Approver ID")
            {
                ApplicationArea = All;
            }
            field("Hold Bill Update"; Rec."Hold Bill Update")
            {
                ApplicationArea = All;

            }
            field("CNTB Bill Rollback"; Rec."CNTB Bill Rollback")
            {
                ApplicationArea = All;

            }
        }
    }
}
