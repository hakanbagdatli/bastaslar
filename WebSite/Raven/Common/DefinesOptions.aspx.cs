using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Common
{
    public partial class DefinesOptions : System.Web.UI.Page
    {
        public string whereClause = "";
        public bool forUser = false;
        public int CatID = 0, RecordID = 0, DefineID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 12);
            PageProperties(Language.GetFixed("Secenekler"), 1);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            #region parameters
            //---------------------------------------------------------
            if (Request["usr"] != null)
                forUser = true;
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID=" + CatID;
                Breadcrumb.Add(Bll.zDefines.Select(CatID, "")[0].Title.ToString(), Developer.ConstantUrl("defines") + "?dhx=edit&id=" + CatID);
            }
            //---------------------------------------------------------
            if (Request["define"] != null)
            {
                DefineID = Convert.ToInt32(Request["define"].ToString());
                whereClause += " AND DefineID=" + DefineID;
            }
            else
                whereClause += " AND DefineID=" + DefineID;
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.SetTree(Language.GetFixed("YeniKayit"), ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion

            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = MenuID.ToString();

        }
        //--------------------------------------------------------- breadcrumb and parameters

    }
}