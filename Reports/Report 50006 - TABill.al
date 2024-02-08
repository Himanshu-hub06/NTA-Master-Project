report 50006 "TA Bill"
{
    ApplicationArea = All;
    Caption = 'TA Bill';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/TA Bill.rdl';
    dataset
    {
        dataitem(TABillHeader; 50005)
        {
            DataItemTableView = SORTING("Reference No", Exam_Mode, "Exam Date", Submitted)
                               ORDER(Ascending);
            RequestFilterFields = "Bill ID", "Exam Name", "Exam_Mode", "Reference No";

            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(PIC; CompanyInfo.Picture)
            {
            }
            column(AddressForCommunication; "Address For Communication")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(Approved_Date; Approved_Date)
            {
            }
            column(Approved_Time; Approved_Time)
            {
            }
            column(Approved_User_ID; Approved_User_ID)
            {
            }
            column(Approved_User_Name; Approved_User_Name)
            {
            }
            column(Bank_Account_No; Bank_Account_No)
            {
            }
            column(Bank_Branch_Name; Bank_Branch_Name)
            {
            }
            column(BillID; "Bill ID")
            {
            }
            column(BillStatus; "Bill Status")
            {
            }
            column(BillType; BillType)
            {
            }
            column(ClaimedAmount; "Claimed Amount")
            {
            }
            column(ContactNo; "Contact No")
            {
            }
            column(CreatedTime; "Created Time")
            {
            }
            column(CreatedUser; "Created User")
            {
            }
            column(CreatedDate; CreatedDate)
            {
            }
            column(DailyAllowanceTotal; DailyAllowanceTotal)
            {
            }
            column(Designation; Designation)
            {
            }
            column(ExamCode; "Exam Code")
            {
            }
            column(ExamDate; "Exam Date")
            {
            }
            column(ExamName; "Exam Name")
            {
            }
            column(Exam_ID; Exam_ID)
            {
            }
            column(Exam_Mode; Exam_Mode)
            {
            }
            column(FirstLevelUser; "First Level User")
            {
            }
            column(HotelFoodAllowanceTotal; HotelFoodAllowanceTotal)
            {
            }
            column(IFSCCode; "IFSC Code")
            {
            }
            column(IP; IP)
            {
            }
            column(LastModifiedon; "Last Modified on")
            {
            }
            column(Latitude; Latitude)
            {
            }
            column(Longitude; Longitude)
            {
            }
            column(Modification_Remark; Modification_Remark)
            {
            }
            column(NTAUniqueID; "NTA Unique ID")
            {
            }
            column(OutStationAllowanceTotal; OutStationAllowanceTotal)
            {
            }
            column(PAN_N0; PAN_N0)
            {
            }
            column(Pending_User_Id; Pending_User_Id)
            {
            }
            column(Pending_User_Name; Pending_User_Name)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ReceiverUserName; "Receiver User Name")
            {
            }
            column(Receiver_ID; Receiver_ID)
            {
            }
            column(ReferenceNo; "Reference No")
            {
            }
            column(Rejected_Date; Rejected_Date)
            {
            }
            column(Rejected_Time; Rejected_Time)
            {
            }
            column(Rejected_User_Id; Rejected_User_Id)
            {
            }
            column(Rejected_user_Name; Rejected_user_Name)
            {
            }
            column(RejectionRemark; "Rejection Remark")
            {
            }
            column(Remark; Remark)
            {
            }
            column(RemunerationAmount; "Remuneration Amount")
            {
            }
            column(RemunerationDays; "Remuneration Days")
            {
            }
            column(RemunerationRate; "Remuneration Rate")
            {
            }
            column(RequesterName; "Requester Name")
            {
            }
            column(RoleID; "Role ID")
            {
            }
            column(Sender_ID; Sender_ID)
            {
            }
            column(Sender_User_ID; Sender_User_ID)
            {
            }
            column(Sending_Date; Sending_Date)
            {
            }
            column(Sending_Time; Sending_Time)
            {
            }
            column(Sending_User_Name; Sending_User_Name)
            {
            }
            column(Status; Status)
            {
            }
            column(Submitted; Submitted)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TDSAmount; "TDS Amount")
            {
            }
            column(TDSPercent; "TDS Percent")
            {
            }
            column(TotalAmountHotel; "Total Amount Hotel")
            {
            }
            column(TotalAmountLocal; "Total Amount Local")
            {
            }
            column(TotalAmountOutstation; "Total Amount Outstation")
            {
            }
            dataitem("TA Bill Hotel"; 50006)
            {
                DataItemLink = "Hotel DA ID" = FIELD("Bill id");
                RequestFilterFields = "Bill ID";

                column(Hotel_DA_ID; "Hotel DA ID")
                {
                }
                column(Bill_ID; "Bill ID")
                {
                }
                column(Hotel_Name___Address; "Hotel Name & Address")
                {
                }
                column(No_of_Days; "No of Days")
                {
                }
                column(Hotel_Bill_No; "Hotel Bill No")
                {
                }
                column(Hotel_Bill_Date; "Hotel Bill Date")
                {
                }
                column(Room_Rent; "Room Rent")
                {
                }
                column(Food_Charges; "Food Charges")
                {
                }
                column(Total_Amount; "Total Amount")
                {
                }
                column(Last_Modified_on; "Last Modified on")
                {
                }
                column(File_Path; "File Path")
                {
                }
                column(Approved_Amount; "Approved Amount")
                {
                }
                column(From_Date; "From Date")
                {
                }
                column(To_Date; "To Date")
                {
                }

                dataitem("TA Bill Local"; 50007)
                {
                    DataItemLink = "Local Journey ID" = field("Hotel DA ID");

                    RequestFilterFields = "Local Journey ID", "Receipt No";

                    column(Local_Journey_ID; "Local Journey ID")
                    {

                    }
                    column(Journey_Date; "Journey Date")
                    {

                    }
                    column(Journey_Remarks; "Journey Remarks")
                    {

                    }
                    column(Departure_Time; "Departure Time")
                    {

                    }
                    column(Departure_From; "Departure From")
                    {

                    }
                    column(Arrival_Time; "Arrival Time")
                    {

                    }
                    column(Arrival_To; "Arrival To")
                    {

                    }
                    column(Mode_Of_Journey; "Mode Of Journey")
                    {

                    }
                    column(Receipt_No; "Receipt No")
                    {

                    }
                    column(Distance_Of_Journey; "Distance Of Journey")
                    {

                    }
                    column(Amount; Amount)
                    {
                    }

                    dataitem("TA Bill Outstation"; 50008)
                    {
                        DataItemLink = "Outstation ID" = field("Local Journey ID");
                        RequestFilterFields = "Outstation ID";
                        column(Outstation_ID; "Outstation ID")
                        {

                        }
                        column(Departure_Date; "Departure Date")
                        {

                        }
                        column(Arrival_Date; "Arrival Date")
                        {

                        }

                    }
                }

            }
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(option)
                {

                }
            }
        }
        actions
        {
            area(processing)
            {

            }
        }
    }

    trigger OnPreReport()
    var

    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;



    var
        Companyinfo: Record 79;
}
