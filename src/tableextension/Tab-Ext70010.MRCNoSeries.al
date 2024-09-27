/// <summary>
/// TableExtension MRC No. Series (ID 70010) extends Record No. Series.
/// </summary>
tableextension 70010 "MRC No. Series" extends "No. Series"
{
    fields
    {
        field(70000; "MRC Interface"; Boolean)
        {
            Caption = 'Interface';
            DataClassification = CustomerContent;
        }
    }
}
