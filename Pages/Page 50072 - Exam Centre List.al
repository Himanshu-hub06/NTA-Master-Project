page 50072 "Exam Centre List"
{
    ApplicationArea = All;
    Caption = 'Exam Centre List';
    PageType = List;
    SourceTable = "Exam Master";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Exam ID"; Rec."Exam ID")
                {
                    ToolTip = 'Specifies the value of the Exam ID field.';
                    ApplicationArea = All;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ToolTip = 'Specifies the value of the Exam Code field.';
                    ApplicationArea = All;
                }

                field("Exam Name"; Rec."Exam Name")
                {
                    ToolTip = 'Specifies the value of the Exam Name field.';
                    ApplicationArea = All;
                }
                field(Exam_Mode; Rec.Exam_Mode)
                {
                    ToolTip = 'Specifies the value of the Exam_Mode field.';
                    ApplicationArea = All;
                }
                field(IsActive; Rec.IsActive)
                {
                    ToolTip = 'Specifies the value of the IsActive field.';
                    ApplicationArea = All;
                }
                field("Last Modified on"; Rec."Last Modified on")
                {
                    ToolTip = 'Specifies the value of the Last Modified on field.';
                    ApplicationArea = All;
                }
                field(Occurance; Rec.Occurance)
                {
                    ToolTip = 'Specifies the value of the Occurance field.';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    ApplicationArea = All;
                }

                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = All;
                }
                field(Total_Candidate; Rec.Total_Candidate)
                {
                    ToolTip = 'Specifies the value of the Total_Candidate field.';
                    ApplicationArea = All;
                }
                field(Total_Centre_D_Superintendent; Rec.Total_Centre_D_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Centre_Deputy_Superintendent field.';
                    ApplicationArea = All;
                }
                field(Total_Centre_Superintendent; Rec.Total_Centre_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Centre_Superintendent field.';
                    ApplicationArea = All;
                }
                field(Total_City_Coordinator; Rec.Total_City_Coordinator)
                {
                    ToolTip = 'Specifies the value of the Total_City_Coordinator field.';
                    ApplicationArea = All;
                }
                field(Total_Deputy_Inde_Observer; Rec.Total_Deputy_Inde_Observer)
                {
                    ToolTip = 'Specifies the value of the Total_Deputy_Inde_Observer field.';
                    ApplicationArea = All;
                }
                field(Total_Deputy_Superintendent; Rec.Total_Deputy_Superintendent)
                {
                    ToolTip = 'Specifies the value of the Total_Deputy_Superintendent field.';
                    ApplicationArea = All;
                }
                field(Total_Invigilator; Rec.Total_Invigilator)
                {
                    ToolTip = 'Specifies the value of the Total_Invigilator field.';
                    ApplicationArea = All;
                }
                field(Total_flying_Squad; Rec.Total_flying_Squad)
                {
                    ToolTip = 'Specifies the value of the Total_flying_Squad field.';
                    ApplicationArea = All;
                }
                field(UploadFile; Rec.UploadFile)
                {
                    ToolTip = 'Specifies the value of the UploadFile field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
