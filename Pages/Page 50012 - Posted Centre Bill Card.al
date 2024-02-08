page 50012 "Posted Centre Bill Card"
{
    // DataCaptionExpression = 'Reference No.';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Posted Centre Bill Header";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bill No."; rec."Reference No.")
                {
                    Editable = false;
                }
                field("Centre No."; rec."Centre No.")
                {
                    Editable = false;
                }
                field("Centre City"; rec."Centre City")
                {
                    Editable = false;
                }
                field("Centre Address"; rec."Centre Address")
                {
                    Editable = false;
                }
                field("Superintendent Name"; rec."Superintendent Name")
                {
                    Editable = false;
                }
                field("Contact No."; rec."Contact No.")
                {
                    Editable = false;
                }
                field("Exam Name"; rec."Exam Name")
                {
                    Editable = false;
                }
                field("Exam Date"; rec."Exam Date")
                {
                    Editable = false;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    Editable = false;
                }
                field("Advance Amount"; rec."Advance Amount")
                {
                    Editable = false;
                }
                field("Refund Amount"; rec."Refund Amount")
                {
                    Editable = false;
                }
                field("Net Payble Amount"; rec."Net Payble Amount")
                {
                    Caption = 'Net Payble Amount';
                    Editable = false;
                }
                //field("Net Approved Amount";rec."Net Approved Amount")
                // {
                //  Editable = false;
                //}
                field("Submitted Date"; rec."Created on")
                {
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
                field("Supporting Document"; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        HYPERLINK('http://104.211.206.19/NTA_ftp/Bill_TravelAllowance_Document/' + rec."File Path");
                    end;
                }
            }
            part("Posted Centre Bill"; "Posted Centre Bill Subform")
            {
                SubPageLink = "Centre Bill ID" = FIELD("CentreBill ID");
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage()
    begin
        AttachDoc := Text001;
    end;

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        NotSent: Boolean;
        AttachDoc: Text;
        Text001: Label 'Click here to View';
}

