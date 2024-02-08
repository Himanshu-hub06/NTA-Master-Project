page 50399 "File Movement FactBox"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    PopulateAllFields = true;
    SourceTable = 50215;



    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    Caption = 'File No.';
                    Visible = false;
                }
                field("Sending Date"; rec."Sending Date")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Receiver Description"; rec."Receiver Description")
                {
                    Caption = 'Receiver User';

                    trigger OnDrillDown()
                    begin
                        FileMovEntry.RESET;
                        FileMovEntry.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
                        FileMovEntry.SETRANGE("Document No.", rec."Document No.");
                        IF FileMovEntry.FIND('-') THEN
                            PAGE.RUNMODAL(50147, FileMovEntry);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        FileMovEntry.RESET;
                        FileMovEntry.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
                        FileMovEntry.SETRANGE("Document No.", rec."Document No.");
                        IF FileMovEntry.FIND('-') THEN
                            PAGE.RUNMODAL(50359, FileMovEntry);
                    end;
                }
                field("Current User"; rec."Current User")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        UserSetup: Record 91;
        FileMovEntry: Record 50215;

    procedure FileMovementEntryExist(SourceFileNo: Code[20]) EntryExist: Boolean
    begin
        rec.SETRANGE("Document No.", SourceFileNo);
        EntryExist := NOT rec.ISEMPTY;
        CurrPage.UPDATE(FALSE);
    end;
}

