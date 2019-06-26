Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Optimization
Imports System.Web.UI

Public Module BundleConfig
    ' For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkID=303951
    Public Sub RegisterBundles(bundles As BundleCollection)
        bundles.Add(New ScriptBundle("~/bundles/WebFormsJs").Include(
            "~/public/Scripts/WebForms/WebForms.js",
            "~/public/Scripts/WebForms/WebUIValidation.js",
            "~/public/Scripts/WebForms/MenuStandards.js",
            "~/public/Scripts/WebForms/Focus.js", "~/public/Scripts/WebForms/GridView.js",
            "~/public/Scripts/WebForms/DetailsView.js",
            "~/public/Scripts/WebForms/TreeView.js",
            "~/public/Scripts/WebForms/WebParts.js"))

        ' Order is very important for these files to work, they have explicit dependencies
        bundles.Add(New ScriptBundle("~/bundles/MsAjaxJs").Include(
            "~/public/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
            "~/public/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
            "~/public/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
            "~/public/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"))

        ' Use the Development version of Modernizr to develop with and learn from. Then, when you’re
        ' ready for production, use the build tool at http://modernizr.com to pick only the tests you need
        bundles.Add(New ScriptBundle("~/bundles/modernizr").Include(
            "~/public/Scripts/modernizr-*"))

        ScriptManager.ScriptResourceMapping.AddDefinition("respond", New ScriptResourceDefinition() With {
            .Path = "~/public/Scripts/respond.min.js",
            .DebugPath = "~/public/Scripts/respond.js"})

    End Sub
End Module
