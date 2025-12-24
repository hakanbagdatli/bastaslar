using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Settings
{
    public partial class MenuContents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Developer", 40);
            PageProperties(Language.GetFixed("MenuIcerikAyarlar"), 7);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int CatID)
        {
            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = CatID.ToString();
            //---------------------------------------------------------
            Breadcrumb.SetTree(Title, ltrTree, this.Page);
        }
        //--------------------------------------------------------- breadcrumb
    }
}