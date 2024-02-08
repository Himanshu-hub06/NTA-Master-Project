report 50138 "Send To Extr Advocate Manually"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 50203)
        {
            DataItemTableView = SORTING("File No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                // IF DataItem1000000000.FileInProcess THEN
                //     ERROR(Text0006);

                IF SendDate = 0D THEN
                    ERROR('Select Sending date');
                AdvAssignEntry.RESET;
                AdvAssignEntry.SETRANGE("File No.", "File No.");
                AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::"Case Assign");
                AdvAssignEntry.SETRANGE("Advocate Type", AdvAssignEntry."Advocate Type"::External);
                AdvAssignEntry.SETRANGE(Active, TRUE);
                IF NOT AdvAssignEntry.FIND('-') THEN
                    ERROR('External advocate not assign');

                AdvAssignEntry2.RESET;
                AdvAssignEntry2.SETRANGE("File No.", "File No.");
                AdvAssignEntry2.SETRANGE("Entry Type", AdvAssignEntry2."Entry Type"::"Sent To External");
                AdvAssignEntry2.SETRANGE("Advocate Type", AdvAssignEntry2."Advocate Type"::External);
                AdvAssignEntry2.SETRANGE(Active, TRUE);
                IF AdvAssignEntry2.FINDFIRST THEN
                    ERROR('SOF already sent');

                Status := Status::Ongoing;
                "SOF Status" := "SOF Status"::Sent;
                "SOF Sent Date" := SendDate;
                //"Writ/Case Header"."SOF Created"=TRUE;
                MODIFY(TRUE);
                REPEAT
                    AdvAssignEntry1.INIT;
                    AdvAssignEntry1."File No." := "File No.";
                    AdvAssignEntry1."Entry Type" := AdvAssignEntry1."Entry Type"::"Sent To External";
                    AdvAssignEntry1."Advocate Type" := AdvAssignEntry."Advocate Type";
                    AdvAssignEntry1.VALIDATE("Advocate Code", AdvAssignEntry."Advocate Code");
                    AdvAssignEntry1.VALIDATE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::" ");
                    AdvAssignEntry1."Assigned Date" := AdvAssignEntry."Assigned Date";
                    AdvAssignEntry1.VALIDATE("SOF Sent", TRUE);
                    AdvAssignEntry1.VALIDATE("SOF Sending Date", SendDate);
                    AdvAssignEntry1.VALIDATE("Sent To External Adv.", TRUE);
                    AdvAssignEntry1.VALIDATE("Sent To External Date", SendDate);
                    AdvAssignEntry1.VALIDATE(Active, TRUE);
                    AdvAssignEntry1."Manual Entry" := TRUE;
                    AdvAssignEntry1.INSERT(TRUE);
                UNTIL AdvAssignEntry.NEXT = 0;
                //MESSAGE('Sent Successfully');
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
            end;

            trigger OnPreDataItem()
            begin
                FileNo := DataItem1000000000.GETFILTER(DataItem1000000000."File No.");
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
        SourceTable = 50213;

        layout
        {
            area(content)
            {
                group(Choose)
                {
                    field("SOF Sent Date"; SendDate)
                    {
                        Caption = 'SOF Sent Date';
                    }
                    field("File No."; FileNo)
                    {
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
        TempUID: Record 50213;
        Text0004: Label 'Document already send to %1.';
        LineNo: Integer;
        Text0005: Label 'Sent successfully.';
        LegalCommentLine: Record "Legal Comment Line";
        FileNo: Code[20];
        WritCaseHdr: Record 50203;
        ExtNotification: Record 50217;
        ExtUserMaster: Record 50216;
        SenderIDInt: Integer;
        ReceiverIDInt: Integer;
        SendDate: Date;
        Text0006: Label 'File process not completed.';
        AdvAssignEntry: Record "Advocate Assigning Entry";
        AdvAssignEntry1: Record "Advocate Assigning Entry";
        AdvAssignEntry2: Record "Advocate Assigning Entry";

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

    procedure SetFileNo(WritFileNo: Code[20])
    begin
        FileNo := WritFileNo;
    end;
}

