report 50127 "Send To Section-SOF App"
{
    Caption = 'Send To Section';
    ProcessingOnly = true;

    dataset
    {
        dataitem(WCHRD; "Writ/Case Header")
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                // IF WCHRD.APP <> '' THEN
                //     UserSetup2.GET(AppID)
                // ELSE
                //     ERROR('Approver ID not found');

                // RecID := "Writ/Case Header".RECORDID;
                // /*

                UserSetup.GET(USERID);
                FileMovementEntry1.RESET;
                FileMovementEntry1.SETRANGE("Document Type", FileMovementEntry1."Document Type"::Legal);
                FileMovementEntry1.SETRANGE(FileMovementEntry1."Document No.", WCHRD."File No.");
                FileMovementEntry1.SETRANGE(FileMovementEntry1.Status, FileMovementEntry1.Status::Open);
                FileMovementEntry1.SETRANGE(FileMovementEntry1."Receiver ID", USERID);
                IF FileMovementEntry1.FINDFIRST THEN BEGIN
                    FileMovementEntry1.Status := FileMovementEntry1.Status::Forwarded;
                    FileMovementEntry1."SOF Approval Status" := FileMovementEntry1."SOF Approval Status"::" ";
                    FileMovementEntry1."Last Modified by" := USERID;
                    FileMovementEntry1."Last Modified Date" := TODAY;
                    FileMovementEntry1.MODIFY;
                END;

                FileMovementEntry.RESET;
                FileMovementEntry.SETRANGE(FileMovementEntry."Document No.", WCHRD."File No.");
                IF FileMovementEntry.FIND('+') THEN
                    NextLineNo := FileMovementEntry."Line No." + 10000
                ELSE
                    NextLineNo := 10000;

                FileMovementEntry.INIT;
                FileMovementEntry."Document Type" := FileMovementEntry."Document Type"::Legal;
                FileMovementEntry."Document No." := "File No.";
                FileMovementEntry."Line No." := NextLineNo;
                FileMovementEntry."Sender ID" := UserSetup."User ID";
                FileMovementEntry.VALIDATE("Sender Examination Code", UserSetup."Examination Code");
                FileMovementEntry.VALIDATE("Sender Location Code", UserSetup."Location Code");
                FileMovementEntry.VALIDATE("Sender Section", UserSetup.Section);
                FileMovementEntry."Sending Date" := TODAY;
                FileMovementEntry."Receiver ID" := AppID;
                FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup2."Examination Code");
                FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup2."Location Code");
                IF UserSetup2.Section <> '' THEN
                    FileMovementEntry.VALIDATE("Receiver Section", UserSetup2.Section)
                ELSE
                    FileMovementEntry.VALIDATE("Receiver Section", UserSec);
                FileMovementEntry."Record ID" := WCHRD.RECORDID;
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
                        FileMovementEntry."Current User" := AppID;
                        FileMovementEntry.MODIFY;
                    UNTIL FileMovementEntry.NEXT = 0;
                END;

                WritCaseHdr1.RESET;
                WritCaseHdr1.SETCURRENTKEY("File No.");
                WritCaseHdr1.SETRANGE(WritCaseHdr1."File No.", "File No.");
                IF WritCaseHdr1.FINDFIRST THEN BEGIN
                    WritCaseHdr1."Previous User" := USERID;
                    WritCaseHdr1."User Assigned" := AppID;
                    WritCaseHdr1."Origin Date" := CURRENTDATETIME;
                    WritCaseHdr1."At Concern Section" := TRUE;
                    WritCaseHdr1."Sent By At Concern Section" := USERID;
                    WritCaseHdr1."Sent Date To Concern Sec" := TODAY;
                    WritCaseHdr1."SOF Status" := WritCaseHdr1."SOF Status"::"Pending for Approval";
                    WritCaseHdr1.MODIFY;
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
                    field(Section; section1)
                    {
                        Caption = 'Section';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                        Visible = false;

                        trigger OnValidate()
                        begin
                            //FillSelection(1,section1);
                            /*
                            ApprovalUserGroupMem.RESET;
                            ApprovalUserGroupMem.SETRANGE("Approval User Group Code",'LEGAL');
                            ApprovalUserGroupMem.SETRANGE(Section,section1);
                            ApprovalUserGroupMem.SETRANGE("Approval Permission",TRUE);
                            IF ApprovalUserGroupMem.FIND('-') THEN BEGIN
                              AppID:=ApprovalUserGroupMem."User Name";
                              ApprovalUserGroupMem.CALCFIELDS("User Description");
                              UserDesignation:=ApprovalUserGroupMem."User Description";
                            END;
                            */

                        end;
                    }
                    field(User1; AppID)
                    {
                        Caption = 'User';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            /*
                            ApprovalUserGroupMem.RESET;
                            ApprovalUserGroupMem.FILTERGROUP(2);
                            ApprovalUserGroupMem.SETRANGE(ApprovalUserGroupMem."Approval User Group Code",'Legal');
                            ApprovalUserGroupMem.SETRANGE(ApprovalUserGroupMem.Section,UserSec);
                            ApprovalUserGroupMem.SETFILTER(ApprovalUserGroupMem."User Name",'<>%1',USERID);
                            ApprovalUserGroupMem.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(50422,ApprovalUserGroupMem) = ACTION::LookupOK THEN
                            BEGIN
                               AppID := ApprovalUserGroupMem."User Name";
                               UserDesignation := ApprovalUserGroupMem."User Description";
                            END;
                            */

                            //UserTab.SETRANGE(UserTab."Employee Left Status", 'N');
                            UserTab.SETFILTER("User Name", '<>%1', USERID);
                            IF PAGE.RUNMODAL(50381, UserTab) = ACTION::LookupOK THEN BEGIN
                                AppID := UserTab."User Name";
                                UserDesignation := UserTab."Designation Name";
                            END;

                        end;
                    }
                    field(Designation; UserDesignation)
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
        WritCaseHdr: Record "Writ/Case Header";
        SeqNo: Integer;
        RecID: RecordID;
        UserSetup: Record "User Setup";
        PrevUser: Code[50];
        SectionArray: array[4] of Code[20];
        section1: Code[20];
        AppID: Code[50];
        UserSetup2: Record "User Setup";
        FileMovementEntry: Record "File Movement Entry";
        FileNo: Code[20];
        NextLineNo: Integer;
        ExtNotification: Record "External CSA Notification";
        ExtUserMaster: Record "External UMS User Master";
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        UserDesignation: Text;
        ApprovalUserGroupMem: Record "Approval User Group Member";
        FileMovementEntry1: Record "File Movement Entry";
        UserSec: Code[20];
        SupportingDoc: Record "Supporting Document";
        UserTab: Record "User BOC";
        WritCaseHdr1: Record 50203;

    local procedure AlreadySelected(SectionCode: Code[20]): Boolean
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(SectionArray) DO BEGIN
            IF SectionCode = SectionArray[i] THEN
                EXIT(TRUE);
        END;
    end;

    local procedure FillSelection(Position: Integer; SecCode: Code[20])
    var
        Text001: Label 'Section already selected.';
    begin
        IF SecCode <> '' THEN BEGIN
            IF NOT AlreadySelected(SecCode) THEN
                SectionArray[Position] := SecCode
            ELSE
                ERROR(Text001);
        END ELSE
            SectionArray[Position] := '';
    end;

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

