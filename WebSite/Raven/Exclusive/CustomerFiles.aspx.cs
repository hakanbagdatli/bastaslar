using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.General
{
    public partial class CustomerFiles : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 10);
            PageProperties(Language.GetFixed("MusteriEvrak"), 1);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            #region parameters
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CustomerID in (" + Select.MultipleCategoryID(CatID) + ")";
                Breadcrumb.Add(Bll.Customers.Select(CatID, "")[0].Name.ToString() + " " + Bll.Customers.Select(CatID, "")[0].Surname.ToString(), Developer.ConstantUrl("customers"));
            }
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, Developer.ConstantUrl("features") + "?catid=" + CatID);
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, Developer.ConstantUrl("features") + "?catid=" + CatID);
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
        //--------------------------------------------------------- paramaters
    }
}