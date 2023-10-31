/// <summary>
/// Report MRC Import OB Item Journal (ID 70005).
/// </summary>
report 70005 "MRC Import OB Item Journal"
{
    Caption = 'Import OB Item Journal';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                    field(FileName; FileName)
                    {
                        Caption = 'File Name';
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the File Name field.';
                        trigger OnAssistEdit()

                        begin
                            UploadIntoStream('Select File', '', '(*.xlsx)|*.xlsx', FileName, gvInstr);
                            if FileName <> '' then
                                Sheetname := gvExcelBuffer.SelectSheetsNameStream(gvInstr)
                            else
                                exit;
                        end;
                    }
                    field(SheetName; SheetName)
                    {
                        Caption = 'Sheet Name';
                        ApplicationArea = all;
                        Editable = false;
                        ToolTip = 'Specifies the value of the Sheet Name field.';
                        trigger OnAssistEdit()
                        begin
                            if FileName <> '' then
                                Sheetname := gvExcelBuffer.SelectSheetsNameStream(gvInstr);

                        end;
                    }
                    field(gvStartFromRowNo; gvStartFromRowNo)
                    {
                        Caption = 'Start From Row No.';
                        ToolTip = 'Strat Read Record from file Excel';
                        MinValue = 0;
                        ApplicationArea = all;
                    }
                }

            }

        }
        trigger OnOpenPage()
        begin
            gvStartFromRowNo := 2;
        end;
    }
    trigger OnPreReport()
    var
        ltItemJournalLine: Record "Item Journal Line";
        ltConversToDicimal: Decimal;
        ltConversToInteger: Integer;
        NewDate: Date;
        CreateDate: Text;
        DateArr: array[3] of Integer;
    begin
        gvExcelBuffer.reset();
        gvExcelBuffer.DeleteAll();
        LastRow := 0;
        if Sheetname <> '' then begin
            gvExcelBuffer.Reset();
            gvExcelBuffer.OpenBookStream(gvInstr, Sheetname);
            gvExcelBuffer.ReadSheet();
            Commit();
            ExcelBufferReset.RESET();
            ExcelBufferReset.SETFILTER("Column No.", '%1', 1);
            ExcelBufferReset.SETFILTER("Cell Value as Text", '<>%1', '');
            IF ExcelBufferReset.FINDLAST() then
                LastRow := ExcelBufferReset."Row No.";
            FOR MyLoop := gvStartFromRowNo TO LastRow DO BEGIN
                ltConversToDicimal := 0;
                ltConversToInteger := 0;
                NewDate := 0D;
                ltItemJournalLine.Init();
                ltItemJournalLine."Journal Template Name" := COPYSTR(GetValueExcel(MyLoop, 1).TrimEnd(), 1, 10);
                ltItemJournalLine."Journal Batch Name" := COPYSTR(GetValueExcel(MyLoop, 2).TrimEnd(), 1, 10);
                Evaluate(ltConversToInteger, GetValueExcel(MyLoop, 3));
                ltItemJournalLine."Line No." := ltConversToInteger;
                ltItemJournalLine."Document No." := COPYSTR(GetValueExcel(MyLoop, 5).TrimEnd(), 1, 20);
                if UPPERCASE(GetValueExcel(MyLoop, 6)) = 'SALE' then
                    ltItemJournalLine.Validate("Entry Type", ltItemJournalLine."Entry Type"::Sale);
                if UPPERCASE(GetValueExcel(MyLoop, 6)) = 'PURCHASE' then
                    ltItemJournalLine.Validate("Entry Type", ltItemJournalLine."Entry Type"::Purchase);
                if COPYSTR(UPPERCASE(GetValueExcel(MyLoop, 6)), 1, 8) = 'POSITIVE' then
                    ltItemJournalLine.Validate("Entry Type", ltItemJournalLine."Entry Type"::"Positive Adjmt.");
                if COPYSTR(UPPERCASE(GetValueExcel(MyLoop, 6)), 1, 8) = 'NEGATIVE' then
                    ltItemJournalLine.Validate("Entry Type", ltItemJournalLine."Entry Type"::"Negative Adjmt.");
                ltItemJournalLine.Insert();
                CreateDate := GetValueExcel(MyLoop, 4).Replace('-', ',');
                CreateDate := GetValueExcel(MyLoop, 4).Replace('/', ',');
                Evaluate(DateArr[1], SelectStr(1, CreateDate));
                Evaluate(DateArr[2], SelectStr(2, CreateDate));
                Evaluate(DateArr[3], SelectStr(3, CreateDate));
                if StrLen(SelectStr(3, CreateDate)) = 2 then
                    DateArr[3] := DateArr[3] + 2000;
                NewDate := DMY2Date(DateArr[1], DateArr[2], DateArr[3]);

                ltItemJournalLine."Posting Date" := NewDate;
                ltItemJournalLine."Document Date" := NewDate;
                ltItemJournalLine."Source Code" := 'ITEMJNL';
                ltItemJournalLine.Validate("Item No.", COPYSTR(GetValueExcel(MyLoop, 7).TrimEnd(), 1, 20));
                if GetValueExcel(MyLoop, 8) <> '' then
                    ltItemJournalLine.Description := COPYSTR(GetValueExcel(MyLoop, 8).TrimEnd(), 1, 100);
                if GetValueExcel(MyLoop, 9) <> '' then
                    ltItemJournalLine.Validate("Variant Code", COPYSTR(GetValueExcel(MyLoop, 9).TrimEnd(), 1, 10));
                ltItemJournalLine.Validate("Location Code", COPYSTR(GetValueExcel(MyLoop, 10).TrimEnd(), 1, 10));
                if GetValueExcel(MyLoop, 11) <> '' then
                    ltItemJournalLine.Validate("Bin Code", COPYSTR(GetValueExcel(MyLoop, 11).TrimEnd(), 1, 20));
                if GetValueExcel(MyLoop, 12) <> '' then begin
                    Evaluate(ltConversToDicimal, GetValueExcel(MyLoop, 12));
                    ltItemJournalLine.Validate(Quantity, ltConversToDicimal);
                end;
                ltItemJournalLine.Validate("Unit of Measure Code", COPYSTR(GetValueExcel(MyLoop, 13).TrimEnd(), 1, 10));
                if GetValueExcel(MyLoop, 14) <> '' then begin
                    Evaluate(ltConversToDicimal, GetValueExcel(MyLoop, 14));
                    ltItemJournalLine.Validate("Unit Cost", ltConversToDicimal);
                end;
                if GetValueExcel(MyLoop, 15) <> '' then
                    ltItemJournalLine.Validate("Gen. Bus. Posting Group", COPYSTR(GetValueExcel(MyLoop, 15).TrimEnd(), 1, 20));
                ltItemJournalLine.Modify();
                if (GetValueExcel(MyLoop, 16).TrimEnd() <> '') and (ltItemJournalLine.Quantity <> 0) then begin
                    NewDate := 0D;
                    CreateDate := '';
                    CLEAR(DateArr);
                    if GetValueExcel(MyLoop, 17) <> '' then begin
                        CreateDate := GetValueExcel(MyLoop, 17).Replace('-', ',');
                        CreateDate := GetValueExcel(MyLoop, 17).Replace('/', ',');
                        Evaluate(DateArr[1], SelectStr(1, CreateDate));
                        Evaluate(DateArr[2], SelectStr(2, CreateDate));
                        Evaluate(DateArr[3], SelectStr(3, CreateDate));
                        if StrLen(SelectStr(3, CreateDate)) = 2 then
                            DateArr[3] := DateArr[3] + 2000;
                        NewDate := DMY2Date(DateArr[1], DateArr[2], DateArr[3]);
                    end;
                    InsertLot(ltItemJournalLine, COPYSTR(GetValueExcel(MyLoop, 16).TrimEnd(), 1, 50), NewDate, true);
                end else
                    if (GetValueExcel(MyLoop, 18).TrimEnd() <> '') and (ltItemJournalLine.Quantity <> 0) then begin
                        NewDate := 0D;
                        CreateDate := '';
                        CLEAR(DateArr);
                        if GetValueExcel(MyLoop, 17) <> '' then begin
                            CreateDate := GetValueExcel(MyLoop, 17).Replace('-', ',');
                            CreateDate := GetValueExcel(MyLoop, 17).Replace('/', ',');
                            Evaluate(DateArr[1], SelectStr(1, CreateDate));
                            Evaluate(DateArr[2], SelectStr(2, CreateDate));
                            Evaluate(DateArr[3], SelectStr(3, CreateDate));
                            if StrLen(SelectStr(3, CreateDate)) = 2 then
                                DateArr[3] := DateArr[3] + 2000;
                            NewDate := DMY2Date(DateArr[1], DateArr[2], DateArr[3]);
                        end;
                        InsertLot(ltItemJournalLine, COPYSTR(GetValueExcel(MyLoop, 18).TrimEnd(), 1, 50), NewDate, false);
                    end;
            end;
        end;

    end;

    local procedure InsertLot(pITemJournal: Record "Item Journal Line"; pLotNo: code[50]; pExpireDate: Date; IsLot: Boolean)
    var
        ltItem: Record Item;
        TempReservEntry: Record "Reservation Entry" temporary;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservStatus: Enum "Reservation Status";
    begin
        ltItem.GET(pITemJournal."Item No.");
        IF ltItem."Item Tracking Code" <> '' then
            if pLotNo <> '' then begin
                TempReservEntry.Init();
                TempReservEntry."Entry No." := GetLastReserveEntry();
                if IsLot then
                    TempReservEntry."Lot No." := pLotNo
                else
                    TempReservEntry."Serial No." := pLotNo;
                TempReservEntry.Quantity := pITemJournal.Quantity;
                if pExpireDate <> 0D then
                    TempReservEntry."Expiration Date" := pExpireDate
                else
                    TempReservEntry."Expiration Date" := Today();
                TempReservEntry.Insert();

                CreateReservEntry.SetDates(0D, TempReservEntry."Expiration Date");
                If pITemJournal."Entry Type" = pITemJournal."Entry Type"::Transfer then begin
                    CreateReservEntry.SetNewExpirationDate(pExpireDate);
                    CreateReservEntry.SetNewTrackingFromItemJnlLine(pITemJournal);
                end;
                CreateReservEntry.CreateReservEntryFor(Database::"Item Journal Line", pITemJournal."Entry Type".AsInteger(), pITemJournal."Journal Template Name", pITemJournal."Journal Batch Name",
                    0, pITemJournal."Line No.", pITemJournal."Qty. per Unit of Measure", TempReservEntry.Quantity, TempReservEntry.Quantity * pITemJournal."Qty. per Unit of Measure", TempReservEntry);
                CreateReservEntry.CreateEntry(pITemJournal."Item No.", pITemJournal."Variant Code", pITemJournal."Location Code", '', 0D, 0D, 0, ReservStatus::Surplus);
            end;

    end;

    local procedure GetLastReserveEntry(): Integer
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.reset();
        ReservationEntry.SetCurrentKey("Entry No.");
        if ReservationEntry.FindLast() then
            exit(ReservationEntry."Entry No." + 1);
        exit(1);
    end;


    /// <summary>
    /// GetValueExcel.
    /// </summary>
    /// <param name="pRowNumber">Integer.</param>
    /// <param name="pColumnNumber">integer.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetValueExcel(pRowNumber: Integer; pColumnNumber: integer): Text
    var
        ltExcelBuffer: Record "Excel Buffer";
    begin
        IF NOT ltExcelBuffer.GET(pRowNumber, pColumnNumber) THEN
            ltExcelBuffer.INIT();
        EXIT(ltExcelBuffer."Cell Value as Text");
    end;

    local procedure GetLastItemJournalLine(pTemplateName: Text[50]; pBatchName: Text[50]): Integer
    var
        ltItemJournalLine: Record "Item Journal Line";
    begin
        ltItemJournalLine.reset();
        ltItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        ltItemJournalLine.SetRange("Journal Template Name", pTemplateName);
        ltItemJournalLine.SetRange("Journal Batch Name", pBatchName);
        if ltItemJournalLine.FindLast() then
            exit(ltItemJournalLine."Line No." + 10000);
        exit(10000);
    end;

    var
        gvExcelBuffer, ExcelBufferReset : Record "Excel Buffer";
        gvInstr: InStream;

        FileName, SheetName, BatchName, TemplateName : text;
        gvStartFromRowNo, LastRow, MyLoop : integer;


}
