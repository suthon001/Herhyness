/// <summary>
/// Unknown MRC Interface Permis (ID 70000).
/// </summary>
permissionset 70000 "MRC Interface Permis"
{
    Assignable = true;
    Caption = 'Interface Permis', MaxLength = 30;
    Permissions =
        report "MRC Sales Credit Memo (Post)" = X,
        report "MRC Report Sales Credit Memo" = X,
        report "MRC Report Sales Invoice" = X,
        report "MRC Sales Invoice (Post)" = X,
        report "MRC Purchase Order" = X,
        report "MRC Import OB Item Journal" = X;
}
