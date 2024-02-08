page 50368 "SOF Received - After Rev Card"
{
    Caption = 'SOF Receive - After Review';
    DataCaptionExpression = rec."File No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 50207;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; rec."File No.")
                {
                    Editable = false;
                }
                field("Name Of Petitioner"; rec."Name Of Petitioner")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Case No."; rec."Case No.")
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Year; rec.Year)
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Advocate Code"; rec."Advocate Code")
                {
                    Editable = false;
                }
                field("Advocate Name"; rec."Advocate Name")
                {
                    Editable = false;
                }
                field("SOF Sending Date"; rec."SOF Sending Date")
                {
                    Caption = 'SOF Sent Date';
                    Editable = false;
                }
                field("SOF Received Date"; rec."SOF Received Date")
                {
                    ShowMandatory = true;
                }
                field("Created/Reviewed SOF"; rec."Created/Reviewed SOF")
                {

                    trigger OnValidate()
                    begin
                        IF rec."Created/Reviewed SOF" THEN
                            rec.VALIDATE("Revised SOF", FALSE);
                    end;
                }
                field("Revised SOF"; rec."Revised SOF")
                {

                    trigger OnValidate()
                    begin
                        IF rec."Revised SOF" THEN
                            rec.VALIDATE("Created/Reviewed SOF", FALSE);
                    end;
                }
                field(Supplementary; rec.Supplementary)
                {
                    Editable = false;
                }
                field(Attachment; AttachedFile)
                {
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec."SOF File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec."SOF File Name");
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Attachmet)
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    InvSetup.GET;
                    OldFileName := '';
                    OldFileName := (InvSetup."Writ Case Write Path" + rec."SOF File Name");
                    ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                    ClientFileName := FileManagement.GetFileName(ServerFileName);
                    IF ClientFileName <> '' THEN BEGIN
                        rec."SOF File Name" := DELCHR(rec."File No.", '=', '/') + '_' + FORMAT(rec."Line No.") + '_R_' + ClientFileName;
                        rec.MODIFY(TRUE);
                    END ELSE BEGIN
                        rec."SOF File Name" := '';
                        rec.MODIFY(TRUE);
                    END;
                    ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(rec."File No.", '=', '/') + '_' + FORMAT(rec."Line No.") + '_R_' + ClientFileName;
                    FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                    IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
                        FileManagement.DeleteServerFile(OldFileName);
                    IF rec."SOF File Name" <> '' THEN
                        AttachedFile := ViewText;
                end;
            }
            action(Receive)
            {
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF rec."SOF File Name" = '' THEN
                        ERROR('Attachment not found');
                    IF rec."SOF Received Date" = 0D THEN
                        ERROR('Please enter SOF received date');
                    IF (rec."Created/Reviewed SOF" = FALSE) AND (rec."Revised SOF" = FALSE) THEN
                        ERROR('Choose Created/Reviewed or Revised SOF');
                    IF NOT CONFIRM(Text0001) THEN
                        EXIT
                    ELSE BEGIN
                        rec."SOF Received" := TRUE;
                        rec."SOF Received By" := USERID;
                        rec.MODIFY(TRUE);
                        WritHdr.RESET;
                        WritHdr.SETCURRENTKEY("File No.");
                        WritHdr.SETRANGE("File No.", rec."File No.");
                        IF WritHdr.FIND('-') THEN BEGIN
                            IF WritHdr.Status = WritHdr.Status::Disposed THEN
                                ERROR('Case is disposed, cannot received.');
                            WritHdr."SOF Status" := WritHdr."SOF Status"::Reviewed;
                            IF WritHdr.MODIFY THEN
                                CurrPage.CLOSE;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF rec."SOF File Name" <> '' THEN
            AttachedFile := 'View';

        AdvAssignEntry.RESET;
        AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
        AdvAssignEntry.SETRANGE("File No.", rec."File No.");
        AdvAssignEntry.SETRANGE("Line No.", rec."Line No.");
        IF AdvAssignEntry.FIND('-') THEN;
    end;

    var
        AdvAssignEntry: Record 50207;
        WritHdr: Record "Writ/Case Header";
        Enable: Boolean;
        Text0001: Label 'Do you want to receive ?';
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        //ServerFileHelper: DotNet File;            HYC190923
        OldFileName: Text;
        AttachedFile: Text;
        ServerFileName: Text;
        ViewText: Label 'View';

}

