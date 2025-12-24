using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = Entities.StaticList.ActiveSite.MetaTitle;

            #region language
            HiddenField hdnID = (HiddenField)this.Master.FindControl("hdnID");
            HiddenField hdnCatID = (HiddenField)this.Master.FindControl("hdnCatID");
            hdnID.Value = "0";
            hdnCatID.Value = "1";
            #endregion
        }
    }
}