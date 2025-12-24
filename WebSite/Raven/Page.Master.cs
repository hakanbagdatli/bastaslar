using System;
using Tools;
using System.Web;

namespace WebSite.Raven
{
    public partial class Page : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("", 9);
        }
    }
}