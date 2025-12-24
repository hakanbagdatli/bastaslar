using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Users
{
    public partial class Profile : System.Web.UI.Page
    {
        public int UserID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserID = Developer.UserToken("").UserID;
            Developer.CheckLogin("Editor", 34);
            PageProperties(Language.GetFixed("Profil"), 6);
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