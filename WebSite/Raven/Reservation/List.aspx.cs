using Tools;
using System;
using System.Web;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Reservation
{
    public partial class Reservations : System.Web.UI.Page
    {
        public string whereClause = "", PageTitle = Language.GetFixed("Rezervasyon");
        public int CatID = 0, RecordID = 0, TurID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 18);
            Paramaters();
            PageProperties(PageTitle, 3);
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
            if (Request["type"] != null)
            {
                TurID = Convert.ToInt32(Request["type"].ToString());
                whereClause += " AND TurID=" + TurID;
                if (TurID == 0)
                    PageTitle = Language.GetFixed("Rezervasyon");
                else if (TurID == 1)
                    PageTitle = Language.GetFixed("Satislar");
                else if (TurID == 2)
                    PageTitle = Language.GetFixed("Surecte");
            }


            #region parameters
            //---------------------------------------------------------
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                if (CatID > 0)
                {
                    whereClause += " AND AgencyID=" + CatID;
                    Breadcrumb.Add(Bll.Agencies.Select(CatID, "")[0].Title.ToString(), Developer.ConstantUrl("agency") + "?dhx=edit&id=" + CatID);
                }
            }
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