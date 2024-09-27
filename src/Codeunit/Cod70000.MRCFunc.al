/// <summary>
/// Codeunit MRC Func (ID 70000).
/// </summary>
codeunit 70000 "MRC Func"
{

    /// <summary>
    /// InterfaceItemJournalToPDA.
    /// </summary>
    /// <param name="ItemJournal">Record "Item Journal Line".</param>
    procedure InterfaceItemJournalToPDA(ItemJournal: Record "Item Journal Line")
    var
        ltItem: Record Item;
        ltJsonObject: JsonObject;
        Result: Text;
        ltDocumentType: Enum "MRC Interface Document Type";
        DicBatch: Dictionary of [code[20], List of [Integer]];
        ListOfInteger: List of [Integer];
    begin
        CLEAR(ltJsonObject);
        ltItem.GET(ItemJournal."Item No.");
        ltJsonObject.Add('template_name', itemJournal."Journal Template Name");
        ltJsonObject.Add('batch_name', itemJournal."Journal Batch Name");
        ltJsonObject.Add('posting_date', itemJournal."Posting Date");
        ltJsonObject.Add('entry_type', format(itemJournal."Entry Type"));
        ltJsonObject.Add('line_no', itemJournal."Line No.");
        ltJsonObject.Add('document_no', itemJournal."Document No.");
        ltJsonObject.Add('item_no', itemJournal."Item No.");
        ltJsonObject.Add('description', itemJournal.Description);
        ltJsonObject.Add('description_th', ltItem."MRC Description TH");
        ltJsonObject.Add('search_description', ltItem."Search Description");
        ltJsonObject.Add('address', itemJournal."MRC Address");
        ltJsonObject.Add('quantity', itemJournal.Quantity);
        ltJsonObject.Add('uom', itemJournal."Unit of Measure Code");
        ltJsonObject.Add('location_code', itemJournal."Location Code");
        ltJsonObject.Add('shipto_name', itemJournal."MRC Ship-to Name");
        ltJsonObject.Add('shipto_address', itemJournal."MRC Ship-to Address");
        ltJsonObject.Add('shipto_district', itemJournal."MRC Ship-to District");
        ltJsonObject.Add('shipto_postcode', itemJournal."MRC Ship-to Post Code");
        ltJsonObject.Add('shipto_mobileno', itemJournal."MRC Ship-to Mobile No.");
        ltJsonObject.Add('shipto_phoneno', itemJournal."MRC Ship-to Phone No.");
        ltJsonObject.Add('shipment_date', itemJournal."MRC Shipment Date");
        ltJsonObject.Add('shipping_agent', itemJournal."MRC Shipping Agent");
        ListOfInteger.Add(itemJournal."Line No.");
        DicBatch.Add(itemJournal."Journal Batch Name", ListOfInteger);
        ltJsonObject.WriteTo(Result);
        CallWebService(ltDocumentType::"Item Journal", Result, ItemJournal."Journal Template Name", DicBatch);
    end;

    /// <summary>
    /// InterfaceTransferToPDA.
    /// </summary>
    /// <param name="pTranferOrder">Record "Transfer Header".</param>
    procedure InterfaceTransferToPDA(pTranferOrder: Record "Transfer Header")
    var
        ltTransferLine: Record "Transfer Line";
        ltITem: Record Item;
        ltJsonObject, ltJsonObjectLine : JsonObject;
        ltJsonArray: JsonArray;
        Result: Text;
        ltDocumentType: Enum "MRC Interface Document Type";
        DicBatch: Dictionary of [code[20], List of [Integer]];
        ListOfInteger: List of [Integer];
    begin
        ltJsonObject.Add('no', pTranferOrder."No.");
        ltJsonObject.Add('transferfromCode', pTranferOrder."Transfer-from Code");
        ltJsonObject.Add('transfertoCode', pTranferOrder."Transfer-to Code");
        ltJsonObject.Add('retailerNo', '');
        ltJsonObject.Add('retailerName', '');
        ltJsonObject.Add('storeLocation', '');
        ltJsonObject.Add('storeLocationName', '');
        ltJsonObject.Add('shiptoName', pTranferOrder."MRC Ship-to Name");
        ltJsonObject.Add('shiptoAddress', pTranferOrder."MRC Ship-to Address");
        ltJsonObject.Add('shiptoDistrict', pTranferOrder."MRC Ship-to District");
        ltJsonObject.Add('shiptoPostcode', pTranferOrder."MRC Ship-to Post Code");
        ltJsonObject.Add('shiptoMobileNo', pTranferOrder."MRC Ship-to Mobile No.");
        ltJsonObject.Add('shiptoPhoneNo', pTranferOrder."MRC Ship-to Phone No.");
        ltJsonObject.Add('storeContact', '');
        ltJsonObject.Add('orderNo', pTranferOrder."External Document No.");
        ltJsonObject.Add('documentDate', pTranferOrder."Posting Date");
        ltJsonObject.Add('shipmentDate', pTranferOrder."Shipment Date");
        ltJsonObject.Add('shippingAgent', pTranferOrder."Shipping Agent Code");
        ltJsonObject.Add('direction', format(pTranferOrder."MRC Direction"));
        ltTransferLine.reset();
        ltTransferLine.SetRange("Document No.", pTranferOrder."No.");
        ltTransferLine.SetRange("Derived From Line No.", 0);
        if ltTransferLine.FindSet() then
            repeat
                CLEAR(ltJsonObjectLine);
                ltITem.GET(ltTransferLine."Item No.");
                ltJsonObjectLine.Add('line_no', ltTransferLine."Line No.");
                ltJsonObjectLine.Add('documentNo', ltTransferLine."Document No.");
                ltJsonObjectLine.Add('itemNo', ltTransferLine."Item No.");
                ltJsonObjectLine.Add('description', ltTransferLine.Description);
                ltJsonObjectLine.Add('descriptionTH', ltITem."MRC Description TH");
                ltJsonObjectLine.Add('searchDescription', ltITem."Search Description");
                ltJsonObjectLine.Add('quantity', ltTransferLine.Quantity);
                ltJsonObjectLine.Add('uOM', ltTransferLine."Unit of Measure Code");
                ltJsonArray.Add(ltJsonObjectLine);
            until ltTransferLine.Next() = 0;
        ltJsonObject.Add('transferlines', ltJsonArray);
        ltJsonObject.WriteTo(Result);
        ListOfInteger.Add(10000);
        DicBatch.Add(pTranferOrder."No.", ListOfInteger);
        CallWebService(ltDocumentType::Transfer, Result, '', DicBatch);
    end;

    local procedure CallWebService(pDocumentType: Enum "MRC Interface Document Type"; pPayload: Text; pJournalTemplate: code[10]; pDicBatch: Dictionary of [code[20], List of [Integer]])
    var
        ltGeneralSetup: Record "General Ledger Setup";
        JsonMgt: Codeunit "JSON Management";
        gvHttpHeadersContent, contentHeaders : HttpHeaders;
        gvHttpResponseMessage: HttpResponseMessage;
        gvHttpClient: HttpClient;
        gvHttpContent: HttpContent;
        ResponseText: Text;
        Url, ltBearer : Text;
    begin
        ltGeneralSetup.GET();
        if pDocumentType = pDocumentType::Transfer then begin
            ltGeneralSetup.TestField("MRC To PDA URL (Transfer)");
            Url := ltGeneralSetup."MRC To PDA URL (Transfer)";
        end else begin
            ltGeneralSetup.TestField("MRC To PDA URL (Item Journal)");
            Url := ltGeneralSetup."MRC To PDA URL (Item Journal)";
        end;
        gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
        gvHttpContent.WriteFrom(pPayload);
        gvHttpContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        ContentHeaders.Add('Authorization', 'Bearer ' + ltBearer);
        gvHttpClient.Post(Url, gvHttpContent, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(ResponseText);
        JsonMgt.InitializeObject(ResponseText);
        if (gvHttpResponseMessage.IsSuccessStatusCode()) and (gvHttpResponseMessage.HttpStatusCode() = 200) then
            InsertToInterfaceLog(0, pDocumentType, pJournalTemplate, pDicBatch, JsonMgt.GetValue('$.PDA_Entry_Ref'), '', pPayload)
        else
            InsertToInterfaceLog(1, pDocumentType, pJournalTemplate, pDicBatch, JsonMgt.GetValue('$.PDA_Entry_Ref'), JsonMgt.GetValue('$.Remark'), pPayload);

    end;

    local procedure InsertToInterfaceLog(pStatus: Option "Success","Failed"; pDocumentType: Enum "MRC Interface Document Type"; pJournalTemplate: code[10]; pDicBatch: Dictionary of [code[20], List of [Integer]];
                                                                                                pPDA_Entry_Ref: text;
                                                                                                pRemark: text;
                                                                                                pPayload: Text)
    var
        InterfaceLogEntry: Record "MRC Interface Log Entry";
        ltTransferHeader: Record "Transfer Header";
        ltITemJournalLine: Record "Item Journal Line";
        ltOutStram: OutStream;
        ltRefPDA: Integer;
        DocNo: Code[20];
        ltLineLists: List of [Integer];
        LtLineNo: Integer;
        ltDicBatch: Dictionary of [code[20], List of [Integer]];
    begin
        foreach DocNo in pDicBatch.Keys() do begin
            ltDicBatch.Get(DocNo, ltLineLists);
            foreach LtLineNo in ltLineLists do begin
                InterfaceLogEntry.Init();
                InterfaceLogEntry."Transaction ID" := InterfaceLogEntry.GetLastTransactionID();
                InterfaceLogEntry."Document Type" := pDocumentType;
                InterfaceLogEntry.Status := pStatus;
                Evaluate(ltRefPDA, pPDA_Entry_Ref);
                InterfaceLogEntry."PDA Entry Ref." := ltRefPDA;
                InterfaceLogEntry.Remark := COPYSTR(pRemark, 1, 2047);
                InterfaceLogEntry.Insert();
                if pDocumentType = pDocumentType::"Item Journal" then begin
                    ltITemJournalLine.GET(pJournalTemplate, DocNo, LtLineNo);
                    InterfaceLogEntry."Document No." := ltITemJournalLine."Document No.";
                    InterfaceLogEntry."Journal Batch Name" := ltITemJournalLine."Journal Batch Name";
                    if pStatus = pStatus::Success then begin
                        ltITemJournalLine."MRC Interface Completed" := true;
                        ltITemJournalLine."MRC Send DateTime" := CurrentDateTime();
                    end;
                    ltITemJournalLine."MRC Transaction ID" := InterfaceLogEntry."Transaction ID";
                    ltITemJournalLine.Modify();
                end else begin
                    ltTransferHeader.GET(DocNo);
                    InterfaceLogEntry."Document No." := ltTransferHeader."No.";
                    if pStatus = pStatus::Success then begin
                        ltTransferHeader."MRC Interface Completed" := true;
                        ltTransferHeader."MRC Send DateTime" := CurrentDateTime();
                    end;
                    ltTransferHeader."MRC Transaction ID" := InterfaceLogEntry."Transaction ID";
                    ltTransferHeader.Modify();
                end;
                InterfaceLogEntry."Json Format".CreateOutStream(ltOutStram, TextEncoding::UTF8);
                ltOutStram.WriteText(pPayload);
                InterfaceLogEntry.Modify();
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure OnAfterCopyFromTransferHeaderReceipt(TransferHeader: Record "Transfer Header"; var TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransferReceiptHeader."MRC Direction" := TransferHeader."MRC Direction";
        TransferReceiptHeader."MRC Ship-to Address" := TransferHeader."MRC Ship-to Address";
        TransferReceiptHeader."MRC Ship-to District" := TransferHeader."MRC Ship-to District";
        TransferReceiptHeader."MRC Ship-to Mobile No." := TransferHeader."MRC Ship-to Mobile No.";
        TransferReceiptHeader."MRC Ship-to Name" := TransferHeader."MRC Ship-to Name";
        TransferReceiptHeader."MRC Ship-to Phone No." := TransferHeader."MRC Ship-to Phone No.";
        TransferReceiptHeader."MRC Ship-to Post Code" := TransferHeader."MRC Ship-to Post Code";
        TransferReceiptHeader."MRC Transaction ID" := TransferHeader."MRC Transaction ID";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure OnAfterCopyFromTransferHeaderShipment(TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader."MRC Direction" := TransferHeader."MRC Direction";
        TransferShipmentHeader."MRC Ship-to Address" := TransferHeader."MRC Ship-to Address";
        TransferShipmentHeader."MRC Ship-to District" := TransferHeader."MRC Ship-to District";
        TransferShipmentHeader."MRC Ship-to Mobile No." := TransferHeader."MRC Ship-to Mobile No.";
        TransferShipmentHeader."MRC Ship-to Name" := TransferHeader."MRC Ship-to Name";
        TransferShipmentHeader."MRC Ship-to Phone No." := TransferHeader."MRC Ship-to Phone No.";
        TransferShipmentHeader."MRC Ship-to Post Code" := TransferHeader."MRC Ship-to Post Code";
        TransferShipmentHeader."MRC Transaction ID" := TransferHeader."MRC Transaction ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLineTransferShipment(TransferShipmentHeader: Record "Transfer Shipment Header"; var ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."MRC Direction" := TransferShipmentHeader."MRC Direction";
        ItemJournalLine."MRC Ship-to Address" := TransferShipmentHeader."MRC Ship-to Address";
        ItemJournalLine."MRC Ship-to District" := TransferShipmentHeader."MRC Ship-to District";
        ItemJournalLine."MRC Ship-to Mobile No." := TransferShipmentHeader."MRC Ship-to Mobile No.";
        ItemJournalLine."MRC Ship-to Name" := TransferShipmentHeader."MRC Ship-to Name";
        ItemJournalLine."MRC Ship-to Phone No." := TransferShipmentHeader."MRC Ship-to Phone No.";
        ItemJournalLine."MRC Ship-to Post Code" := TransferShipmentHeader."MRC Ship-to Post Code";
        ItemJournalLine."MRC Transaction ID" := TransferShipmentHeader."MRC Transaction ID";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLineRecript(var ItemJournalLine: Record "Item Journal Line"; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        ItemJournalLine."MRC Direction" := TransferReceiptHeader."MRC Direction";
        ItemJournalLine."MRC Ship-to Address" := TransferReceiptHeader."MRC Ship-to Address";
        ItemJournalLine."MRC Ship-to District" := TransferReceiptHeader."MRC Ship-to District";
        ItemJournalLine."MRC Ship-to Mobile No." := TransferReceiptHeader."MRC Ship-to Mobile No.";
        ItemJournalLine."MRC Ship-to Name" := TransferReceiptHeader."MRC Ship-to Name";
        ItemJournalLine."MRC Ship-to Phone No." := TransferReceiptHeader."MRC Ship-to Phone No.";
        ItemJournalLine."MRC Ship-to Post Code" := TransferReceiptHeader."MRC Ship-to Post Code";
        ItemJournalLine."MRC Transaction ID" := TransferReceiptHeader."MRC Transaction ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgEntry: Record "Item Ledger Entry")
    begin
        NewItemLedgEntry."MRC Direction" := ItemJournalLine."MRC Direction";
        NewItemLedgEntry."MRC Ship-to Address" := ItemJournalLine."MRC Ship-to Address";
        NewItemLedgEntry."MRC Ship-to District" := ItemJournalLine."MRC Ship-to District";
        NewItemLedgEntry."MRC Ship-to Mobile No." := ItemJournalLine."MRC Ship-to Mobile No.";
        NewItemLedgEntry."MRC Ship-to Name" := ItemJournalLine."MRC Ship-to Name";
        NewItemLedgEntry."MRC Ship-to Phone No." := ItemJournalLine."MRC Ship-to Phone No.";
        NewItemLedgEntry."MRC Ship-to Post Code" := ItemJournalLine."MRC Ship-to Post Code";
        NewItemLedgEntry."MRC Shipment Date" := ItemJournalLine."MRC Shipment Date";
        NewItemLedgEntry."MRC Shipping Agent" := ItemJournalLine."MRC Shipping Agent";
        NewItemLedgEntry."MRC Transaction ID" := ItemJournalLine."MRC Transaction ID";
        NewItemLedgEntry."MRC Address" := ItemJournalLine."MRC Address";
        NewItemLedgEntry."MRC Original Quantity" := ItemJournalLine."MRC Original Quantity";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterSetupNewLine', '', True, true)]
    local procedure "AfterSetupNewLine"(var ItemJournalLine: Record "Item Journal Line"; var LastItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."MRC Interface" := LastItemJournalLine."MRC Interface";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'BeforInsertDocumentAssignEdit', '', false, false)]
    local procedure BeforInsertDocumentAssignEdit(var pItemJournalLine: Record "Item Journal Line")
    var
        ltNoSeries: Record "No. Series";
    begin
        if ltNoSeries.GET(pItemJournalLine."YVS Document No. Series") then
            pItemJournalLine."MRC Interface" := ltNoSeries."MRC Interface";
    end;
}
