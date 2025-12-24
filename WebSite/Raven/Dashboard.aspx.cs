using Tools;
using System;
using Entities;

namespace WebSite.Raven
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = StaticList.Settings.CompanyName + " CRM";
            if (Developer.UserToken("").Statu == 5)
                Response.Redirect(Developer.ConstantUrl("partner"));
        }
    }
}