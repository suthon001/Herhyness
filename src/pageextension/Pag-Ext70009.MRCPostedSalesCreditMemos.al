/// <summary>
/// PageExtension MRC Posted Sales Credit Memos (ID 70009) extends Record Posted Sales Credit Memos.
/// </summary>
pageextension 70009 "MRC Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    actions
    {
        addafter(Print_Sales_CreditMemo)
        {
            action("MRCPrint_Sales_CreditMemo")
            {
                ApplicationArea = All;
                Caption = 'Sales Credit Memo';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                ToolTip = 'Show Report';
                trigger OnAction()
                var
                    RecSalesHeader: Record "Sales Cr.Memo Header";
                begin
                    RecSalesHeader.RESET();
                    RecSalesHeader.SetRange("No.", rec."No.");
                    Report.Run(Report::"MRC Sales Credit Memo (Post)", TRUE, TRUE, RecSalesHeader);
                end;
            }
        }
        modify(Print_Sales_CreditMemo)
        {
            Visible = false;
        }
    }
}


