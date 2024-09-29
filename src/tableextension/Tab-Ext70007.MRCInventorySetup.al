/// <summary>
/// TableExtension MRC Inventory Setup (ID 70007) extends Record Inventory Setup.
/// </summary>
tableextension 70007 "MRC Inventory Setup" extends "Inventory Setup"
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
