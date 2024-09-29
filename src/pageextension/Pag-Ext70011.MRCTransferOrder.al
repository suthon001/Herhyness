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
                Caption = 'Submit to PDA';
                Image = Interaction;
                ApplicationArea = all;
                ToolTip = 'Executes the Submit to PDA action.';
                trigger OnAction()
                var
                    TransferLine: Record "Transfer Line";
                    MRCInterfaceLogEntry: Record "MRC Interface Log Entry";
                    MRCFunc: Codeunit "MRC Func";
                begin
                    rec.TestField("Transfer-to Code");
                    rec.TestField("Transfer-from Code");
                    TransferLine.reset();
                    TransferLine.SetRange("Document No.", rec."No.");
                    if TransferLine.FindSet() then
                        repeat
                            TransferLine.TestFieldAPI();
                        until TransferLine.Next() = 0
                    else
                        Error('Nothing to Send');

                    MRCFunc.InterfaceTransferToPDA(rec);
                    MRCInterfaceLogEntry.reset();
                    MRCInterfaceLogEntry.SetRange("Action Page", MRCInterfaceLogEntry."Action Page"::Transfer);
                    MRCInterfaceLogEntry.SetRange("Primary Key 1", rec."No.");
                    page.Run(0, MRCInterfaceLogEntry);
                end;
            }
            action(ClearInterface)
            {
                Caption = 'Clear Interface';
                Image = Cancel;
                ApplicationArea = all;
                ToolTip = 'Executes the Clear Interface  action.';
                trigger OnAction()
                begin
                    rec."MRC Interface Completed" := false;
                    rec."MRC Send DateTime" := 0DT;
                    rec.Modify();
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
                    MRCInterfaceLogEntry.SetRange("Action Page", MRCInterfaceLogEntry."Action Page"::Transfer);
                    MRCInterfaceLogEntry.SetRange("Primary Key 1", rec."No.");
                    page.Run(0, MRCInterfaceLogEntry);
                end;
            }
        }
        addafter(Category_Category6)
        {
            group(InterfaceTOPDAPromote)
            {
                Caption = 'API Management';
                actionref(InterfaceToPDA_Promoted; InterfaceToPDA)
                {
                }
                actionref(ClearInterface_Promoted; ClearInterface)
                {
                }
                actionref(LogInterfaceToPDA_Promoted; LogInterfaceToPDA)
                {
                }
            }
        }
    }
}


