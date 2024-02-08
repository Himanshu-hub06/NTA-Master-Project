/// <summary>
/// Codeunit PFMS Request Management (ID 50011).
/// </summary>
codeunit 50009 "PFMS Request Management Admin"
{
    Local Procedure CallIRNGenerationWebService(URL: text; reqtxt: Text; var JSONResponse: JSONObject)
    var
        RequestContent: HttpContent;
        httpheader: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        TxtResponse: text;
        Client: HttpClient;
        //APIManagementEwayWebtel: Codeunit "API Management Eway -Webtel1";
        request: HttpRequestMessage;
        txterror: text;
        txtmsg: text;
    begin
        request.Method := 'POST';
        if (reqtxt = '') or (reqtxt = '[]') then
            EXIt;
        requestContent.WriteFrom(reqtxt);
        requestContent.GetHeaders(HttpHeader);
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-type', 'application/xml');
        // Message(reqtxt);
        if Client.Post(URL, requestContent, ResponseMessage) then begin
            if ResponseMessage.HttpStatusCode() = 200 then begin
                IF ResponseMessage.Content.ReadAs(TxtResponse) THEN begin
                    TxtResponse := DELCHR(TxtResponse, '=', '[');
                    TxtResponse := DELCHR(TxtResponse, '=', ']');

                end;
            END ELSE
                Error('Web Service Call Failed with Error Status Code %1  %2', ResponseMessage.HttpStatusCode(), ResponseMessage.Content);
        end else
            Error('Cannot connect the Server');

    end;

    procedure GetSanctionStatus(SanctionNo: Text): Text
    var
        StrTxt: Text;
    begin

        //  StrTxt := '    < Sanctions xmlns="" http://webservices.pfms.nic.in/PFMSExternalWebService.xsd"">' +//EXPDIP

        StrTxt :=
        '<Sanction>' +
       '< UniqueIdentifier > ' + SanctionNo + '</UniqueIdentifier>' +
       '<RequestSource>' +
       'DAVP' +
       '</ RequestSource > ' +
       '</Sanction>' +
       '</Sanctions>';
        EXIT(StrTxt);
    end;

    procedure CreateXMLSanctionRequest(SanctionNo: Code[20])
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        ParentNode, ParentNode1, ParentNode2, ParentNode3 : XmlElement;
        ChildNode, ChildNode1 : XmlElement;
        XMLTxt: XmlText;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        OutStr: OutStream;
        WriteTxt: Text;
        MyFile: File;
        fileDir: Record 50083;
    begin
        fileDir.Get();
        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        XMLDoc.SetDeclaration(XMLDec);
        //XMLDoc.Add(XmlElement.Create('Sanctions'));
        RootNode := XmlElement.Create('Sanctions', 'http://webservices.pfms.nic.in/PFMSExternalWebService.xsd');
        XMLDoc.Add(RootNode);
        ParentNode := XmlElement.Create('Sanction');
        RootNode.add(ParentNode);
        ChildNode := XmlElement.Create('UniqueIdentifier');
        XMLTxt := XmlText.Create(SanctionNo);
        ChildNode.Add(XMLTxt);
        ParentNode.Add(ChildNode);
        ChildNode1 := XmlElement.Create('RequestSource');
        XMLTxt := XmlText.Create('DAVP');
        ChildNode1.Add(XMLTxt);
        ParentNode.Add(ChildNode1);

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(OutStr);
        XMLDoc.WriteTo(WriteTxt);
        WriteTxt := WriteTxt.Replace(' xmlns=""', '');
        MyFile.Create(fileDir."PFMS Sanction Status" + SanctionNo + '.xml');
        MyFile.Close();
        MyFile.WriteMode(true);
        MyFile.TextMode(true);
        MyFile.Open(fileDir."PFMS Sanction Status" + SanctionNo + '.xml');
        MyFile.Write(WriteTxt);
        MyFile.Close();
    end;

    procedure CreateXMLPushRequest(InvoiceNo: Code[20]): Code[20]
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        DOMProcessingInstruction: XmlProcessingInstruction;
        RootNode: XmlElement;
        ParentNode, ParentNode1, ParentNode2, ParentNode3 : XmlElement;
        ChildNode: XmlElement;
        PurchHead, PurchHead1 : Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        FieldCaption: Text;
        XMLTxt: XmlText;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        OutStr: OutStream;
        ReadTxt: Text;
        WriteTxt: Text;
        currYear: Integer;
        paymentAmount: Decimal;
        paymentamount1: Text[20];
        vendtab: Record Vendor;
        CurrMonth: Text[2];
        CurrDays: Integer;
        CurrDate: Text[30];
        purchSetup: Record "Purchases & Payables Setup";
        SanNo: Text[10];
        fileDir: Record 50083;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MyFile: File;
        FileMangement: Codeunit "File Management";
    begin

        PurchHead1.Reset();
        PurchHead1.SetRange("No.", InvoiceNo);
        if PurchHead1.FindFirst() then;
        vendtab.Get(PurchHead1."Buy-from Vendor No.");
        vendtab.TestField("PFMS Code");
        vendtab.TestField("Vendor Account No.");
        vendtab.TestField("IFSC Code");
        vendtab.TestField("Bank Name");
        fileDir.Get();
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHead1."Document Type");
        PurchLine.SetRange("Document No.", PurchHead1."No.");
        IF PurchLine.FindFirst() then begin
            repeat

                paymentAmount := paymentAmount + PurchLine.Amount;
            UNTIL PurchLine.Next() = 0;
        End;
        // paymentAmount1 := FORMAT(Evaluate(paymentAmount);
        paymentAmount1 := FORMAT(paymentAmount, 0, 1);

        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        XMLDoc.SetDeclaration(XMLDec);
        //XMLDoc.Add(XmlElement.Create('Sanctions'));
        RootNode := XmlElement.Create('Sanctions', 'http://webservices.pfms.nic.in/PFMSExternalWebService.xsd');
        XMLDoc.Add(RootNode);
        purchSetup.Get();
        purchSetup.TestField("PFMS No.");
        SanNo := NoSeriesMgt.GetNextNo(purchSetup."PFMS No.", TODAY, TRUE);

        CurrMonth := FORMAT(DATE2DMY(Today, 2));
        If StrLen(CurrMonth) = 1 then
            CurrMonth := '0' + CurrMonth;
        CurrYear := DATE2DMY(Today, 3);
        Currdays := DATE2DMY(Today, 1);
        CurrDate := FORMAT(CurrYear) + '-' + FORMAT(CurrMonth) + '-' + FORMAT(CurrDays);

        ParentNode := XmlElement.Create('Sanction');
        ParentNode.SetAttribute('DDOCODE', '227974');
        ParentNode.SetAttribute('SanctionNo', SanNo);
        ParentNode.SetAttribute('SanctionDate', CurrDate);
        ParentNode.SetAttribute('SchemeCode', '1890');
        ParentNode.SetAttribute('SanctionAmount', Format(paymentAmount1));
        ParentNode.SetAttribute('CreatedBy', 'AVBS2');
        ParentNode.SetAttribute('PaymentMode', '528');
        ParentNode.SetAttribute('SanctionType', '14');
        ParentNode.SetAttribute('IFDNumber', SanNo);
        ParentNode.SetAttribute('IFDDate', CurrDate);
        ParentNode.SetAttribute('BillNumber', SanNo);
        ParentNode.SetAttribute('BillDate', CurrDate);
        ParentNode.SetAttribute('NPBDate', CurrDate);
        ParentNode.SetAttribute('UniqueIdentifier', SanNo);
        ParentNode.SetAttribute('RequestSource', 'DAVP');
        ParentNode.SetAttribute('FinancialYear', FORMAT(currYear));
        ParentNode.SetAttribute('BillStatus', 'F');
        RootNode.add(ParentNode);
        ParentNode1 := XmlElement.Create('ExpenditureSummary');
        ParentNode.Add(ParentNode1);
        ChildNode := XmlElement.Create('Account');
        ChildNode.SetAttribute('FuncHead', '2220601010601');
        ChildNode.SetAttribute('ObjHead', '24');
        ChildNode.SetAttribute('Category', '5');
        ChildNode.SetAttribute('GrantNo', '061');
        ChildNode.SetAttribute('SumAmount', FORMAT(paymentAmount1));
        ParentNode1.Add(ChildNode);
        ParentNode2 := XmlElement.Create('BeneficiaryDetails');
        ParentNode.Add(ParentNode2);

        PurchHead.RESET;
        PurchHead.SETRANGE("No.", invoiceno);
        IF PurchHead.FindFirst() THEN begin

            Clear(ParentNode3);
            ParentNode3 := XmlElement.Create('Beneficiary');
            ParentNode3.SetAttribute('PFMSUniqueCode', FORMAT(vendtab."PFMS Code"));
            ParentNode3.SetAttribute('AccountNumber', Format(vendtab."Vendor Account No."));
            ParentNode3.SetAttribute('Name', FORMAT(vendtab.Name));
            ParentNode3.SetAttribute('IFSCCode', FORMAT(vendtab."IFSC Code"));
            ParentNode3.SetAttribute('GrossAmount', Format(paymentAmount1));
            ParentNode3.SetAttribute('NetAmount', Format(paymentAmount1));
            ParentNode3.SetAttribute('PayeeRemarks', FORMAT(PurchHead.Remarks));
            ParentNode3.Add('', '');
            ParentNode2.Add(ParentNode3);
            PurchHead."Sanction No." := SanNo;
            PurchHead."Sanction Date" := Today;
            PurchHead."Sanction Time" := Time;
            PurchHead."PFMS File Attachment" := SanNo + '.xml';

            PurchHead.Modify();

        End;
        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(OutStr);
        //XMLDoc.WriteTo(OutStr); org
        XMLDoc.WriteTo(WriteTxt);
        WriteTxt := WriteTxt.Replace(' xmlns=""', '');
        //OutStr.WriteText(WriteTxt);
        //Instr.ReadText(WriteTxt);
        //ReadTxt := 'PFMS.xml';
        MyFile.Create(fileDir."PFMS Push Status" + SanNo + '.xml');
        MyFile.Close();
        MyFile.WriteMode(true);
        MyFile.TextMode(true);
        MyFile.Open(fileDir."PFMS Push Status" + SanNo + '.xml');
        MyFile.Write(WriteTxt);
        MyFile.Close();
        //myfile := TemporaryPath + 'PFMS.xml';
        //FileMangement.UploadFileSilentToServerPath(MyFile, 'D:\Published_App\BOC\BOC_FTP\PFMS_XML\');
        exit(SanNo);
    end;

    procedure CreateXMLPaymentDetailRequest(SanctionNo: Code[20])
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        Attribute: XmlAttribute;
        ParentNode, ParentNode1, ParentNode2, ParentNode3 : XmlElement;
        ChildNode, ChildNode1 : XmlElement;
        XMLTxt: XmlText;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        OutStr: OutStream;
        WriteTxt: Text;
        MyFile: File;
        fileDir: Record 50083;
        myString: Text;
    begin
        fileDir.Get();
        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'utf-8', 'yes');
        XMLDoc.SetDeclaration(XMLDec);
        //XMLDoc.Add(XmlElement.Create('Sanctions'));
        RootNode := XmlElement.Create('Sanctions', 'http://webservices.pfms.nic.in/PFMSExternalWebService.xsd');
        //RootNode.SetAttribute('xmlns', 'http://webservices.pfms.nic.in/PFMSExternalWebService.xsd');
        XMLDoc.Add(RootNode);
        ParentNode := XmlElement.Create('Sanction');
        RootNode.Add(ParentNode);
        ChildNode := XmlElement.Create('UniqueIdentifier');
        XMLTxt := XmlText.Create(SanctionNo);
        ChildNode.Add(XMLTxt);
        ParentNode.Add(ChildNode);
        ChildNode1 := XmlElement.Create('RequestSource');
        XMLTxt := XmlText.Create('DAVP');
        ChildNode1.Add(XMLTxt);
        ParentNode.Add(ChildNode1);

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(OutStr);
        XMLDoc.WriteTo(WriteTxt);
        WriteTxt := WriteTxt.Replace(' xmlns=""', '');
        MyFile.Create(fileDir."PFMS Payment Status" + SanctionNo + '.xml');
        MyFile.Close();
        MyFile.WriteMode(true);
        MyFile.TextMode(true);
        MyFile.Open(fileDir."PFMS Payment Status" + SanctionNo + '.xml');
        MyFile.Write(WriteTxt);
        MyFile.Close();


    end;

    var
        webServReqMgt: Codeunit 1290;
}