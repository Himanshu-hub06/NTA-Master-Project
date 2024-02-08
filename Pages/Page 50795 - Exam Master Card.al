page 50766 "Exam Master Card"
{
    ApplicationArea = All;
    Caption = 'Exam Master Card';
    PageType = Card;
    SourceTable = "Exam Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                // field("End Date"; Rec."End Date")
                // {
                //     ToolTip = 'Specifies the value of the End Date field.';
                // }
                field("Exam Code"; Rec."Exam Code")
                {
                    ToolTip = 'Specifies the value of the Exam Code field.';
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
                field(IsActive; Rec.IsActive)
                {
                    ToolTip = 'Specifies the value of the IsActive field.';
                }
                field("Last Modified on"; Rec."Last Modified on")
                {
                    ToolTip = 'Specifies the value of the Last Modified on field.';
                }
                field(Occurance; Rec.Occurance)
                {
                    ToolTip = 'Specifies the value of the Occurance field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {

                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(Total_Candidate; Rec.Total_Candidate)
                {
                    ToolTip = 'Specifies the value of the Total_Candidate field.';
                }
                field(Total_Centre_D_Superintendent; Rec.Total_Centre_D_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Centre_Deputy_Superintendent field.';
                }
                field(Total_Centre_Superintendent; Rec.Total_Centre_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Centre_Superintendent field.';
                }
                field(Total_City_Coordinator; Rec.Total_City_Coordinator)
                {
                    ToolTip = 'Specifies the value of the Total_City_Coordinator field.';
                }
                field(Total_Deputy_Inde_Observer; Rec.Total_Deputy_Inde_Observer)
                {
                    ToolTip = 'Specifies the value of the Total_Deputy_Inde_Observer field.';
                }
                field(Total_Deputy_Superintendent; Rec.Total_Deputy_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Deputy_Superintendent field.';
                }
                field(Total_Invigilator; Rec.Total_Invigilator)
                {
                    ToolTip = 'Specifies the value of the Total_Invigilator field.';
                }
                field(Total_flying_Squad; Rec.Total_flying_Squad)
                {
                    ToolTip = 'Specifies the value of the Total_flying_Squad field.';
                }
                field(UploadFile; Rec.UploadFile)
                {
                    ToolTip = 'Specifies the value of the UploadFile field.';
                }
            }
        }
    }
}
