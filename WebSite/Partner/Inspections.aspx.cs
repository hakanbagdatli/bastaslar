using Tools;
using System;
using System.Collections;

namespace WebSite.Partner
{
    public partial class Inspections : System.Web.UI.Page
    {
        public string whereClause = "";
        public int RecordID = 0, TurID = 0;
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetPartner("Gosterimler"));
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string Title)
        {
            Page.Title = Title; 
            whereClause = " AND AgencyID=" + UserData.CatID;
            //---------------------------------------------------------
            if (UserData.CatID == 1)
            {
                whereClause = " AND _SaleExecutiveID=" + UserData.id;
                if (Request["catid"] != null)
                    whereClause += " AND AgencyID=" + Request["catid"];
            }
            //---------------------------------------------------------
            if (Request["type"] != null) { 
                TurID = Convert.ToInt32(Request["type"].ToString());
                whereClause += " AND TurID=" + TurID;
            }
            //---------------------------------------------------------
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "edit")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
        }
        //--------------------------------------------------------- paramaters

        protected bool inList(ArrayList myList, int item)
        {
            bool hasItem = false;
            for (int i = 0; i < myList.Count; i++)
            {
                if (item == Convert.ToInt32(myList[i]))
                    hasItem = true;
            }
            return hasItem;
        }
        //--------------------------------------------------------- is option inside a list
    }
}