page 50398 "Supporting Doc Factbox"
{
    Caption = 'Supporting Documents';
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = 50076;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; rec."File Name")
                {
                    Width = 10;

                    // trigger OnDrillDown()
                    // begin

                    //     InvSetup.GET;
                    //     IF rec."File Name" <> '' THEN
                    //         HYPERLINK(InvSetup."Writ Case Read Path" + rec."File Name");
                    //     HYPERLINK(rec."File Name");

                    // end;
                }
                field("Document Type"; rec."Legal File Type")
                {
                }
                // field("Created User Name"; rec."Created User Name")
                // {
                //     Caption = 'Attached By';
                // }

                field("Created By User ID"; Rec."Created By User ID")
                {
                    Caption = 'Attached By';


                }

                field(Attachment; AttachDoc)
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        recFiredire.GET;
                        IF Rec."File Name" <> '' THEN
                            //  Hyperlink('file:///F:/Published_APP/LegalFL0014_1000_S_27%20Supreme%20court%20decisions_0.pdf');
                            //Hyperlink(recFiredire."Writ Case Read Path" + Rec."File Name");
                            Hyperlink(recFiredire."Writ Case Read Path" + Rec."File Name");

                    end;



                }


            }
        }


    }





    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        IF Rec."File Name" <> '' THEN
            AttachDoc := Text001
        ELSE
            AttachDoc := '';


    end;

    var
        InvSetup: Record "Inventory Setup";

        recFiredire: Record 50083;
        OldFileName: Text;
        ServerFileName: Text;

        AttachDoc: Text[30];
        Text001: Label 'View';

    procedure SuppDocExist(DocNo: Code[20]) EntryExist: Boolean
    begin
        rec.SETRANGE("Document No.", DocNo);
        EntryExist := NOT rec.ISEMPTY;
        CurrPage.UPDATE(FALSE);
    end;
}

