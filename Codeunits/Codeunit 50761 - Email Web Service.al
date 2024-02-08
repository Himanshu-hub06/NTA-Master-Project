// codeunit 50761 "Email Web Service"
// {

//     trigger OnRun()
//     begin
//         CLEAR(Request);
//         CLEAR(Response);
//         CLEAR(uriObj);
//         CLEAR(stream);
//     end;

//     var
//         uriObj: DotNet Uri;
//         Request: DotNet HttpWebRequest;
//         stream: DotNet StreamWriter;
//         Response: DotNet HttpWebResponse;
//         reader: DotNet XmlTextReader;
//         document: DotNet XmlDocument;
//         ascii: DotNet Encoding;
//         FileMgt: Codeunit "419";
//         FileSrv: Text;
//         ToFile: Text;
//         xml: Text;
//         url: Text;
//         soapAction: Text;
//         ResponseCode: Text;

//     [TryFunction]
//     procedure SendEmailWithoutCC(ReceiverID: Text;SubjectText: Text;BodyText: Text)
//     begin
//         xml := '<?xml version="1.0" encoding="utf-8"?>'+
//         '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
//           '<soap:Body>'+
//             '<SendEmailWithoutCC xmlns="http://tempuri.org/">'+
//               '<email_to>'+ReceiverID  + '</email_to>'+
//               '<subject>'+ SubjectText + '</subject>'+
//               '<msg>'+ BodyText + '</msg>'+
//             '</SendEmailWithoutCC>'+
//           '</soap:Body>'+
//         '</soap:Envelope>';

//         url := 'http://172.17.101.13/email/email.asmx';
//         uriObj := uriObj.Uri(url);
//         Request := Request.CreateDefault(uriObj);
//         Request.Method := 'POST';
//         Request.ContentType := 'text/xml';
//         //soapAction := '"http://172.17.101.13/email/email.asmx/SendEmail"';
//         soapAction := '"http://tempuri.org/SendEmailWithoutCC"';
//         Request.Headers.Add('SOAPAction', soapAction);
//         Request.Timeout := 120000;

//         // Send the request to the webservice
//         stream := stream.StreamWriter(Request.GetRequestStream(), ascii.UTF8);
//         stream.Write(xml);
//         stream.Close();


//         // Get the response
//         Response := Request.GetResponse();
//         reader := reader.XmlTextReader(Response.GetResponseStream());
//     end;

//     [TryFunction]
//     procedure SendEmailCC(ReceiverID: Text;CCID: Text;SubjectText: Text;BodyText: Text)
//     begin
//         xml := '<?xml version="1.0" encoding="utf-8"?>'+
//         '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
//           '<soap:Body>'+
//             '<SendEmail xmlns="http://tempuri.org/">'+
//               '<email_to>'+ReceiverID  + '</email_to>'+
//               '<email_cc>'+CCID +'</email_cc>'+
//               '<subject>'+ SubjectText + '</subject>'+
//               '<msg>'+ BodyText + '</msg>'+
//             '</SendEmail>'+
//           '</soap:Body>'+
//         '</soap:Envelope>';

//         url := 'http://172.17.101.13/email/email.asmx';
//         uriObj := uriObj.Uri(url);
//         Request := Request.CreateDefault(uriObj);
//         Request.Method := 'POST';
//         Request.ContentType := 'text/xml';
//         //soapAction := '"http://172.17.101.13/email/email.asmx/SendEmail"';
//         soapAction := '"http://tempuri.org/SendEmail"';
//         Request.Headers.Add('SOAPAction', soapAction);
//         Request.Timeout := 120000;

//         // Send the request to the webservice
//         stream := stream.StreamWriter(Request.GetRequestStream(), ascii.UTF8);
//         stream.Write(xml);
//         stream.Close();


//         // Get the response
//         Response := Request.GetResponse();
//         reader := reader.XmlTextReader(Response.GetResponseStream());
//     end;

//     [TryFunction]
//     procedure SendProEmailWithoutCC(ReceiverID: Text;SubjectText: Text;BodyText: Text;Attach1: Text;Attach2: Text;Attach3: Text;Attach4: Text;Attach5: Text;Attach6: Text)
//     begin
//         CLEAR(Request);
//         CLEAR(Response);
//         CLEAR(uriObj);
//         CLEAR(stream);
//         xml := '<?xml version="1.0" encoding="utf-8"?>'+
//         '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
//           '<soap:Body>'+
//             '<SendPROEmailWithoutCC xmlns="http://tempuri.org/">'+
//              '<email_to>'+ ReceiverID  + '</email_to>'+
//               '<subject>'+ SubjectText + '</subject>'+
//               '<msg>'+ BodyText + '</msg>'+
//               '<Atch1>'+ Attach1 +'</Atch1>'+
//               '<Atch2>'+ Attach2 +'</Atch2>'+
//               '<Atch3>'+ Attach3 +'</Atch3>'+
//               '<Atch4>'+ Attach4 +'</Atch4>'+
//               '<Atch5>'+ Attach5 +'</Atch5>'+
//               '<Atch6>'+ Attach6 +'</Atch6>'+
//             '</SendPROEmailWithoutCC>'+
//           '</soap:Body>'+
//         '</soap:Envelope>';

//         url := 'http://172.17.101.13/emailpro/email.asmx';
//         uriObj := uriObj.Uri(url);
//         Request := Request.CreateDefault(uriObj);
//         Request.Method := 'POST';
//         Request.ContentType := 'text/xml';
//         //soapAction := '"http://172.17.101.13/emailpro/email.asmx/SendEmail"';
//         soapAction := '"http://tempuri.org/SendPROEmailWithoutCC"';
//         Request.Headers.Add('SOAPAction', soapAction);
//         Request.Timeout := 120000;

//         // Send the request to the webservice
//         stream := stream.StreamWriter(Request.GetRequestStream(), ascii.UTF8);
//         stream.Write(xml);
//         stream.Close();


//         // Get the response
//         Response := Request.GetResponse();
//         reader := reader.XmlTextReader(Response.GetResponseStream());
//     end;

//     [TryFunction]
//     procedure SendProEmailWithoutCC1(ReceiverID: Text;SubjectText: Text;BodyText: Text;Attach1: Text;Attach2: Text)
//     begin
//         CLEAR(Request);
//         CLEAR(Response);
//         CLEAR(uriObj);
//         CLEAR(stream);
//         xml := '<?xml version="1.0" encoding="utf-8"?>'+
//         '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
//           '<soap:Body>'+
//             '<SendPROEmailWithoutCC xmlns="http://tempuri.org/">'+
//              '<email_to>'+ ReceiverID  + '</email_to>'+
//               '<subject>'+ SubjectText + '</subject>'+
//               '<msg>'+ BodyText + '</msg>'+
//               '<Atch1>'+ Attach1 +'</Atch1>'+

//             '</SendPROEmailWithoutCC>'+
//           '</soap:Body>'+
//         '</soap:Envelope>';

//         url := 'http://172.17.101.13/emailpro/email.asmx';
//         uriObj := uriObj.Uri(url);
//         Request := Request.CreateDefault(uriObj);
//         Request.Method := 'POST';
//         Request.ContentType := 'text/xml';
//         //soapAction := '"http://172.17.101.13/emailpro/email.asmx/SendEmail"';
//         soapAction := '"http://tempuri.org/SendPROEmailWithoutCC"';
//         Request.Headers.Add('SOAPAction', soapAction);
//         Request.Timeout := 120000;

//         // Send the request to the webservice
//         stream := stream.StreamWriter(Request.GetRequestStream(), ascii.UTF8);
//         stream.Write(xml);
//         stream.Close();


//         // Get the response
//         Response := Request.GetResponse();
//         reader := reader.XmlTextReader(Response.GetResponseStream());
//     end;
// }

