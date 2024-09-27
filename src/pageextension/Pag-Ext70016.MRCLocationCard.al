/// <summary>
/// PageExtension MRC Location Card (ID 70016) extends Record Location Card.
/// </summary>
pageextension 70016 "MRC Location Card" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("MRC Main"; rec."MRC Main")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Main field.';
            }
        }
    }
}
