using Tools;
using System;

namespace WebSite.Partner
{
    public partial class Profile : System.Web.UI.Page
    {
        public int RecordID = 0;
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            Page.Title = Language.GetPartner("Profil");
        }
        //--------------------------------------------------------- pageLoad işlemleri

    }
}