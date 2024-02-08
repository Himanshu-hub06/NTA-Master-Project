report 50131 "Send Order To Section"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(WCHRD; 50203)
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                NextLineNo := 0;
                UserSetup.GET(USERID);
                IF ReceiverID = '' THEN
                    ERROR('Receiver ID not found');

                UserSetup2.GET(ReceiverID);

                FileMovementEntry1.RESET;
                FileMovementEntry1.SETRANGE("Document Type", FileMovementEntry1."Document Type"::Legal);
                FileMovementEntry1.SETRANGE(FileMovementEntry1."Document No.", WCHRD."File No.");
                FileMovementEntry1.SETRANGE(FileMovementEntry1.Status, FileMovementEntry1.Status::Open);
                FileMovementEntry1.SETRANGE(FileMovementEntry1."Receiver ID", USERID);
                IF FileMovementEntry1.FINDFIRST THEN BEGIN
                    FileMovementEntry1.Status := FileMovementEntry1.Status::Forwarded;
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
                FileMovementEntry."Receiver ID" := UserSetup2."User ID";
                FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup2."Examination Code");
                FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup2."Location Code");
                IF UserSetup2.Section <> '' THEN
                    FileMovementEntry.VALIDATE("Receiver Section", UserSetup2.Section)
                ELSE
                    FileMovementEntry.VALIDATE("Receiver Section", UserSec);
                FileMovementEntry."Record ID" := WCHRD.RECORDID;
                FileMovementEntry.Status := FileMovementEntry.Status::Open;
                FileMovementEntry."Sent For Compliance" := TRUE;
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
                ExtNotification.Message := 'Legal request pending for Compliance order.';
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
                        FileMovementEntry."Current User" := UserSetup2."User ID";
                        FileMovementEntry.MODIFY;
                    UNTIL FileMovementEntry.NEXT = 0;
                END;
                WritCaseHdr.RESET;
                WritCaseHdr.SETRANGE("File No.", "File No.");
                IF WritCaseHdr.FIND('-') THEN BEGIN
                    WritCaseHdr."Previous User" := USERID;
                    WritCaseHdr."User Assigned" := UserSetup2."User ID";
                    WritCaseHdr."Origin Date" := CURRENTDATETIME;
                    WritCaseHdr."At Concern Section" := TRUE;
                    WritCaseHdr."Sent By At Concern Section" := USERID;
                    WritCaseHdr."Sent Date To Concern Sec" := TODAY;
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
                    field(Section; section1)
                    {
                        Caption = 'Section';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                        Visible = false;

                        trigger OnValidate()
                        begin
                            //FillSelection(1,section1);
                        end;
                    }
                    field(User1; ReceiverID)
                    {
                        Caption = 'User';

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            //UserTab.SETRANGE(UserTab."Employee Left Status",'N');   //DSC
                            UserTab.SETFILTER("User Name", '<>%1', USERID);
                            IF PAGE.RUNMODAL(50381, UserTab) = ACTION::LookupOK THEN BEGIN
                                ReceiverID := UserTab."User Name";
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
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        FileMovementEntry: Record "File Movement Entry";
        NextLineNo: Integer;
        section1: Code[20];
        section2: Code[20];
        section3: Code[20];
        section4: Code[20];
        ReceiverID: Code[50];
        SectionErrr: Label 'You cannot send your own section';
        ReceiverSection: Code[20];
        SectionArray: array[4] of Code[20];
        i: Integer;
        Text0001: Label 'Section officer not define for %1 section.';
        Text0002: Label 'Already sent to %1 section.';
        Text0003: Label 'Sent successfully.';
        LegalCommentLine: Record 50213;
        WritCaseHdr: Record "Writ/Case Header";
        FileNo: Code[20];
        ExtNotification: Record 50217;
        ExtUserMaster: Record 50216;
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        UserDesignation: Text;
        ApprovalUserGroupMem: Record 50082;
        FileMovementEntry1: Record "File Movement Entry";
        UserSec: Code[20];
        SupportingDoc: Record "Supporting Document";
        UserTab: Record "User BOC";

    local procedure AlreadySelected(SectionCode: Code[20]): Boolean
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

    procedure SetSection(SectionCode: Code[10])
    begin
        UserSec := SectionCode;
    end;
}

