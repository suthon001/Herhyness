/// <summary>
/// PageExtension MRC Item Card (ID 70020) extends Record Item Card.
/// </summary>
pageextension 70020 "MRC Item Card" extends "Item Card"
{
    layout
    {
        addafter("Description 2")
        {
            field("MRC Description TH"; rec."MRC Description TH")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Description TH field.';
            }
        }
    }
}
