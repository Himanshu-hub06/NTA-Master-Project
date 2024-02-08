// report 50050 "Rate Update"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(DataItem1000000000;50059)
//         {
//             DataItemTableView = SORTING(NP Code);
//             RequestFilterHeading = 'no';

//             trigger OnAfterGetRecord()
//             begin
//                 NPRate.SETRANGE("NP Code","NP Code");
//                 IF NPRate.FINDLAST THEN BEGIN
//                   Line11 := NPRate."Line No.";
//                   IF UpdateDt<=NPRate."Effective Date" THEN
//                     ERROR('You select a date later than %1',NPRate."Effective Date");
//                   IF UpdateDt<>0D THEN
//                     NPRate."End Date" := CALCDATE('-1D',UpdateDt)
//                   ELSE
//                     ERROR('Please Select The Date');
//                   NPRate.Latest := FALSE;
//                   IF (NRate <> 0)AND(CRate<>0)AND(FRate<>0) THEN
//                     NPRate.MODIFY;
//                  END;
//                 Line22 := Line11 + 10000;

//                 IF CONFIRM('New Values are %1,%2,%3.\ Do You Want To Proceed?',TRUE,NRate,CRate,FRate) THEN BEGIN
//                   NPRate1.INIT;
//                   NPRate1."NP Code" := "NP Code";
//                   NPRate1."Line No." := Line22;
//                   NPRate1."Effective Date" := UpdateDt;
//                   NPRate1."Normal Rate" := NRate;
//                   NPRate1."Color Rate" := CRate;
//                   NPRate1."Front Page Rate" := FRate;
//                   NPRate1.Latest := TRUE;

//                   IF (NRate <> 0)AND(CRate<>0)AND(FRate<>0) THEN
//                     NPRate1.INSERT;
//                  END;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group("Fill the New Value")
//                 {
//                     field("Effective Date";UpdateDt)
//                     {
//                     }
//                     field("Normal Rate";NRate)
//                     {
//                     }
//                     field("Color Page  Rate";CRate)
//                     {
//                     }
//                     field("Front Page Rate";FRate)
//                     {
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         UpdateDt: Date;
//         NRate: Decimal;
//         CRate: Decimal;
//         FRate: Decimal;
//         NPRate: Record "50060";
//         Line11: Integer;
//         Line22: Integer;
//         NPRate1: Record "50060";
// }

