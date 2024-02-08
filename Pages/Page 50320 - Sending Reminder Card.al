page 50320 "Sending Reminder Card"
{
    Caption = 'Reminder Card';
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Reminder Entry";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reminder No."; rec."Reminder No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF rec."Reminder No." = '' THEN
                            IF rec.AssistEdit THEN
                                CurrPage.UPDATE;
                    end;
                }
                field("Document No."; rec."Document No.")
                {
                    Caption = 'File No.';
                    Editable = editable;
                    ShowMandatory = true;
                }
                field("Receiver ID"; rec."Receiver ID")
                {
                    Editable = editable;
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //UserTab.SETRANGE(UserTab."Employee Left Status",'N'); //dsc
                        UserTab.SETFILTER("User Name", '<>%1', USERID);
                        IF PAGE.RUNMODAL(50381, UserTab) = ACTION::LookupOK THEN BEGIN
                            rec."Receiver ID" := UserTab."User Name";
                            rec."Receiver Description" := UserTab."Full Name";
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Receiver Description"; rec."Receiver Description")
                {
                    Caption = 'Receiver Name';
                    Editable = false;
                }
                field(AttachedFile; AttachedFile)
                {
                    Caption = 'Attachment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF rec.Attachment <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + rec.Attachment)
                    end;
                }
                field(Description; rec.Description)
                {
                    Editable = editable;
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Attachment)
            {
                Image = Attach;
                Promoted = true;
                Visible = editable;

                trigger OnAction()
                begin
                    InvSetup.GET;
                    OldFileName := '';
                    OldFileName := (InvSetup."Writ Case Write Path" + rec.Attachment);
                    ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                    ClientFileName := FileManagement.GetFileName(ServerFileName);
                    IF ClientFileName <> '' THEN BEGIN
                        rec.Attachment := DELCHR(rec."Reminder No.", '=', '/') + '_' + ClientFileName;
                        rec.MODIFY(TRUE);
                    END ELSE BEGIN
                        rec.Attachment := '';
                        rec.MODIFY(TRUE);
                    END;
                    ClientFileName := InvSetup."Writ Case Write Path" + DELCHR(rec."Reminder No.", '=', '/') + '_' + ClientFileName;
                    FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                    IF (OldFileName <> ClientFileName) AND (OldFileName <> '') THEN
                        FileManagement.DeleteServerFile(OldFileName);
                    IF rec.Attachment <> '' THEN
                        AttachedFile := Text001;
                end;
            }
            action(Send)
            {
                Image = SendTo;
                Promoted = true;
                Visible = Editable;

                //DSC

                //         trigger OnAction()
                //         begin
                //             rec.TESTFIELD("Reminder No.");
                //             IF rec."Document No." = '' THEN
                //               ERROR('File no. cannot be blank');
                //             rec.TESTFIELD("Receiver ID");
                //             rec.TESTFIELD(Description);
                //             IF NOT CONFIRM('Do you want to send reminder?') THEN
                //               EXIT
                //             ELSE BEGIN
                //               IF rec."Receiver ID" = USERID THEN
                //                 ERROR('You cannot send reminder yourself');
                //               UserSetup.GET(USERID);
                //               rec.Sent:=TRUE;
                //               rec."Sender ID":=USERID;
                //               rec."Sender Section Code":=UserSetup.Section;
                //               rec."Sent Date Time":=CURRENTDATETIME;
                //               rec.Active:=TRUE;
                //               rec.Unread:=TRUE;
                //               rec.MODIFY(TRUE);
                //                //.Net Notificaion Table Start
                //                  ExtNotification.INIT;
                //                  ExtNotification."Module ID":=68;
                //                  ExtNotification."View ID":=3831;
                //                  ExtNotification."Action ID":=14;

                //                  ExtUserMaster.RESET;
                //                  ExtUserMaster.SETRANGE("User Name",UserSetup."User ID");
                //                  IF ExtUserMaster.FIND('-') THEN
                //                   SenderIDInt:=ExtUserMaster."User ID"
                //                  ELSE
                //                    ERROR('SenderID not found in UMS_User_Mst');

                //                  ExtNotification."Sender ID":=SenderIDInt;

                //                  ExtUserMaster.RESET;
                //                  ExtUserMaster.SETRANGE("User Name","Receiver ID");
                //                  IF ExtUserMaster.FIND('-') THEN
                //                   ReceiverIDInt:=ExtUserMaster."User ID"
                //                  ELSE
                //                   ERROR('ReceiverID not found in UMS_User_Mst');

                //                  ExtNotification."Receiver ID":=ReceiverIDInt;
                //                  ExtNotification."Notification Type":='PROCESS';
                //                  ExtNotification.Message:='Notification for Legal File No.-' + "Document No.";
                //                  ExtNotification.Status:=0;
                //                  ExtNotification."Read Status":=0;
                //                  ExtNotification."Last Modified on":=CURRENTDATETIME;
                //                  ExtNotification."Last Modified by":=SenderIDInt;
                //                  ExtNotification.IsActive:=1;
                //                  ExtNotification.INSERT;
                //                //.Net Notificaion Table End
                //               CurrPage.CLOSE;
                //             END;


                //         end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Editable := TRUE;
        IF REC.Sent THEN
            Editable := FALSE;

        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnAfterGetRecord()
    begin
        Editable := TRUE;
        IF REC.Sent THEN
            Editable := FALSE;

        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    trigger OnOpenPage()
    begin
        Editable := TRUE;
        IF REC.Sent THEN
            Editable := FALSE;

        IF REC.Attachment <> '' THEN
            AttachedFile := 'View'
        ELSE
            AttachedFile := '';
    end;

    var
        ServerFileName: Text;
        FileExtension: Text;
        ClientFileName: Text;
        FileManagement: Codeunit "File Management";
        InvSetup: Record "Inventory Setup";
        DialogTitle: Text;
        // ServerFileHelper: DotNet File;   //DSC
        OldFileName: Text;
        AttachedFile: Text;
        Text001: Label 'View';
        Editable: Boolean;
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        // TempUID: Record 50067;
        ExtNotification: Record 50085;
        ExtUserMaster: Record 50084;
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        UserTab: Record "User BOC";
}

