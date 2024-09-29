/// <summary>
/// TableExtension MRC Transfer Header (ID 70002) extends Record Transfer Header.
/// </summary>
tableextension 70002 "MRC Transfer Header" extends "Transfer Header"
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
        field(70007; "MRC Interface Completed"; Boolean)
        {
            Caption = 'Interface Completed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70008; "MRC Send DateTime"; DateTime)
        {
            Caption = 'Send Date Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70009; "MRC Transaction ID"; Integer)
        {
            Caption = 'Transaction ID';
            Editable = false;
        }
        field(70010; "MRC Interface"; Boolean)
        {
            Caption = 'Interface';
            DataClassification = CustomerContent;
            Editable = false;
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                Location: Record Location;
            begin
                if not Location.GET(rec."Transfer-from Code") then
                    Location.Init();
                if Location."MRC Main" then
                    rec."MRC Direction" := rec."MRC Direction"::Order
                else
                    rec."MRC Direction" := rec."MRC Direction"::Advice;
            end;
        }
    }
    trigger OnInsert()
    var
        ltNoSeries: Record "No. Series";
    begin
        if ltNoSeries.GET(rec."No. Series") then
            rec."MRC Interface" := ltNoSeries."MRC Interface";
    end;
}
