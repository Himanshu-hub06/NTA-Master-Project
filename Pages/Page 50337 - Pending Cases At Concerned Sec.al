page 50337 "Pending Cases At Concerned Sec"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Writ/Case Header";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; REC."File No.")
                {
                    Width = 12;
                }
                field("Case Type"; REC."Case Type")
                {
                }
                field("Case No."; REC."Case No.")
                {
                }
                field("Name Of Petitioner"; REC."Name Of Petitioner")
                {
                }
                field("Section Name"; REC."Section Name")
                {
                }
                field("Sent By To Concern Section"; REC."Sent User Name")
                {
                    Enabled = false;
                }
                field("Current User ID"; REC."User Assigned")
                {
                }
                field("Current User Name"; REC."Assigned User Name")
                {
                    Enabled = false;
                }
            }
            group("Count Filter")
            {
                Caption = '*';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = true;
                field(COUNT; REC.COUNT)
                {
                    Caption = 'Total No. Of Records';
                    ColumnSpan = 3;
                    Editable = false;
                    Enabled = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("File Outward")
            {
                Caption = 'File Movement Status';
                Image = OrderList;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    FileMovEntry: Record "File Movement Entry";
                begin
                    FileMovEntry.RESET;
                    FileMovEntry.FILTERGROUP(2);
                    FileMovEntry.SETRANGE("Document Type", FileMovEntry."Document Type"::Legal);
                    FileMovEntry.SETRANGE("Document No.", REC."File No.");
                    FileMovEntry.FILTERGROUP(0);
                    IF FileMovEntry.FIND('-') THEN
                        PAGE.RUN(PAGE::"Legal File In-Out List", FileMovEntry)
                    ELSE
                        MESSAGE('Details not found');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        REC.SETRANGE("Sent By At Concern Section", USERID);
        REC.SETRANGE("At Concern Section", TRUE);
    end;

    var
        WritCaseHdr: Record "Writ/Case Header";
        "CaseNo.": Text;
        Year: Integer;
        CaseType: Text;
}

