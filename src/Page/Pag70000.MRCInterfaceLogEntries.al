/// <summary>
/// Page MRC Interface Log Entries (ID 70000).
/// </summary>
page 70000 "MRC Interface Log Entries"
{
    ApplicationArea = All;
    Caption = 'Interface Log Entries';
    PageType = List;
    SourceTable = "MRC Interface Log Entry";
    UsageCategory = Administration;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ToolTip = 'Specifies the value of the Transaction ID field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("PDA Entry Ref."; Rec."PDA Entry Ref.")
                {
                    ToolTip = 'Specifies the value of the PDA Entry Ref. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DownloadJason)
            {
                Caption = 'Download Json';
                ApplicationArea = all;
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Download Json action.';
                trigger OnAction()
                var
                    ltInstream: InStream;
                    ltFileName: Text;
                begin
                    if rec."Json Format".HasValue then begin
                        rec."Json Format".CreateInStream(ltInstream, TextEncoding::UTF8);
                        ltFileName := rec."Document No." + '_' + format(Rec."Transaction ID") + '.txt';
                        DownloadFromStream(ltInstream, '', '', '', ltFileName);
                    end;
                end;

            }
        }
    }
}
