using Tools;
using System;
using System.Web.UI.WebControls;
using System.Collections;

namespace WebSite.Raven.Inspection
{
    public partial class List : System.Web.UI.Page
    {
        public string whereClause = "", PageTitle = Language.GetFixed("Gosterimler");
        public int CatID = 0, RecordID = 0, TurID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 14);
            Paramaters();
            PageProperties(PageTitle, 2);
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
            if (Request["turid"] != null)
            {
                TurID = Convert.ToInt32(Request["turid"].ToString());
                whereClause += " AND TurID=" + TurID;
                if (TurID == 1)
                    PageTitle = Language.GetFixed("Gorunum");
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