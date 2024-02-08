page 50799 "Meeting RoleCenter"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 50285;

    layout
    {
        area(RoleCenter)
        {
            group(group1)
            {
                part(part1; 50800)
                {
                    ApplicationArea = All;
                }


            }
        }
    }


}
profile MeetingStatus
{
    ProfileDescription = 'RoleCenter';
    RoleCenter = "Meeting RoleCenter";
    Caption = 'Committee Cell Managment';
}