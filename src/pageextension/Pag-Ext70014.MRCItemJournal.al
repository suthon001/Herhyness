/// <summary>
/// PageExtension MRC Item Journal (ID 70014) extends Record Item Journal.
/// </summary>
pageextension 70014 "MRC Item Journal" extends "Item Journal"
{
    layout
    {
        addafter(Description)
        {
            field("MRC Description TH"; rec."MRC Description TH")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Description TH field.';
            }
            field("MRC Search Description"; rec."MRC Search Description")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Search Description field.';
            }
            field("MRC Address"; rec."MRC Address")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Address field.';
            }
            field("MRC Original Quantity"; rec."MRC Original Quantity")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Original Quantity field.';
            }
        }
        addlast(Control1)
        {
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
            field("MRC Interface"; rec."MRC Interface")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Interface field.';
            }
            field("MRC Interface Completed"; rec."MRC Interface Completed")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Interface Completed field.';
            }
            field("MRC Send DateTime"; rec."MRC Send DateTime")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Send Date Time field.';
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
                    MRCFunc.InterfaceItemJournalToPDA(rec);
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
                    MRCInterfaceLogEntry.SetRange("Document Type", MRCInterfaceLogEntry."Document Type"::"Item Journal");
                    MRCInterfaceLogEntry.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    MRCInterfaceLogEntry.SetRange("Document No.", rec."Document No.");
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


