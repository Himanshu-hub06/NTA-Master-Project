page 50358 "SOF Status list"
{
    Caption = 'SOF Status';
    //DataCaptionExpression = "File No.";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    ApplicationArea = all;
    SourceTable = "Advocate Assigning Entry";
    SourceTableView = SORTING("File No.", "Line No.")
                      ORDER(Ascending);
    //WHERE("Entry Type" = CONST());

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; REC."File No.")
                {
                    Editable = false;
                }
                field("Advocate Code"; REC."Advocate Code")
                {
                }
                field("Advocate Name"; REC."Advocate Name")
                {
                }
                field("Advocate Type"; REC."Advocate Type")
                {
                }
                field("Internal Adv. Type"; REC."Internal Adv. Type")
                {
                }
                field("Assigned Date"; REC."Assigned Date")
                {
                }
                field("SOF Sent"; REC."SOF Sent")
                {
                }
                field("SOF Sending Date"; REC."SOF Sending Date")
                {
                    Caption = 'SOF Sent Date';
                }
                field("SOF Received"; REC."SOF Received")
                {
                }
                field("SOF Received Date"; REC."SOF Received Date")
                {
                }

                field("Entry Type"; Rec."Entry Type")
                {

                }
                field(Attachment; AttachFile)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        InvSetup.GET;
                        IF REC."SOF File Name" <> '' THEN
                            HYPERLINK(InvSetup."Writ Case Read Path" + REC."SOF File Name");
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Download SOF")
            {
                Caption = 'SOF Document';
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    AdvAssignEntry.RESET;
                    AdvAssignEntry.SETCURRENTKEY("File No.", "Line No.");
                    AdvAssignEntry.SETRANGE("File No.", REC."File No.");
                    AdvAssignEntry.SETRANGE("Line No.", REC."Line No.");
                    AdvAssignEntry.SETRANGE("Entry Type", AdvAssignEntry."Entry Type"::SOF);
                    AdvAssignEntry.SETRANGE("Internal Adv. Type", AdvAssignEntry."Internal Adv. Type"::Creator);
                    AdvAssignEntry.SETRANGE("SOF Received", TRUE);
                    IF AdvAssignEntry.FIND('-') THEN BEGIN
                        IF AdvAssignEntry."SOF File Name" <> '' THEN BEGIN
                            InvSetup.GET;
                            OldFileName := AdvAssignEntry."SOF File Name";
                            ServerFileName := InvSetup."Writ Case Write Path" + AdvAssignEntry."SOF File Name";
                            DOWNLOAD(ServerFileName, '', '', '', OldFileName);
                        END ELSE
                            ERROR('SOF document not found');
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF REC."SOF File Name" <> '' THEN
            AttachFile := 'Download'
        ELSE
            AttachFile := '';
    end;

    trigger OnAfterGetRecord()
    begin
        IF REC."SOF File Name" <> '' THEN
            AttachFile := 'Download'
        ELSE
            AttachFile := '';
    end;

    var
        WritCaseHdr: Record "Writ/Case Header";
        AdvAssignEntry: Record "Advocate Assigning Entry";
        InvSetup: Record "Inventory Setup";
        OldFileName: Text;
        ServerFileName: Text;
        AttachFile: Text;
}

