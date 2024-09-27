/// <summary>
/// PageExtension MRC No. Series (ID 70021) extends Record No. Series.
/// </summary>
pageextension 70021 "MRC No. Series" extends "No. Series"
{
    layout
    {
        addlast(Control1)
        {
            field("MRC Interface"; rec."MRC Interface")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Interface field.';
            }
        }
    }
}
