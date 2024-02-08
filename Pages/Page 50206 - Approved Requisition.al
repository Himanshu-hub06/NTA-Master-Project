#pragma implicitwith disable
/// <summary>
/// Page Approved Requisition (ID 50206).
/// </summary>
page 50206 "Approved Requisition"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = 50087;
    SourceTableView = WHERE(Posted = CONST(true),
                            Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Requisition from Other Section"; Rec."Requisition from Other Section")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                }
                field("Requisition to Section"; Rec."Requisition to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section';
                }
                field("Req. To Department Name"; Rec."Req. To Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Req. To Section Name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
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

                        FilePath := FileDir."Requisition Read";

                        if Rec.Attachment <> '' THEN BEGIN
                            OldFileName := Rec."Attachment";
                            ServerFileName := FilePath + Rec."Attachment";
                            HYPERLINK(ServerFileName);
                        END;
                    end;
                }
            }
            part(RequisitionHeaderSubform; 50207)
            {
                ApplicationArea = All;
                SubPageLink = "Requisition No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Requisition &Slip")
            {
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ReqHeadRec.RESET;
                    ReqHeadRec.SETRANGE("No.", Rec."No.");
                    IF ReqHeadRec.FIND('-') THEN BEGIN
                        REPORT.RUNMODAL(50019, TRUE, TRUE, ReqHeadRec);
                    END;
                end;
            }
            action("&List")
            {
                Image = List;
                Promoted = true;
                RunObject = Page Issue;
                ApplicationArea = All;
                RunPageView = SORTING("No.")
                  ORDER(Ascending);
            }
            action("Re&open")
            {
                Image = ReOpen;
                Promoted = true;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin

                    IF Rec.Status = Rec.Status::"Pending for Approval" THEN BEGIN
                        Rec.Status := Rec.Status::Open;
                        Rec."Approving UID" := '';
                        Rec."Approving Date" := 0D;
                        Rec."Approving Time" := 0T;
                        Rec."Sending UID" := '';
                        Rec."Sending Date" := 0D;
                        Rec."Sending Time" := 0T;
                        Rec.MODIFY;
                    END;
                    //END ELSE
                    //  ERROR('Already Open');

                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                        REPEAT
                            RequisitionLine.Status := RequisitionLine.Status::Open;
                            RequisitionLine.MODIFY;
                        UNTIL RequisitionLine.NEXT = 0;
                    END;

                    MESSAGE('Document No. %1 has successfully Reopen', Rec."No.");
                end;
            }
            action("Calculate Requisition Slip for Day Production")
            {
                Image = CalculatePlan;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    /*IF "Requisition Type" = "Requisition Type"::" " THEN BEGIN
                    //  MasterTable.DELETEALL;
                    
                      NoofRec := 0;
                      LineNo := 0;
                    
                      Window.OPEN('#1################# @2@@@@@@@@@@@@@@@@@@@@@@\\');
                    
                      IF "Location Code" = '1101' THEN BEGIN
                        ProdOrderComp.RESET;
                        ProdOrderComp.SETCURRENTKEY(Status,"Location Code");
                        ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status::Released);
                        ProdOrderComp.SETRANGE("Requistion Made",FALSE);
                        IF UserSetup.GET(USERID) THEN BEGIN
                          IF UserSetup."Location Code" <> '' THEN
                            ProdOrderComp.SETRANGE("Location Code",UserSetup."Location Code");
                        END;
                        ProdOrderComp.SETRANGE("Due Date",Date);
                        IF ProdOrderComp.FINDSET THEN
                          REPEAT
                            IF Item.GET(ProdOrderComp."Item No.") THEN BEGIN
                              RequisitionLine2.RESET;
                              RequisitionLine2.SETRANGE("Requisition No.","No.");
                              RequisitionLine2.SETRANGE(Status,ProdOrderComp.Status);
                              RequisitionLine2.SETRANGE("No.",ProdOrderComp."Item No.");
                              RequisitionLine2.SETRANGE("Location Code",LocCode);
                              RequisitionLine2.SETRANGE("Liquid-Powder",ProdOrderComp."Liquid-Powder");
                              IF RequisitionLine2.FIND('+') THEN BEGIN
                                RequisitionLine2.Quantity += ProdOrderComp."Original Expected Qty";
                                RequisitionLine2."Remaining Qty" := RequisitionLine2.Quantity;
                                RequisitionLine2."Original Quantity" := RequisitionLine2.Quantity;
                                RequisitionLine2.MODIFY;
                    
                                MasterTable.INIT;
                                MasterTable."Document Type" := MasterTable."Document Type"::"1";
                                MasterTable."Sub Document Type" := MasterTable."Sub Document Type"::"1";
                                MasterTable.No := ProdOrderComp."Prod. Order No.";
                                MasterTable."Document Line No" := ProdOrderComp."Prod. Order Line No.";
                                MasterTable."Line No" := ProdOrderComp."Line No.";
                                MasterTable."Item No" := ProdOrderComp."Item No.";
                                MasterTable."Requisition No." := "No.";
                                MasterTable.Status := MasterTable.Status::"3";
                                MasterTable.INSERT;
                              END ELSE BEGIN
                                NoofRec += 1;
                                LineNo += 10000;
                                RequisitionLine.INIT;
                                RequisitionLine."Requisition No." := "No.";
                                RequisitionLine.Status := ProdOrderComp.Status;
                                RequisitionLine."Line No." := LineNo;
                                RequisitionLine."No." := ProdOrderComp."Item No.";
                                RequisitionLine.Description := ProdOrderComp.Description;
                                RequisitionLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                RequisitionLine.Quantity := ProdOrderComp."Original Expected Qty";
                                RequisitionLine."Original Quantity" := ProdOrderComp."Original Expected Qty";
                                RequisitionLine."Remaining Qty" := ProdOrderComp."Original Expected Qty";
                                RequisitionLine."Location Code" := ProdOrderComp."Location Code";
                                RequisitionLine.VALIDATE("Shortcut Dimension 1 Code",ProdOrderComp."Shortcut Dimension 1 Code");
                                RequisitionLine.VALIDATE("Shortcut Dimension 2 Code",ProdOrderComp."Shortcut Dimension 2 Code");
                                RequisitionLine."Bin Code" := ProdOrderComp."Bin Code";
                                RequisitionLine."Liquid-Powder" := ProdOrderComp."Liquid-Powder";
                                RequisitionLine.INSERT;
                    
                                MasterTable.INIT;
                                MasterTable."Document Type" := MasterTable."Document Type"::"1";
                                MasterTable."Sub Document Type" := MasterTable."Sub Document Type"::"1";
                                MasterTable.No := ProdOrderComp."Prod. Order No.";
                                MasterTable."Document Line No" := ProdOrderComp."Prod. Order Line No.";
                                MasterTable."Line No" := ProdOrderComp."Line No.";
                                MasterTable."Item No" := ProdOrderComp."Item No.";
                                MasterTable."Requisition No." := "No.";
                                MasterTable.Status := MasterTable.Status::"3";
                                MasterTable.INSERT;
                    
                    
                                Window.UPDATE(1,STRSUBSTNO('%1 %2',ProdOrderComp."Prod. Order No.",ProdOrderComp."Item No."));
                                SLEEP(2);
                              END;
                            END;
                            LocCode := ProdOrderComp."Location Code";
                          UNTIL ProdOrderComp.NEXT = 0;
                    
                      END ELSE BEGIN
                        ProdOrderComp.RESET;
                        ProdOrderComp.SETCURRENTKEY(Status,"Location Code");
                        ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status::Released);
                        ProdOrderComp.SETRANGE("Requistion Made",FALSE);
                        IF UserSetup.GET(USERID) THEN BEGIN
                          IF UserSetup."Location Code" <> '' THEN
                            ProdOrderComp.SETRANGE("Location Code",UserSetup."Location Code");
                        END;
                        ProdOrderComp.SETRANGE("Due Date",Date);
                        IF ProdOrderComp.FINDSET THEN
                          REPEAT
                            IF Item.GET(ProdOrderComp."Item No.") THEN BEGIN
                              IF Item."Replenishment System" = Item."Replenishment System"::Purchase THEN BEGIN
                                RequisitionLine2.RESET;
                                RequisitionLine2.SETRANGE("Requisition No.","No.");
                                RequisitionLine2.SETRANGE(Status,ProdOrderComp.Status);
                                RequisitionLine2.SETRANGE("No.",ProdOrderComp."Item No.");
                                RequisitionLine2.SETRANGE("Location Code",LocCode);
                                RequisitionLine2.SETRANGE("Liquid-Powder",ProdOrderComp."Liquid-Powder");
                                IF RequisitionLine2.FIND('+') THEN BEGIN
                                  RequisitionLine2.Quantity += ProdOrderComp."Original Expected Qty";
                                  RequisitionLine2."Remaining Qty" := RequisitionLine2.Quantity;
                                  RequisitionLine2."Original Quantity" := RequisitionLine2.Quantity;
                                  RequisitionLine2.MODIFY;
                    
                                  MasterTable.INIT;
                                  MasterTable."Document Type" := MasterTable."Document Type"::"1";
                                  MasterTable."Sub Document Type" := MasterTable."Sub Document Type"::"1";
                                  MasterTable.No := ProdOrderComp."Prod. Order No.";
                                  MasterTable."Document Line No" := ProdOrderComp."Prod. Order Line No.";
                                  MasterTable."Line No" := ProdOrderComp."Line No.";
                                  MasterTable."Item No" := ProdOrderComp."Item No.";
                                  MasterTable."Requisition No." := "No.";
                                  MasterTable.Status := MasterTable.Status::"3";
                                  MasterTable.INSERT;
                                END ELSE BEGIN
                                  NoofRec += 1;
                                  LineNo += 10000;
                                  RequisitionLine.INIT;
                                  RequisitionLine."Requisition No." := "No.";
                                  RequisitionLine.Status := ProdOrderComp.Status;
                                  RequisitionLine."Line No." := LineNo;
                                  RequisitionLine."No." := ProdOrderComp."Item No.";
                                  RequisitionLine.Description := ProdOrderComp.Description;
                                  RequisitionLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                  RequisitionLine.Quantity := ProdOrderComp."Original Expected Qty";
                                  RequisitionLine."Original Quantity" := ProdOrderComp."Original Expected Qty";
                                  RequisitionLine."Remaining Qty" := ProdOrderComp."Original Expected Qty";
                                  RequisitionLine."Location Code" := ProdOrderComp."Location Code";
                                  RequisitionLine.VALIDATE("Shortcut Dimension 1 Code",ProdOrderComp."Shortcut Dimension 1 Code");
                                  RequisitionLine.VALIDATE("Shortcut Dimension 2 Code",ProdOrderComp."Shortcut Dimension 2 Code");
                                  RequisitionLine."Bin Code" := ProdOrderComp."Bin Code";
                                  RequisitionLine."Liquid-Powder" := ProdOrderComp."Liquid-Powder";
                                  RequisitionLine.INSERT;
                    
                                  MasterTable.INIT;
                                  MasterTable."Document Type" := MasterTable."Document Type"::"1";
                                  MasterTable."Sub Document Type" := MasterTable."Sub Document Type"::"1";
                                  MasterTable.No := ProdOrderComp."Prod. Order No.";
                                  MasterTable."Document Line No" := ProdOrderComp."Prod. Order Line No.";
                                  MasterTable."Line No" := ProdOrderComp."Line No.";
                                  MasterTable."Item No" := ProdOrderComp."Item No.";
                                  MasterTable."Requisition No." := "No.";
                                  MasterTable.Status := MasterTable.Status::"3";
                                  MasterTable.INSERT;
                    
                    
                                  Window.UPDATE(1,STRSUBSTNO('%1 %2',ProdOrderComp."Prod. Order No.",ProdOrderComp."Item No."));
                                  SLEEP(2);
                        //          Window.UPDATE(2,ROUND(NoofRec/ProdOrderComp.COUNT * 100000,1));
                                END;
                              END;
                            END;
                            LocCode := ProdOrderComp."Location Code";
                          UNTIL ProdOrderComp.NEXT = 0;
                      END;
                    END;
                    {
                      CalcMRPforPlan3.RESET;
                      IF CalcMRPforPlan3.FINDSET THEN BEGIN
                       REPEAT
                          CalcMRPforPlan3.CALCFIELDS("Item Safety Stock Qty","Quantity in Stock",
                            "Quantity on Purchase Order","Quantity on Component Line",CalcMRPforPlan3."Item Minimum Order Qty");
                          CalcMRPforPlan3."Expected Stock in  Hand" := ((CalcMRPforPlan3."Quantity in Stock" + CalcMRPforPlan3."Quantity on Purchase Order") -
                            CalcMRPforPlan3."Quantity on Component Line" );
                          CalcMRPforPlan3."Net Req. Qty for Indent" := ((CalcMRPforPlan3.Quantity + CalcMRPforPlan3."Item Safety Stock Qty") - CalcMRPforPlan3."Expected Stock in  Hand");
                          IF CalcMRPforPlan3."Net Req. Qty for Indent" < 0 THEN
                            CalcMRPforPlan3."Net Req. Qty for Indent" := 0;
                          IF CalcMRPforPlan3."Net Req. Qty for Indent" <> 0 THEN BEGIN
                            CalcMRPforPlan3.CALCFIELDS("Qty on Indent");
                            IF CalcMRPforPlan3."Item Minimum Order Qty" <> 0 THEN BEGIN
                              ActualQtyForIndent := ROUND((CalcMRPforPlan3."Net Req. Qty for Indent" / CalcMRPforPlan3."Item Minimum Order Qty"),2,'>');
                              CalcMRPforPlan3."Actual Qty Send for Indent" := ((ActualQtyForIndent * CalcMRPforPlan3."Item Minimum Order Qty") - CalcMRPforPlan3."Qty on Indent");
                            END ELSE BEGIN
                              CalcMRPforPlan3."Actual Qty Send for Indent" := (CalcMRPforPlan3."Net Req. Qty for Indent" - CalcMRPforPlan3."Qty on Indent");
                            END;
                          END;
                          IF CalcMRPforPlan3."Actual Qty Send for Indent" < 0 THEN
                            CalcMRPforPlan3."Actual Qty Send for Indent" := 0
                          ELSE
                            CalcMRPforPlan3."Actual Qty Send for Indent" := CalcMRPforPlan3."Actual Qty Send for Indent";
                    
                          CalcMRPforPlan3.MODIFY;
                       UNTIL CalcMRPforPlan3.NEXT = 0;
                      END;
                      //UpdateCalculateMRP;
                      }
                    Window.CLOSE;
                     */

                end;
            }
            action("Send To Store")
            {
                Caption = 'Send To Store';
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin

                    Rec.TESTFIELD(Status, Rec.Status::Approved);

                    IF CONFIRM('Do you want send to Store', TRUE) THEN BEGIN
                        Rec.Posted := TRUE;

                        Rec.MODIFY;
                        MESSAGE('Requisition Send to store');
                    END;
                    /*TESTFIELD("Requisition Type");
                    TESTFIELD("Requisition to Section");
                    TESTFIELD("Shortcut Dimension 1 Code");
                    TESTFIELD("Shortcut Dimension 2 Code");
                    VALIDATE("Shortcut Dimension 1 Code");
                    VALIDATE("Shortcut Dimension 2 Code");
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.","No.");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                      RequisitionLine.TESTFIELD(RequisitionLine.Quantity);
                     END;
                    IF CONFIRM (Text001_gTxt,FALSE) THEN BEGIN
                      IF ApprovalMagmt.CheckRequistionApprovalsWorkflowEnabled(Rec) THEN
                        ApprovalMagmt.OnSendRequistionForApproval(Rec);
                      MESSAGE(Text002_gTxt,"No.");
                    END;
                    */
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Requisition No.", Rec."No.");
                    IF RequisitionLine.FINDFIRST THEN
                        CurrPage.CLOSE;

                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                    IF ApprovalEntry.FIND('-') THEN
                        IF USERID <> ApprovalEntry."Sender ID" THEN
                            ERROR(CancelRequestErr, ApprovalEntry."Sender ID");

                    //ApprovalMagmt.OnCancelRequistionApprovalRequest(Rec);//EXP
                    ReqHrd.RESET;
                    ReqHrd.SETRANGE(ReqHrd."No.", Rec."No.");
                    IF ReqHrd.FINDFIRST THEN BEGIN
                        ReqHrd."Sent for Authorization" := FALSE;
                        ReqHrd.Status := Rec.Status::Open;
                        ReqHrd."Approving UID" := '';
                        ReqHrd."Approving Date" := 0D;
                        ReqHrd."Approving Time" := 0T;
                        ReqHrd."Sending UID" := '';
                        ReqHrd."Sending Date" := 0D;
                        ReqHrd."Sending Time" := 0T;
                        ReqHrd.MODIFY;
                    END;
                end;
            }
            // action("Closed Requisition")
            // {
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin


            //         RequisitionHeader.RESET;
            //         RequisitionHeader.SETRANGE("No.", Rec."No.");
            //         IF RequisitionHeader.FIND('-') THEN
            //             IF RequisitionHeader.Status = RequisitionHeader.Status::Closed THEN BEGIN
            //                 MESSAGE(Text50002, Rec."No.");
            //             END ELSE
            //                 IF CONFIRM(Text50001, TRUE, Rec."No.") THEN BEGIN
            //                     InvSetup.GET;
            //                     InvSetup.TESTFIELD(InvSetup."Posted Requisition No.");
            //                     PostedReqHead.TRANSFERFIELDS(Rec);
            //                     PostedReqHead."No." := NoSeriesMgt.GetNextNo(InvSetup."Posted Requisition No.", WORKDATE, TRUE);
            //                     PostedReqHead.Attachment := Rec."No.";
            //                     PostedReqHead.Status := PostedReqHead.Status::Closed;
            //                     PostedReqHead.INSERT;
            //                     RequisitionLine.RESET;
            //                     RequisitionLine.SETRANGE(RequisitionLine."Requisition No.", Rec."No.");

            //                     IF RequisitionLine.FINDFIRST THEN BEGIN
            //                         REPEAT
            //                             PostedReqLine.TRANSFERFIELDS(RequisitionLine);
            //                             PostedReqLine."Requisition No." := PostedReqHead."No.";

            //                             PostedReqLine.INSERT;

            //                         UNTIL RequisitionLine.NEXT = 0;
            //                     END;

            //                 END;
            //         ReqHead.SETRANGE(ReqHead."No.", Rec."No.");
            //         IF ReqHead.FINDFIRST THEN BEGIN
            //             ReqHead.DELETE;
            //         END;
            //         MESSAGE('Requisition Closed');
            //     end;
            // }
            action("View Note Sheet")
            {
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ApprovalCommentLine.SETRANGE(ApprovalCommentLine."Document No.", rec."No.");
                    PAGE.RUN(PAGE::"NoteSheet Display", ApprovalCommentLine);
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ApplicationArea = All;
                ShortCutKey = 'Shift+Ctrl+D';

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
            action("View attachment")
            {
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    FileDir.Get();
                    //LoaPath := FileDir.Loa;
                    //  FilePath := 'http://192.168.10.60/boc_ftp/loa/';
                    FilePath := FileDir."Requisition Read";

                    IF Rec.Attachment <> '' THEN BEGIN
                        OldFileName := Rec.Attachment;
                        ServerFileName := FilePath + Rec.Attachment;
                        HYPERLINK(ServerFileName);
                    END;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnOpenPage()
    begin
        //Rec.SetSecurityFilter;
    end;

    var
        ReqHeadRec: Record 50087;
        NoofRec: Integer;
        LineNo: Integer;
        ProdOrderComp: Record 5407;
        Item: Record 27;
        Window: Dialog;
        RequisitionLine2: Record 50088;
        ILERemQty: Decimal;
        AvailQty: Decimal;
        RemQty: Decimal;
        UserSetup: Record 91;
        LocCode: Code[20];
        LineNo2: Integer;
        LocCode2: Code[20];
        ProdOrder: Record 5405;
        ProdOrderComp2: Record 5407;
        ActualQtyForIndent: Decimal;
        ItemSubs: Record 5715;
        item3: Record 27;
        SubstituteItemStock: Decimal;
        Location6: Record 14;
        RequisitionLine: Record 50088;
        ShortcutDimCode: array[8] of Code[20];
        ApprovalMagmt: Codeunit 1535;
        User1: Code[50];
        User2: Code[50];
        Text0001: Label 'Status must be Open for Indent %1';
        Text002: Label 'You cannot rename a %1.';
        Text001_gTxt: Label 'Do you want to Send for Approval?';
        Text002_gTxt: Label 'Document No. %1 Successfully Sent for Approval..!';
        Text003_gTxt: Label 'Do you want to Approved?';
        Text004_gTxt: Label 'Document No. %1 Successfully Approved..!';
        ApprovalEntry: Record 454;
        CancelRequestErr: Label 'Document Sent by %. You cannot cancel approval request.';
        ReqHrd: Record 50087;
        RequisitionHeader: Record 50087;
        Text50002: Label 'Requisition No. %1 already closed.';
        Text50003: Label 'Requisition %1 posted successfully.';
        Text50004: Label 'There is nothing to post?';
        Text50001: Label 'Do you want to Closed Requisition %1?';
        PostedReqHead: Record 50091;
        PostedReqLine: Record 50092;
        InvSetup: Record 313;
        NoSeriesMgt: Codeunit 396;
        ReqHead: Record 50087;
        ReqLine: Record 50088;
        OldFileName: Text;
        ServerFileName: Text;
        FilePath: Text[150];
        FileDir: Record 50083;
        ApprovalCommentLine: Record 50084;
        ApprovalUserGroup: Record 50081;
}

#pragma implicitwith restore

