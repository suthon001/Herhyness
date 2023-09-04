/// <summary>
/// PageExtension MRC Purchase Order List (ID 70001) extends Record Purchase Order List.
/// </summary>
pageextension 70001 "MRC Purchase Order List" extends "Purchase Order List"
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
                PromotedCategory = Category10;
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
