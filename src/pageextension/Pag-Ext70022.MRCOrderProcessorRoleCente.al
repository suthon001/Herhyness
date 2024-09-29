/// <summary>
/// PageExtension MRC Order Processor Role Cente (ID 70022) extends Record Order Processor Role Center.
/// </summary>
pageextension 70022 "MRC Order Processor Role Cente" extends "Order Processor Role Center"
{
    actions
    {
        addlast(Action62)
        {
            action(PostedItemJournal)
            {
                ApplicationArea = Location;
                Caption = 'Posted Item Journal';
                RunObject = Page "MRC Posted Item Journal Lines";
                ToolTip = 'Executes the Posted Item Journal action.';

            }
        }
    }
}
