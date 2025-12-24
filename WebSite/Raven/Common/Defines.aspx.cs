using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Common
{
    public partial class Defines : System.Web.UI.Page
    {
        public string whereClause = "";
        public int RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Paramaters();
            Developer.CheckLogin("Sales", 12);
            PageProperties(Language.GetFixed("Tanimlar"), 1);
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
            #region parameters
            //---------------------------------------------------------
            if (Request["id"] != null)
                whereClause += " AND id in(" + Request["id"].ToString() + ")";
            #endregion

            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters
    }
}