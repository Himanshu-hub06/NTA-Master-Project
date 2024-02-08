/// <summary>
/// Codeunit PFMS Request Management (ID 50011).
/// </summary>
codeunit 50008 "PFMS Request Management"
{
    procedure GetSanctionStatus()
    var
        XMLBuffer: Record "XML Buffer";
        xmlDoc: XmlDocument;
        OutStrm: OutStream;
        InsStrm: InStream;
        TempBlob: Codeunit "Temp Blob";
        XMLFile: File;
        XMLString: Text;
        FilePath: Text;
        node1: XmlNode;
        node2: XmlNode;
        NodeList: XmlNodeList;
        nodelist1: XmlNodeList;
        tab: XmlElement;
        PFMSData: Record "PFMS Sanction Response";
        element: XmlElement;
        RootNode: XmlElement;
        e, e1 : XmlElement;
        AttributeList: XmlAttributeCollection;
        Attribute: XmlAttribute;
        LastEntryNo: Integer;
        FileDirectory: Record "File Directory Detail";
    begin
        //FilePath := 'http://20.219.125.221/PFMS_XML/SanctionStatus/SanctionResponse.xml';
        //XMLFile.Open('F:\Published_apps\pfms\PFMS_XML\SanctionStatus\SanctionResponse.xml');
        FileDirectory.Get();
        FileDirectory.TestField("PFMS Sanction Status");
        XMLFile.Open(FileDirectory."PFMS Sanction Status" + 'SanctionResponse.xml');
        XMLFile.CreateInStream(InsStrm);
        XmlDocument.ReadFrom(InsStrm, xmlDoc);
        XMLFile.Close();
        xmlDoc.GetRoot(RootNode);
        RootNode.SelectSingleNode('//RequestSource', node1);
        RootNode.SelectSingleNode('//Status', node2);
        e := node1.AsXmlElement();
        e1 := node2.AsXmlElement();
        PFMSData.Reset();
        PFMSData.SetCurrentKey("Entry No.");
        if PFMSData.FindLast() then
            LastEntryNo := PFMSData."Entry No."
        else
            LastEntryNo := 0;
        Clear(PFMSData);
        PFMSData.Init();
        PFMSData."Entry No." := LastEntryNo + 1;
        if e.Attributes().Get('UniqueIdentifier', Attribute) then
            PFMSData."Sanction No." := Attribute.Value;
        if e1.Attributes().Get('Value', Attribute) then
            PFMSData."Response Status" := Attribute.Value;
        if e.Attributes().Get('RequestSource', Attribute) then
            PFMSData."Request Source" := Attribute.Value;
        if e.Attributes().Get('IsSuccess', Attribute) then
            Evaluate(PFMSData.IsSuccess, Attribute.Value);
        if e.Attributes().Get('ErrorDescription', Attribute) then
            PFMSData."Error Description" := Attribute.Value;
        PFMSData."Status DateTime" := CurrentDateTime;
        PFMSData.Insert();

    end;


    procedure GetPushStatus(SanctionNo: code[20])
    var
        XMLFile: File;
        xmlDoc: XmlDocument;
        node1: XmlNode;
        node2: XmlNode;
        node3: XmlNode;
        RootNode: XmlElement;
        e, e1 : XmlElement;
        StatusElement, RequestSourceElement, SanctionElement : XmlElement;
        Attribute: XmlAttribute;
        LastEntryNo: Integer;
        InsStrm: InStream;
        FileDirectory: Record "File Directory Detail";
        PFMSPushStatus: Record "PFMS Push Status";
    begin
        FileDirectory.Get();
        FileDirectory.TestField("PFMS Push Status");
        //XMLFile.Open('D:\Published_App\BOC\BOC_FTP\PFMS_XML\res.xml');
        XMLFile.Open(FileDirectory."PFMS Push Status" + 'PushResponse.xml');
        XMLFile.CreateInStream(InsStrm);
        XmlDocument.ReadFrom(InsStrm, xmlDoc);
        XMLFile.Close();
        xmlDoc.GetRoot(RootNode);
        RootNode.SelectSingleNode('//ErrorDesc', node1);
        RootNode.SelectSingleNode('//Status', node2);
        e := node1.AsXmlElement();
        e1 := node2.AsXmlElement();
        PFMSPushStatus.Reset();
        PFMSPushStatus.SetCurrentKey("Entry No.");
        if PFMSPushStatus.FindLast() then
            LastEntryNo := PFMSPushStatus."Entry No."
        else
            LastEntryNo := 0;
        Clear(PFMSPushStatus);
        PFMSPushStatus.Init();
        PFMSPushStatus."Entry No." := LastEntryNo + 1;
        PFMSPushStatus."Sanction No." := SanctionNo;
        PFMSPushStatus."Error Description" := e.InnerText();
        if e1.Attributes().Get('Value', Attribute) then
            PFMSPushStatus."Response Status" := Attribute.Value;
        PFMSPushStatus."Status DateTime" := CurrentDateTime();
        PFMSPushStatus.Insert();
    end;

    procedure GetPaymentStatus(Sanctiono: Code[20])
    var
        XMLFile: File;
        xmlDoc: XmlDocument;
        node1: XmlNode;
        node2: XmlNode;
        node3: XmlNode;
        RootNode: XmlElement;
        StatusElement, RequestSourceElement, SanctionElement : XmlElement;
        Attribute: XmlAttribute;
        XmlAttributes: XmlAttributeCollection;
        PayeeDetailList: XmlNodeList;
        PayeeElement: XmlElement;
        nodelist1: XmlNodeList;
        LastEntryNo: Integer;
        InsStrm: InStream;
        FileDirectory: Record "File Directory Detail";
        PFMSPaymentStatus, PFMSPaymentStatus1 : Record "PFMS Payment Response";
        PaymentStatusHistory, PaymentStatusHistory1 : record "PFMS Payment Response History";
        NodeNo: integer;
        XMLNode1: XmlNode;
        TotalNode: Integer;
        i: integer;
        HistLastEntry: Integer;
    begin
        PaymentStatusHistory.Reset();
        PaymentStatusHistory.SetCurrentKey("Entry No.");
        if PaymentStatusHistory.FindLast() then
            HistLastEntry := PaymentStatusHistory."Entry No."
        else
            HistLastEntry := 0;

        PFMSPaymentStatus.Reset();
        PFMSPaymentStatus.SetCurrentKey("Entry No.", "Sanction No.");
        PFMSPaymentStatus.SetRange("Sanction No.", Sanctiono);
        if PFMSPaymentStatus.FindSet() then
            repeat
                HistLastEntry := HistLastEntry + 1;
                PaymentStatusHistory1.Init();
                PaymentStatusHistory1.TransferFields(PFMSPaymentStatus);
                PaymentStatusHistory1."Entry No." := HistLastEntry;
                PaymentStatusHistory1.Insert();
            until PFMSPaymentStatus.Next() = 0;

        PFMSPaymentStatus1.Reset();
        PFMSPaymentStatus1.SetCurrentKey("Entry No.", "Sanction No.");
        PFMSPaymentStatus1.SetRange("Sanction No.", Sanctiono);
        if Not PFMSPaymentStatus1.IsEmpty then
            PFMSPaymentStatus1.DeleteAll();

        NodeNo := 1;
        FileDirectory.Get();
        FileDirectory.TestField("PFMS Payment Status");
        XMLFile.Open(FileDirectory."PFMS Payment Status" + 'PaymentDetailResponse.xml');
        //XMLFile.Open('D:\Published_App\BOC\BOC_FTP\PFMS_XML\PaymentDetailResponse.xml');
        XMLFile.CreateInStream(InsStrm);
        XmlDocument.ReadFrom(InsStrm, xmlDoc);
        XMLFile.Close();
        xmlDoc.GetRoot(RootNode);
        RootNode.SelectSingleNode('//Status', node1);
        RootNode.SelectSingleNode('//RequestSource', node2);
        RootNode.SelectSingleNode('//Sanction', node3);
        xmlDoc.SelectNodes('//RequestSource/PayeeDetails', PayeeDetailList);
        StatusElement := node1.AsXmlElement();
        RequestSourceElement := node2.AsXmlElement();
        SanctionElement := node3.AsXmlElement();

        PFMSPaymentStatus.Reset();
        PFMSPaymentStatus.SetCurrentKey("Entry No.");
        if PFMSPaymentStatus.FindLast() then
            LastEntryNo := PFMSPaymentStatus."Entry No."
        else
            LastEntryNo := 0;

        TotalNode := PayeeDetailList.Count;
        for i := 1 to TotalNode do begin
            Clear(PFMSPaymentStatus);
            PayeeDetailList.Get(i, XMLNode1);
            PayeeElement := XMLNode1.AsXmlElement();
            LastEntryNo := LastEntryNo + 1;
            PFMSPaymentStatus.Init();
            PFMSPaymentStatus."Entry No." := LastEntryNo;
            //------------------Status----------------------//
            if StatusElement.Attributes().Get('Value', Attribute) then
                PFMSPaymentStatus."Response Status" := Attribute.Value;
            //------------Request Source----------------//
            if RequestSourceElement.Attributes().Get('UniqueIdentifier', Attribute) then
                PFMSPaymentStatus."Sanction No." := Attribute.Value;
            if RequestSourceElement.Attributes().Get('RequestSource', Attribute) then
                PFMSPaymentStatus."Request Source" := Attribute.Value;
            if RequestSourceElement.Attributes().Get('IsSuccess', Attribute) then
                Evaluate(PFMSPaymentStatus.IsSuccess, Attribute.Value);
            //-----------------Sanction-----------------//
            if SanctionElement.Attributes().Get('SanctionAmount', Attribute) then
                Evaluate(PFMSPaymentStatus."Sanction Amount", Attribute.Value);
            if SanctionElement.Attributes().Get('ModifiedBy', Attribute) then
                PFMSPaymentStatus."Modified By" := Attribute.Value;
            //-----------------PayeeDetails-------------//
            if PayeeElement.Attributes().Get('PFMSTransactionID', Attribute) then
                PFMSPaymentStatus."PFMS Transaction ID" := Attribute.Value;
            if PayeeElement.Attributes().Get('Amount', Attribute) then
                Evaluate(PFMSPaymentStatus.Amount, Attribute.Value);
            if PayeeElement.Attributes().Get('ScrollStatus', Attribute) then
                PFMSPaymentStatus."Scroll Status" := Attribute.Value;
            if PayeeElement.Attributes().Get('ScrollNo', Attribute) then
                PFMSPaymentStatus."Scroll No." := Attribute.Value;
            if PayeeElement.Attributes().Get('ScrollDate', Attribute) then
                Evaluate(PFMSPaymentStatus."Scroll Date", Attribute.Value);
            if PayeeElement.Attributes().Get('BankTransactionStatus', Attribute) then
                PFMSPaymentStatus."Bank Transaction Status" := Attribute.Value;
            if PayeeElement.Attributes().Get('BankTransactionID', Attribute) then
                PFMSPaymentStatus."Bank Transaction ID" := Attribute.Value;
            if PayeeElement.Attributes().Get('ReasonForFailure', Attribute) then
                PFMSPaymentStatus."Reason For Failure" := Attribute.Value;
            if PayeeElement.Attributes().Get('VendorUniqueCode', Attribute) then
                PFMSPaymentStatus."Vendor Code" := Attribute.Value;
            PFMSPaymentStatus."Status DateTime" := CurrentDateTime;
            PFMSPaymentStatus.Insert();
        end;
        //XMLFile.Close();
    end;

    var
        webServReqMgt: Codeunit 1290;
}