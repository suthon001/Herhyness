/// <summary>
/// PageExtension MRC Company Information (ID 70010) extends Record Company Information.
/// </summary>
pageextension 70010 "MRC Company Information" extends "Company Information"
{
    layout
    {
        addafter("Bank Name")
        {
            field("MRC Bank Name Eng"; rec."MRC Bank Name Eng")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Bank Name Eng field.';
            }
            field("MRC Bank Branch Name Thai"; rec."MRC Bank Branch Name Thai")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Bank Branch Name Thai field.';
            }
            field("MRC Bank Branch Name Eng"; rec."MRC Bank Branch Name Eng")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Bank Branch Name Eng field.';
            }
        }
        addafter("Bank Account No.")
        {
            field("MRC Bank Account Name"; rec."MRC Bank Account Name")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Bank Account Name field.';
            }
        }
    }
}
