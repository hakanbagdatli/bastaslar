using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Exclusive
{
    public partial class Brokers : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 9);
            PageProperties(Language.GetFixed("Brokers"), 1);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = MenuID.ToString();
            //---------------------------------------------------------

            #region parameters
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                if (CatID > 0)
                {
                    whereClause += " AND CatID=" + CatID;
                    Breadcrumb.Add(Bll.Agencies.Select(CatID, "")[0].Title.ToString(), Developer.ConstantUrl("agency") + "?dhx=edit&id=" + CatID);
                }
            }
            else
                whereClause += " AND CatID>0";
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("brokers") + "?catid=" + CatID);
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("brokers") + "?catid=" + CatID);
                    Breadcrumb.SetTree(Language.GetFixed("YeniKayit"), ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion
        }
        //--------------------------------------------------------- breadcrumb and parameters
    }
}