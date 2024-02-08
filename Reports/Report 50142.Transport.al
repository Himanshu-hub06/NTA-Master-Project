report 50142 Transport
{
    ApplicationArea = All;
    Caption = 'Transport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/Transport.rdl';
    dataset
    {
        dataitem(TransportFleetLogMaster; "Transport/Fleet Log Master")
        {
            RequestFilterFields = "TF Code";
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(PIC; CompanyInfo.Picture)
            {
            }
            column(TFCode; "TF Code") { }
            column(TF_Time; "TF Time") { }
            column(TF_Date; "TF Date") { }
            column(Place_to_Visit; "Place to Visit") { }
            column(Journey_Type; "Journey Type") { }
            column(Requirement_Type; "Requirement Type") { }
            column(From_Date; "From Date") { }
            column(To_Date; "To Date") { }
            column(Start_Time; "Start Time") { }
            column(End_Time; "End Time") { }
            column(Name; Name) { }
            column(Designation; Designation) { }
            column(Purpose; Purpose) { }
            column(Remarks; Remarks) { }
            column(Transfer_User_ID; "Transfer User ID")
            {

            }
            dataitem(Vehicle; Vehicle)
            {
                DataItemLink = "Vehicle Code" = field("Vehicle Code");
                RequestFilterFields = "Vehicle No.";
                column(Vehicle_Color; "Vehicle Color") { }
                column(Vehicle_Code; "Vehicle Code") { }
                column(Vehicle_Name; "Vehicle Name") { }
                column(Vehicle_No_; "Vehicle No.") { }
                column(Vehicle_Type; "Vehicle Type") { }
                column(Vehicle_Registration_No_; "Vehicle Registration No.") { }
                column(Vehicle_Registration_Date; "Vehicle Registration Date") { }
                column(RC_Validity_Date; "RC Validity Date") { }
                column(Availability; Availability) { }
                column(Total__KM_; "Total (KM)") { }

            }
            dataitem(Driver; Driver)
            {
                DataItemLink = "Driver Code" = field("Driver Code");
                RequestFilterFields = "Driver Code";
                column(Driver_Name; "Driver Name")
                {
                }
                column(Driver_Code; "Driver Code") { }
                column(Contact_No_; "Contact No.") { }
                column(Email; Email) { }
                column(Address; Address) { }
                column(City; City) { }
                column(State; State) { }
                column(Pin_Code; "Pin Code") { }
                column(No__Series; "No. Series") { }
                column(State_Name; "State Name") { }
                column(Image; Image) { }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
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


