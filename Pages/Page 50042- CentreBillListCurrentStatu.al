page 50042 "CentreBill List Current Statu"
{
    ApplicationArea = All;
    Caption = 'CentreBill List Current Status';
    PageType = List;
    Editable = false;
    SourceTable = "Centre Bill Header";
    UsageCategory = Lists;
    //Editable = false;

    SourceTableView = SORTING()
                        ORDER(Ascending)
                        WHERE(Submitted = CONST(true),
                              Status = FILTER(<> Approved));


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }

                field(Status; Rec.Status)
                {

                }
                field(Receiver_ID; Rec.Receiver_ID)
                {
                    ToolTip = 'Specifies the value of the Receiver ID field.';
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ToolTip = 'Specifies the value of the Exam Code field.';
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ToolTip = 'Specifies the value of the Exam Date field.';
                }
                field("Exam ID"; Rec."Exam ID")
                {
                    ToolTip = 'Specifies the value of the Exam ID field.';
                }
                field("Exam Name"; Rec."Exam Name")
                {
                    ToolTip = 'Specifies the value of the Exam Name field.';
                }
                field(Exam_Mode; Rec.Exam_Mode)
                {
                    ToolTip = 'Specifies the value of the Exam_Mode field.';
                }

                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                }
                field("CentreBill ID"; Rec."CentreBill ID")
                {
                    ToolTip = 'Specifies the value of the CentreBill ID field.';
                }
                field(Longitude; Rec.Longitude)
                {
                    ToolTip = 'Specifies the value of the Longitude field.';
                }
                field("Net Payble Amount"; Rec."Net Payble Amount")
                {
                    ToolTip = 'Specifies the value of the Net Payble Amount field.';
                }
                field("Total Approved Amount"; Rec."Total Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Total Approved Amount field.';
                }
                field(Rejected_Date; Rec.Rejected_Date)
                {
                    ToolTip = 'Specifies the value of the Rejected Date field.';
                }
                field(Rejected_Time; Rec.Rejected_Time)
                {
                    ToolTip = 'Specifies the value of the Rejected Time field.';
                }
                field(Rejected_User_Id; Rec.Rejected_User_Id)
                {
                    ToolTip = 'Specifies the value of the Rejected User Id field.';
                }
                field(Rejected_user_Name; Rec.Rejected_user_Name)
                {
                    ToolTip = 'Specifies the value of the Rejected user Name field.';
                }
                field("Centre City"; Rec."Centre City")
                {
                    ToolTip = 'Specifies the value of the Centre City field.';
                }
                field("Centre Address"; Rec."Centre Address")
                {
                    ToolTip = 'Specifies the value of the Centre Address field.';
                }
                field("Centre No."; Rec."Centre No.")
                {
                    ToolTip = 'Specifies the value of the Centre No. field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No field.';
                }
            }
        }
    }
}
