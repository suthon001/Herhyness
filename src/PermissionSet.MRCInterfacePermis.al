/// <summary>
/// Unknown MRC Interface Permis (ID 70000).
/// </summary>
permissionset 70000 "MRC Interface Permis"
{
    Assignable = true;
    Caption = 'Interface Permis', MaxLength = 30;
    Permissions =
        table "MRC Interface Log Entry" = X,
        tabledata "MRC Interface Log Entry" = RMID,
        table "MRC Posted Item Journal Line" = X,
        tabledata "MRC Posted Item Journal Line" = RMID,
        page "MRC Interface Log Card" = X,
        page "MRC Posted Item Journal Lines" = X,
        page "Interface Item Journal" = X,
        page "Interface Transfer Order" = X,
        page "MRC Interface Log Entries" = X,
        report "MRC Sales Credit Memo (Post)" = X,
        report "MRC Report Sales Credit Memo" = X,
        report "MRC Report Sales Invoice" = X,
        report "MRC Sales Invoice (Post)" = X,
        report "MRC Purchase Order" = X,
        report "MRC Import OB Item Journal" = X,
        codeunit "MRC Func" = X;
}
