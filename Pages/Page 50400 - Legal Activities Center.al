page 50400 "Legal Activities Center"
{
    Caption = 'Dashboard';
    PageType = ListPart;
    SourceTable = "NTA Cue";
    ApplicationArea = ALL;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Write Cases")
            {
                field("New Write Case"; Rec."New Write Case")
                {
                    DrillDown = true;
                    DrillDownPageId = 50350;
                    Editable = false;
                    ApplicationArea = all;

                }

                field("Ongoing Write Cases"; Rec."Ongoing Write Cases")
                {
                    DrillDown = true;
                    DrillDownPageId = 50350;
                    Editable = false;
                    ApplicationArea = all;

                }

                field("Disposed Write Cases"; Rec."Disposed Write Cases")
                {
                    DrillDown = true;
                    DrillDownPageId = 50362;
                    Editable = false;
                    ApplicationArea = all;

                }



            }

            cuegroup(Advocate)
            {
                field(Advocates; Rec.Advocates)
                {
                    DrillDown = true;
                    DrillDownPageId = 50301;
                    Editable = false;

                }

            }


        }
    }

    actions
    {

    }

    // trigger OnAfterGetRecord()
    // var
    //     DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    // begin
    //     CalculateCueFieldValues;
    //     ShowDocumentsPendingDodExchService := FALSE;
    //     IF DocExchServiceSetup.GET THEN
    //         ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    // end;

    // trigger OnOpenPage()
    // // var
    // //     CentreBill: Record 50002;
    //  begin
    //     IF NOT rec.GET THEN BEGIN
    //         rec.INIT;
    //         rec.INSERT;
    //     END;


    // end;



    var
        CueSetup: Codeunit "Cues And KPIs";
        ShowDocumentsPendingDodExchService: Boolean;


}

