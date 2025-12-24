using Tools;
using System;
using System.Collections;
using System.Web.UI.WebControls;

namespace WebSite.Raven.Operation
{
    public partial class TaskList : System.Web.UI.Page
    {
        public int RecordID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Developer.CheckLogin("Sales", 11);
            PageProperties(Language.GetFixed("IsAtama"), 1);
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