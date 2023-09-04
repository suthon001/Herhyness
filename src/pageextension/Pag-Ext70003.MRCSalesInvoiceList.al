/// <summary>
/// OnAction.
/// </summary>
pageextension 70003 "MRC Sales Invoice List" extends "Sales Invoice List"
{
    actions
    {
        addafter(Print_Sales_Invoice)
        {
            action("MRC Print_Sales_Invoice")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Sales Invoice action.';
                trigger OnAction()
                var
                    RecSalesHeader: Record "Sales Header";
                begin
                    RecSalesHeader.RESET();
                    RecSalesHeader.SetRange("Document Type", rec."Document Type");
                    RecSalesHeader.SetRange("No.", rec."No.");
                    Report.Run(Report::"MRC Report Sales Invoice", TRUE, TRUE, RecSalesHeader);
                end;
            }
        }
        modify(Print_Sales_Invoice)
        {
            Visible = false;
        }
    }
}
