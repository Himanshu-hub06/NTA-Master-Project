page 50367 "SOF Received - After Cre Card"
{
    Caption = 'SOF Receive - After Creation';
    //DataCaptionExpression = "File No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Advocate Assigning Entry";




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

    // actions
    // {
    //     area(processing)
    //     {
    //         action(Attachmet)
    //         {
    //             Image = Attach;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin
    //                 InvSetup.GET;
    //                 OldFileName:='';
    //                 OldFileName:=(InvSetup."Writ Case Write Path" + "SOF File Name");
    //                 ServerFileName:=FileManagement.UploadFile(DialogTitle,'');
    //                 ClientFileName:=FileManagement.GetFileName(ServerFileName);
    //                 IF ClientFileName <> '' THEN BEGIN
    //                   "SOF File Name":=DELCHR("File No.",'=','/') + '_'+FORMAT("Line No.") +'_C_'+ClientFileName;
    //                    MODIFY(TRUE);
    //                  END ELSE
    //                   BEGIN
    //                   "SOF File Name":='';
    //                    MODIFY(TRUE);
    //                 END;
    //                 ClientFileName := InvSetup."Writ Case Write Path" + DELCHR("File No.",'=','/') + '_'+FORMAT("Line No.") + '_C_'+ClientFileName;
    //                 FileManagement.CopyServerFile(ServerFileName,ClientFileName,TRUE);
    //                 IF (OldFileName <> '') AND (OldFileName <> ClientFileName) THEN
    //                   FileManagement.DeleteServerFile(OldFileName);
    //                 IF "SOF File Name" <> '' THEN
    //                   AttachedFile:=ViewText;
    //             end;
    //         }
    //         action(Receive)
    //         {
    //             Image = ReleaseDoc;
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin
    //                 IF "SOF File Name" = '' THEN
    //                   ERROR('Attachment not found');
    //                 IF "SOF Received Date" = 0D THEN
    //                   ERROR('Please enter SOF received date');
    //                 IF ("Created/Reviewed SOF" = FALSE) AND ("Revised SOF" = FALSE) THEN
    //                   ERROR('Choose Created/Reviewed or Revised SOF');
    //                 IF NOT CONFIRM(Text0001) THEN
    //                   EXIT
    //                 ELSE BEGIN
    //                   "SOF Received":=TRUE;
    //                   "SOF Received By":=USERID;
    //                   MODIFY(TRUE);
    //                   WritHdr.RESET;
    //                   WritHdr.SETCURRENTKEY("File No.");
    //                   WritHdr.SETRANGE("File No.","File No.");
    //                   IF WritHdr.FIND('-') THEN BEGIN
    //                     IF WritHdr.Status = WritHdr.Status::Disposed THEN
    //                       ERROR('Case is disposed, cannot received.');
    //                     WritHdr."SOF Status":=WritHdr."SOF Status"::Created;
    //                     WritHdr."SOF Created":=TRUE;
    //                      IF WritHdr.MODIFY THEN
    //                       CurrPage.CLOSE;
    //                   END;
    //                 END;
    //             end;
    //         }
    //     }
    // }

    trigger OnOpenPage()
    begin
        IF rec."SOF File Name" <> '' THEN
            AttachedFile := 'View';
    end;

    var
        AdvAssignEntry: Record "Advocate Assigning Entry";
        WritHdr: Record "Writ/Case Header";
        Text0001: Label 'Do you want to receive ?';
        ServerFileName: Text;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        //ServerFileHelper: DotNet File;
        OldFileName: Text;
        AttachedFile: Text;
        ViewText: Label 'View';
}

