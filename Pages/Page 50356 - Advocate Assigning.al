page 50356 "Advocate Assigning"
{
    Caption = 'Assigning of Internal/External Advocate';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Advocate Assigning Entry";
    SourceTableView = SORTING("File No.", "Line No.")
                      ORDER(Ascending);

    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File No."; rec."File No.")
                {
                    Editable = false;
                }
                field("Advocate Type"; rec."Advocate Type")
                {
                }
                field("Advocate Code"; rec."Advocate Code")
                {

                    trigger OnValidate()
                    begin
                        IF rec."Advocate Type" = rec."Advocate Type"::Internal THEN
                            Enable1 := TRUE
                        ELSE
                            Enable1 := FALSE;
                    end;
                }
                field("Advocate Name"; rec."Advocate Name")
                {
                    Editable = false;
                }
                field("Internal Adv. Type"; rec."Internal Adv. Type")
                {
                    Enabled = true;
                }
                field("Assigned Date"; rec."Assigned Date")
                {

                    trigger OnValidate()
                    begin

                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE("File No.", rec."File No.");
                        IF WritCaseHdr.FIND('-') THEN
                            IF WritCaseHdr."BSEB Receiving Date" <> 0D THEN BEGIN
                                IF rec."Assigned Date" < WritCaseHdr."BSEB Receiving Date" THEN
                                    ERROR('Advocate assign date should be greater than or equals to BSEB receiving date');
                            END ELSE
                                ERROR('Please enter BSEB receiving date');
                    end;
                }
                field(Remarks; rec.Remarks)
                {
                }
                field(Active; rec.Active)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Cancel)
            {
                Image = CancelLine;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF NOT rec.Active THEN
                        ERROR('Already cancel');

                    IF NOT CONFIRM('Text002') THEN
                        EXIT;
                    // Active := FALSE;
                    // "Inactive Date" := WORKDATE;
                    // MODIFY(TRUE);

                    //END;

                end;
            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     IF rec."Advocate Type" = rec."Advocate Type"::Internal THEN
    //         Enable1 := TRUE
    //     ELSE
    //         Enable1 := FALSE;
    // end;

    trigger OnModifyRecord(): Boolean
    begin
        //     IF Active THEN
        //         ERROR('Active entry cannot be modified.');
    end;

    var
        Text001: Label 'Advocate type should be Internal';
        Enable1: Boolean;
        AdvMaster: Record Advocate;
        AdvAssignEntry: Record "Advocate Assigning Entry";
        WritCaseHdr: Record "Writ/Case Header";
        AdvType: Text;
        Text002: Label 'Do you want to cancel advocate assign entry ?';
        CreatedErr: Label 'SOF received from %1, you cannot cancel advocate assign entry.';

}