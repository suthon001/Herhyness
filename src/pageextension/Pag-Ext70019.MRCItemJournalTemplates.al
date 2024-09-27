/// <summary>
/// PageExtension MRC Item Journal Templates (ID 70019) extends Record Item Journal Templates.
/// </summary>
pageextension 70019 "MRC Item Journal Templates" extends "Item Journal Templates"
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
