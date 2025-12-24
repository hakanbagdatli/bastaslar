using Tools;
using System;

namespace WebSite.Partner
{
    public partial class Leads : System.Web.UI.Page
    {
        public string whereClause = "";
        public int CatID = 0, RecordID = 0;
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetPartner("PotansiyelMusteri"));
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title)
        {
            Page.Title = Title;
            whereClause = " AND SalesExecutive=" + UserData.id;

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