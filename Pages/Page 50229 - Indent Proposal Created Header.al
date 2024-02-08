page 50229 "Indent Proposal Created Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = 50089;
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER(Approved),
                            "Purchase Proposal Created" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Indented By"; Rec."Indented By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Estimated Cost Including GST"; Rec."Estimated Cost Including GST")
                {
                    ApplicationArea = All;
                    Caption = 'Total Estimated Cost Including GST';
                    Editable = false;
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Proposal Created Date"; Rec."Proposal Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            part(IndentLine; 50230)
            {
                ApplicationArea = All;
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
                action("Send for Department")
                {
                    ApplicationArea = All;
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want Send for department?', TRUE, Rec."No.") THEN BEGIN
                            //TESTFIELD("Remarks");
                            Rec.Reopen;
                        END;
                    end;
                }
                action("Fill Requisition Line")
                {
                    ApplicationArea = All;
                    Image = Indent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF Rec.Status = Rec.Status::"Pending for Approval" THEN
                            ERROR('Document Must be Open');
                        Rec.TESTFIELD("Requisition No.");
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");

                        //CurrPage.IndentLine.PAGE.GetPurchReqLines;
                    end;
                }
                action(Attachment1)
                {
                    Caption = 'Attachment';
                    ApplicationArea = All;
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    trigger OnAction()
                    begin
                        IF Rec.Attachment <> '' THEN
                            IF NOT CONFIRM('Indent document is already uploaded. Do you want to replace it?', FALSE, TRUE) THEN EXIT;
                        FileDir.Get();

                        FilePath := FileDir."Indent Write";
                        OldFileName := (FilePath + Rec.Attachment);
                        ServerFileName := FileManagement.UploadFile(DialogTitle, '');
                        ClientFileName := FileManagement.GetFileName(ServerFileName);
                        IF ClientFileName <> '' THEN BEGIN
                            Rec.Attachment := ClientFileName;
                            Rec.MODIFY(TRUE);
                        END;
                        ClientFileName := FilePath + Rec.Attachment;
                        FileManagement.CopyServerFile(ServerFileName, ClientFileName, TRUE);
                        IF OldFileName <> '' THEN
                            FileManagement.DeleteServerFile(OldFileName);
                        //MESSAGE('Upload successfully');




                    end;

                }
            }
            group(Posting)
            {
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'Create Purchase Proposal';
                    Image = Post;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Purchase Type");
                        Rec.TESTFIELD("Proposal Created Date");
                        /*
                        CALCFIELDS("Estimated Cost Including GST");
                        PurchaseCon.SETRANGE(PurchaseCon."Purchase Type","Purchase Type");
                        IF PurchaseCon.FINDFIRST THEN BEGIN
                           IF    "Estimated Cost Including GST" > PurchaseCon."From Amount" THEN
                             ERROR('You cannot select %1 Purchase Type',"Purchase Type");
                        END;
                        */
                        IF CONFIRM('Do you want Create Purchase Praposal?', TRUE, Rec."No.") THEN BEGIN

                            IndentLine.RESET;
                            IndentLine.SETRANGE(IndentLine."Document No.", Rec."No.");
                            IndentLine.SETRANGE(IndentLine."Select Item For Proposal", TRUE);
                            IF IndentLine.FINDFIRST THEN BEGIN
                                ItemJnlManag.FillPurchasePraposalFromIndent(Rec."No.");
                            END
                            ELSE
                                ERROR('Please select Indent line for Purchase Praposal Creation');
                        END;
                        CurrPage.CLOSE;

                    end;
                }
                action("Manual Close Indent")
                {
                    ApplicationArea = All;
                    Image = Close;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IndentLine.SETRANGE("Document No.", Rec."No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IF IndentLine."Purchase Order No." = '' THEN
                                    PurchaseOrder := IndentLine."Purchase Order No.";
                            UNTIL IndentLine.NEXT = 0;
                            IF PurchaseOrder <> '' THEN BEGIN
                                Rec.Posted := TRUE;
                                Rec."Manual Close" := TRUE;
                                Rec.MODIFY;
                            END ELSE
                                ERROR('This Indent is not selected in any Purchase Document');
                        END;
                    end;
                }
                action("Indent Print")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IndentHead.SETRANGE("No.", Rec."No.");
                        IF IndentHead.FINDFIRST THEN
                            REPORT.RUN(50076, TRUE, TRUE, IndentHead);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Approval;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF CONFIRM('Do you want Approve the Indent?', TRUE, "No.") THEN
                        Rec.ApprovedReq_gFnc;
                    end;
                }
                action("Send Email")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.SendForApproval();
                        /*IndentLine.SETRANGE("Document No.","No.");
                        IF IndentLine.FINDFIRST THEN BEGIN
                          REPEAT
                          ItemNo := IndentLine."No.";
                          ItemDescription := IndentLine.Description + ' ' + IndentLine."Description 2" +' ' + IndentLine."Description 3";
                          ItemQty := IndentLine.Quantity;
                          UNTIL IndentLine.NEXT =0;
                        END;
                        
                        
                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID",USERID);
                        IF UserSetup.FIND('-') THEN BEGIN
                          SenderAddress:=UserSetup."Sender's Email ID";
                          Recipient :=UserSetup."Receiver's Email ID" ;
                          SenderName := "User ID";
                        END;
                        Subject:='Pending Indent for Approval';
                        Body:='Indent Document No. '+"No."+' is Pending for your approval .';
                        SMTPMail.CreateMessage(SenderName,SenderAddress,Recipient,Subject,'',TRUE);
                        SMTPMail.AppendBody('Dear Sir / Madam,');
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody(Body);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Branch-');
                        SMTPMail.AppendBody("Shortcut Dimension 1 Code");
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Department-');
                        SMTPMail.AppendBody("Department");
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item No-');
                        SMTPMail.AppendBody(ItemNo);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item Description-');
                        SMTPMail.AppendBody(ItemDescription);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Item Qty-');
                        SMTPMail.AppendBody(FORMAT(ItemQty));
                        SMTPMail.AppendBody('<br><Br>');
                        SMTPMail.AppendBody('Regards,');
                        SMTPMail.AppendBody('<br>');
                        SMTPMail.AppendBody(SenderName);
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('This is a system generated mail. Please do not reply to this email ID.');
                        IF CCName <> '' THEN
                          SMTPMail.AddCC :=CCName;
                          SMTPMail.Send;
                          "Email Sent" := TRUE;
                          MODIFY;
                          MESSAGE('E-Mail Sent Successfully');
                         */

                    end;
                }
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.UPDATE;
    end;

    var
        IndentLine: Record 50090;
        PurchaseOrder: Code[20];
        PurchaseLine: Integer;
        IndentHead: Record 50089;
        UserSetup_gRec: Record 91;
        SenderAddress: Text[100];
        Recipient: Text[200];
        SenderName: Text[100];
        Subject: Text[100];
        Body: Text[100];
        // SMTPMail: Codeunit 400;
        UserSetup: Record 91;
        CCName: Text;
        ItemDescription: Text[150];
        ItemNo: Code[20];
        ItemQty: Decimal;
        ItemJnlManag: Codeunit "ItemJnlManagement Ext";
        FileDir: Record 50083;
        OldFileName: Text;
        ServerFileName: Text;
        FilePath: Text[150];
        ClientFileName: Text;
        FileManagement: Codeunit 419;
        DialogTitle: Text;
    //  ItemJnlManag1: Codeunit 240;
}

