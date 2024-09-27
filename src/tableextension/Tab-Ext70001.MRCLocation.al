/// <summary>
/// TableExtension MRC Location (ID 70001) extends Record Location.
/// </summary>
tableextension 70001 "MRC Location" extends Location
{
    fields
    {
        field(70000; "MRC Main"; Boolean)
        {
            Caption = 'Main';
            DataClassification = ToBeClassified;
        }
    }
}
