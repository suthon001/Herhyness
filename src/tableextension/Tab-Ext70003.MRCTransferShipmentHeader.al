/// <summary>
/// TableExtension MRC Transfer Shipment Header (ID 70003) extends Record Transfer Shipment Header.
/// </summary>
tableextension 70003 "MRC Transfer Shipment Header" extends "Transfer Shipment Header"
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
        field(70006; "MRC Direction"; enum "MRC Direction")
        {
            Caption = 'Direction';
            DataClassification = CustomerContent;
        }
        field(70009; "MRC Transaction ID"; Integer)
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
    }
}
