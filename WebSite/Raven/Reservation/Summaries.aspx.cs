using Tools;
using System;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Reservation
{
    public partial class Summaries : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 17);
            PageProperties(Language.GetFixed("PotansiyelMusteri"), 3);
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
            if (Request["catid"] != null)
            {
                CatID = Convert.ToInt32(Request["catid"].ToString());
                whereClause += " AND CatID=" + CatID;
                Breadcrumb.Add(Bll.Inspections.Select(CatID, "")[0].PNRCode.ToString(), Developer.ConstantUrl("inspections") + "?dhx=edit&catid=0&id=" + CatID);
            }

            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters
    }
}