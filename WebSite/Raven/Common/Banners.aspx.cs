using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Common
{
    public partial class Banners : System.Web.UI.Page
    {
        public int RecordID = 0, LangID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Editor", 21);
            PageProperties(Language.GetFixed("BannerList"), 4);
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
            if (Request["lang"] != null)
                LangID = Convert.ToInt32(Request["lang"].ToString());
            //---------------------------------------------------------
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters
    }
}