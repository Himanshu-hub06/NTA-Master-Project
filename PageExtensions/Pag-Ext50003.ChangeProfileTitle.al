/*pageextension 50003 "Change Profile Title" extends "Profile Card"
{
      layout
         {
             addlast(ControlAddIn = 'ChangeTabTitle', ApplicationArea = All)
             {
                 Script[OnAfterGetRecord] = 'OnAfterGetRecord';
             }
         }

         actions
         {
             actions
             {
                 OnAfterGetRecord()
                 {

                     
                     window := window.GetCurrentWindow();

                     // Change the title of the browser tab
                     window.document.title := 'NTA ERP';
                 }
             }
         }
         //var window : DotNet "'Microsoft.Dynamics.Nav.Client'.Microsoft.Dynamics.Nav.Client.ScriptObject" RUNONCLIENT;
}*/
