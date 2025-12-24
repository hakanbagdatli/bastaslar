using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Seo
{
    public partial class General : System.Web.UI.Page
    {

        public int RecordID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Admin", 29);
            PageProperties(Language.GetFixed("MetaTags"), 5);
            Paramaters();
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

        protected void Paramaters()
        {
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters

    }
}