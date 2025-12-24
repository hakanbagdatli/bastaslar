using Tools;
using System;
using Utility;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Data;

namespace WebSite.Raven.Reservation
{
    public partial class Reports : System.Web.UI.Page
    {
        public string TotalResCount = "", TotalSaleCount = "", ResWhereClause = "", SalWhereClause = "", InsWhereClause = "";
        public string StartDate = "", EndDate = "", Type = "0", SaleExecutiveID = "", AgencyID = "", PageTitle = Language.GetFixed("Raporlar");

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
                ResWhereClause += " AND _SaleExecutiveID=" + SaleExecutiveID;
                SalWhereClause += " AND _SaleExecutiveID=" + SaleExecutiveID;
                InsWhereClause += " AND _SaleExecutiveID=" + SaleExecutiveID;
            }
            //---------------------------------------------------------
            if (Request["agency"] != null)
            {
                AgencyID = Request["agency"];
                ResWhereClause += " AND AgencyID=" + AgencyID;
                SalWhereClause += " AND AgencyID=" + AgencyID;
                InsWhereClause += " AND AgencyID=" + AgencyID;
            }
            //---------------------------------------------------------
            if (Request["startdate"] != null)
            {
                StartDate = Request["startdate"];
                ResWhereClause += " AND TRY_CONVERT(datetime, ReservationDate, 104) BETWEEN '" + Helper.SQLDateFormat(StartDate) + "'";
                SalWhereClause += " AND TRY_CONVERT(datetime, ContractofSigning, 104) BETWEEN '" + Helper.SQLDateFormat(StartDate) + "'";
                InsWhereClause += " AND TRY_CONVERT(datetime, PresentationDate, 104) BETWEEN '" + Helper.SQLDateFormat(StartDate) + "'";
            }
            //---------------------------------------------------------
            if (Request["enddate"] != null) { 
                EndDate = Request["enddate"];
                ResWhereClause += " AND '" + Helper.SQLDateFormat(Convert.ToDateTime(EndDate).AddDays(1).ToString()) + "'";
                SalWhereClause += " AND '" + Helper.SQLDateFormat(Convert.ToDateTime(EndDate).AddDays(1).ToString()) + "'";
                InsWhereClause += " AND '" + Helper.SQLDateFormat(Convert.ToDateTime(EndDate).AddDays(1).ToString()) + "'";
            }
            //---------------------------------------------------------
            if (Request["type"] != null)
            {
                Type = Request["type"];
                switch (Type)
                {
                    case "2":
                        ResWhereClause = " AND TurID=0";
                        SalWhereClause = " AND TurID=1";
                        PageTitle = "Reservation & Completed Sales Details Report";
                        break;
                    case "3":
                        PageTitle = "Ins. Trip / Property View Report";
                        break;
                    default:
                        TotalResCount = ReservationCount("0", ResWhereClause);
                        TotalSaleCount = ReservationCount("1", SalWhereClause);
                        PageTitle = "Reservation & Completed Sales Report";
                        break;
                }
            }
        }
        //--------------------------------------------------------- paramaters

        public string PaidAmount(int ReservationID)
        {
            double TotalPaid = 0;
            List<Entities.SaleTransactions> dataList = Bll.SaleTransactions.Select(0, filter: " AND CatID=" + ReservationID + " AND Approved=1");
            foreach (var item in dataList)
            {
                TotalPaid += Helper.MoneytoDouble(item.Amount);
            }
            //---------------------------------------------------------
            if (TotalPaid > 0)
                return Helper.MoneyFormat(TotalPaid);
            else
                return "0";
        }
        //---------------------------------------------------------

        public string RemainingAmount(string Contract, string Paid)
        {
            double ContractAmount = Helper.MoneytoDouble(Contract);
            double PaidAmount = Helper.MoneytoDouble(Paid);
            return Helper.MoneyFormat(ContractAmount  - PaidAmount);
        }
        //---------------------------------------------------------

        public static string ReservationCount(string Type, string Clause) 
        {
            string SqlString = @"SELECT COUNT(id) AS TotalCount, 
                                       SUM(CONVERT(float, REPLACE(REPLACE(ContractPrice, '.', ''), ',', '.'))) AS TotalAmount 
                                       FROM " + Entities.Reservations.tableName + " WHERE Approved=1 AND isDeleted=0 AND TurID=" + Type + Clause;
            DataTable dt = Bll.Reservations.GetDataTable(SqlString, CommandType.Text, null, null);
            if (dt.Rows.Count > 0)
                return dt.Rows[0]["TotalCount"].ToString() + "~" + string.Format("{0:C2}", dt.Rows[0]["TotalAmount"]).Replace("£", "");
            else 
                return "0~0";
        }
        //---------------------------------------------------------
    }
}