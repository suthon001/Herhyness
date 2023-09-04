/// <summary>
/// Unknown MRC Permission (ID 70000).
/// </summary>
permissionset 70000 "MRC Permission"
{
    Assignable = true;
    Caption = 'Permission', MaxLength = 30;
    Permissions =
        report "MRC Sales Invoice (Post)" = X,
        report "MRC Sales Credit Memo (Post)" = X,
        report "MRC Purchase Order" = X,
        report "MRC Report Sales Invoice" = X,
        report "MRC Report Sales Credit Memo" = X;
}
