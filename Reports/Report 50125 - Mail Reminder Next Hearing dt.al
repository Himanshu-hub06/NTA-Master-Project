report 50125 "Mail Reminder Next Hearing dt"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(WCHDR; 50203)
        {

            trigger OnAfterGetRecord()
            begin
                NextHearDate := 0D;
                RemindDate := 0D;
                WCHDR.CALCFIELDS(WCHDR."Next Hearing Date");
                IF WCHDR."Next Hearing Date" <> 0D THEN
                    NextHearDate := WCHDR."Next Hearing Date"
                ELSE
                    NextHearDate := WCHDR."First Hearing Date";

                IF NextHearDate <> 0D THEN
                    RemindDate := CALCDATE('-3D', NextHearDate);

                //DSC COMMENT

                // IF RemindDate = TODAY THEN BEGIN
                //     SMTPMailSetup.GET;
                //     UserSetup.GET('LEGALO-S');
                //     Subject := 'Reminder :: Next hearing date of case no. - ' + WCHDR."File No.";
                //     Body := 'Dear Sir,';
                //     SMTPMail.CreateMessage('Reminder', SMTPMailSetup."User ID", UserSetup."E-Mail", Subject, Body, TRUE);
                //     SMTPMail.AppendBody('<BR><BR>');
                //     SMTPMail.AppendBody('Please note that next hearing date of case no. - ' + WCHDR."File No." + ' is ' + FORMAT(NextHearDate));
                //     SMTPMail.AppendBody('<BR><BR><BR>');
                //     SMTPMail.AppendBody('Regards');
                //     SMTPMail.AppendBody('<BR><BR>');
                //     SMTPMail.AppendBody(SenderName);
                //     SMTPMail.AppendBody('<BR>');
                //     SMTPMail.AppendBody('Bihar School Examination Board');
                //     SMTPMail.SendBSEB('LEGAL');
                //     ;
                // END;
            end;

            trigger OnPreDataItem()
            begin
                WCHDR.SETCURRENTKEY("File No.");
                WCHDR.SETFILTER(WCHDR.Status, '<>%1', WCHDR.Status::Disposed);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NextHearDate: Date;
        RemindDate: Date;
        RecepientID: Text;
        SenderName: Text;
        //SMTPMail: Codeunit "400";  //DSC
        //SMTPMailSetup: Record "409";//DSC
        // TempBlob: Record "99008535";   //DSC
        FileMgt: Codeunit "File Management";
        Subject: Text[150];
        Body: Text[200];
        UserSetup: Record "User Setup";
}

