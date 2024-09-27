/// <summary>
/// PageExtension MRC Item Ledger Entries (ID 70015) extends Record Item Ledger Entries.
/// </summary>
pageextension 70015 "MRC Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("MRC Direction"; rec."MRC Direction")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Direction field.';
            }
            field("MRC Ship-to Name"; Rec."MRC Ship-to Name")
            {
                ToolTip = 'Specifies the value of the Ship-to Name field.';
                ApplicationArea = all;
            }
            field("MRC Ship-to Address"; Rec."MRC Ship-to Address")
            {
                ToolTip = 'Specifies the value of the Ship-to Address field.';
                ApplicationArea = all;
            }
            field("MRC Ship-to District"; Rec."MRC Ship-to District")
            {
                ToolTip = 'Specifies the value of the Ship-to District field.';
                ApplicationArea = all;
            }
            field("MRC Ship-to Post Code"; Rec."MRC Ship-to Post Code")
            {
                ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                ApplicationArea = all;
            }
            field("MRC Ship-to Phone No."; Rec."MRC Ship-to Phone No.")
            {
                ToolTip = 'Specifies the value of the Ship-to Phone No. field.';
                ApplicationArea = all;
            }
            field("MRC Ship-to Mobile No."; Rec."MRC Ship-to Mobile No.")
            {
                ToolTip = 'Specifies the value of the Ship-to Mobile No. field.';
                ApplicationArea = all;
            }
            field("MRC Shipment Date"; rec."MRC Shipment Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shipment Date field.';
            }
            field("MRC Shipping Agent"; rec."MRC Shipping Agent")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shipping Agent field.';
            }
        }
    }
}

