/// <summary>
/// TableExtension MRC Item Journal Line (ID 70005) extends Record Item Journal Line.
/// </summary>
tableextension 70005 "MRC Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(70000; "MRC Ship-to Name"; Text[200])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(70001; "MRC Ship-to Address"; Text[255])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(70002; "MRC Ship-to District"; Text[50])
        {
            Caption = 'Ship-to District';
            DataClassification = CustomerContent;
        }
        field(70003; "MRC Ship-to Post Code"; Text[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
        }
        field(70004; "MRC Ship-to Mobile No."; Text[50])
        {
            Caption = 'Ship-to Mobile No.';
            DataClassification = CustomerContent;
        }
        field(70005; "MRC Ship-to Phone No."; Text[20])
        {
            Caption = 'Ship-to Phone No.';
            DataClassification = CustomerContent;
        }
        field(70006; "MRC Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';
        }
        field(70007; "MRC Shipping Agent"; code[10])
        {
            TableRelation = "Shipping Agent".Code;
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent';
        }
        field(70008; "MRC Direction"; enum "MRC Direction")
        {
            Caption = 'Direction';
            DataClassification = CustomerContent;
        }
        field(70009; "MRC Interface Completed"; Boolean)
        {
            Caption = 'Interface Completed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70010; "MRC Send DateTime"; DateTime)
        {
            Caption = 'Send Date Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70011; "MRC Transaction ID"; Integer)
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        field(70012; "MRC Interface"; Boolean)
        {
            Caption = 'Interface';
            DataClassification = CustomerContent;
        }
        field(70013; "MRC Search Description"; Text[100])
        {
            Caption = 'Search Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Search Description" where("No." = field("Item No.")));
        }
        field(70014; "MRC Description TH"; Text[100])
        {
            Caption = 'Description TH';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."MRC Description TH" where("No." = field("Item No.")));
        }
        field(70015; "MRC Original Quantity"; Decimal)
        {
            Caption = 'Original Quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                rec.Validate(Quantity, rec."MRC Original Quantity");
            end;
        }
        field(70016; "MRC Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }

    }
    /// <summary>
    /// TestFieldAPI.
    /// </summary>
    procedure TestFieldAPI()
    begin
        rec.TestField("Posting Date");
        rec.TestField("Document No.");
        rec.TestField("Item No.");
        rec.TestField("Unit of Measure Code");
        rec.TestField(Quantity);
        rec.TestField("Location Code");
        rec.TestField("MRC Interface Completed", false);
    end;
}
