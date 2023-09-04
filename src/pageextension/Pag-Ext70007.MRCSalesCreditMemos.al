/// <summary>
/// PageExtension MRC Sales Credit Memos (ID 70007) extends Record Sales Credit Memos.
/// </summary>
pageextension 70007 "MRC Sales Credit Memos" extends "Sales Credit Memos"
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
                    RecSalesHeader: Record "Sales Header";
                begin
                    RecSalesHeader.RESET();
                    RecSalesHeader.SetRange("Document Type", rec."Document Type");
                    RecSalesHeader.SetRange("No.", rec."No.");
                    Report.Run(Report::"MRC Report Sales Credit Memo", TRUE, TRUE, RecSalesHeader);
                end;
            }
        }
        modify(Print_Sales_CreditMemo)
        {
            Visible = false;
        }
    }
}
