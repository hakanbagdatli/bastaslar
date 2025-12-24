using System;
using System.Web;
using Tools;

namespace WebSite.Partner.Shared
{
    public partial class Header : System.Web.UI.UserControl
    {
        public string PLanguage = "2";
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };
        protected void Page_Load(object sender, EventArgs e)
        {
            UserData = Developer.LoggedPartner(false);
            //---------------------------------------------------------
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
                PLanguage = RavenCookies.Values["RavenLang"];
        }
    }
}