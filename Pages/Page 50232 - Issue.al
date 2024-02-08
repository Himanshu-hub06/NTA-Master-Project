#pragma implicitwith disable
page 50232 Issue
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 50093;
    SourceTableView = WHERE(Posted = CONST(false));

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
                    Caption = 'Document Date';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Issue From Section';
                }
                field("Section Name"; Rec."Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Issue From Section Name';
                }
                field("Issue to Section"; Rec."Issue to Section")
                {
                    ApplicationArea = All;
                    Caption = 'Issue To Section';
                }
                field("Issue To Section Name"; Rec."Issue To Section Name")
                {
                    ApplicationArea = All;
                    Caption = 'Issue To Section Name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
            }
            part(RequisitionHeaderSubform; "Issue Line Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart("Notes"; Notes)
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

                trigger OnAction()
                begin
                    IssHeadRec.RESET;
                    IssHeadRec.SETRANGE("No.", Rec."No.");
                    IF IssHeadRec.FIND('-') THEN BEGIN
                        REPORT.RUNMODAL(50019, TRUE, TRUE, IssHeadRec);
                    END;
                end;
            }
            action("&List")
            {
                Image = List;
                Promoted = true;
                RunObject = Page Issue;
                RunPageView = SORTING("No.")
                              ORDER(Ascending);
            }
            action("Re&open")
            {
                Image = ReOpen;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF Rec.Status = Rec.Status::Release THEN BEGIN
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    END ELSE
                        ERROR('Already Open');

                    IssueLine.RESET;
                    IssueLine.SETRANGE("Document No.", Rec."No.");
                    IF IssueLine.FINDFIRST THEN BEGIN
                        REPEAT
                            IssueLine.Status := IssueLine.Status::Open;
                            IssueLine.MODIFY;
                        UNTIL IssueLine.NEXT = 0;
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
            action(Release)
            {
                Image = Approval;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Shortcut Dimension 1 Code");
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    Rec.TESTFIELD("Issued Date");
                    Rec.TESTFIELD("Issue to Section");

                    Rec.VALIDATE("Shortcut Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code");

                    IF Rec.Status = Rec.Status::Open THEN BEGIN
                        Rec.Status := Rec.Status::Release;
                        Rec.MODIFY;
                    END ELSE
                        ERROR('Already Open');

                    IssueLine.RESET;
                    IssueLine.SETRANGE("Document No.", Rec."No.");
                    IF IssueLine.FINDFIRST THEN BEGIN
                        REPEAT
                            IssueLine.Status := IssueLine.Status::Release;
                            IssueLine.MODIFY;
                        UNTIL IssueLine.NEXT = 0;
                    END;

                    MESSAGE('Document No. %1 has successfully Release', Rec."No.");
                end;
            }
            action("Post Issue")
            {
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin

                    Rec.TESTFIELD(Status, Rec.Status::Release);
                    Rec.TESTFIELD("Issued Date");
                    IssueLine.RESET;
                    IssueLine.SETRANGE(IssueLine."Document No.", Rec."No.");
                    IssueLine.SETFILTER(IssueLine.Quantity, '<>%1', 0);
                    IF NOT IssueLine.FINDFIRST THEN
                        ERROR('Quantity to issue is not bank');
                    IF CONFIRM('Do you want to Issue Issue', TRUE) THEN BEGIN
                        ItemJnlmanag.FillItemJournalFromRequisition2(Rec."No.");//EXP
                    END;
                end;
            }
            action(Dimensions)
            {
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

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    var
        IssHeadRec: Record 50093;
        NoofRec: Integer;
        LineNo: Integer;
        ProdOrderComp: Record 5407;
        Item: Record 27;
        Window: Dialog;
        IssueLine2: Record 50094;
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
        IssueLine: Record 50094;
        IssueLine1: Record 50094;
        ShortcutDimCode: array[8] of Code[20];
        ItemJnlmanag: Codeunit "ItemJnlManagement Ext";
        // ItemJnlmanag: Codeunit 240;
        ItemTab: Record 27;
}

#pragma implicitwith restore

