page 50039 "NTA Activities TADA"
{
    Caption = 'NTA Activities TADA';
    PageType = CardPart;
    SourceTable = "NTA Cue";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            cuegroup("'")
            {
                Caption = '==';
                field("Open Bills - TADA"; rec."Open Bills - TADA")
                {
                    Caption = 'Open Bills';
                    DrillDownPageID = "TA Bill List - cue";
                    Editable = false;
                    Image = Star;
                }
                field("Pending Approval Bills - TADA"; rec."Pending Approval Bills - TADA")
                {
                    Caption = 'Pending Approval Bills';
                    DrillDownPageID = "TA Bill List - cue";
                    Editable = false;
                }
                field("Approved Bills - TADA"; rec."Approved Bills - TADA")
                {
                    Caption = 'Approved Bills';
                    DrillDownPageID = "TA Bill List";
                    Editable = false;
                }
                field("Rejected Bills"; rec."Rejected Bills - TADA")
                {
                    Caption = 'Rejected Bills';
                    DrillDownPageID = "TA Bill List";
                    Editable = false;
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        Caption = 'New Sales Quote';
                        Image = TileBlue;
                        RunObject = Page 41;
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        Caption = 'New Sales Order';
                        RunObject = Page 42;
                        RunPageMode = Create;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                Caption = 'Set Up Cues';
                Image = Setup;
                Visible = false;

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
                end;
            }
        }
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
    begin

        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;

        rec.SetRespCenterFilter;
        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
        rec.SETFILTER("Date Filter2", '>=%1', WORKDATE);
    end;

    var
        //Raj Block due to base  code
        CueSetup: Codeunit 9701;
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

