page 50360 "Hearing Details"
{
    Caption = 'Hearing Details';
    DelayedInsert = true;
    PageType = List;
    Editable = true;
    SourceTable = "Case Hearing Entry";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; rec."Document No.")
                {
                    Caption = 'File No.';
                    //Editable = false;
                }

                field("Line No."; Rec."Line No.")
                {

                    // app

                }


                field("Next Hearing Date"; rec."Next Hearing Date")
                {

                    trigger OnValidate()
                    begin
                        WritCaseHdr.RESET;
                        WritCaseHdr.SETRANGE("File No.", REC."Document No.");
                        IF WritCaseHdr.FIND('-') THEN
                            IF REC."Next Hearing Date" <= WritCaseHdr."First Hearing Date" THEN
                                ERROR('Next hearing date should be greater than %1 first hearing date', WritCaseHdr."First Hearing Date");
                    end;
                }


                field("Hearing Details"; rec."Hearing Details")
                {
                }

                //field(fiz)
                field("Oath No."; rec."Oath No.")
                {
                }
                field("Oath Date"; rec."Oath Date")
                {
                }
                field(Remarks; rec.Remarks)
                {
                }
                field("SOF Required"; rec."SOF Required")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        WritCaseHdr: Record "Writ/Case Header";
}

