using System;
using System.Web;
using Tools;

namespace WebSite.Raven
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie RavenCookies = new HttpCookie("RavenData");
            RavenCookies.Expires = DateTime.Now.AddDays(-1); // Geçmiş bir tarih ayarlayarak siliyoruz
            HttpContext.Current.Response.Cookies.Add(RavenCookies); 
            Response.Redirect(Developer.ConstantUrl("login"));
        }
    }
}