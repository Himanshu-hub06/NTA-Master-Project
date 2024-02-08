page 50110 "NTA Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = all;


    layout
    {


        area(rolecenter)
        {

            group(GRP00)
            {

                // part("Store Activities"; "Store Activities")
                part("NTA Activities"; 50038)
                {
                    Caption = '';
                    Visible = true;
                    ApplicationArea = All;
                }

            }

        }
    }

    actions
    {
        area(sections)
        {
            group("TA Bill Processing")
            {
                Caption = 'TA Bill Processing';
                Image = ResourcePlanning;
                ToolTip = 'To Process the TA Bills Send for Approval .', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                group(TABILLS)
                {
                    Caption = 'TA Bill';
                    // action("Approval Request-TA Bills")
                    // {
                    //     Caption = 'Approval Request-TA Bills';
                    //     ApplicationArea = All;
                    //     RunObject = Page 50005;
                    //     RunPageView = SORTING("Bill ID")
                    //                ORDER(Ascending)
                    //                WHERE(Status = FILTER("CC Approved" | "RC Approved" | "Pending Approval"));
                    // }
                    action(Pending)
                    {
                        Caption = 'Pending For Approval';
                        ApplicationArea = All;
                        RunObject = Page 50005;
                        RunPageView = where(Status = filter("Pending Approval" | "CC Approved" | "RC Approved"));
                    }
                    action(Approved)
                    {
                        Caption = 'Approved Bills';
                        ApplicationArea = All;
                        RunObject = Page 50819;
                        //RunPageView = where(Status = filter(Approved));
                    }
                    action(Rejected)
                    {
                        Caption = 'Rejected Bills';
                        ApplicationArea = All;
                        RunObject = Page 50817;
                        //RunPageView = where(Status = filter(Rejected));
                    }
                    action(Disbursement)
                    {
                        Caption = 'Pending For Disbusrment';
                        ApplicationArea = All;
                        RunObject = Page 50816;
                        //RunPageView = where(Status = filter('Disbursement Pending'));
                    }

                    action("TA BILL Status")
                    {
                        Caption = 'Disbursement';
                        ApplicationArea = All;
                        RunObject = Page 50816;
                        //RunPageView = where(Status = filter('Disbursement Pending'));
                    }
                }


            }

            group("Centre Bill Processing")

            {
                Caption = 'Centre Bill Processing';
                Image = ResourcePlanning;
                ToolTip = 'To Process the Centre Bill Send for Approval .', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
                group(CentreBill)
                {
                    Caption = 'Centre Bill';

                    action("Approval Request-Centre Bills")
                    {
                        Caption = 'Approval Request-Centre Bills';
                        RunObject = Page 50002;
                        RunPageView = SORTING("CentreBill ID")
                                   ORDER(Ascending)
                                   WHERE(Status = FILTER("CC Approved" | "RC Approved" | "Pending Approval"));
                    }
                    action("Centre Pending")
                    {
                        Caption = 'Pending For Approval';
                        ApplicationArea = All;
                        RunObject = Page 50002;
                        RunPageView = where(Status = filter("Pending Approval"));
                    }
                    action("Centre Approved")
                    {
                        Caption = 'Approved Bills';
                        ApplicationArea = All;
                        RunObject = Page 50002;
                        RunPageView = where(Status = filter(Approved));
                    }
                    action("Centre Rejected")
                    {
                        Caption = 'Rejected Bills';
                        ApplicationArea = All;
                        RunObject = Page 50002;
                        RunPageView = where(Status = filter(Rejected));
                    }
                    action(CentreDisbursement)
                    {
                        Caption = 'Pending For Disbusrment';
                        ApplicationArea = All;
                        RunObject = Page 50002;
                        RunPageView = where(Status = filter("Disbursement Pending"));
                    }


                }



            }

            // group("Approval Status")
            // {

            //     Caption = 'Approval Status';
            //     Image = ResourcePlanning;
            //     ToolTip = 'To Check the Approval Status of Bills for Approvals .', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;


            //     action("Approval Status-  Centre Bills")
            //     {
            //         ApplicationArea = all;
            //         Caption = 'Approval Status-  Centre Bills';
            //         RunObject = Page 50042;
            //     }

            //     action("Approval Status- TA Bills")
            //     {
            //         Caption = 'Approval Status- TA Bills';

            //         ApplicationArea = all;
            //         RunObject = Page 50043;
            //     }
            // }

            // group("Rejected Bills")
            // {
            //     Caption = 'Rejected Bills';
            //     ToolTip = 'To Check the List of Rejected Bills for Approvals .', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
            //     action("Rejected TA Bills")
            //     {
            //         Caption = 'Rejected TA Bills';
            //         ToolTip = 'To Check the List of Rejected Bills.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
            //         ApplicationArea = all;
            //         RunObject = Page 50043;
            //         RunPageView = WHERE(Status = FILTER('Rejected'));
            //     }

            //     action("Rejected-Centre Bills")
            //     {
            //         Caption = 'Rejected-Centre Bills';

            //         RunObject = Page 50002;
            //         //Style = Unfavorable;

            //         RunPageView = SORTING("CentreBill ID")
            //                        ORDER(Ascending)
            //                        WHERE(Status = FILTER("Rejected"));
            //     }

            // }

            // group("Approved Bill")
            // {
            //     Caption = 'Approved Bill';
            //     ToolTip = 'To Check the List of Approved Bills.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
            //     action("Approved Bill TA Bills")
            //     {
            //         Caption = 'Approved Bill TA Bills';
            //         ToolTip = 'To Check the List of Approved Bills.', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 100;
            //         ApplicationArea = all;
            //         RunObject = Page 50022;
            //         RunPageView = WHERE(Status = FILTER('Approved'));
            //     }

            //     action("Approved-Centre Bills")
            //     {
            //         Caption = 'Approved-Centre Bills';

            //         RunObject = Page 50019;
            //         //Style = Unfavorable;

            //         RunPageView = SORTING("CentreBill ID")
            //                        ORDER(Ascending)
            //                        WHERE(Status = FILTER("Approved"));
            //     }

            //     action("Approved-Centre Bills for Dispershal")
            //     {
            //         Caption = 'Approved-Centre Bills';

            //         RunObject = Page 50002;
            //         //Style = Unfavorable;

            //         RunPageView = SORTING("CentreBill ID")
            //                        ORDER(Ascending)
            //                        WHERE(Status = FILTER("Disbursement Pending"));
            //     }

            //     action("Approved-TA Bill for Dispershal")
            //     {
            //         Caption = 'Approved-TA Bill for Dispershal';

            //         RunObject = Page 50043;
            //         //Style = Unfavorable;
            //         RunPageView = WHERE(Status = FILTER('Disbursement Pending'));
            //     }
            // }

            group(Setup11)//Rashmi19-07-2023
            {
                Caption = 'Setup';
                Image = ResourcePlanning;
                action(Users)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Users';
                    RunObject = Page "NTA User List";
                }

                action("User Password111")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Change Password';
                    Image = EncryptionKeys;
                    RunObject = codeunit "Change Password";
                }
                action("NTA Approval Setup")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'NTA Approval Setup';
                    RunObject = Page "Approval User Groups";
                }
                action("NTA Set-up")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'NTA Set-up';
                    RunObject = Page 50149;
                    RunPageView = WHERE(Department = CONST('NTA Bill'));
                }

                action("Exam Master Card")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Exam Master ';
                    RunObject = Page 50072;
                }
                action("ERP Master List")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'ERP Master ';
                    RunObject = Page 50073;
                }

            }
            group(REPORTS)
            {
                Caption = 'Reports';
                Image = ResourcePlanning;
                action("Center Bill")
                {
                    ApplicationArea = All;
                    Caption = 'CENTER BILL REPORT';
                    RunObject = Report 50005;
                }
                action("TA BILL")
                {
                    ApplicationArea = All;
                    Caption = 'TA BILL REPORT';
                    RunObject = Report 50006;
                }
            }
            group("Admin Activity")
            {
                action("TA Bill Edit")
                {
                    ApplicationArea = all;
                    Caption = 'TA Bill Edit';
                    RunObject = page 50820;
                }
                action("Central bill Edit")
                {
                    ApplicationArea = all;
                    Caption = 'Central bill Edit';
                    RunObject = page 50821;
                }
            }


        }

        area(Processing)
        {
            // action("Item_Journal")
            //  {
            //     ApplicationArea = All;
            //   Caption = 'Item Journal';
            //     RunObject = Page 40;
            //  }
            // action(Notification)

            // {
            //     ApplicationArea = All;
            //     RunObject = Page 50192;

            //     Image = ReceiptReminder;

            // }



            //     layout
            //     {
            //         area(rolecenter)
            //         {
            //             group(General)
            //             {
            //                 part("NTA Activities"; 50038)
            //                 {
            //                     Visible = True;

            //                 }
            //             }
            //             group(Report)
            //             {
            //                 chartpart("T36-08"; "T36-08")
            //                 {
            //                     //Editable = true;
            //                     Visible = TRUE;
            //                 }
            //                 part("Job Queue"; "My Job Queue")
            //                 {
            //                     Visible = false;
            //                 }
            //                 systempart(Notes; MyNotes)
            //                 {
            //                 }
            //             }
            //         }
            //     }

            //     actions
            //     {
            //         area(sections)
            //         {


            //             group("TA Bill Processing")
            //             {
            //                 //Caption = 'Centre Bill- Processing';
            //                 Caption = 'TA Bill Processing', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 150;
            //                 Image = ResourcePlanning;
            //                 Visible = true;

            //                 action("Approval Request-TA Bills")

            //                 {
            //                     Caption = 'Approval Request-Centre Bills';
            //                     ApplicationArea = All;
            //                     RunObject = Page 50005;
            //                     RunPageView = SORTING("Bill ID")
            //                                    ORDER(Ascending)
            //                                    WHERE(Status = FILTER("CC Approved" | "RC Approved" | "Pending Approval"));


            //                 }

            //                 action("Approval Status- TA Bills")
            //                 {
            //                     Caption = 'Approval Status- TA Bills';
            //                     ApplicationArea = all;
            //                     RunObject = Page 50043;



            //                 }
            //                 action("Reject TA Bills")
            //                 {
            //                     ApplicationArea = all;
            //                     RunObject = Page 50043;
            //                     RunPageView = WHERE(Status = FILTER('Rejected'));
            //                 }
            //                 action("Rejected-TA Bills")
            //                 {
            //                     Caption = 'Rejected-Centre TA Bills';
            //                     ApplicationArea = all;
            //                     RunObject = Page 50043;
            //                     RunPageView = SORTING("Bill ID")
            //                                    ORDER(Ascending)
            //                                    WHERE(Status = FILTER("Rejected"));
            //                 }


            //             }


            //             group("Centre Bill Processing")
            //             {
            //                 //Caption = 'Centre Bill- Processing';
            //                 Caption = 'Centre Bill Processing', Locked = true, Comment = 'Keep like this, do not translate.', MaxLength = 150;
            //                 Image = ResourcePlanning;
            //                 Visible = true;

            //                 action("Approval Request-Centre Bills")
            //                 {
            //                     Caption = 'Approval Request-Centre Bills';
            //                     RunObject = Page 50002;
            //                     RunPageView = SORTING("CentreBill ID")
            //                                    ORDER(Ascending)
            //                                    WHERE(Status = FILTER("CC Approved" | "RC Approved"));


            //                 }

            //                 action("Approval Status-  Centre Bills")
            //                 {
            //                     ApplicationArea = all;
            //                     Caption = 'Approval Status-  Centre Bills';
            //                     RunObject = Page 50042;



            //                 }


            //                 action("Rejected-Centre Bills")
            //                 {
            //                     Caption = 'Rejected-Centre Bills';
            //                     RunObject = Page 50002;
            //                     //Style = Unfavorable;

            //                     RunPageView = SORTING("CentreBill ID")
            //                                    ORDER(Ascending)
            //                                    WHERE(Status = FILTER("Rejected"));
            //                 }

            //                 action("Approved-Centre Bills")
            //                 {
            //                     Caption = 'Rejected-Centre Bills';
            //                     RunObject = Page 50042;

            //                     RunPageView = SORTING("CentreBill ID")
            //                                    ORDER(Ascending)
            //                                    WHERE(Status = FILTER("Approved"));
            //                 }
            //             }

            //             group(Setup11)//Rashmi19-07-2023
            //             {
            //                 Caption = 'Setup';
            //                 Image = ResourcePlanning;
            //                 action(Users)
            //                 {
            //                     ApplicationArea = RelationshipMgmt;
            //                     Caption = 'Users';
            //                     RunObject = Page "NTA User List";
            //                 }

            //                 action("User Password111")
            //                 {
            //                     ApplicationArea = RelationshipMgmt;
            //                     Caption = 'Change Password';
            //                     Image = EncryptionKeys;
            //                     RunObject = codeunit "Change Password";
            //                 }
            //                 action("NTA Approval Setup")
            //                 {
            //                     ApplicationArea = RelationshipMgmt;
            //                     Caption = 'NTA Approval Setup';
            //                     RunObject = Page "Approval User Groups";
            //                 }
            //                 action("NTA Set-up")
            //                 {
            //                     ApplicationArea = RelationshipMgmt;
            //                     Caption = 'NTA Set-up';
            //                     RunObject = Page 50149;
            //                     RunPageView = WHERE(Department = CONST('NTA Bill'));
            //                 }





            //             }

            //         }
            //         area(embedding)
            //         {
            //             // action("Centre Bill - Open")
            //             // {
            //             //     Caption = 'Centre Bill - Open';
            //             //     RunObject = Page 50027;
            //             //     RunPageView = SORTING("CentreBill ID")
            //             //                   ORDER(Ascending)
            //             //                   WHERE(Status=CONST(Open));
            //             // }
            //             // action("Centre Bill- Pending Approval")
            //             // {
            //             //     Caption = 'Centre Bill- Pending Approval';
            //             //     RunObject = Page 654;
            //             //     RunPageView = WHERE(Bill Type=FILTER("Centre Bill"));
            //             // }
            //             // action("Centre Bill-Approved")
            //             // {
            //             //     Caption = 'Centre Bill-Approved';
            //             //     RunObject = Page 50002;
            //             //     RunPageView = SORTING(CentreBill ID)
            //             //                   ORDER(Ascending)
            //             //                   WHERE(Status=FILTER("RC Approved"));
            //             //}
            //             // action("Centre TA/DA Bill Submission Statusill-Rejected")
            //             // {
            //             //     Caption = 'Centre Bill-Rejected';
            //             //     RunObject = Page 50002;
            //             //     RunPageView = SORTING(CentreBill ID)
            //             //                   ORDER(Ascending)
            //             //                   WHERE(Status=FILTER("CC Rejected"));
            //             //}
            //             // action("TA/DA Bill - Open")
            //             // {
            //             //     Caption = 'TA/DA Bill - Open';
            //             //     RunObject = Page 50031;
            //             //     RunPageView = SORTING("Bill ID")
            //             //                   ORDER(Ascending)
            //             //                   WHERE(Status = FILTER(Open));
            //             // }
            //             // action("TA/DA Bill - Pending Approval")
            //             // {
            //             //     Caption = 'TA/DA Bill - Pending Approval';
            //             //     RunObject = Page 654;
            //             //     RunPageView = WHERE("Bill Type"=FILTER("TA/DA Bill"));
            //             // }
            //             // action("TA/DA Bill - Approved")
            //             // {
            //             //     Caption = 'TA/DA Bill - Approved';
            //             //     RunObject = Page 50040;
            //             // }
            //             // action("TA/DA Bill - Rejected")
            //             // {
            //             //     Caption = 'TA/DA Bill - Rejected';
            //             //     RunObject = Page 50042;
            //             //     Visible = false;
            //             // }
            //             // action("TA/DA Bill - Approval Status")
            //             // {
            //             //     Caption = 'TA/DA Bill - Approval Status';
            //             //     RunObject = Page 50043;
            //             // }
            //             // action("Centre Bill")
            //             // {
            //             //     Caption = 'Centre Bill Card';
            //             //     RunObject = Page 50003;
            //             //     RunPageView = SORTING("CentreBill ID")
            //             //                       ORDER(Ascending);
            //             //     // WHERE(Status = FILTER("Approved"));
            //             // }
            //             // action("TA/DA Bill - Final Approved")
            //             // {
            //             //     Caption = 'TA/DA Bill - Final Approved';
            //             //     RunObject = Page 50022;
            //             // }
            //             // action("TA/DA Bill - Rejected")
            //             // {
            //             //     Caption = 'TA/DA Bill - Rejected';
            //             //     RunObject = Page 50044;
            //             // }

            //             // action(Setup)
            //             // {
            //             //     Caption = 'Setup';
            //             //     RunObject = Page 50070;
            //             //     RunPageView = SORTING("P Code")
            //             //                   ORDER(Ascending)
            //             //                   WHERE(Department = filter('NTA'),
            //             //                         "Page Type" = CONST(Setup));
            //             // }
            //             // action(Reports)
            //             // {
            //             //     Caption = 'Reports';
            //             //     RunObject = Page 50071;
            //             //     RunPageView = WHERE(Department = filter('ACCOUNTS'));
            //             // }
            //         }
            //         // area(reporting)
            //         // {
            //         //     action("TA/DA Bill Submission Status")
            //         //     {
            //         //         Caption = 'TA/DA Bill Submission Status';
            //         //         Image = "Report";
            //         //         //Promoted = true;
            //         //         // PromotedCategory = "Report";
            //         //         RunObject = Report 50003;
            //         //     }
            //         // }
            //     }

            //     var
            //         EdtVis: Boolean;
        }
    }

}