using System;
using System.Web;

namespace Utility
{
    public class Feature
    {
        public static string ActiveLanguage = "";
        //---------------------------------------------------------

        public static string CRMLanguage = "EN";
        //---------------------------------------------------------

        public static string SiteDomain = "";
        //---------------------------------------------------------

        public static string Version { get { return DateTime.Now.ToString("yyyy.MM.dd.hhss"); } }
        //---------------------------------------------------------

        public static string ResolveUrl(string relativeUrl)
        {
            try
            {
                System.Web.UI.Page p = HttpContext.Current.Handler as System.Web.UI.Page; 
                return @"" + p.ResolveUrl(relativeUrl);
            }
            catch { return relativeUrl + "/"; }
        }
        //-------------------------------------------------------------------

        public static string UploadFolder { get { return ResolveUrl("~") + "uploads/"; } }
        //---------------------------------------------------------

        public static string LogFolder { get { return UploadFolder + "logs/"; } }
        //---------------------------------------------------------

        public static string ImageFolder { get { return UploadFolder + "images/"; } }
        //---------------------------------------------------------

        public static string FileFolder { get { return UploadFolder + "files/"; } }
        //---------------------------------------------------------

        public static string ReportFileFolder { get { return UploadFolder + "reports/"; } }
        //---------------------------------------------------------

        public static string VideoFolder { get { return UploadFolder + "videos/"; } }
        //---------------------------------------------------------
        
        public static string AgencyFolder { get { return UploadFolder + "agencies/"; } }
        //---------------------------------------------------------

        public static string TempFolder { get { return UploadFolder + "temp/"; } }
        //---------------------------------------------------------

        public static string QRFolder { get { return UploadFolder + "qrcodes/"; } }
        //---------------------------------------------------------

        public static string EditorFolder { get { return UploadFolder + "editor/"; } }
        //---------------------------------------------------------

    }
}