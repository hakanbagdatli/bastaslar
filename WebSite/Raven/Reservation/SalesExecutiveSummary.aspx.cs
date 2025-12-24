using Tools;
using System;
using Utility;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Data;

namespace WebSite.Raven.Reservation
{
    public partial class SalesExecutiveSummary : System.Web.UI.Page
    {
        public string StartDate = "", EndDate = "", Type = "0", SaleExecutiveID = "0", AgencyID = "", PageTitle = Language.GetFixed("SalesExecutiveSummary");
        public string TotalTouch = "", TotalReservation = "", TotalCompleted = "", TotalInspection = "", TotalPropertyView = "";
        public int SaleExecutiveId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Developer.CheckLogin("Sales", 41);
                Paramaters();
                PageProperties(PageTitle, 3);
            }
            catch (Exception)
            {

                throw;
            }
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
            //---------------------------------------------------------
            if (Request["saleexecutive"] != null)
            {
                SaleExecutiveID = Request["saleexecutive"];
            }
            //---------------------------------------------------------
           
            //---------------------------------------------------------
            if (Request["startdate"] != null)
            {
                StartDate = Request["startdate"];
            }
            //---------------------------------------------------------
            if (Request["enddate"] != null)
            {
                EndDate = Request["enddate"];
            }
            //---------------------------------------------------------
        }
    }
}