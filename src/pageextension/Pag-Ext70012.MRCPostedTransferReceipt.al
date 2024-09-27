/// <summary>
/// PageExtension MRC Posted Transfer Receipt (ID 70012) extends Record Posted Transfer Receipt.
/// </summary>
pageextension 70012 "MRC Posted Transfer Receipt" extends "Posted Transfer Receipt"
{
    layout
    {
        addlast(General)
        {
            field("MRC Direction"; rec."MRC Direction")
            {
                ToolTip = 'Specifies the value of the Direction field.';
                ApplicationArea = all;
            }
        }
        addafter(TransferReceiptLines)
        {
            group(ShipToInformation)
            {
                Caption = 'Ship-to';
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
            }
        }
    }
}



