using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Reservation
{
    public partial class Transactions : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0, PageTypeID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 18);
            PageProperties(Language.GetFixed("OdemePlani"), 3);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            #region parameters
            //---------------------------------------------------------
            if (Request["ptype"] != null)
                PageTypeID = Convert.ToInt32(Request["ptype"].ToString());
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID in (" + Select.MultipleCategoryID(CatID) + ")";
                Breadcrumb.Add(Bll.Reservations.Select(CatID, "")[0]._PlanName.ToString(), Developer.ConstantUrl("reservations") + "?dhx=edit&id=" + CatID);
            }
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("reservations") + "?id=" + CatID);
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("reservations") + "?id=" + CatID);
                    Breadcrumb.SetTree(Language.GetFixed("YeniKayit"), ltrTree, this.Page);
                }
            }
            else
                Breadcrumb.SetTree(Title, ltrTree, this.Page);

            #endregion

            if (PageTypeID == 15)
                MenuID = 2;
            //---------------------------------------------------------
            HiddenField hdnMenuID = this.Master.FindControl("hdnMenuID") as HiddenField;
            hdnMenuID.Value = MenuID.ToString();
        }
        //--------------------------------------------------------- paramaters
    }
}