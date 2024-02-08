report 50133 "Send To User-Legal"
{
    ApplicationArea = all;
    ProcessingOnly = true;

    dataset
    {
        dataitem(WCHRD; "Writ/Case Header")
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                UserSetup.GET(USERID);
                ReceiverID := user1;
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
                FileMovementEntry.VALIDATE("Sender Section", UserSetup.Section);
                FileMovementEntry."Sending Date" := TODAY;
                UserSetup2.GET(ReceiverID);
                FileMovementEntry."Receiver ID" := UserSetup2."User ID";
                FileMovementEntry.VALIDATE("Receiver Examination Code", UserSetup2."Examination Code");
                FileMovementEntry.VALIDATE("Receiver Location Code", UserSetup2."Location Code");
                FileMovementEntry.VALIDATE("Receiver Section", UserSetup2.Section);
                FileMovementEntry."Record ID" := RECORDID;
                FileMovementEntry.Status := FileMovementEntry.Status::Open;
                FileMovementEntry."In Legal Section" := TRUE;
                FileMovementEntry.INSERT(TRUE);

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
                WritCaseHdr.SETRANGE("File No.", WCHRD."File No.");
                IF WritCaseHdr.FIND('-') THEN BEGIN
                    WritCaseHdr."Previous User" := USERID;
                    WritCaseHdr."User Assigned" := UserSetup2."User ID";
                    WritCaseHdr.Unread := TRUE;
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
        DeleteAllowed = false;
        InsertAllowed = false;
        ModifyAllowed = true;

        layout
        {
            area(content)
            {
                group(Choose)
                {
                    field(User1; user1)
                    {
                        Caption = 'User';

                        trigger OnDrillDown()
                        begin
                            ApprovalUserGroupMem.RESET;
                            ApprovalUserGroupMem.FILTERGROUP(2);
                            ApprovalUserGroupMem.SETRANGE(ApprovalUserGroupMem."Approval User Group Code", 'Legal');
                            IF LegalUserExamCode = 'EXESEC' THEN
                                ApprovalUserGroupMem.SETRANGE(ApprovalUserGroupMem.Section, 'S070')
                            ELSE
                                IF LegalUserExamCode = 'EXESSEC' THEN
                                    ApprovalUserGroupMem.SETRANGE(ApprovalUserGroupMem.Section, 'S069');
                            ApprovalUserGroupMem.SETFILTER(ApprovalUserGroupMem."User ID", '<>%1', USERID);
                            ApprovalUserGroupMem.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(50422, ApprovalUserGroupMem) = ACTION::LookupOK THEN BEGIN
                                user1 := ApprovalUserGroupMem."User Full Name";
                                UserDescription := ApprovalUserGroupMem."User Description";
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            //FillUser(1,user1);
                        end;
                    }
                    field(Designation; UserDescription)
                    {
                        Editable = false;
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


        end;
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
        EntryNo: Integer;
        section1: Code[20];
        section2: Code[20];
        section3: Code[20];
        section4: Code[20];
        user1: Code[50];
        user2: Code[50];
        ReceiverID: Code[50];
        SectionErrr: Label 'You cannot send your own section';
        ReceiverSection: Code[20];
        UserArray: array[4] of Code[20];
        i: Integer;
        Text0001: Label 'Section Officer not found for %1 section.';
        Text0002: Label 'Already sent to %1 user.';
        Text0003: Label 'Sent successfully.';
        UserSec: Code[10];
        // TempUID: Record 50067;
        Text0004: Label 'Document already send to %1.';
        LineNo: Integer;
        Text0005: Label 'Sent successfully.';
        LegalCommentLine: Record "Legal Comment Line";
        FileNo: Code[20];
        WritCaseHdr: Record "Writ/Case Header";
        FileMovementEntry1: Record "File Movement Entry";
        SupportingDoc: Record "Supporting Document";
        UserDescription: Text;
        ApprovalUserGroupMem: Record "Approval User Group Member";
        LegalUserExamCode: Code[10];

    local procedure AlreadySelected(UserCode: Code[50]): Boolean
    begin
        FOR i := 1 TO ARRAYLEN(UserArray) DO BEGIN
            IF UserCode = UserArray[i] THEN
                EXIT(TRUE);
        END;
    end;

    local procedure FillUser(Position: Integer; UserCode: Code[50])
    var
        Text001: Label 'User already selected.';
    begin
        IF UserCode <> '' THEN BEGIN
            IF NOT AlreadySelected(UserCode) THEN
                UserArray[Position] := UserCode
            ELSE
                ERROR(Text001);
        END ELSE
            UserArray[Position] := '';
    end;

    procedure SetSection(SectionCode: Code[10]; UserExamCode: Code[10])
    begin
        UserSec := SectionCode;
        LegalUserExamCode := UserExamCode;
    end;
}

