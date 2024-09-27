/// <summary>
/// TableExtension MRC Item Ledger Entry (ID 70006) extends Record Item Ledger Entry.
/// </summary>
tableextension 70006 "MRC Item Ledger Entry" extends "Item Ledger Entry"
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
        field(70010; "MRC Transaction ID"; Integer)
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        field(70011; "MRC Original Quantity"; Decimal)
        {
            Caption = 'Original Quantity';
            DataClassification = CustomerContent;
        }
        field(70012; "MRC Address"; Text[250])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
    }
}
