using System;
using Tools;

namespace WebSite.Partner
{
    public partial class Default : System.Web.UI.Page
    {
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            UserData = Developer.LoggedPartner();
        }
    }
}