/// <summary>
/// Table MRC Interface Log Entry (ID 70000).
/// </summary>
table 70000 "MRC Interface Log Entry"
{
    Caption = 'Interface Log Entry';
    DataClassification = CustomerContent;
    LookupPageId = "MRC Interface Log Entries";
    DrillDownPageId = "MRC Interface Log Entries";
    fields
    {
        field(1; "Transaction ID"; Integer)
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        field(2; "Action Page"; Enum "MRC Interface Document Type")
        {
            Caption = 'Action Page';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "PDA Entry Ref."; Integer)
        {
            Caption = 'PDA Entry Ref.';
        }
        field(5; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Success","Failed";
            OptionCaption = 'Success,Failed';
        }
        field(6; "Method Type"; Option)
        {
            Caption = 'Method Type';
            OptionMembers = "Insert","Update","Delete";
            OptionCaption = 'Insert,Update,Delete';
        }
        field(7; "Direction"; Option)
        {
            Caption = 'Direction';
            OptionMembers = "Inbound","Outbound";
            OptionCaption = 'Inbound,Outbound';
        }
        field(8; "Description"; text[2047])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "Json Log"; Blob)
        {
            Caption = 'Json Format';
        }
        field(10; "Response Log"; Blob)
        {
            Caption = 'Response Log';
        }

    }
    keys
    {
        key(PK; "Transaction ID")
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// GetLastTransactionID.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetLastTransactionID(): Integer
    var
        ltInterfaceLog: Record "MRC Interface Log Entry";
    begin
        ltInterfaceLog.reset();
        ltInterfaceLog.SetCurrentKey("Transaction ID");
        ltInterfaceLog.ReadIsolation := IsolationLevel::ReadCommitted;
        if ltInterfaceLog.FindLast() then
            exit(ltInterfaceLog."Transaction ID" + 1);
        exit(1);
    end;
}
