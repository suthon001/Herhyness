/// <summary>
/// TableExtension MRC Transfer Line (ID 70011) extends Record Transfer Line.
/// </summary>
tableextension 70011 "MRC Transfer Line" extends "Transfer Line"
{
    /// <summary>
    /// TestFieldAPI.
    /// </summary>
    procedure TestFieldAPI()
    begin
        rec.TestField("Document No.");
        rec.TestField("Item No.");
        rec.TestField("Unit of Measure Code");
        rec.TestField(Quantity);
    end;
}
