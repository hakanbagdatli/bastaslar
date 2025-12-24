using System;
using Tools;

namespace WebSite.Partner
{
    public partial class MarketInsights : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
        }
    }
}