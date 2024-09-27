/// <summary>
/// PageExtension MRC Location List (ID 70017) extends Record Location List.
/// </summary>
pageextension 70017 "MRC Location List" extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("MRC Main"; rec."MRC Main")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Main field.';
            }
        }
    }
}

