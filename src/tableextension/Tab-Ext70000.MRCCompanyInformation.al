/// <summary>
/// TableExtension MRC Company Information (ID 70000) extends Record Company Information.
/// </summary>
tableextension 70000 "MRC Company Information" extends "Company Information"
{
    fields
    {
        field(70000; "MRC Bank Name Eng"; Text[100])
        {
            Caption = 'Bank Name Eng';
            DataClassification = ToBeClassified;
        }
        field(70001; "MRC Bank Branch Name Eng"; Text[100])
        {
            Caption = 'Bank Branch Name Eng';
            DataClassification = ToBeClassified;
        }
        field(70002; "MRC Bank Branch Name Thai"; Text[100])
        {
            Caption = 'Bank Branch Name Thai';
            DataClassification = ToBeClassified;
        }
        field(70003; "MRC Bank Account Name"; Text[100])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
    }
}
