page 50133 "Approval User Group Members"
{
    Caption = 'Approval User Group Members';
    // DelayedInsert = true;
    PageType = List;
    SourceTable = 50082;
    ApplicationArea = all;
    SourceTableView = SORTING("Sequence No.")
                      ORDER(Ascending);
    // DeleteAllowed = true;
    // InsertAllowed = true;
    // ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; rec."User ID")
                {
                    LookupPageID = "Approval User Setup";
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(NTAUser);
                        IF NTAUser.RUNMODAL = ACTION::OK THEN BEGIN
                            NTAUser.GETRECORD(UserTab);
                            rec."User ID" := UserTab."User Name";
                            rec."User Description" := UserTab.Designation;
                            // "Sequence No." += 1;
                        END;
                    end;
                }
                field("Sequence No."; rec."Sequence No.")

                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("User Description"; rec."User Description")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Minimum Price For Approval"; rec."Minimum Price For Approval")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Maximum Price For Approval"; rec."Maximum Price For Approval")
                {
                    ApplicationArea = all;
                }
                field("Approval Permission"; rec."Approval Permission")
                {
                    ApplicationArea = all;
                }
                field("Recommend To Committee"; rec."Recommend To Committee")
                {
                    ApplicationArea = all;
                }
                field("Send for Modification"; rec."Send For Modification")
                {
                    ApplicationArea = All;

                }
                field("Plan Modification"; Rec."Plan Modification")
                {
                    ApplicationArea = All;

                }
                field("Agreement Creation"; Rec."Agreement Creation")
                {
                    ApplicationArea = All;

                }
                field("Application User Shift"; Rec."Application User Shift")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        IF (rec."Minimum Price For Approval" <> 0) AND (rec."Maximum Price For Approval" = 0) THEN
            rec."Maximum Price For Approval" := 999999999999999.99;
    end;

    var
        UserTab: Record 50000;
        NTAUser: Page 50130;
}

