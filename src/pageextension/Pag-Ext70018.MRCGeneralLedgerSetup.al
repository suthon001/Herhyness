/// <summary>
/// PageExtension MRC General Ledger Setup (ID 70018) extends Record General Ledger Setup.
/// </summary>
pageextension 70018 "MRC General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addafter(General)
        {
            group(MRCInterface)
            {
                Caption = 'Interface To PDA';
                field("MRC To PDA URL (Transfer)"; Rec."MRC To PDA URL (Transfer)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Interface To PDA URL (Transfer) field.';
                }
                field("MRC To PDA URL (Item Journal)"; Rec."MRC To PDA URL (Item Journal)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Interface To PDA URL (Item Journal) field.';
                }
            }
        }
    }
}

