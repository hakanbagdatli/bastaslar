using Tools;
using System;

namespace WebSite.Partner
{
    public partial class Status : System.Web.UI.Page
    {
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetPartner("ProjeDurumlari"));
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title)
        {
            Page.Title = Title;
        }
        //--------------------------------------------------------- paramaters
    }
}