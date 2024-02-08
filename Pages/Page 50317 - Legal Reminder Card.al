page 50317 "Legal Reminder Card"
{
    Caption = 'Reminder Card';
    //DataCaptionExpression = "Reminder No.";
    DataCaptionFields = "Reminder No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Reminder Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reminder No."; Rec."Reminder No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'File No.';

                    trigger OnDrillDown()
                    begin
                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE("File No.", REC."Document No.");
                        IF WritCaseHdr.FIND('-') THEN
                            PAGE.RUN(50405, WritCaseHdr);
                    end;
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Attachment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF REC.Attachment <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec.Attachment)
                    end;
                }
                field(Description; REC.Description)
                {
                    MultiLine = true;
                }
                field("Sender ID"; REC."Sender ID")
                {
                }
                field("Sender Description"; REC."Sender Description")
                {
                    Caption = 'Sender Name\Designation';
                    Editable = false;
                }
                field("Sent Date Time"; REC."Sent Date Time")
                {
                }
                field("Receiver ID"; REC."Receiver ID")
                {
                    Editable = false;
                }
                field("Receiver Description"; REC."Receiver Description")
                {
                    Caption = 'Receiver Name\Designation';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnAfterGetRecord()
    begin
        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnClosePage()
    begin
        IF rec.Unread THEN BEGIN
            rec.Unread := FALSE;
            REC."Read Date Time" := CURRENTDATETIME;
            rec.MODIFY;
        END;
    end;

    trigger OnOpenPage()
    begin
        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    var
        AttachedFile: Text;
        InvSetup: Record "Inventory Setup";

        WritCaseHdr: Record "Writ/Case Header";
}

