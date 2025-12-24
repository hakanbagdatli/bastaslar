using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Settings
{
    public partial class General : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Developer", 36);
            PageProperties(Language.GetFixed("GenelAyarlar"), 7);
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