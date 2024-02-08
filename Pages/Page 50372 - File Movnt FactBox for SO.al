page 50372 "File Movnt FactBox for SO"
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
                }
                field("Sending Date"; rec."Sending Date")
                {
                }
                field("Receiver ID"; rec."Receiver ID")
                {
                }
                field(Status; rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        rec.FILTERGROUP(2);
        //rec.SETRANGE("In Legal Section",FALSE);   //HYC 190923
    end;

    var
        UserSetup: Record "User Setup";
        Enable: Boolean;

    procedure FileMovementEntryExist(SourceFileNo: Code[20]) EntryExist: Boolean
    begin
        rec.SETRANGE("Document No.", SourceFileNo);
        EntryExist := NOT rec.ISEMPTY;
        CurrPage.UPDATE(FALSE);
    end;
}

