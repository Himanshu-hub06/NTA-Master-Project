// report 50131 "Legal Note Sheet"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Legal Note Sheet.rdlc';

//     dataset
//     {
//         dataitem("Legal Comment Line"; "Legal Comment Line")
//         {
//             DataItemTableView = SORTING("Entry No.", "Document No.")
//                                 ORDER(Ascending);
//             RequestFilterFields = "Document No.";
//             // column(EntryNo_LegalCommentLine; rec."Legal Comment Line"."Entry No.")
//             // {
//             // }
//             column(Entry_No_; "Entry No.")
//             {

//             }

//             column(UserDescription_LegalCommentLine; "Legal Comment Line"."User Description")
//             {
//             }
//             column(DateandTime_LegalCommentLine; "Legal Comment Line"."Date and Time")
//             {
//             }
//             column(Nsheet; Nsheet)
//             {
//             }
//             column(User_FullName; "Legal Comment Line"."User Description")
//             {
//             }
//             // column(User_Designation;"Legal Comment Line".)
//             // {
//             // }
//             column(Sno; Sno)
//             {
//             }
//             column(Company_Picture; CompanyInfo.Picture)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 Sno := Sno + 1;
//                 CALCFIELDS("Note Sheet", "User Description", "User Designation");
//                 IF "Note Sheet".HASVALUE THEN BEGIN
//                     "Note Sheet".CREATEINSTREAM(InStr, TEXTENCODING::UTF16);
//                     InStr.READ(Nsheet);
//                 END;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         CompanyInfo.GET;
//         CompanyInfo.CALCFIELDS(Picture);
//     end;

//     var
//         //UserTab: Record "2000000120";
//         CompanyInfo: Record "Company Information";
//         Nsheet: Text;
//         InStr: InStream;
//         Sno: Integer;
// }

