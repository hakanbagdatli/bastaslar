using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Shared
{
    public partial class Sidebar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public bool HasSubMenu(int CatID)
        {
            if (Bll.zMenus.RowCount("AND CatID=" + CatID + " AND Approved=1", Entities.zMenus.tableName) > 0)
                return true;
            else
                return false;
        }
        //---------------------------------------------------------

        public string SetPanelName(int PanelID)
        {
            switch (PanelID)
            {
                case 2:
                    return "Projects";
                case 3:
                    return "Inspections";
                case 4:
                    return "Web Site";
                case 5:
                    return "Digital Marketing";
                case 7:
                    return "User Management";
                case 8:
                    return "General Settings";
                default:
                    return "Dashboard";
            }
        }
    }
}