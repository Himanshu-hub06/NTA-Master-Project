report 50184 "Legal Note Sheet"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Legal Note Sheet.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 50213)
        {
            DataItemTableView = SORTING("Entry No.", "Document No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";
            // column(EntryNo_LegalCommentLine; "Legal Comment Line"."Entry No.")
            // {
            // }
            column(Entry_No_; "Entry No.")
            {

            }

            // column(UserDescription_LegalCommentLine; "Legal Comment Line"."User Description")
            // {
            // }
            column(User_Description; "User Description")
            {

            }
            // column(DateandTime_LegalCommentLine; "Legal Comment Line"."Date and Time")
            // {
            // }
            column(Date_and_Time; "Date and Time")
            {

            }
            // column(Nsheet; Nsheet)
            // {
            // }

            column(Note_Sheet; "Note Sheet")
            {

            }
            // column(User_FullName; "Legal Comment Line"."User Description")
            // {
            // }
            column(User_ID; "User ID")
            { }
            // column(User_Designation; "Legal Comment Line"."User Designation")
            // {
            // }

            column(User_Designation; "User Designation")
            {

            }
            column(Sno; Sno)
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sno := Sno + 1;
                CALCFIELDS("Note Sheet", "User Description", "User Designation");
                IF "Note Sheet".HASVALUE THEN BEGIN
                    "Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
                    InStr.READ(Nsheet);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        UserTab: Record "User BOC";
        CompanyInfo: Record 79;
        Nsheet: Text;
        InStr: InStream;
        Sno: Integer;
}

