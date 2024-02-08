report 50050 "Requisition Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Requisition Slip.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Requistion Header"; 50087)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(IssuedDate_RequistionHeader; "Requistion Header"."Issued Date")
            {
            }
            column(Status_RequistionHeader; "Requistion Header".Status)
            {
            }
            column(No_RequisitionSlip; "No.")
            {
            }
            column(Name_Location; LocationRec.Name)
            {
            }
            column(Address_Location; LocationRec.Address + ' ' + LocationRec."Address 2")
            {
            }
            column(City_Location; LocationRec.City + ' ' + StateTBL.Description)
            {
            }
            column(SectionName_RequistionHeader; "Requistion Header"."Section Name")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(Requisition_Caption; RequisitionCaption)
            {
            }
            column(UserID_RequisitionSlip; "User ID")
            {
            }
            column(ShortcutDimension1Code_RequisitionSlip; Name1)
            {
            }
            column(ShortcutDimension2Code_RequisitionSlip; Name2)
            {
            }
            column(LocationCode_RequisitionSlip; "Location Code")
            {
            }
            column(Company_ContryRegion; CompanyInfo."Country/Region Code")
            {
            }
            column(Departmentcode; DimenssionRec.Name)
            {
            }
            column(Departmentcode2; DimenssionRec2.Name)
            {
            }
            column(Date; "Requistion Header"."Posting Date")
            {
            }
            column(ApprovedBy; "Requistion Header"."Approved By")
            {
            }
            column(IssuedBy; "Requistion Header"."Issued By")
            {
            }
            column(IssueTo; "Requistion Header"."Issue To")
            {
            }
            column(Priority; "Requistion Header".Priority)
            {
            }
            dataitem("Requistion Line"; 50088)
            {
                DataItemLink = "Requisition No." = FIELD("No.");
                DataItemTableView = SORTING("Requisition No.", "Line No.")
                                    ORDER(Ascending);
                column(ConsumptionType_RequistionLine; "Requistion Line"."Consumption Type")
                {
                }
                column(ItemNo_RequisitionSlipLine; "Requistion Line"."No.")
                {
                }
                column(Item_Description; "Requistion Line".Description)
                {
                }
                column(Quantity_RequisitionSlipLine; "Requistion Line".Quantity)
                {
                }
                column(Approved_Quantity; "Requistion Line"."Approved Qty")
                {
                }
                column(Issued_Quantity; "Requistion Line"."Issued Quantity")
                {
                }
                column(ItemCategory; ItemRec."Item Category Code")
                {
                }
                column(RequisitionRemarks; "Requistion Line"."Requisition Remarks")
                {
                }
                column(IssuedQTY; "Requistion Line"."Issued Quantity")
                {
                }
                column(QTYtoIssue; "Requistion Line"."Quantity To Issue")
                {
                }
                column(CostCentreName; CCName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IssuedQty := 0;
                    ItemRec.RESET;
                    ItemRec.SETRANGE("No.", "No.");
                    IF ItemRec.FIND('-') THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*//EXP
                ShortCutDim1 := '';
                ShortCutDim2 := '';
                ReqSlipLineRec.RESET;
                ReqSlipLineRec.SETRANGE("Document No.","No.");
                IF ReqSlipLineRec.FIND('+') THEN BEGIN
                  ShortCutDim1 := ReqSlipLineRec."Shortcut Dimension 1 Code";
                  ShortCutDim2 := ReqSlipLineRec."Shortcut Dimension 2 Code";
                END;
                
                DimenssionRec.RESET;
                DimenssionRec.SETRANGE(Code,"Requistion Header".Department);
                IF DimenssionRec.FINDFIRST THEN
                  Name1 := DimenssionRec.Name;
                
                DimenssionRec.RESET;
                DimenssionRec.SETRANGE(Code,"Requisition to Section");
                IF DimenssionRec.FINDFIRST THEN
                  Name2 := DimenssionRec.Name;
                *///EXP
                /*
                DimenssionRec2.RESET;
                DimenssionRec2.SETRANGE("Dimension Code",'DEPARTMENT');
                DimenssionRec2.SETRANGE(Code,"Requisition to Department");
                IF DimenssionRec2.FINDFIRST THEN;
                 */
                LocationRec.RESET;
                LocationRec.SETRANGE(LocationRec.Code, "Requistion Header"."Location Code");
                IF LocationRec.FIND('-') THEN BEGIN
                    LocationName := LocationRec.Name;
                    LocationAddress := LocationRec.Address;
                    LocationCity := LocationRec.City;
                    StateTBL.RESET;
                    StateTBL.SETRANGE(Code, LocationRec."State Code");
                    IF StateTBL.FINDFIRST THEN
                        StateName := StateTBL.Description;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                //CompanyInfo.CALCFIELDS(CompanyInfo."ISO Picture");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record 79;
        RequisitionCaption: Label 'Requisition Slip';
        ItemRec: Record 27;
        IssuedQty: Decimal;
        RequisitionNoCaption: Label 'Requisition No. :-';
        PoductionOrderCaption: Label 'Production Order No :-';
        RoutingNoCaption: Label 'Routing No :-';
        UserIdCaption: Label 'User ID :-';
        LocationCaption: Label 'Location Code :-';
        BinCaption: Label 'bin Code :-';
        DueDateCaption: Label 'Due Date :-';
        CreateDateCaption: Label 'Create Date :-';
        CreateTimeCaption: Label 'Create Time :-';
        ShortCutDim1: Code[10];
        ShortCutDim2: Code[10];
        ShortCutDim1Caption: Label 'Department :-';
        ShortcutDim2Caption: Label 'Division :-';
        DimenssionRec, DimenssionRec2 : Record 349;
        ApprovedQty: Decimal;
        LocationRec: Record 14;
        LocationName: Text;
        LocationAddress: Text;
        LocationCity: Text;
        Name1: Text;
        Name2: Text;
        DimenstionValueList_Rec,
        DimVal : Record 349;
        CCName: Text;
        StateTBL: Record state;
        StateName: Text;
}

