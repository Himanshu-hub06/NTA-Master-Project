#pragma implicitwith disable
page 50197 "Posted Indent Header"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = 50089;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Send For Approval" = FILTER(true),
                            Approved = FILTER(true));
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        //CurrPage.UPDATE;
                    end;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        FileDir.Get();
                        FilePath := FileDir."Indent Read";
                        if Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec."Attachment";
                            ServerFileName := FilePath + Rec."Attachment";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
            }
#pragma warning disable AL0269
            part(IndentLine; "Posted Indent Line")
#pragma warning restore AL0269
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Function ")
            {
                action("Indent Slip")
                {
                    ApplicationArea = All;
#pragma warning disable AL0482
                    Image = slip;
#pragma warning restore AL0482
                    Promoted = true;

                    trigger OnAction()
                    begin
                        /*
                        indent.SETRANGE("NP Code","No.");
                        IF indent.FIND('-') THEN BEGIN
                          REPORT.RUNMODAL(50010,TRUE,TRUE,indent);
                        END;
                        */

                    end;
                }
                action("Closed Indent")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Indent';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = true;

                    trigger OnAction()
                    begin
                        indent.RESET;
                        indent.SETRANGE(indent."No.", Rec."No.");
                        IF indent.FIND('-') THEN
                            IF indent.Status = indent.Status::Rejected THEN BEGIN
                                MESSAGE(Text50002, Rec."No.");
                            END ELSE
                                IF CONFIRM(Text50001, TRUE, Rec."No.") THEN BEGIN
                                    indent.RESET;
                                    // RequisitionHeader.SETRANGE("Document Type",RequisitionHeader."Document Type"::Requisition);
                                    indent.SETRANGE("No.", Rec."No.");
                                    IF indent.FIND('-') THEN
                                        indent.Status := indent.Status::Rejected;
                                    indent.Posted := TRUE;
                                    indent.MODIFY;
                                END;
                    end;
                }
            }
        }
    }
    var
        indent: Record 50089;
        Text50001: Label 'Do you want to Post Indent %1?';
        Text50002: Label 'Indent No. %1 already closed.';
        Text50003: Label 'Indent %1 posted successfully.';
        Text50004: Label 'There is nothing to post?';
        FileDir: Record 50083;
        OldFileName: Text;
        ServerFileName: Text;
        FilePath: Text[150];
}

#pragma implicitwith restore

