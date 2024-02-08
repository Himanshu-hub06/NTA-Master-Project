page 50038 "NTA Activities Center"
{
    Caption = 'Dashboard';
    PageType = CardPart;
    SourceTable = "NTA Cue";
    ApplicationArea = ALL;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("TA Bill")
            {
                field("Total TA Bills"; Rec."Total TA Bills")
                {
                    DrillDown = true;
                    DrillDownPageId = 50005;
                    Editable = false;

                }
                field("Pending Approval Bills - TADA"; Rec."Pending Approval Bills - TADA")
                {
                    Caption = 'Pending for Approval-TA Bills';
                    DrillDown = true;
                    // DrillDownPageId = 50074;
                    DrillDownPageId = 50818;
                    Editable = false;
                }
                field("Approved Bills - TADA"; Rec."Approved Bills - TADA")
                {
                    Caption = 'Approved - TA Bills';
                    DrillDownPageID = 50819;
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("Rejected Bills - TADA"; Rec."Rejected Bills - TADA")
                {
                    Caption = 'Rejected - TA Bills';
                    DrillDownPageID = 50817;
                    Style = favorable;
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("Disbursment Bill"; Rec."Disbursment Bill")
                {
                    Caption = 'Pending For Disbursement';
                    DrillDownPageID = 50816;
                    Style = favorable;
                    Editable = false;
                    ApplicationArea = ALL;
                }





            }
            cuegroup("Centre Bill")
            {
                field("Total Centre Bill"; Rec."Total Centre Bill")
                {
                    DrillDown = true;
                    DrillDownPageId = 50002;
                    Editable = false;
                }
                field("Pending Approval Bills - Cente"; Rec."Pending Approval Bills - Cente")
                {
                    Caption = 'Pending for Approval - Centre Bills';
                    DrillDown = true;
                    DrillDownPageId = 50002;
                    Editable = false;
                }
                field("Approved Bills - Center"; Rec."Approved Bills - Center")
                {
                    Caption = 'Approved - Center Bill';

                    DrillDownPageID = 50002;
                    Style = favorable;
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("Rejected Bills  - Center"; Rec."Rejected Bills  - Center")
                {
                    Caption = 'Rejected - Center Bill';
                    DrillDownPageID = 50002;
                    Style = favorable;
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("Centre Disburment Bill"; Rec."Centre Disburment Bill")
                {
                    Caption = 'Pending For Disbursement';
                    DrillDownPageID = 50002;
                    Style = favorable;
                    Editable = false;
                    ApplicationArea = ALL;
                }

            }
        }
    }

    actions
    {
        // area(processing)
        // {

        //     action("New Sales Quote")
        //     {
        //         Caption = 'New Sales Quote';
        //         // Image = TileBlue;
        //         RunObject = Page 41;
        //         RunPageMode = Create;
        //     }
        //     action("New Sales Order")
        //     {
        //         Caption = 'New Sales Order';
        //         RunObject = Page 42;
        //         RunPageMode = Create;
        //     }

        //     action("Set Up Cues")
        //     {
        //         Caption = 'Set Up Cues';
        //         Image = Setup;
        //         Visible = false;

        //         trigger OnAction()
        //         var
        //             CueRecordRef: RecordRef;
        //         begin
        //             CueRecordRef.GETTABLE(rec);
        //             CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
        //         end;
        //     }
        // }
    }

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        CalculateCueFieldValues;
        ShowDocumentsPendingDodExchService := FALSE;
        IF DocExchServiceSetup.GET THEN
            ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    end;

    trigger OnOpenPage()
    var
        CentreBill: Record 50002;
    begin
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;
        rec.SetRespCenterFilter;
        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
        rec.SETFILTER("Date Filter2", '>=%1', WORKDATE);

        rec.FilterGroup(0);
        rec.setrange(Rec."User Filter", UserId);
        rec.FilterGroup(2);



    end;



    var
        CueSetup: Codeunit "Cues And KPIs";
        ShowDocumentsPendingDodExchService: Boolean;

    local procedure CalculateCueFieldValues()
    begin
        /*
        IF FIELDACTIVE("Average Days Delayed") THEN
          "Average Days Delayed" := CalculateAverageDaysDelayed;

        IF FIELDACTIVE("Ready to Ship") THEN
          "Ready to Ship" := CountOrders(FIELDNO("Ready to Ship"));

        IF FIELDACTIVE("Partially Shipped") THEN
          "Partially Shipped" := CountOrders(FIELDNO("Partially Shipped"));

        IF FIELDACTIVE(Delayed) THEN
          Delayed := CountOrders(FIELDNO(Delayed));
          *///GK

    end;
}

