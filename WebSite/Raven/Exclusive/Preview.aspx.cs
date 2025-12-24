using Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Exclusive
{
    public partial class Preview : System.Web.UI.Page
    {
        public string TableName = "";
        public int RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["t"] != null)
                TableName = Request["t"].ToString();
            //---------------------------------------------------------
            if (Request["v"] != null)
                RecordID = Convert.ToInt32(Request["v"].ToString());
            //---------------------------------------------------------
            if (!String.IsNullOrEmpty(TableName) && RecordID > 0)
            {
                DataTable dataList = Bll.Base.GetDataTable("SELECT * FROM " + TableName + " WHERE id=" + RecordID, CommandType.Text, null, null);
                DataArea(dataList);
            }
        }
        //---------------------------------------------------------

        protected void DataArea(DataTable dList)
        {
            string[] parameters = new string[dList.Columns.Count];
            string[] paramvalues = new string[dList.Columns.Count];
            for (int i = 0; i < dList.Columns.Count; i++)
            {
                string ColumnName = dList.Columns[i].ColumnName;
                parameters[i] = ColumnName;
                paramvalues[i] = dList.Rows[0][ColumnName].ToString();
            }

            string mailbody = Mailing.CreateTemplate("Preview", Mailing.CreateBody(parameters, paramvalues));
            Response.Write(mailbody);
            Response.End();
        }
        //---------------------------------------------------------

    }
}