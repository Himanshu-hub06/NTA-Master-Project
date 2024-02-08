page 50790 "Meeting List Part"
{
    AutoSplitKey = true;
    Caption = 'Metting Applications';
    DataCaptionFields = "Committee Code", "Meeting Type", "Meeting No.";
    InsertAllowed = false;
    PageType = ListPart;
    //SourceTable = 50061;
    SourceTable = 50286;
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Committee Code"; Rec."Committee Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Meeting No."; Rec."Meeting No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Newspaper Code"; Rec."Newspaper Code")
                {
                    // Caption = 'FM Station No.'; // ROHIT++
                    // Editable = false;
                    // ApplicationArea = all;
                    // trigger OnDrillDown()
                    // var
                    //     VendorEmpPvtFM: Record 50160;
                    //     PvtFMVendCard: Page 50216;
                    //     MeetingLine_L_Rec: Record 50061;
                    //     MeetingMaster: Record 50060;
                    //     LineNo: Integer;
                    //     MeetingLine: Record 50061;
                    // begin
                    //     VendorEmpPvtFM.RESET;
                    //     VendorEmpPvtFM.SETCURRENTKEY("FM Station ID");
                    //     VendorEmpPvtFM.SETRANGE("FM Station ID", "Newspaper Code");
                    //     IF VendorEmpPvtFM.FIND('-') THEN BEGIN
                    //         PvtFMVendCard.SETRECORD(VendorEmpPvtFM);
                    //         PvtFMVendCard.EDITABLE(FALSE);
                    //         PvtFMVendCard.RUN;
                    //     END ELSE
                    //         MESSAGE('Application not found.');
                    // end;

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     VendorEmpPrint_l_Rec: Record 50152;
                    //     VendorEmpanelmentList_Page: Page 50341;
                    //     MeetingLine_L_Rec: Record 50061;
                    //     MeetingMaster: Record 50060;
                    //     LineNo: Integer;
                    //     MeetingLine: Record 50061;
                    // begin
                    // end; // ROHIT--
                }
                field("Newspaper Name"; Rec."Newspaper Name")
                {
                    Caption = 'Station Name';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Place of Publication"; Rec."Place of Publication")
                {
                    Caption = 'Broadcast City';
                    ApplicationArea = all;
                }
                // field(Language; LangName)
                // {
                //     Caption = 'Language';
                //     ApplicationArea = all;
                // } //ROHIT
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Load Vendor Application")
            {
                ApplicationArea = All;
                Image = ApplicationWorksheet;
                //Promoted = true; //ROHIT++
                //PromotedCategory = Process;

                //             trigger OnAction()
                //             var
                //                 VendEmpPvtFM: Record 50160;
                //                 MeetingLine, MeetingLine11 : Record 50286;
                //                 MeetHdr: Record 50285;
                //                 CommitteAppEntry: Record 50269;
                //                 CommitteeLineRec: Record 50266;
                //                 cnt, Ln : Integer;
                //             begin
                //                 MeetHdr.SETRANGE("Committee Code", Rec."Committee Code");
                //                 MeetHdr.SETRANGE("Meeting No.", Rec."Meeting No.");
                //                 MeetHdr.SETRANGE(Status, MeetHdr.Status::Approved);
                //                 IF MeetHdr.FINDFIRST THEN
                //                     ERROR('Meeting is Closed!!!');
                //                 VendEmpPvtFM.RESET;
                //                 VendEmpPvtFM.SETCURRENTKEY("FM Station ID");
                //                 VendEmpPvtFM.SETRANGE(Status, VendEmpPvtFM.Status::Approved);
                //                 VendEmpPvtFM.SetAutoCalcFields("Selected in Meeting");
                //                 VendEmpPvtFM.SetRange("Selected in Meeting", false);
                //                 IF VendEmpPvtFM.FindFirst() THEN BEGIN
                //                     MeetingLine11.Reset();
                //                     MeetingLine11.setrange("Committee Code", rec."Committee Code");
                //                     MeetingLine11.SetRange("Meeting No.", rec."Meeting No.");
                //                     IF MeetingLine11.FindLast() then
                //                         Ln := MeetingLine11."Line No.";
                //                     REPEAT
                //                         Ln += 10000;
                //                         MeetingLine.INIT;
                //                         MeetingLine."Committee Code" := "Committee Code";
                //                         MeetingLine."Meeting Type" := "Meeting Type";
                //                         MeetingLine."Meeting No." := "Meeting No.";
                //                         MeetingLine."Document No." := "Document No.";
                //                         MeetingLine."Line No." := Ln;
                //                         MeetingLine."Newspaper Code" := VendEmpPvtFM."FM Station ID";
                //                         MeetingLine."Newspaper Name" := VendEmpPvtFM."FM Station Name";
                //                         MeetingLine."Place of Publication" := VendEmpPvtFM."Broadcast City";
                //                         MeetingLine.Language := VendEmpPvtFM.Language;
                //                         MeetingLine."Bank Account No." := VendEmpPvtFM."Bank A/c No.";
                //                         MeetingLine."Bank Name" := VendEmpPvtFM."Bank Name";
                //                         MeetingLine."Account Holder Name" := VendEmpPvtFM."A/C Holder Name";
                //                         MeetingLine."Account Address" := VendEmpPvtFM."Bank A/C Address";
                //                         MeetingLine."IFSC Code" := VendEmpPvtFM."IFSC Code";
                //                         MeetingLine.Branch := VendEmpPvtFM."Bank Branch";
                //                         MeetingLine."Global Dimension 1 Code" := VendEmpPvtFM."Global Dimension 1 Code";
                //                         if MeetingLine.INSERT() then begin
                //                             cnt += 1;
                //                             CommitteeLineRec.RESET;
                //                             CommitteeLineRec.SETRANGE("Committee Code", rec."Committee Code");
                //                             IF CommitteeLineRec.FINDSET THEN
                //                                 REPEAT
                //                                     CommitteAppEntry.INIT;
                //                                     CommitteAppEntry."User ID" := CommitteeLineRec."Member ID";
                //                                     CommitteAppEntry."Committee Code" := Rec."Committee Code";
                //                                     CommitteAppEntry."Meeting No." := Rec."Meeting No.";
                //                                     CommitteAppEntry."Line No." := CommitteAppEntry."Line No." + 10000;
                //                                     CommitteAppEntry."FM Station Code" := MeetingLine."Newspaper Code";
                //                                     CommitteAppEntry."FM Station Name" := MeetingLine."Newspaper Name";
                //                                     CommitteAppEntry."Language Code" := MeetingLine.Language;
                //                                     // CommitteAppEntry."Publication Place" := MeetingLine."Place of Publication";//kc 28042023
                //                                     CommitteAppEntry."Broadcast City" := MeetingLine."Place of Publication";
                //                                     CommitteAppEntry."Global Dimension 1 Code" := MeetingLine."Global Dimension 1 Code";
                //                                     CommitteAppEntry."Global Dimension 2 Code" := MeetingLine."Global Dimension 2 Code";
                //                                     CommitteAppEntry.INSERT;
                //                                 UNTIL CommitteeLineRec.NEXT = 0;
                //                         end;
                //                     UNTIL VendEmpPvtFM.NEXT = 0;
                //                     Message('%1 Applications loaded in Meeting', cnt);
                //                 END
                //                 ELSE
                //                     MESSAGE('Application not found to load.');
                //             end;
                //         }
                //     }
                // }
                // var
                //     LanguageTab: record Language;
                //     LangName: Text;

                // trigger OnAfterGetRecord()
                // var

                // begin
                //     LanguageTab.Reset();
                //     LanguageTab.SetRange(Code, rec.Language);
                //     if LanguageTab.FindFirst() then
                //         LangName := LanguageTab.Name;
                // end;

                // trigger OnAfterGetCurrRecord()
                // var
                //     MeetingMasterL: Record 50063;
                // begin
                //end;  //ROHIT--
            }
        }

    }
}

