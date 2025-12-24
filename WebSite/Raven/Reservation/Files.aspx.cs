using System;
using Tools;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Reservation
{
    public partial class Files : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0, TypeID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 18);
            PageProperties(Language.GetFixed("DosyaYonetimi"), 3);
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title, int MenuID)
        {
            #region parameters
            //---------------------------------------------------------
            if (Request["type"] != null)
                TypeID = Convert.ToInt32(Request["type"].ToString());
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID=" + CatID;
                string previewURL = Developer.ConstantUrl("preview") + "?dhx=view&id=" + CatID;
                switch (TypeID)
                {
                    case 1:
                        Breadcrumb.Add(Bll.Reservations.Select(CatID, "")[0].SaleNumber, previewURL);
                        break;
                    default:
                        Breadcrumb.Add(Bll.Reservations.Select(CatID, "")[0].ReservationNumber, previewURL);
                        break;
                }
            }
            #endregion

            #region BreadCrumb
            //---------------------------------------------------------
            if (Request["dhx"] != null)
            {
                if (Request["dhx"].ToString() == "edit")
                {
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                    Breadcrumb.Add(Title, "javascript:;");
                    Breadcrumb.SetTree(Language.GetFixed("Duzenle"), ltrTree, this.Page);
                }
                else
                {
                    RecordID = 0;
                    Breadcrumb.Add(Title, "javascript:;");
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