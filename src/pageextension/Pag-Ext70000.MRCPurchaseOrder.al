/// <summary>
/// PageExtension MRC Purchase Order (ID 70000) extends Record Purchase Order.
/// </summary>
pageextension 70000 "MRC Purchase Order" extends "Purchase Order"
{
    actions
    {
        addafter("Purchase Order")
        {
            action("MRC Purchase Order")
            {
                Caption = 'Purchase Order';
                Image = PrintReport;
                ApplicationArea = all;
                PromotedCategory = Report;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Purchase Order action.';
                trigger OnAction()
                var

                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.reset();
                    PurchaseHeader.SetRange("Document Type", rec."Document Type");
                    PurchaseHeader.SetRange("No.", rec."No.");
                    REPORT.RunModal(REPORT::"MRC Purchase Order", true, true, PurchaseHeader);
                end;
            }
        }
        modify("Purchase Order")
        {
            Visible = false;
        }
    }
}
