using Tools;
using System;
using System.Collections;

namespace WebSite.Partner
{
    public partial class Reservations : System.Web.UI.Page
    {
        public string whereClause = "";
        public int RecordID = 0, TurID = 0;
        public Entities.zUsers UserData = new Entities.zUsers { id = 0, CatID = 0 };

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Agency", 1);
            UserData = Developer.LoggedPartner();
            PageProperties(Language.GetFixed("Rezervasyon"));
        }
        //--------------------------------------------------------- pageLoad işlemleri

        protected void PageProperties(string PageTitle)
        {

            if (UserData.CatID == 1)
            {
                whereClause = " AND _SaleExecutiveID=" + UserData.id;
                if (Request["catid"] != null)
                    whereClause += " AND AgencyID=" + Request["catid"];
            }
            else
                whereClause = " AND AgencyID=" + UserData.CatID;
            //---------------------------------------------------------
            if (Request["type"] != null)
            {
                TurID = Convert.ToInt32(Request["type"].ToString());
                whereClause += " AND TurID=" + TurID;
                if (TurID == 0)
                    PageTitle = Language.GetPartner("Rezervasyon");
                else if (TurID == 1)
                    PageTitle = Language.GetPartner("Satislar");
                else if (TurID == 2)
                    PageTitle = Language.GetPartner("Surecte");
            }
            Page.Title = PageTitle; 
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