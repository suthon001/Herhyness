/// <summary>
/// PageExtension MRC Posted Sales Invoice (ID 70005) extends Record Posted Sales Invoice.
/// </summary>
pageextension 70005 "MRC Posted Sales Invoice" extends "Posted Sales Invoice"
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

