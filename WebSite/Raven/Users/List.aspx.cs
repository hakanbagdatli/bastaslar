using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Users
{
    public partial class List : System.Web.UI.Page
    {
        public int RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Admin", 33);
            PageProperties(Language.GetFixed("KullaniciList"), 6);
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