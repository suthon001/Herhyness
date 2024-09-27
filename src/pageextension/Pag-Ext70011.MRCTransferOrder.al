/// <summary>
/// PageExtension MRC Transfer Order (ID 70011) extends Record Transfer Order.
/// </summary>
pageextension 70011 "MRC Transfer Order" extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the External Document No. field.';
            }
            field("MRC Direction"; rec."MRC Direction")
            {
                ToolTip = 'Specifies the value of the Direction field.';
                ApplicationArea = all;
            }
        }
        addafter(TransferLines)
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
    actions
    {
        addfirst(processing)
        {
            action(InterfaceToPDA)
            {
                Caption = 'Interface to PDA';
                Image = Interaction;
                ApplicationArea = all;
                ToolTip = 'Executes the Interface to PDA action.';
                trigger OnAction()
                var
                    MRCFunc: Codeunit "MRC Func";
                begin
                    MRCFunc.InterfaceTransferToPDA(rec);
                end;
            }
            action(LogInterfaceToPDA)
            {
                Caption = 'Log';
                Image = Log;
                ApplicationArea = all;
                ToolTip = 'Executes the Log action.';
                trigger OnAction()
                var
                    MRCInterfaceLogEntry: Record "MRC Interface Log Entry";
                begin
                    MRCInterfaceLogEntry.reset();
                    MRCInterfaceLogEntry.SetRange("Document Type", MRCInterfaceLogEntry."Document Type"::Transfer);
                    MRCInterfaceLogEntry.SetRange("Document No.", rec."No.");
                    page.Run(0, MRCInterfaceLogEntry);
                end;
            }
        }
        addafter(Category_Category6)
        {
            group(InterfaceTOPDAPromote)
            {
                Caption = 'Interface To PDA';
                actionref(InterfaceToPDA_Promoted; InterfaceToPDA)
                {
                }
                actionref(LogInterfaceToPDA_Promoted; LogInterfaceToPDA)
                {
                }
            }
        }
    }
}


