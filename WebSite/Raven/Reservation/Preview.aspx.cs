using Tools;
using System;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace WebSite.Raven.Reservation
{
    public partial class Preview : System.Web.UI.Page
    {
        public int RecordID = 0;
        public List<Entities.Reservations> dataList;
        public List<Entities.ReservationFiles> fileList;
        public List<Entities.ReservationFeatures> featureList;
        public List<Entities.SaleTransactions> paymentList;

        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 18);
            PageProperties(Language.GetFixed("Onizle"), 3);
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
            if (Request["dhx"] != null)
                if (Request["dhx"].ToString() == "view")
                    RecordID = Convert.ToInt32(Request["id"].ToString());
                else
                    RecordID = 0;
            //---------------------------------------------------------
            dataList = Bll.Reservations.Select(RecordID, "");
            fileList = Bll.ReservationFiles.Select(0, filter: " AND CatID=" + RecordID);
            featureList = Bll.ReservationFeatures.Select(0, filter: " AND CatID=" + RecordID);
            paymentList = Bll.SaleTransactions.Select(0, filter: " AND CatID=" + RecordID);
        }
        //--------------------------------------------------------- paramaters
    }
}