page 50247 "Store Cue Activities"
{
    Caption = 'Store Activities';
    PageType = CardPart;
    SourceTable = "Store Cue";
    ApplicationArea = All;
    UsageCategory = Lists;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            grid(Grd11)
            {
                group(Requisition)
                {
                    ShowCaption = false;
                    cuegroup(Cuegroup_Requisition)
                    {
                        Caption = 'Requisition';
                        field(OpenRequisition; Rec."Open Requisition")
                        {
                            Caption = 'Open';
                            ApplicationArea = All;
                            //AccessByPermission = tabledata "Requistion Header" = R;
                            DrillDown = true;
                            DrillDownPageId = "Requisition Header List";
                            // trigger OnDrillDown()
                            // var
                            //     ReqHeaderTAb: Record "Requistion Header";
                            // begin
                            //     ReqHeaderTAb.Reset();
                            //     ReqHeaderTAb.SetRange(Status, ReqHeaderTAb.Status::Open);
                            //     if ReqHeaderTAb.FindFirst() then
                            //         Page.Run(50743, ReqHeaderTAb);
                            // end;
                        }

                        field(UnderApprovalRequisition; Rec."Pending Requisition")
                        {
                            Caption = 'Pending for Approval';
                            ApplicationArea = All;
                            Style = Ambiguous;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = "Requisition Under App List";
                            // trigger OnDrillDown()
                            // var
                            //     ReqHeaderTAb: Record "Requistion Header";
                            // begin
                            //     ReqHeaderTAb.Reset();
                            //     ReqHeaderTAb.SetRange(Status, ReqHeaderTAb.Status::"Pending for Approval");
                            //     if ReqHeaderTAb.FindFirst() then
                            //         Page.Run(50749, ReqHeaderTAb);
                            // end;
                        }
                        field(ApprovedRequisition; Rec."Approved Requisition")
                        {
                            Caption = 'Approved';
                            ApplicationArea = All;
                            Style = Favorable;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = "Approved Requisition List";
                            // trigger OnDrillDown()
                            // var
                            //     ReqHeaderTAb: Record "Requistion Header";
                            // begin
                            //     ReqHeaderTAb.Reset();
                            //     ReqHeaderTAb.SetRange(Status, ReqHeaderTAb.Status::Approved);
                            //     if ReqHeaderTAb.FindFirst() then
                            //         Page.Run(50753, ReqHeaderTAb);
                            // end;
                        }
                        field(RejectedRequisition; REc."Rejected Requisition")
                        {
                            Caption = 'Rejected';
                            ApplicationArea = All;
                            Style = favorable;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = "Rejected Requisition List";
                            // trigger OnDrillDown()
                            // var
                            //     ReqHeaderTAb: Record "Requistion Header";
                            // begin
                            //     ReqHeaderTAb.Reset();
                            //     ReqHeaderTAb.SetRange(Status, ReqHeaderTAb.Status::Rejected);
                            //     if ReqHeaderTAb.FindFirst() then
                            //         Page.Run(50769, ReqHeaderTAb);
                            // end;
                        }
                    }
                }
                group(Indent)
                {
                    ShowCaption = false;
                    cuegroup(CueGroup_Indent)
                    {
                        caption = 'Indent';
                        field(OpenIndent; Rec."Open Indent")
                        {
                            Caption = 'Open';
                            ApplicationArea = All;
                            DrillDown = true;
                            DrillDownPageId = "Indent List";
                            // trigger OnDrillDown()
                            // var
                            //     PageIndentList: Page "Indent List";
                            //     IndtHeaderTab: Record "Indent Header";
                            // begin
                            //     IndtHeaderTab.Reset();
                            //     IndtHeaderTab.SetRange(Status, IndtHeaderTab.Status::Open);
                            //     if IndtHeaderTab.FindFirst() then
                            //         Page.Run(50748, IndtHeaderTab);
                            // end;
                        }
                        field(PendingIndent; Rec."Pending Indent")
                        {
                            Caption = 'Pending for Approval';
                            ApplicationArea = All;
                            Style = Ambiguous;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = 50241;
                            // trigger OnDrillDown()
                            // var
                            //     PageIndentList: Page "Indent List";
                            //     IndtHeaderTab: Record "Indent Header";
                            // begin
                            //     IndtHeaderTab.Reset();
                            //     IndtHeaderTab.SetRange(Status, IndtHeaderTab.Status::"Pending for Approval");
                            //     if IndtHeaderTab.FindFirst() then
                            //         Page.Run(50748, IndtHeaderTab);
                            // end;
                        }
                        field(ApprovedIndent; Rec."Approved Indent")
                        {
                            Caption = 'Approved';
                            ApplicationArea = All;
                            Style = Favorable;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = "Indent Approved List";
                            // trigger OnDrillDown()
                            // var
                            //     PageIndentList: Page "Indent List";
                            //     IndtHeaderTab: Record "Indent Header";
                            // begin
                            //     IndtHeaderTab.Reset();
                            //     IndtHeaderTab.SetRange(Status, IndtHeaderTab.Status::Approved);
                            //     if IndtHeaderTab.FindFirst() then
                            //         Page.Run(50748, IndtHeaderTab);
                            // end;
                        }
                        field(RejectedIndent; Rec."Rejected Indent")
                        {
                            Caption = 'Rejected';
                            ApplicationArea = All;
                            Style = favorable;
                            StyleExpr = true;
                            DrillDown = true;
                            DrillDownPageId = "Rejected Indent List";
                            // trigger OnDrillDown()
                            // var
                            //     PageIndentList: Page "Indent List";
                            //     IndtHeaderTab: Record "Indent Header";
                            // begin
                            //     IndtHeaderTab.Reset();
                            //     IndtHeaderTab.SetRange(Status, IndtHeaderTab.Status::Rejected);
                            //     if IndtHeaderTab.FindFirst() then
                            //         Page.Run(50748, IndtHeaderTab);
                            // end;
                        }
                    }
                }

            }
            grid(Grd12)
            {
                cuegroup(Issue)
                {
                    field("Issue From Store"; Rec."Issue From Store")
                    {
                        ApplicationArea = All;
                        Style = Ambiguous;
                        StyleExpr = true;
                        DrillDownPageId = "Posted Requisition List";
                    }
                    field("Issued From Store"; Rec."Issued From Store")
                    {
                        Caption = 'Issued/Closed';
                        ApplicationArea = All;
                        Style = Favorable;
                        StyleExpr = true;
                        DrillDownPageId = "Closed/Issued Requisition List";
                    }
                }
                cuegroup(GemPurchaseProposal)
                {
                    Caption = 'Gem Purchase Proposal';
                    field("Open - Gem Proposal"; Rec."Open - Gem Proposal")
                    {
                        Caption = 'Open';
                        ApplicationArea = All;
                        DrillDownPageId = "GeM Purchase Proposal List";
                    }
                    field("Pending - Gem Proposal"; Rec."Pending - Gem Proposal")
                    {
                        Caption = 'Pending for Approval';
                        Style = Ambiguous;
                        StyleExpr = true;
                        ApplicationArea = All;
                        DrillDownPageId = "GeM Purch. Proposal Under App";
                    }
                    field("Approved - Gem Proposal"; Rec."Approved - Gem Proposal")
                    {
                        Caption = 'Approved';
                        Style = Favorable;
                        StyleExpr = true;
                        ApplicationArea = All;
                        DrillDownPageId = "GeM Proposal Approved List";
                    }
                }
            }
            grid(Grd13)
            {
                cuegroup(DirectPurchaseProposal)
                {
                    Caption = 'Direct Purchase Proposal';
                    field("Open - DP-Proposal"; Rec."Open - DP-Proposal")
                    {
                        Caption = 'Open';
                        ApplicationArea = All;
                        DrillDownPageId = "Purchase Proposal List";
                    }
                    field("Pending - DP-Proposal"; Rec."Pending - DP-Proposal")
                    {
                        Caption = 'Pending for Approval';
                        ApplicationArea = All;
                        Style = Ambiguous;
                        StyleExpr = true;
                        DrillDownPageId = "Purch. Proposal Under App List";
                    }
                    field("Approved - DP-Proposal"; Rec."Approved - DP-Proposal")
                    {
                        Caption = 'Approved';
                        ApplicationArea = All;
                        Style = Favorable;
                        StyleExpr = true;
                        DrillDownPageId = "Purch. Proposal Approved List";
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User Filter", UserId);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        // Rec."User Filter" := UserId;
        // Rec.Modify();
        // CalcFields(rec."Open Requisition");

    end;
}
