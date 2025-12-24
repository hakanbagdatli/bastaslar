using Tools;
using System;
using Entities.Items;
using System.Web;

namespace WebSite.Partner
{
    public partial class Announcements : System.Web.UI.Page
    {
        public int RecordID = 0;
        public string PLanguage = "2";
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetPartner("Duyurular"));
            //---------------------------------------------------------
            HttpCookie RavenCookies = HttpContext.Current.Request.Cookies["RavenData"];
            if (RavenCookies != null)
                PLanguage = RavenCookies.Values["RavenLang"];
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title)
        {
            Page.Title = Title;
            //---------------------------------------------------------
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters
    }
}