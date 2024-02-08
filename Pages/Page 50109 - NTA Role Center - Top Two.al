page 50109 "NTA Role Center - Top Two"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = all;

    layout
    {
        area(rolecenter)
        {
            group("Bills")
            {
                part("Center Bills"; 50038)
                {
                    Caption = 'Center Bills';
                    Visible = true;
                }
                part("TA/DA Bills"; 50039)
                {
                    Caption = 'TA/DA Bills';
                }
            }
            group("TA/Da")
            {
                systempart(MyNotes; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(sections)
        {
            group("Accounts & Finance")
            {
                Caption = 'Accounts & Finance';
                Image = ResourcePlanning;
                Visible = false;
                action("Centre Bill - Open")
                {
                    Caption = 'Centre Bill - Open';
                    RunObject = Page "Centre Bill open list";
                    RunPageView = SORTING("CentreBill ID")
                                  ORDER(Ascending)
                                  WHERE(Status = CONST(Open));
                }
                action("Requests to Approve")
                {
                    Caption = '';
                    RunObject = Page "Requests to Approve";
                    RunPageView = WHERE("Bill Type" = FILTER("Centre Bill"));
                }
                action("Centre Bill-Approved")
                {
                    Caption = 'Centre Bill-Approved';
                    RunObject = Page 50002;
                    RunPageView = SORTING("CentreBill ID")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER("Approved"));
                }
                action("Centre Bill-Rejected")
                {
                    Caption = 'Centre Bill-Rejected';
                    RunObject = Page 50002;
                    RunPageView = SORTING("CentreBill ID")
                                  ORDER(Ascending);
                    //WHERE(Status = FILTER(Rejected));
                }
                action("Centre Bill-Posted")
                {
                    Caption = 'Centre Bill-Posted';
                    RunObject = Page 50002;
                    RunPageView = SORTING("CentreBill ID")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Posted));
                }
                // action("TA/DA Bill - Open")
                // {
                //     Caption = 'TA/DA Bill - Open';
                //     RunObject = Page 50031;
                //     RunPageView = SORTING("Bill ID")
                //                   ORDER(Ascending)
                //                   WHERE(Status = FILTER(Open));
                // }
                action("TA/DA Bill - Pending Approval")
                {
                    Caption = 'TA/DA Bill - Pending Approval';
                    RunObject = Page "Requests to Approve";
                    RunPageView = WHERE("Bill Type" = FILTER("TA/DA Bill"));
                }
                action("TA/DA Bill - Approved")
                {
                    Caption = 'TA/DA Bill - Approved';
                    RunObject = Page "TA Bill List";

                    RunPageView = SORTING("Bill ID")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Approved));
                }
                action("TA/DA Bill - Rejected")
                {
                    Caption = 'TA/DA Bill - Rejected';
                    RunObject = Page 50005;
                    RunPageView = SORTING("Bill ID")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Rejected));
                }
                action("Payment Disbursement")
                {
                    Caption = 'Payment Disbursement';
                    Enabled = false;
                    RunObject = Page 50030;
                    RunPageMode = View;
                    RunPageOnRec = true;
                }
                action("Payment History")
                {
                    Caption = 'Payment History';
                    Enabled = false;
                    RunObject = Page 50034;
                    RunPageMode = View;
                }
                action(Setup)
                {
                    Caption = 'Setup';
                    RunObject = Page 50070;
                    RunPageView = SORTING("P Code")
                                  ORDER(Ascending)
                                  WHERE(Department = filter('NTA'),
                                        "Page Type" = CONST(Setup));
                }
            }
        }
        area(embedding)
        {
            // action("Centre Bill - Open")
            // {
            //     Caption = 'Centre Bill - Open';
            //     RunObject = Page 50027;
            //                     RunPageView = SORTING(CentreBill ID)
            //                   ORDER(Ascending)
            //                   WHERE(Status=CONST(Open));
            // }
            // action("")
            // {
            //     Caption = '';
            //     RunObject = Page 654;
            //                     RunPageView = WHERE(Bill Type=FILTER(Centre Bill));
            // }
            // action("Centre Bill-Approved")
            // {
            //     Caption = 'Centre Bill-Approved';
            //     RunObject = Page 50002;
            //                     RunPageView = SORTING(CentreBill ID)
            //                   ORDER(Ascending)
            //                   WHERE(Status=FILTER(Approved));
            // }
            // action("Centre Bill-Rejected")
            // {
            //     Caption = 'Centre Bill-Rejected';
            //     RunObject = Page 50002 ;
            //     {
            //                     RunPageView = SORTING(CentreBill ID)
            //                   ORDER(Ascending)
            //                   WHERE(Status=FILTER(Rejected));
            // }
            // action("TA/DA Bill - Open")
            // {
            //     Caption = 'TA/DA Bill - Open';
            //     RunObject = Page 50031;
            //     RunPageView = SORTING("Bill ID")
            //                   ORDER(Ascending)
            //                   WHERE(Status = FILTER(Open));
            // }
            // action("TA/DA Bill - Pending Approval")
            // {
            //     Caption = 'TA/DA Bill - Pending Approval';
            //     RunObject = Page 654;
            //                     RunPageView = WHERE(Bill Type=FILTER(TA/DA Bill));
            // }
            // action("TA/DA Bill - Approved")
            // {
            //     Caption = 'TA/DA Bill - Approved';
            //     RunObject = Page 50040;
            // }
            // action("TA/DA Bill - Rejected")
            // {
            //     Caption = 'TA/DA Bill - Rejected';
            //     RunObject = Page 50042;
            //                     Visible = false;
            // }
            action("TA/DA Bill - Final Approved")
            {
                Caption = 'TA/DA Bill - Final Approved';
                RunObject = Page 50022;
            }
            // action("TA/DA Bill - Rejected")
            // {
            //     Caption = 'TA/DA Bill - Rejected';
            //     RunObject  50044;
            // }
            // action("Payment Disbursement")
            // {
            //     Caption = 'Payment Disbursement';
            //     RunObject = Page "Approved Bills";
            //                     RunPageMode = Edit;
            //                     RunPageOnRec = true;
            // }
            // action("Payment History")
            // {
            //     Caption = 'Payment History';
            //     RunObject = Page "Paid Bill List";
            // }
            // action(Setup)
            // {
            //     Caption = 'Setup';
            //     RunObject = Page 50070;
            //                     RunPageView = SORTING(P Code)
            //                   ORDER(Ascending)
            //                   WHERE(Department=CONST(NTA),
            //                         Page Type=CONST(Setup));
            // }
        }
    }

    var
        EdtVis: Boolean;
}

