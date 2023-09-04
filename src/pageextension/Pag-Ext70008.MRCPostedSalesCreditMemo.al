/// <summary>
/// PageExtension MRC Posted Sales Credit Memo (ID 70008) extends Record Posted Sales Credit Memo.
/// </summary>
pageextension 70008 "MRC Posted Sales Credit Memo" extends "Posted Sales Credit Memo"
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

