/// <summary>
/// PageExtension MRC Posted Sales Invoices (ID 70004) extends Record Posted Sales Invoices.
/// </summary>
pageextension 70004 "MRC Posted Sales Invoices" extends "Posted Sales Invoices"
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
                    RecSalesHeader: Record "Sales Invoice Header";
                begin
                    RecSalesHeader.RESET();
                    RecSalesHeader.SetRange("No.", rec."No.");
                    Report.Run(Report::"MRC Sales Invoice (Post)", TRUE, TRUE, RecSalesHeader);
                end;
            }
        }
        modify(Print_Sales_Invoice)
        {
            Visible = false;
        }
    }
}
