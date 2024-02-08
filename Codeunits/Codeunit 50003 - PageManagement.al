/// <summary>
/// Codeunit Page_Management (ID 50003).
/// </summary>
codeunit 50003 "Page_Management"
{
    // Subtype = Upgrade;
    EventSubscriberInstance = StaticAutomatic;


    //[IntegrationEvent(true, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnBeforeGetConditionalCardPageID', '', true, true)]
    local procedure CallPageID(RecRef: RecordRef; var CardPageID: Integer; var IsHandled: Boolean)
    var
        myInt: Integer;
    begin
        case RecRef.Number of

            Database::"TA Bill Header":
                Begin
                    CardPageID := 50006;
                    IsHandled := True;
                End;
            Database::"Requistion Header":
                Begin
                    CardPageID := 50203;
                    IsHandled := True;
                End;

            Database::"indent header":
                Begin
                    CardPageID := 50242;
                    IsHandled := True;
                End;
            Database::"Purchase Proposal Header":
                Begin
                    // CardPageID := 50158;
                    CardPageID := GetProposalHeaderPageID(RecRef);
                    IsHandled := True;
                End;



            Else
                Exit;
        End;

    end;

    //procedure CallGetCardPageId(RecRef: RecordRef; var CardPageID: Integer; var IsHandled: Boolean)
    /// <summary>
    /// CallGetCardPageId.
    /// </summary>
    /// <param name="recref">RecordRef.</param>
    procedure CallGetCardPageId(recref: RecordRef)
    begin
        GetCardPageId(RecRef);
    end;

    local procedure GetCardPageId(var RecRef: RecordRef): Integer;
    begin

        case RecRef.Number of
            DATABASE::"TA Bill Header":
                exit(Page::"TA Bill Card");

            DATABASE::"Requistion Header":
                exit(Page::"Requisition Under App Header");
        end;
        exit(0);

    end;

    local procedure GetproposalHeaderPageId(var RecRef: RecordRef): Integer
    var
        ProposalHeader: Record "Purchase Proposal Header";
    begin
        RecRef.SetTable(ProposalHeader);
        CASE ProposalHeader."Purchase Type" OF
            ProposalHeader."Purchase Type"::Direct:
                IF ProposalHeader.Status = ProposalHeader.Status::"Pending for Approval" THEN
                    EXIT(PAGE::"Purch. Proposal Under Approval")
                ELSE
                    //IF ProposalHeader.Status = ProposalHeader.Status::Approved Then
                    EXIT(PAGE::"Purch. Proposal Approved");
            ProposalHeader."Purchase Type"::GeM:
                IF ProposalHeader.Status = ProposalHeader.Status::"Pending for Approval" THEN
                    EXIT(PAGE::"Gems Proposal Under Approval")
                ELSE
                    EXIT(PAGE::"Gems Proposal Approved");
        end;
    end;
}
