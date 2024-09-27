/// <summary>
/// TableExtension MRC General Ledger Setup (ID 70007) extends Record General Ledger Setup.
/// </summary>
tableextension 70007 "MRC General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(70000; "MRC To PDA URL (Transfer)"; Text[250])
        {
            Caption = 'Interface To PDA URL (Transfer)';
            DataClassification = CustomerContent;
        }
        field(70001; "MRC To PDA URL (Item Journal)"; Text[250])
        {
            Caption = 'Interface To PDA URL (Item Journal)';
            DataClassification = CustomerContent;
        }
    }
}
