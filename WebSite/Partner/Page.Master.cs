using Tools;
using System;

namespace WebSite.Partner
{
    public partial class Page : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = Entities.StaticList.Settings.CompanyName + " CRM";
            //Developer.CheckLogin("Agency", 1);
        }
    }
}