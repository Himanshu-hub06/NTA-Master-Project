report 50128 "Send To User-SOF App"
{
    Caption = 'Send To User';
    ProcessingOnly = true;

    dataset
    {
        dataitem(WCHRD; 50203)
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                IF User1 = '' THEN
                    ERROR('User not selected');
                UserSetup2.GET(User1);
                ApproverID := User1;
                RecID := WCHRD.RECORDID;
                UserSetup.GET(USERID);
                FileMovementEntry1.RESET;
                FileMovementEntry1.SETRANGE("Document Type", FileMovementEntry1."Document Type"::Legal);
                FileMovementEntry1.SETRANGE("Document No.", WCHRD."File No.");
                FileMovementEntry1.SETRANGE(Status, FileMovementEntry1.Status::Open);
                FileMovementEntry1.SETRANGE("Receiver ID", USERID);
                IF FileMovementEntry1.FINDFIRST THEN BEGIN
                    FileMovementEntry1.Status := FileMovementEntry1.Status::Forwarded;
                    IF FileMovementEntry1."SOF Approval Status" IN [FileMovementEntry1."SOF Approval Status"::" "] THEN
                        FileMovementEntry1."SOF Approval Status" := FileMovementEntry1."SOF Approval Status"::" ";
                    FileMovementEntry1."Last Modified by" := USERID;
                    FileMovementEntry1."Last Modified Date" := TODAY;
                    FileMovementEntry1.MODIFY;
                END;

                FileMovementEntry.RESET;
                FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                FileMovementEntry.SETRANGE("Document No.", "File No.");
                IF FileMovementEntry.FIND('+') THEN
                    LineNo := FileMovementEntry."Line No." + 10000
                ELSE
                    LineNo := 10000;
                FileMovementEntry.INIT;
                FileMovementEntry."Document Type" := FileMovementEntry."Document Type"::Legal;
                FileMovementEntry."Line No." := LineNo;
                FileMovementEntry."Document No." := "File No.";
                FileMovementEntry."Sender ID" := UserSetup."User ID";
                FileMovementEntry.VALIDATE("Sender Examination Code", UserSetup."Examination Code");
                FileMovementEntry.VALIDATE("Sender Location Code", UserSetup."Location Code");
                FileMovementEntry.VALIDATE("Sender Section", UserSec);
                FileMovementEntry."Sending Date" := TODAY;
                FileMovementEntry."Receiver ID" := UserSetup2."User ID";
                FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup2."Examination Code");
                FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup2."Location Code");
                IF UserSetup2.Section <> '' THEN
                    FileMovementEntry.VALIDATE("Receiver Section", UserSetup2.Section)
                ELSE
                    FileMovementEntry.VALIDATE("Receiver Section", UserSec);
                FileMovementEntry."Record ID" := RECORDID;
                FileMovementEntry.Status := FileMovementEntry.Status::Open;
                FileMovementEntry."SOF Approval Status" := FileMovementEntry."SOF Approval Status"::" ";
                FileMovementEntry."Sent For SOF Approval" := TRUE;
                FileMovementEntry.INSERT(TRUE);
                //.Net Notificaion Table Start
                ExtNotification.INIT;
                ExtNotification."Module ID" := 68;
                ExtNotification."View ID" := 3831;
                ExtNotification."Action ID" := 14;

                ExtUserMaster.RESET;
                ExtUserMaster.SETRANGE("User Name", UserSetup."User ID");
                IF ExtUserMaster.FIND('-') THEN
                    SenderIDInt := ExtUserMaster."User ID"
                ELSE
                    ERROR('SenderID not found in UMS_User_Mst');

                ExtNotification."Sender ID" := SenderIDInt;

                ExtUserMaster.RESET;
                ExtUserMaster.SETRANGE("User Name", UserSetup2."User ID");
                IF ExtUserMaster.FIND('-') THEN
                    ReceiverIDInt := ExtUserMaster."User ID"
                ELSE
                    ERROR('ReceiverID not found in UMS_User_Mst');

                ExtNotification."Receiver ID" := ReceiverIDInt;
                ExtNotification."Notification Type" := 'PROCESS';
                ExtNotification.Message := 'Legal request pending for SOF approval';
                ExtNotification.Status := 0;
                ExtNotification."Read Status" := 0;
                ExtNotification."Last Modified on" := CURRENTDATETIME;
                ExtNotification."Last Modified by" := SenderIDInt;
                ExtNotification.IsActive := 1;
                ExtNotification.INSERT;
                //.Net Notificaion Table End
                FileMovementEntry.RESET;
                FileMovementEntry.SETRANGE("Document Type", FileMovementEntry."Document Type"::Legal);
                FileMovementEntry.SETRANGE(FileMovementEntry."Document No.", WCHRD."File No.");
                IF FileMovementEntry.FIND('-') THEN BEGIN
                    REPEAT
                        FileMovementEntry."Current User" := ApproverID;
                        FileMovementEntry.MODIFY;
                    UNTIL FileMovementEntry.NEXT = 0;
                END;
                WritCaseHdr.RESET;
                WritCaseHdr.SETRANGE("File No.", WCHRD."File No.");
                IF WritCaseHdr.FIND('-') THEN BEGIN
                    WritCaseHdr."Previous User" := USERID;
                    WritCaseHdr.Unread := TRUE;
                    WritCaseHdr."User Assigned" := ApproverID;
                    WritCaseHdr."Origin Date" := CURRENTDATETIME;
                    WritCaseHdr.MODIFY;
                END;

                LegalCommentLine.RESET;
                LegalCommentLine.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Record ID to Approve");
                LegalCommentLine.SETRANGE("Document No.", "File No.");
                LegalCommentLine.SETRANGE(Active, FALSE);
                IF LegalCommentLine.FIND('-') THEN BEGIN
                    REPEAT
                        LegalCommentLine.Active := TRUE;
                        LegalCommentLine.MODIFY;
                    UNTIL LegalCommentLine.NEXT = 0;
                END;

                SupportingDoc.RESET;
                SupportingDoc.SETCURRENTKEY("Document No.", "Line No.");
                SupportingDoc.SETRANGE("Document No.", "File No.");
                SupportingDoc.SETRANGE(Active, FALSE);
                IF SupportingDoc.FINDSET THEN BEGIN
                    REPEAT
                        SupportingDoc.Active := TRUE;
                        SupportingDoc.MODIFY;
                    UNTIL SupportingDoc.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                FileNo := WCHRD.GETFILTER(WCHRD."File No.");
                IF FileNo = '' THEN
                    ERROR('File no. not exist');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Choose)
                {
                    field(User1; User1)
                    {
                        Caption = 'User';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            /*
                            ApprovalUserGroup.RESET;
                            ApprovalUserGroup.FILTERGROUP(2);
                            ApprovalUserGroup.SETRANGE(ApprovalUserGroup."Approval User Group Code",'LEGAL');
                            ApprovalUserGroup.SETRANGE(ApprovalUserGroup.Section,UserSec);
                            ApprovalUserGroup.SETFILTER("User Name",'<>%1',USERID);
                            ApprovalUserGroup.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(50422,ApprovalUserGroup) = ACTION::LookupOK THEN
                            BEGIN
                               User1 := ApprovalUserGroup."User Name";
                               UserDescription := ApprovalUserGroup."User Description";
                            END;
                            */
                            //UserTab.SETRANGE(UserTab."Employee Left Status",'N');  //DSC
                            UserTab.SETFILTER("User Name", '<>%1', USERID);
                            IF PAGE.RUNMODAL(50381, UserTab) = ACTION::LookupOK THEN BEGIN
                                User1 := UserTab."User Name";
                                UserDescription := UserTab."Designation Name";
                            END;

                        end;
                    }
                    field(Designation; UserDescription)
                    {
                        Caption = 'Designation';
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        MESSAGE(Text0003);
    end;

    var
        SectionErrr: Label 'You cannot send your own section';
        Text0001: Label 'Section officer not define for %1 section.';
        Text0002: Label 'Already sent to %1 section.';
        Text0003: Label 'Sent successfully.';
        SOFApprovalEntry: Record "SOF Approval entry";
        SOFApprovalEntry2: Record "SOF Approval entry";
        SeqNo: Integer;
        RecID: RecordID;
        UserSetup: Record "User Setup";
        PrevUser: Code[50];
        SectionArray: array[4] of Code[20];
        User1: Code[50];
        ApproverID: Code[50];
        UserSetup2: Record "User Setup";
        TempUID: Record "Temporary User Setup";
        FileMovementEntry: Record 50215;
        FileNo: Code[20];
        WritCaseHdr: Record 50203;
        LegalCommentLine: Record 50213;
        LineNo: Integer;
        ExtNotification: Record 50217;
        ExtUserMaster: Record 50216;
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        ApprovalUserGroup: Record "Approval User Group Member";
        UserDescription: Text;
        UserSec: Code[20];
        FileMovementEntry1: Record "File Movement Entry";
        SupportingDoc: Record "Supporting Document";
        UserTab: Record "User BOC";

    local procedure DuplicateUser(DocNo: Code[20]; UserCode: Code[50]): Boolean
    var
        SOFApprovalEntry1: Record "SOF Approval entry";
    begin
        SOFApprovalEntry1.RESET;
        SOFApprovalEntry1.SETCURRENTKEY("Document No.", "Sequence No.");
        SOFApprovalEntry1.SETRANGE("Document No.", DocNo);
        SOFApprovalEntry1.SETRANGE("Approver ID", UserCode);
        SOFApprovalEntry1.SETFILTER(Status, '%1|%2', SOFApprovalEntry1.Status::Created, SOFApprovalEntry1.Status::Open);
        IF SOFApprovalEntry1.FIND('-') THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure SetSection(SectionCode: Code[10])
    begin
        UserSec := SectionCode;
    end;
}

