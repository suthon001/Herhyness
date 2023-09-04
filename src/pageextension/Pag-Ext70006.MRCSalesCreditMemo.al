/// <summary>
/// OnAction.
/// </summary>
pageextension 70006 "MRC Sales Credit Memo" extends "Sales Credit Memo"
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
