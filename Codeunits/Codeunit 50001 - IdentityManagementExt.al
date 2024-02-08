// /// <summary>
// /// Codeunit Identity Management Ext (ID 50013).
// /// </summary>
// codeunit 50001 "Identity Management Ext"
// {
//     /// <summary>
//     /// GetMaskedNavPassword.
//     /// </summary>
//     /// <param name="UserSecurityID">GUID.</param>
//     /// <returns>Return variable MaskedPassword of type Text[80].</returns>
//     procedure GetMaskedNavPassword(UserSecurityID: GUID) MaskedPassword: Text[80]
//     begin
//         IF UserAccountHelper.IsPasswordSet(UserSecurityID) THEN
//             MaskedPassword := '********'
//         ELSE
//             MaskedPassword := '';
//     end;

//     var
//         // UserAccountHelper	DotNet	Microsoft.Dynamics.Nav.NavUserAccount.NavUserAccountHelper.'Microsoft.Dynamics.Nav.NavUserAccount, Version=9.0.*.*, Culture=neutral, PublicKeyToken=31bf3856ad364e35'	
//         UserAccountHelper: DotNet MyUserAccountHelper;


// }
// //kamlesh
// dotnet
// {
//     assembly(Microsoft.Dynamics.Nav.NavUserAccount)
//     {
//         type(Microsoft.Dynamics.Nav.NavUserAccount.NavUserAccountHelper; MyUserAccountHelper) { }
//         type(Microsoft.Dynamics.Nav.NavDocumentService.NavDocumentServiceHelper; MyuserDocumentService) { }
//     }

// }
// //kamlesh